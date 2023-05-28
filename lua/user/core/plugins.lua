local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local PACKER_BOOTSTRAP

if fn.empty(fn.glob(install_path)) > 0 then
   PACKER_BOOTSTRAP = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
   })
   print("Installing packer close and reopen Neovim...")
   vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
   return
end

-- Install your plugins here
return packer.startup({
   function(use)
      -- My plugins here

      -- Dependencies
      use("wbthomason/packer.nvim") -- Have packer manage itself

      -- Startup Time
      use({
         "lewis6991/impatient.nvim",
         config = require("user.plugins.impatient"),
      }) -- Speed up loading Lua modules in Neovim to improve startup time.

      -- Coloscheme
      use({
         "catppuccin/nvim",
         as = "catppuccin",
         config = require("user.plugins.colorscheme"),
      })

      -- Startup
      use({ "goolord/alpha-nvim", config = require("user.plugins.alpha") })

      -- Statusline
      use({
         "nvim-lualine/lualine.nvim",
         config = require("user.plugins.lualine"),
      })
      use({
         "akinsho/bufferline.nvim",
         tag = "v2.*",
         requires = "tiagovla/scope.nvim",
         after = "catppuccin",
         config = function()
            require("user.plugins.bufferline")
            require("user.plugins.scope")
         end,
      })

      -- File Explorer
      use({
         "nvim-neo-tree/neo-tree.nvim",
         branch = "v2.x",
         requires = { "MunifTanjim/nui.nvim" },
         config = require("user.plugins.neo-tree"),
      })
      use({
         "nvim-telescope/telescope.nvim",
         tag = "0.1.x",
         requires = "nvim-lua/plenary.nvim",
         config = require("user.plugins.telescope"),
      })
      use({
         "ahmedkhalf/project.nvim",
         config = require("user.plugins.project"),
      })

      -- Which Key
      use({ "folke/which-key.nvim", config = require("user.plugins.whichkey") }) -- That displays a popup with possible key bindings of the command you started typing.

      -- Terminal
      use({
         "akinsho/toggleterm.nvim",
         tag = "*",
         config = require("user.plugins.toggleterm"),
      })

      -- Utils
      use("moll/vim-bbye") -- Allows you to do delete buffers (close files) without closing your windows or messing up your layout.
      use({
         "lukas-reineke/indent-blankline.nvim",
         config = require("user.plugins.indent-blankline"),
      })
      use({ "numToStr/Comment.nvim", config = require("Comment").setup() })
      use({
         "windwp/nvim-autopairs",
         config = require("nvim-autopairs").setup(),
      })
      use({
         "norcalli/nvim-colorizer.lua",
         config = require("colorizer").setup(),
      })
      use("kyazdani42/nvim-web-devicons")

      -- Treesitter
      use({
         "nvim-treesitter/nvim-treesitter",
         run = ":TSUpdate",
         config = require("user.plugins.treesitter"),
      })

      -- CMP
      use("hrsh7th/nvim-cmp") -- The completion plugin
      use("hrsh7th/cmp-buffer") -- buffer completions
      use("hrsh7th/cmp-path") -- path completions
      use("hrsh7th/cmp-cmdline") -- cmdline completions
      use("saadparwaiz1/cmp_luasnip") -- snippet completions
      use("onsails/lspkind.nvim")
      use("hrsh7th/cmp-nvim-lsp")
      use("rcarriga/cmp-dap") -- source for nvim-dap REPL and nvim-dap-ui buffers

      -- snippets
      use("L3MON4D3/LuaSnip") --snippet engine
      use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

      -- LSP
      use({
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim",
         "neovim/nvim-lspconfig",
         "folke/neodev.nvim",
      })
      use({
         "glepnir/lspsaga.nvim",
         opt = true,
         branch = "main",
         event = "LspAttach",
      })

      -- Formatter / Linter
      use("jose-elias-alvarez/null-ls.nvim")
      use("jay-babu/mason-null-ls.nvim")

      -- DAP
      use({
         "mfussenegger/nvim-dap",
         "rcarriga/nvim-dap-ui",
         "jay-babu/mason-nvim-dap.nvim",
      })
      use({ "mxsdev/nvim-dap-vscode-js" })
      use({
         "microsoft/vscode-js-debug",
         opt = true,
         run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      })

      -- Trouble
      use({ "folke/trouble.nvim", config = require("user.plugins.trouble") })

      -- Git
      use({
         "lewis6991/gitsigns.nvim",
         config = require("user.plugins.gitsigns"),
      })

      -- Typescript
      use("jose-elias-alvarez/typescript.nvim")
      use({
         "windwp/nvim-ts-autotag",
         config = require("nvim-ts-autotag").setup(),
      })
      use("JoosepAlviste/nvim-ts-context-commentstring")

      -- Automatically set up your configuration after cloning packer.nvim
      -- Put this at the end after all plugins
      if PACKER_BOOTSTRAP then
         require("packer").sync()
      end
   end,
   config = {
      display = {
         open_fn = function()
            return require("packer.util").float({ border = "rounded" })
         end,
      },
   },
})