" TODO:
"  - fix the bug when exiting insert mode using jk
"  - add which key
"  - fix git integration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialize vim-plug
call plug#begin()
" List your plugins here
" Plug 'tpope/vim-sensible'                                                 "  example plugin
  Plug 'preservim/nerdtree'                                                 "  File browser
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                       "  fuzzy finder
  Plug 'junegunn/fzf.vim'
  Plug 'itchyny/lightline.vim'                                              "  Minimalist statusline
  Plug 'mhinz/vim-startify'                                                 "  Startup screen
  Plug 'tpope/vim-fugitive'                                                 "  git
call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure vim-startify
let g:startify_custom_header = [
    \ '   ',
    \ '                                         kkkkkkkk                                                       iiii                           ',
    \ '                                         k::::::k                                                      i::::i                          ',
    \ '                                         k::::::k                                                       iiii                           ',
    \ '                                         k::::::k                                                                                      ',
    \ '   nnnn  nnnnnnnn        eeeeeeeeeeee     k:::::k    kkkkkkk   ooooooooooo   vvvvvvv           vvvvvvviiiiiii    mmmmmmm    mmmmmmm    ',
    \ '   n:::nn::::::::nn    ee::::::::::::ee   k:::::k   k:::::k  oo:::::::::::oo  v:::::v         v:::::v i:::::i  mm:::::::m  m:::::::mm  ',
    \ '   n::::::::::::::nn  e::::::eeeee:::::ee k:::::k  k:::::k  o:::::::::::::::o  v:::::v       v:::::v   i::::i m::::::::::mm::::::::::m ',
    \ '   nn:::::::::::::::ne::::::e     e:::::e k:::::k k:::::k   o:::::ooooo:::::o   v:::::v     v:::::v    i::::i m::::::::::::::::::::::m ',
    \ '     n:::::nnnn:::::ne:::::::eeeee::::::e k::::::k:::::k    o::::o     o::::o    v:::::v   v:::::v     i::::i m:::::mmm::::::mmm:::::m ',
    \ '     n::::n    n::::ne:::::::::::::::::e  k:::::::::::k     o::::o     o::::o     v:::::v v:::::v      i::::i m::::m   m::::m   m::::m ',
    \ '     n::::n    n::::ne::::::eeeeeeeeeee   k:::::::::::k     o::::o     o::::o      v:::::v:::::v       i::::i m::::m   m::::m   m::::m ',
    \ '     n::::n    n::::ne:::::::e            k::::::k:::::k    o::::o     o::::o       v:::::::::v        i::::i m::::m   m::::m   m::::m ',
    \ '     n::::n    n::::ne::::::::e          k::::::k k:::::k   o:::::ooooo:::::o        v:::::::v        i::::::im::::m   m::::m   m::::m ',
    \ '     n::::n    n::::n e::::::::eeeeeeee  k::::::k  k:::::k  o:::::::::::::::o         v:::::v         i::::::im::::m   m::::m   m::::m ',
    \ '     n::::n    n::::n  ee:::::::::::::e  k::::::k   k:::::k  oo:::::::::::oo           v:::v          i::::::im::::m   m::::m   m::::m ',
    \ '     nnnnnn    nnnnnn    eeeeeeeeeeeeee  kkkkkkkk    kkkkkkk   ooooooooooo              vvv           iiiiiiiimmmmmm   mmmmmm   mmmmmm ',
    \ '',
    \ '   Welcome to Vim! Happy editing.',
    \ '',
    \ '   For help, press ":h startify"',
    \ ]

" Optionally, you can set a list of recently opened files
let g:startify_lists = [
    \ { 'type': 'files', 'header': ['   Recent Files'] },
    \ ]




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-fugitive keybindings
nnoremap <leader>gs :Gstatus<CR>  " Git status
nnoremap <leader>gd :Gdiff<CR>    " Git diff
nnoremap <leader>gc :Gcommit<CR>  " Git commit
nnoremap <leader>gp :Gpush<CR>    " Git push
nnoremap <leader>gl :Gpull<CR>    " Git pull




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keybindings
let mapleader = " "                                                         " Set the leader key

" Map 'jk' to <Esc> in Insert mode with a timeout
" `^ = moves the cursor back to its position before the last change or jump, effectively keeping the cursor in place after exiting Insert mode.
" inoremap jk <Esc>`^                                                         " change exit mode keybinding

nnoremap <C-q> :close<CR>                                                   " Close window with Ctrl + q

nnoremap <C-h> <C-w>h                                                       " Switch windows with Ctrl + hjkl
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent>]b :bnext<CR>                                              " switch to next buffer
nnoremap <silent>[b :bprevious<CR>                                          " switch to previous buffer
nnoremap <Leader>d :bd<CR>                                                  " close current buffer




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd VimEnter * NERDTree | wincmd p                                      " Start NERDTree and put the cursor back in the other window.

" Keybindings for NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>                                      " Toggle NERDTree

" Focus NERDTree
" Function to toggle focus between NERDTree and the previous window
" function! ToggleNERDTreeFocus()
"   if exists("t:nerdtree_winid") && win_gotoid(t:nerdtree_winid)
"    wincmd p
"  elseif bufname('%') =~ 'NERD_tree_'
"    wincmd p
"  else
"    NERDTreeFind
"  endif
" endfunction

" Keybinding to toggle focus with leader + o
" nnoremap <leader>o :call ToggleNERDTreeFocus()<CR>

" YOU CAN USE THIS INSTEAD THE FUNCTION ABOVE
" This code does the same thing as the ToggleNERDTreeFocus function
nnoremap <leader>o :NERDTreeFocus<CR>  
autocmd FileType nerdtree nnoremap <buffer> <leader>o :wincmd p<CR>         " When in NERDTree, change focus back to the code with leader + o

" Keybinding to open fzf file search within NERDTree
nnoremap <leader>f :Files<CR>




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set relative numbers
set number
set relativenumber
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on
" Load an indent file for the detected file type.
filetype indent on
" Turn on syntax highlighting
syntax on
" Set tabstop to 4 spaces
set tabstop=4
" Convert tabs to spaces
set expandtab
" Set shiftwidth to 2 spaces
set shiftwidth=2
" Ignore capital letters during search
set ignorecase
" copy to systems clipboard
set clipboard=unnamed

" change cursor
" Set terminal insert mode start sequence
let &t_SI = "\e[6 q"
" Set terminal insert mode end sequence
let &t_EI = "\e[2 q"
" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme
colorscheme habamax
" colorscheme monokai
" set opacity
hi Normal guibg=NONE ctermbg=NONE




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show the mode you are on the last line
" set showmode

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
" set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Enable plugins and load plugin for the detected file type.
" filetype plugin on
