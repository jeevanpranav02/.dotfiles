require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
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
		["core.presenter"] = {
			config = {
				zen_mode = "zen-mode",
				slide_count = {
					enable = true,
					position = "top",
					count_format = "[%d/%d]",
				},
			},
		},
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
