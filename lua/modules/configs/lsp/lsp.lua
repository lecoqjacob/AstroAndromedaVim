local api = vim.api
local diagnostic = vim.diagnostic

return {
  config = function(_, opts)
    require("astrolsp").setup(opts)

    Andromeda.kit.lsp.on_attach(function(_, bufnr)
      api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local float_opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always", -- show source in diagnostic popup window
            prefix = " ",
          }

          ---@diagnostic disable-next-line: inject-field
          if not vim.b.diagnostics_pos then vim.b.diagnostics_pos = { nil, nil } end

          local cursor_pos = api.nvim_win_get_cursor(0)
          if
            (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
            and #diagnostic.get() > 0
          then
            diagnostic.open_float(nil, float_opts)
          end

          ---@diagnostic disable-next-line: inject-field
          vim.b.diagnostics_pos = cursor_pos
        end,
      })
    end)
  end,
}
