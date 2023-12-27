return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
		{ "honza/vim-snippets" },
	},
	config = function()
		local luasnip = require("luasnip")
		local types = require("luasnip.util.types")

		luasnip.config.set_config({
			-- This tells LuaSnip to remember to keep around the last snippet.
			-- You can jump back into it even if you move outside of the selection
			history = false,

			-- This one is cool cause if you have dynamic snippets, it updates as you type!
			updateevents = "TextChanged,TextChangedI",

			-- Autosnippets:
			enable_autosnippets = true,

			-- Crazy highlights!!
			-- #vid3
			-- ext_opts = nil,
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { " « ", "NonTest" } },
					},
				},
			},
		})

		-- Loading VSCode Snippets in LuaSnip
		require("luasnip.loaders.from_vscode").lazy_load()
		-- Use Flutter for .dart files
		require("luasnip").filetype_extend("dart", { "flutter" })

		-- Use javascript and typescript for React
		require("luasnip").filetype_extend("javascript", { "jsdoc" })
		require("luasnip").filetype_extend("typescript", { "javascript", "tsdoc" })
		require("luasnip").filetype_extend("javascriptreact", { "html", "jsdoc", "react-es7" })
		require("luasnip").filetype_extend("typescriptreact", { "html", "tsdoc", "react-ts" })

		-- Javadocs
		require("luasnip").filetype_extend("java", { "javadoc" })

		-- Lua
		require("luasnip").filetype_extend("lua", { "luadoc" })

		-- Python
		require("luasnip").filetype_extend("python", { "django", "djangohtml" })

		-- <c-k> is my expansion key
		-- this will expand the current item or jump to the next item within the snippet.
		vim.keymap.set({ "i", "s" }, "<c-k>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { silent = true })

		-- <c-j> is my jump backwards key.
		-- this always moves to the previous item within the snippet
		vim.keymap.set({ "i", "s" }, "<c-j>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { silent = true })

		-- <c-l> is selecting within a list of options.
		-- This is useful for choice nodes (introduced in the forthcoming episode 2)
		vim.keymap.set("i", "<c-l>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end)

		vim.keymap.set("i", "<c-u>", require("luasnip.extras.select_choice"))

		-- shorcut to source my luasnips file again, which will reload my snippets
		vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

		local list_snips = function()
			local ft_list = require("luasnip").available()[vim.o.filetype]
			local ft_snips = {}
			for _, item in pairs(ft_list) do
				ft_snips[item.trigger] = item.name
			end
			print(vim.inspect(ft_snips))
		end

		vim.api.nvim_create_user_command("SnipList", list_snips, {})

		require("telescope").load_extension("luasnip")
	end,
}
