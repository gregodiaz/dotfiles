vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'

	use 'jose-elias-alvarez/null-ls.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground'

    use {
        'williamboman/nvim-lsp-installer',
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'onsails/lspkind.nvim',
            'windwp/nvim-autopairs',
        }
    }

    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release
    }

    use 'ellisonleao/gruvbox.nvim'

    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    use 'jwalton512/vim-blade'

    -- use 'feline-nvim/feline.nvim'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'christoomey/vim-tmux-navigator'

    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    use 'mattn/emmet-vim'

    use({ 'adalessa/laravel.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'rcarriga/nvim-notify' },
            { 'nvim-telescope/telescope.nvim' },
        },
    })

    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            -- require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }
    use 'mfussenegger/nvim-treehopper'
    use 'ziontee113/syntax-tree-surfer'

    use({ 'L3MON4D3/LuaSnip',
        tag = 'v1.1.0',
        -- tag = 'v<CurrentMajor>.*',
        after = 'nvim-cmp',
    })

    use 'ap/vim-css-color'

    -- rest-nvim
    use {
        'NTBBloodbath/rest.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }

    use {
        'ThePrimeagen/harpoon',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
        },
    }

    use { 'nvim-telescope/telescope-file-browser.nvim' }

    use 'dominikduda/vim_current_word'

    use 'praem90/nvim-phpcsf'

    use 'preservim/nerdtree'

    use 'akinsho/toggleterm.nvim'

    -- use { 'fgheng/winbar.nvim' }

    use({
        'jackMort/ChatGPT.nvim',
        requires = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        }
    })

    use 'lukas-reineke/indent-blankline.nvim'

    use 'hkupty/iron.nvim'

    use 'anuvyklack/hydra.nvim'

    use { 'nvim-lua/lsp-status.nvim' }

    use 'jacoborus/tender.vim'
    use 'folke/tokyonight.nvim'
    use { 'stevearc/dressing.nvim' }

    use 'JulesWang/css.vim'
    use 'cakebaker/scss-syntax.vim'

	use 'MunifTanjim/prettier.nvim'

	use 'github/copilot.vim'
end
)
