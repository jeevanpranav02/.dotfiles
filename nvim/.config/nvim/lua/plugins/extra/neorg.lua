return {
    {
        "vhyrro/luarocks.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-neotest/nvim-nio",
            "nvim-neorg/lua-utils.nvim",
            "nvim-lua/plenary.nvim"
        },		priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true, -- This automatically runs `require("luarocks-nvim").setup()`
    },
    {
        "nvim-neorg/neorg",
        priority = 30,
        dependencies = {
            { "vhyrro/luarocks.nvim" },
            { "godlygeek/tabular" },
        },
        -- config = true,
        lazy = true,
        ft = "norg",
        cmd = "Neorg",
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
            },
        }
