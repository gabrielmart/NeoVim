local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)

  -- My plugins here

  -- Dependencies
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used any lots of plugins

  -- Startup Time
  use "lewis6991/impatient.nvim" -- Speed up loading Lua modules in Neovim to improve startup time.

  -- Utils
  use "moll/vim-bbye" -- Allows you to do delete buffers (close files) without closing your windows or messing up your layout.
  use "tpope/vim-surround" -- Provides mappings to easily delete, change and add such surroundings in pairs
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "lukas-reineke/indent-blankline.nvim" -- Adds indentation guides to all lines (including empty lines).
  use "NMAC427/guess-indent.nvim" -- The goal of this plugin is to automatically detect the indentation style used in a buffer.
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "norcalli/nvim-colorizer.lua" -- A high-performance color highlighter for Neovim

  -- File Explorer
  use { 'kyazdani42/nvim-tree.lua', tag = 'nightly' } -- optional, updated every week. (see issue #1193)
  use "goolord/alpha-nvim"
  use "ahmedkhalf/project.nvim"

  -- Which Key
  use "folke/which-key.nvim" -- That displays a popup with possible key bindings of the command you started typing.

  -- Coloscheme
  use 'folke/tokyonight.nvim' -- Terminal Colors
  use "kyazdani42/nvim-web-devicons"
  use { 'akinsho/bufferline.nvim', tag = "v2.*" }
  use "nvim-lualine/lualine.nvim"
  use 'arkav/lualine-lsp-progress'

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/nvim-lsp-ts-utils"
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "gpanders/editorconfig.nvim"
  use "folke/trouble.nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "rcarriga/cmp-dap" -- source for nvim-dap REPL and nvim-dap-ui buffers


  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Debug
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'Pocco81/DAPInstall.nvim'
  use 'theHamsta/nvim-dap-virtual-text'

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Terminal
  use { "akinsho/toggleterm.nvim", tag = 'v1.*', config = function() require("toggleterm").setup() end }
  use({
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        -- overwrite default configuration
        -- here, e.g. to enable default bindings
        copy_sync = {
          -- enables copy sync and overwrites all register actions to
          -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
          enable = true,
        },
        navigation = {
          -- enables default keybindings (C-hjkl) for normal mode
          enable_default_keybindings = true,
        },
        resize = {
          -- enables default keybindings (A-hjkl) for normal mode
          enable_default_keybindings = true,
        }
      })
    end
  })
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
