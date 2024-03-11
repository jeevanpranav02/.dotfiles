local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end
local home = os.getenv("HOME")

local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

jdtls.jol_path = os.getenv("HOME") .. "/tools/jol.jar"

local workspace_folder = home .. "/.cache/jdtls/workspace-" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local jar_patterns = {
	"/tools/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
	"/tools/vscode-java-decompiler/server/*.jar",
	"/tools/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar",
	"/tools/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar",
	"/tools/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar",
}
local plugin_path =
	"/tools/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/"

local bundle_list = vim.tbl_map(function(x)
	return require("jdtls.path").join(plugin_path, x)
end, {
	"junit-jupiter-*.jar",
	"junit-platform-*.jar",
	"junit-vintage-engine_*.jar",
	"org.opentest4j*.jar",
	"org.apiguardian.api_*.jar",
	"org.eclipse.jdt.junit4.runtime_*.jar",
	"org.eclipse.jdt.junit5.runtime_*.jar",
	"org.opentest4j_*.jar",
})
vim.list_extend(jar_patterns, bundle_list)
local bundles = {}
for _, jar_pattern in ipairs(jar_patterns) do
	for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), "\n")) do
		if
			not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
			and not vim.endswith(bundle, "com.microsoft.java.test.runner.jar")
		then
			table.insert(bundles, bundle)
		end
	end
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

local capabilities = require("jb.lsputils").capabilities
-- capabilities.workspace.configuration = true
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
	local function with_compile(fn)
		return function()
			if vim.bo.modified then
				vim.cmd("w")
			end
			client.request_sync("java/buildWorkspace", false, 5000, bufnr)
			fn()
		end
	end

	vim.lsp.codelens.refresh()

	local opts = {
		silent = true,
		buffer = bufnr,
	}

	local set = vim.keymap.set
	set(
		"n",
		"<F5>",
		with_compile(function()
			local main_config_opts = {
				verbose = false,
				on_ready = require("dap").continue,
			}
			require("jdtls.dap").setup_dap_main_class_configs(main_config_opts)
		end),
		opts
	)
	require("jb.lsputils").on_attach(client, bufnr)

	set("n", "<M-o>", jdtls.organize_imports, {
		desc = "Organize imports",
		buffer = bufnr,
	})

	set("n", "<leader>df", jdtls.test_class, opts)

	set("n", "<leader>dn", jdtls.test_nearest_method, opts)

	set("n", "<leader>rv", jdtls.extract_variable_all, {
		desc = "Extract variable",
		buffer = bufnr,
	})

	set("v", "<leader>rm", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], {
		desc = "Extract method",
		buffer = bufnr,
	})

	set("n", "<leader>rc", jdtls.extract_constant, {
		desc = "Extract constant",
		buffer = bufnr,
	})

	set("n", "<leader>ds", function()
		local dap = require("dap")
		if dap.session() then
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		else
			client.request_sync("java/buildWorkspace", false, 5000, bufnr)
			require("jdtls.dap").pick_test()
		end
	end, opts)

	require("jdtls").setup_dap({ hotcodereplace = "auto" })
end

local settings = {
	java = {
		maxConcurrentBuilds = 8,
		eclipse = {
			downloadSources = false,
		},
		saveActions = {
			organizeImports = true,
		},
		maven = {
			downloadSources = true,
		},
		autobuild = { enabled = true },
		signatureHelp = { enabled = true },
		contentProvider = { preferred = "fernflower" },
		implementationsCodeLens = {
			enabled = true,
		},
		referencesCodeLens = {
			enabled = true,
		},
		references = {
			includeDecompiledSources = true,
		},
		inlayHints = {
			parameterNames = {
				enabled = "all", -- literals, all, none
			},
		},
		completion = {
			favoriteStaticMembers = {
				"io.crate.testing.Asserts.assertThat",
				"org.assertj.core.api.Assertions.assertThat",
				"org.assertj.core.api.Assertions.assertThatThrownBy",
				"org.assertj.core.api.Assertions.assertThatExceptionOfType",
				"org.assertj.core.api.Assertions.catchThrowable",
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
			filteredTypes = {
				"com.sun.*",
				"io.micrometer.shaded.*",
				"java.awt.*",
				"jdk.*",
				"sun.*",
			},
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			hashCodeEquals = {
				useJava7Objects = true,
			},
			useBlocks = true,
		},
		format = {
			settings = {
				url = home .. "/.config/nvim/lang-servers/eclipse-java-google-style.xml",
				profile = "GoogleStyle",
			},
		},
	},
}

local config = {
	capabilities = capabilities,
	root_dir = root_dir,
	on_attach = on_attach,
	on_init = function(client, _)
		client.notify("workspace/didChangeConfiguration", { settings = settings })
	end,
	flags = {
		debounce_text_changes = 80,
		allow_incremental_sync = true,
	},
	init_options = {
		bundles = bundles,
		extendedClientCapabilities = extendedClientCapabilities,
	},
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/tools/jdtls/lombok.jar",
		"-jar",
		home .. "/tools/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		"-configuration",
		home .. "/tools/jdtls/config_linux/",
		"-data",
		workspace_folder,
	},
	settings = settings,
	-- handlers = {
	-- 	["language/status"] = function() end,
	-- },
}

require("dap.ext.vscode").load_launchjs()

jdtls.start_or_attach(config)

vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
