local mason_cfg = require("completion.mason")

local cmp_plugins = {}

cmp_plugins["AstroNvim/astrolsp"] = {
  "AstroNvim/astrolsp",
  cfg = "completion.lsp",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "williamboman/mason.nvim", opts = mason_cfg["mason"] },
    { "jay-babu/mason-null-ls.nvim", opts = mason_cfg["mason-null-ls"] },
    { "jay-babu/mason-nvim-dap.nvim", opts = mason_cfg["mason-nvim-dap"] },
    { "williamboman/mason-lspconfig.nvim", opts = mason_cfg["mason-lspconfig"] },
  },
}

cmp_plugins["hrsh7th/nvim-cmp"] = {
  event = "InsertEnter",
  opts = require("completion.cmp"),
  dependencies = { "hrsh7th/cmp-emoji" },
}

cmp_plugins["stevearc/aerial.nvim"] = {
  event = "User AstroFile",
  cfg = "completion.aerial",
}

cmp_plugins["zbirenbaum/copilot.lua"] = {
  cmd = "Copilot",
  event = "InsertEnter",
  build = ":Copilot auth",
  cfg = "completion.copilot",
}

return cmp_plugins
