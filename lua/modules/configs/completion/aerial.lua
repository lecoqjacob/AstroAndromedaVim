local Plugin = {}

Plugin.deps = {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<Leader>lS"] = { function() require("aerial").toggle() end, desc = "Symbols outline" }
    end,
  },
}

Plugin.opts = {
  lazy_load = true,
  close_on_select = true,
  highlight_on_jump = true,

  manage_folds = "auto",
  attach_mode = "global",

  layout = {
    default_direction = "prefer_right",
  },

  ignore = {
    filetypes = {
      "NvimTree",
      "terminal",
      "nofile",
    },
  },

  -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("aerial.actions").<name>
  -- Set to `false` to remove a keymap
  keymaps = {
    ["?"] = "actions.show_help",
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<C-v>"] = "actions.jump_vsplit",
    ["<C-s>"] = "actions.jump_split",
    ["<C-d>"] = "actions.down_and_scroll",
    ["<C-u>"] = "actions.up_and_scroll",
    ["{"] = "actions.prev",
    ["}"] = "actions.next",
    ["[["] = "actions.prev_up",
    ["]]"] = "actions.next_up",
    ["q"] = "actions.close",
    ["o"] = "actions.tree_toggle",
    ["O"] = "actions.tree_toggle_recursive",
    ["zr"] = "actions.tree_increase_fold_level",
    ["zR"] = "actions.tree_open_all",
    ["zm"] = "actions.tree_decrease_fold_level",
    ["zM"] = "actions.tree_close_all",
    ["zx"] = "actions.tree_sync_folds",
    ["zX"] = "actions.tree_sync_folds",
  },

  -- A list of all symbols to display. Set to false to display all symbols.
  -- This can be a filetype map (see :help aerial-filetype-map)
  -- To see all available values, see :help SymbolKind
  filter_kind = {
    "Array",
    "Boolean",
    "Class",
    "Constant",
    "Constructor",
    "Enum",
    "EnumMember",
    "Event",
    "Field",
    "File",
    "Function",
    "Interface",
    "Key",
    "Method",
    "Module",
    "Namespace",
    "Null",
    -- "Number",
    "Object",
    "Operator",
    "Package",
    -- "Property",
    -- "String",
    "Struct",
    -- "TypeParameter",
    -- "Variable",
  },
}

return Plugin
