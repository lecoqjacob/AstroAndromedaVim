return function()
  return {
    min_jump = 10,
    show_jumps = true,

    ignore_filetypes = {},
    ignore_buftypes = { nofile = true },

    popup = {
      delay_ms = 0, -- delay before popup displays
      inc_ms = 10, -- time increments used for fade/resize effects
      blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
      width = 10,
      winhl = "PmenuSbar",
      fader = require("specs").pulse_fader,
      resizer = require("specs").shrink_resizer,
    },
  }
end
