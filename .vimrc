set number
set nohlsearch
set noerrorbells
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set scrolloff=12 " 8 for 24inch, 12 for 27inch ish???
set incsearch
set smartcase
set hidden
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set path=.,,** " Allows for finding a file recursively

" Better completion stuff
set completeopt=menuone,noinsert,noselect
set shortmess+=c

set colorcolumn=80 " Set a marker for where we should approx. new-line at
set cursorline
set autoread
set cinoptions=l1 " Align switch statements with case label

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300 " 50
set cmdheight=1

set statusline=
set statusline+=\ %f
set statusline+=\ %m%r%w

set statusline+=\ \ \ \ \ \  
set statusline+=\ %p%%
set statusline+=\ \  
set statusline+=\ L%l/%L
set statusline+=\ C%c
set statusline+=\ \  

set statusline+=\ \ %#PmenuSel#%{g:gitstatus}%#StatusLine#\ \  

set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ (%{&fileformat}\) 
set statusline+=\ %y

syntax on

if has('nvim')
    "Neovim commands/plugins

    " Set insert mode cursor to block
    set guicursor=
endif

call plug#begin('~/.vim/bundle')

Plug 'rmagatti/auto-session'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'tpope/vim-fugitive'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mbbill/undotree'
"Plug 'nvim-tree/nvimtree.lua'

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'chr4/nginx.vim'
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'ziglang/zig.vim'
Plug 'mfussenegger/nvim-jdtls'

Plug 'gruvbox-community/gruvbox'
Plug 'aktersnurra/no-clown-fiesta.nvim'
Plug 'tomasiser/vim-code-dark'

call plug#end()

if has('nvim')
"    colorscheme jax
    colorscheme no-clown-fiesta
    
    highlight Normal guibg=none
endif

let is_wsl = 0
let kernel_str = system("cat /proc/version")
if kernel_str =~ "Linux" && (kernel_str =~ "microsoft" || kernel_str =~ "WSL2")
    let is_wsl = 1
endif

if (is_wsl == 1)
    " Rust program for 2-way clipboard transfer
    " program in ~/bin/win32yank.exe
    "  https://github.com/equalsraf/win32yank
    let g:clipboard = {
    \   'name': 'win32yank-wsl',
    \   'copy': {
    \       '+': 'win32yank.exe -i --crlf',
    \       '*': 'win32yank.exe -i --crlf',
    \   },
    \   'paste': {
    \       '+': 'win32yank.exe -o --lf',
    \       '*': 'win32yank.exe -o --lf',
    \   },
    \   'cache_enabled': 0,
    \}
endif

" TODO: Try switching to ccls for lsp, since it at least tries to work with unity builds
"  (https://github.com/clangd/clangd/issues/45#issuecomment-707260811)

lua << EOF
local lspconfig = require'lspconfig'
--local onattach = require'completion'.on_attach
local telescope = require'telescope'

telescope.setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
         }
    }
}

telescope.load_extension('fzy_native')

EOF

let $MYVIMRC = '~/.vimrc'
let mapleader = " "

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Navigate through quickfix lists easily
nnoremap <A-n> :cn<CR>
nnoremap <A-N> :cp<CR>
nnoremap <A-q> :ccl<CR>

nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>hs :split<CR>

nnoremap <C-n> :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <C-p> :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap vld :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap vd :lua vim.lsp.buf.definition()<CR>
nnoremap vi :lua vim.lsp.buf.implementation()<CR>
nnoremap vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fg :lua require('telescope.builtin').live_grep()<CR>

"inoremap " ""<Esc>ha
"inoremap ' ''<Esc>ha
"inoremap ` ``<Esc>ha
"inoremap ( ()<Esc>ha
"inoremap { {}<Esc>ha
"inoremap [ []<Esc>ha
" Open braces and place cursor inside (O command)
"inoremap {<CR> {<CR>}<Esc>O 

inoremap <C-c> <Esc>

" Exit terminal mode in nvim
tnoremap <Esc> <C-\><C-N>

" Trigger nvim completion popup
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

function! GetGitStatus()
    let revision = system('cd '.expand('%:p:h:S').' && git rev-parse --short HEAD 2>/dev/null | tr -d "\n"')
    let branchname = system('cd '.expand('%:p:h:S').' && git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d "\n"')
    if (strlen(revision) > 0) && (strlen(branchname) > 0)
        let g:gitstatus = ' ' . branchname . '@' . revision . ' '
    else 
        let g:gitstatus = ' '
    endif
endfunc
autocmd BufEnter,BufWritePost * call GetGitStatus()

" When the cursor isn't moved by the time 'updatetime', execute checktime to check for file changes
au CursorHold * checktime

" NOTES:
" remember! lower a in command mode to append at cursor, A to move to end
"  of line and append!

" TODO LIST!!!
" Alternate between matching header and cpp file (support all extensions)
" Jump to definition (in side window)
" Jump to most likely thing for identifier
" Fuzzy file search project-wide
" 1G=G to auto indent all lines, 1G takes cursor to start of file, = will
"  auto-indent and G will take cursor to last line. Map this a keybind to
"  clean the file!
"
" settle on colors! 
"  - mix of vscode-dark vim theme, gruvbox, caseys emacs,
"     and ryan fleurys 4ed?
