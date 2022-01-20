" ----------------------------- GENERAL SETTINGS -----------------------------

set background=dark
set incsearch
set hidden
set clipboard^=unnamed
filetype indent plugin on
syntax on
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set confirm
set cmdheight=2
set number
set relativenumber

" ----------------------------- PLUGGED SETTINGS -----------------------------

" auto-install vim-plugged if it's not installed yet
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins installed with :PlugInstall
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dikiaap/minimalist'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/jsonc.vim'
Plug 'leafgarland/typescript-vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tmsvg/pear-tree'

call plug#end()

" ----------------------------- PEARTREE SETTINGS -----------------------------

" dont make parens on enter disappear
let g:pear_tree_repeatable_expand = 0


" ----------------------------- NERDTREE SETTINGS -----------------------------

" open NERDTree whenever vim is started
autocmd vimenter * NERDTree

" close vim when NERDTree is the last window
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif


" --------------------------- NERDCOMMENTER SETTINGS ---------------------------

let g:NERDSpaceDelims = 1

" ---------------------------- MINIMALIST SETTINGS -----------------------------

set t_Co=256
colorscheme minimalist

" ----------------------------- COC.NVIM SETTINGS ------------------------------

" suggested COC settings
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" K shows documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

if maparg("<C-\>", "n") == ""
  inoremap <buffer> <C-\> <C-K>l*
endif

" use tab to trigger completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" format selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" add `:Format` command to format the current buffer
command! -nargs=0 Format :call CocAction('format')

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" CTRL-/ toggles comments
map <C-_> <Plug>NERDCommenterToggle
imap <C-_> <Plug>NERDCommenterToggle
nnoremap <C-J> a<CR><Esc>k$

" ----------- COC EXTENSIONS -----------  
"  coc-eslint
"  coc-prettier


