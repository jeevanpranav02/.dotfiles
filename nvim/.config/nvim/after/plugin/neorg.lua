require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.qol.toc"] = {
            config = {
                close_after_use = true,
            },
        },
        ["core.integrations.treesitter"] = {},
        ["core.concealer"] = {},
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
            }
        },
        ["core.dirman"] = {
            config = {
                workspaces = {
                    work     = "~/development/notes/work",
                    tn2s     = "~/development/notes/TN2S",
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
    }
}
