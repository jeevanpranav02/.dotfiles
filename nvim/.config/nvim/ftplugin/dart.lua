vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.bo.syntax = ""
vim.bo.textwidth = 100
vim.opt_local.spell = true

vim.keymap.set("n", "<leader>fd", "<Cmd>FlutterDevices<CR>", { desc = "flutter: devices", buffer = 0 })
vim.keymap.set("n", "<leader>fe", "<Cmd>FlutterEmulators<CR>", { desc = "flutter: emulators", buffer = 0 })
vim.keymap.set("n", "<leader>fo", "<Cmd>FlutterOutline<CR>", { desc = "flutter: outline", buffer = 0 })
vim.keymap.set("n", "<leader>fq", "<Cmd>FlutterQuit<CR>", { desc = "flutter: quit", buffer = 0 })
vim.keymap.set("n", "<leader>fr", "<Cmd>FlutterRun<CR>", { desc = "flutter: server run", buffer = 0 })
vim.keymap.set("n", "<leader>frs", "<Cmd>FlutterRestart<CR>", { desc = "flutter: server restart", buffer = 0 })
vim.keymap.set("n", "<leader>frn", "<Cmd>FlutterRename<CR>", { desc = "flutter: rename class (& file)", buffer = 0 })
vim.keymap.set("n", "<leader>fdb", "<Cmd>TermExec direction='vertical' cmd='dart pub run build_runner watch'<CR>", {
	desc = "flutter: run code generation",
	buffer = 0,
})
