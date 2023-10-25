local status, jdtls = pcall(require, "jdtls")
if not status then
    return
end

local home = os.getenv('HOME')

local root_markers = { 'gradlew', 'mvnw', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)

local workspace_folder = home .. "/.cache/jdtls/workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local bundles = {
    vim.fn.glob('home/jp/tools/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
    vim.fn.glob('/home/jp/tools/vscode-java-test/*.jar'),
}

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client, bufnr)
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
    if status_ok then
        jdtls_dap.setup_dap_main_class_configs()
    end
    local _, _ = pcall(vim.lsp.codelens.refresh)
    vim.lsp.codelens.refresh()

    local opts = {
        silent = true,
        buffer = bufnr
    }

    vim.keymap.set('n', "<C-o>", jdtls.organize_imports, {
        desc = 'Organize imports',
        buffer = bufnr
    })

    vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)

    vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)

    vim.keymap.set('n', '<leader>rv', jdtls.extract_variable_all, {
        desc = 'Extract variable',
        buffer = bufnr
    })

    vim.keymap.set('v', '<leader>rm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], {
        desc = 'Extract method',
        buffer = bufnr
    })

    vim.keymap.set('n', '<leader>rc', jdtls.extract_constant, {
        desc = 'Extract constant',
        buffer = bufnr
    })
end
local config = {
    capabilities = capabilities,
    root_dir = root_dir,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 80,
        allow_incremental_sync = true,
    },
    init_options = {
        bundles = bundles,
    },
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            saveActions = {
                organizeImports = true,
            },
            format = {
                settings = {
                    url = home .. ".config/nvim/lang-servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            maven = {
                downloadSources = true,
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
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
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                    "java.util.stream.Collectors.*",
                    "org.assertj.core.api.Assertions.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
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
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            extendedClientCapabilities = extendedClientCapabilities
        },
    },
    cmd = {
        "java",
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        "-javaagent:" .. home .. "/tools/jdtls/lombok.jar",
        '-jar',
        vim.fn.glob(
            "/home/jp/tools/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"),
        "-configuration", "/home/jp/tools/jdtls/config_linux/",
        '-data', workspace_folder,
    },
}


require('dap.ext.vscode').load_launchjs()

--vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--    pattern = { "*.java" },
--    callback = function()
--        local _, _ = pcall(vim.lsp.codelens.refresh)
--    end,
--})

jdtls.start_or_attach(config)

vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
