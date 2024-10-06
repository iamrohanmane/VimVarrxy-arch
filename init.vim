" Set the leader key to space
let mapleader = " "

" Initialize Plug
call plug#begin('~/.local/share/nvim/plugged')

" Essential plugins
Plug 'neovim/nvim-lspconfig'  " LSP support
Plug 'hrsh7th/nvim-cmp'       " Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'   " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'     " Buffer completions
Plug 'hrsh7th/cmp-path'       " Path completions
Plug 'L3MON4D3/LuaSnip'       " Snippet engine
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Syntax highlighting
Plug 'nvim-lua/plenary.nvim'  " Required for Telescope
Plug 'nvim-telescope/telescope.nvim'  " Fuzzy finder
Plug 'kyazdani42/nvim-tree.lua'  " File explorer
Plug 'kyazdani42/nvim-web-devicons'  " Devicons for nvim-tree
Plug 'lewis6991/gitsigns.nvim'   " Git signs
Plug 'nvim-lualine/lualine.nvim'  " Status line
Plug 'numToStr/Comment.nvim'      " Commenting
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }  " Color scheme

call plug#end()

" Key mappings for Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Key mappings for nvim-tree
nnoremap <leader>e :NvimTreeToggle<CR>          " Toggle nvim-tree
nnoremap <leader>R :NvimTreeRefresh<CR>         " Refresh nvim-tree
nnoremap <leader>f :NvimTreeFindFileToggle<CR> " Toggle and find current file in nvim-tree
nnoremap <leader>r :NvimTreeClipboard<CR>       " Print clipboard content
nnoremap <leader>z :NvimTreeResize 50<CR>       " Resize nvim-tree (example size)

" Load your Lua configuration
lua require('varrxy_mocha')
lua require('cmp_config')
lua require('git-signs')
lua require('varrxy-tree')
lua require('comment')
