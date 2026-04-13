-- Autocmds are automatically loaded on the VeryLazy event
-- Add any custom autocmds here

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.fn.system("macime set com.apple.inputmethod.Kotoeri.RomajiTyping.Roman")
  end,
})
