return {
    {
        "numToStr/Comment.nvim",
		lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("Comment").setup()
        end,
    },
}
