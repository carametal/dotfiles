return {
  "Zeioth/markmap.nvim",
  build = "npm install -g markmap-cli",
  cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
  ft = { "markdown" },
  keys = {
    { "<leader>mm", "<cmd>MarkmapOpen<cr>",      desc = "Markmap Open",       ft = "markdown" },
    { "<leader>mw", "<cmd>MarkmapWatch<cr>",     desc = "Markmap Watch",      ft = "markdown" },
    { "<leader>ms", "<cmd>MarkmapWatchStop<cr>", desc = "Markmap Watch Stop", ft = "markdown" },
  },
  opts = {
    html_output = "/tmp/markmap.html",
    hide_toolbar = false,
    grace_period = 3600000,
  },
  config = function(_, opts)
    require("markmap").setup(opts)
  end,
}
