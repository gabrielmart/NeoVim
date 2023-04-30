local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                  install_path}
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

-- Install your plugins here
return packer.startup({function(use)

    -- My plugins here

    -- Dependencies
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- Startup Time
    use "lewis6991/impatient.nvim" -- Speed up loading Lua modules in Neovim to improve startup time.

    use "goolord/alpha-nvim"

    -- Utils
    use "moll/vim-bbye" -- Allows you to do delete buffers (close files) without closing your windows or messing up your layout.

    -- Coloscheme
    use 'folke/tokyonight.nvim' -- Terminal Colors
    use "kyazdani42/nvim-web-devicons"
    use "nvim-lualine/lualine.nvim"
    use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'tiagovla/scope.nvim' }

    -- Which Key
    use "folke/which-key.nvim" -- That displays a popup with possible key bindings of the command you started typing.

    -- File Explorer
    use {
      "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
          "MunifTanjim/nui.nvim",
        }
    }
    use 'kyazdani42/nvim-tree.lua'
    use "ahmedkhalf/project.nvim"

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Git
    use 'lewis6991/gitsigns.nvim'

    -- indent
    use "lukas-reineke/indent-blankline.nvim"

    -- Telescope
    use { "nvim-telescope/telescope.nvim", tag = '0.1.x', requires = 'nvim-lua/plenary.nvim' }

    use { "akinsho/toggleterm.nvim", tag = '*' }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end,  config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end
  }
}})
