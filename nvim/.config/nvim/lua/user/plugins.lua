local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
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

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)

    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
    use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
    use("kyazdani42/nvim-web-devicons")
    use('iamcco/markdown-preview.nvim')
    use('folke/trouble.nvim')
    use('folke/todo-comments.nvim')
    use({ "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require('neoscroll').setup({
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
                    '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
                hide_cursor = true, -- Hide cursor while scrolling
                stop_eof = true, -- Stop at <EOF> when scrolling downwards
                use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
                respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = nil, -- Default easing function
                pre_hook = nil, -- Function to run before the scrolling animation starts
                post_hook = nil, -- Function to run after the scrolling animation ends
            })
        end
    })
    use({ 'akinsho/flutter-tools.nvim',
        config = function()
            require('flutter-tools').setup({})
        end
    })
    use('mg979/vim-visual-multi')
    use('kyazdani42/nvim-tree.lua')
    use('lukas-reineke/indent-blankline.nvim')

    -- nvim cmp
    use('hrsh7th/nvim-cmp') -- Completion plugin
    use('hrsh7th/cmp-buffer') -- Buffer completions
    use('hrsh7th/cmp-path') -- Path completions
    use('hrsh7th/cmp-nvim-lsp') -- LSP completions
    use('hrsh7th/cmp-nvim-lua') -- Nvim completions for lua configs
    use('saadparwaiz1/cmp_luasnip') -- Snippets
    use('hrsh7th/cmp-cmdline') -- CMD completions

    -- LSP
    use('neovim/nvim-lspconfig')
    use('williamboman/nvim-lsp-installer')
    use('jose-elias-alvarez/null-ls.nvim')

    -- colorschemes
    use('folke/tokyonight.nvim')

    -- Telescope
    use('nvim-telescope/telescope.nvim')
    use('nvim-telescope/telescope-media-files.nvim')

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter')

    -- Git
    use('lewis6991/gitsigns.nvim')


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
