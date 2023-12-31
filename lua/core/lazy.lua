local Lazy = {}

local USE_STABLE = false

local vim_path = Globals.vim_path
local data_dir = Globals.data_dir
local modules_dir = vim_path .. "/lua/modules"
local lazy_path = data_dir .. "lazy/lazy.nvim"
local plugin_dir = modules_dir .. "/plugins/*.lua"

function Lazy:append_nativertp()
  package.path = package.path .. string.format(";%s;%s;", modules_dir .. "/?.lua", modules_dir .. "/configs/?.lua")
end

function Lazy:init_lazy()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.g.astronvim_first_install = true -- lets AstroNvim know that this is an initial installation
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  end
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

  Lazy:append_nativertp()
end

function Lazy:init_andromeda()
  --! Load all kits
  require("kit.path").load_dir("kit")

  Andromeda.kit.root.setup()
  Andromeda.kit.format.setup()
end

function Lazy:load_plugins()
  local get_plugins_list = function()
    local list = {}
    local plugins_list = vim.split(vim.fn.glob(plugin_dir), "\n")
    for _, f in ipairs(plugins_list) do
      -- aggregate the plugins from `/plugins/*.lua` and `/user/plugins/*.lua` to a plugin list of a certain field for later `require` action.
      -- current fields contains: completion, editor, lang, tool, ui
      list[#list + 1] = f:find(modules_dir) and f:sub(#modules_dir - 6, -1)
    end

    return list
  end

  self.modules = {
    { import = "astronvim.lazy_snapshot", cond = USE_STABLE },
    { "AstroNvim/AstroNvim", branch = "v4", version = USE_STABLE and "^4" or nil, import = "astronvim.plugins" },
    { "AstroNvim/astrocommunity", branch = "v4" },
  }

  for _, m in ipairs(get_plugins_list()) do
    -- require modules returned from `get_plugins_list()` function.
    local modules = require(m:sub(0, #m - 4))

    if type(modules) == "table" then
      for name, conf in pairs(modules) do
        -- If cfg exist, then attempt to merge the cfg with the conf.
        if conf.merge ~= nil then
          if type(conf.merge) == "string" then conf.merge = require(conf.merge) end
          conf = vim.tbl_extend("force", conf, conf.merge)
        end

        if conf.import ~= nil or type(conf) == "string" then
          self.modules[#self.modules + 1] = conf
        else
          self.modules[#self.modules + 1] = vim.tbl_extend("force", { name }, conf)
        end
      end
    end
  end
end

function Lazy:load_lazy()
  self:init_lazy()
  self:init_andromeda()
  self:load_plugins()

  local icons = Andromeda.icons

  ---@class LazyConfig
  local lazy_opts = {
    checker = { enabled = true },
    change_detection = { enabled = true },
    defaults = { lazy = true, version = false },

    install = {
      missing = true,
      colorscheme = Andromeda.settings.theme.enabled_themes,
    },

    ui = {
      wrap = true, -- wrap the lines in the ui
      border = Andromeda.settings.ui.float.border,

      icons = {
        ft = icons.File,
        lazy = icons.Lazy,
        task = icons.Check,
        config = icons.Gear,
        event = icons.Event,
        cmd = icons.Terminal,
        init = icons.LazyInit,
        keys = icons.Keyboard,
        plugin = icons.Package,
        runtime = icons.NeoVim,
        start = icons.LazyStart,
        import = icons.FileImport,
        source = icons.SourceCode,
        require = icons.LazyRequire,
        loaded = icons.PackageLoaded,
        not_loaded = icons.PackageUninstalled,
        list = { "●", "➜", "★", "‒" },
      },
    },

    performance = {
      rtp = {
        -- disable some rtp plugins, add more to your liking
        disabled_plugins = {
          "gzip",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "zipPlugin",
        },
      },
    },

    dev = {
      path = "",
      fallback = false,
      patterns = { "AndromedaVim" },
    },
  }

  if Globals.is_mac then lazy_opts.concurrency = 20 end

  require("lazy")--[[@as Lazy]]
    .setup(self.modules, lazy_opts)
end

Lazy:load_lazy()
