-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

---@enum (key) Icons
Andromeda.icons = {
  --! General
  ArrowClosed = "",
  ArrowLeft = "",
  ArrowOpen = "",
  ArrowRight = "",
  Bookmarks = "",
  BufferClose = "󰅖",
  Check = "",
  Circle = " ",
  Dots = "󰇘",
  Ellipsis = "…",
  Environment = "",
  Event = "",
  Gear = "",
  Heart = " ",
  Keyboard = "",
  MacroRecording = "",
  Note = "",
  NeoVim = "",
  Paste = "󰅌",
  Power = "",
  Refresh = "",
  Search = "",
  Selected = "❯",
  Session = "󱂬",
  Sort = "󰒺",
  SourceCode = "",
  Sparkle = "",
  Spellcheck = "󰓆",
  Tab = "󰓩",
  TabClose = "󰅙",
  Terminal = "",
  Window = "",
  WordFile = "󰈭",

  --! Debug
  DapBreakpoint = "",
  DapBreakpointCondition = "",
  DapBreakpointRejected = "",
  DapLogPoint = ".>",
  DapStopped = "󰁕",
  Debugger = "",

  --! Diagnostic
  Diagnostic = "󰒡",
  DiagnosticError = "",
  DiagnosticHint = "󰌵",
  DiagnosticInformation = "󰋼",
  DiagnosticQuestion = "",
  DiagnosticWarning = "",

  --! Files
  DefaultFile = "󰈙",
  File = "",
  FileEmpty = "",
  FileImport = "",
  FileModified = "",
  FileNew = "",
  FileReadOnly = "",
  FileSymLink = "",
  Files = "",

  --! Folders
  FoldClosed = "",
  FoldOpened = "",
  FoldSeparator = " ",
  Folder = "",
  FolderClosed = "",
  FolderEmpty = "",
  FolderOpen = "",
  FolderSymlink = "",
  FolderSymlinkOpen = "",
  OpenFolder = "",
  OpenFolderEmpty = "",

  --! GIT
  Git = "󰊢",
  GitAdd = "",
  GitBranch = "",
  GitChange = "",
  GitConflict = "",
  GitDelete = "",
  GitIgnored = "◌",
  GitRemoved = "",
  GitRemovedAlt = "",
  GitRenamed = "",
  GitSign = "▎",
  GitStaged = "",
  GitUnmerged = "",
  GitUnstaged = "✗",
  GitUntracked = "★",

  --! Language
  ActiveLSP = "",
  ActiveTS = "",
  LSPLoading1 = "",
  LSPLoading2 = "󰀚",
  LSPLoading3 = "",

  --! Lazy
  Lazy = "󰒲",
  LazyInit = "",
  LazyRequire = "󰢱",
  LazyStart = "",
  LazyUnloaded = "",

  --! Packages
  Package = "󰏖",
  PackageLoaded = "",
  PackagePending = "",
  PackageUninstalled = "󰚌",
}

--- Get an icon from the AstroNvim internal icons if it is available and return it
---@param kind Icons The kind of icon in astroui.icons to retrieve
---@param padding? integer Padding to add to the end of the icon
---@param no_fallback? boolean Whether or not to disable fallback to text icon
---@return string icon
Andromeda.icons.get = function(kind, padding, no_fallback)
  return require("astroui").get_icon(kind, padding, no_fallback)
end
