return {
	"nvim-neorg/neorg",
	lazy = true,
	build = ":Neorg sync-parsers",
	ft = "norg",
	cmd = "Neorg",
	priority = 30,
	dependencies = { { "nvim-lua/plenary.nvim" }, { "godlygeek/tabular" } },
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				-- ["core.completion"] = {
				-- 	config = {
				-- 		engine = "nvim-cmp",
				-- 	},
				-- },
				["core.clipboard.code-blocks"] = {},
				["core.autocommands"] = {},
				["core.esupports.indent"] = {},
				["core.qol.toc"] = {
					config = {
						close_split_on_jump = false,
					},
				},
				["core.integrations.treesitter"] = {},
				["core.export"] = {},
				["core.export.markdown"] = {
					config = {
						extension = "md",
						extenstions = "all",
					},
				},
				["core.concealer"] = {
					config = {
						icon_preset = "varied",
					},
				},
				["core.mode"] = {},
				["core.promo"] = {},
				["core.ui"] = {},
				["core.itero"] = {},
				["core.ui.calendar"] = {},
				["core.queries.native"] = {},
				["core.summary"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							work = "~/development/notes/work",
							tn2s = "~/development/notes/TN2S",
							personal = "~/development/notes/personal",
						},
						default_workspace = "personal",
					},
				},
				["core.keybinds"] = {
					config = {
						default_keybinds = true,
						neorg_leader = " ",
					},
				},
			},
		})
	end,
}
