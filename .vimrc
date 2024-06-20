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
  Plug 'mhinz/vim-startify'                                                 "  Startup screen
  Plug 'tpope/vim-fugitive'                                                 "  git

  " Statusline
  " Plug 'itchyny/lightline.vim'                                              
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Colorschemes
  Plug 'tyrannicaltoucan/vim-deep-space'
  Plug 'ajmwagar/vim-deus'
  Plug 'morhetz/gruvbox'
  Plug 'whatyouhide/vim-gotham'
  Plug 'jaredgorski/spacecamp'
  Plug 'glepnir/oceanic-material'
  Plug 'nikolvs/vim-sunbather'
  Plug 'kristijanhusak/vim-hybrid-material'
  Plug 'Badacadabra/vim-archery'




call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure vim-startify
let g:startify_custom_header = [
    \ '   ',
    \ '███╗   ██╗███████╗██╗  ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
    \ '████╗  ██║██╔════╝██║ ██╔╝██╔═══██╗██║   ██║██║████╗ ████║',
    \ '██╔██╗ ██║█████╗  █████╔╝ ██║   ██║██║   ██║██║██╔████╔██║',
    \ '██║╚██╗██║██╔══╝  ██╔═██╗ ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
    \ '██║ ╚████║███████╗██║  ██╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
    \ '╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
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
" airline config
" let g:airline_theme='deus'
" let g:airline_theme='gruvbox'
" let g:airline_theme='gotham'
" let g:airline_theme = "hybrid"
let g:airline_theme = 'archery'

" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" This require powerline fonts
" Patched font installation:
" Download powerline
"  wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
"  wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
" Move the patched font to a valid X font path. Valid font paths can be listed with xset q:
"  mv 'SomeFont for Powerline.otf' ~/.local/share/fonts/
" Update font cache for the path the font was moved to (root privileges may be needed for updating font cache for some paths):
" fc-cache -vf ~/.local/share/fonts/
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" powerline symbols
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='⚡'

let g:airline_section_b = '%-0.12{getcwd()}'
let g:airline_section_c = '%t'
" Simplified
" let g:airline_section_z = '%3p%% %l:%c'
let g:airline_section_z = '%3p%% ㏑%l/%L ☰ %c '

" let g:airline_symbols.colnr = ' ㏇:'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'



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

" Display a status line and a tab line in Vim
set showtabline=2
set laststatus=2



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme

set background=dark

" habamax theme
" colorscheme habamax

" monokai theme
" colorscheme monokai

" deep-space theme
" colorscheme deep-space

" deus theme
" colorscheme deus

" gruvbox theme
" Set the background to dark
" colorscheme gruvbox

" gotham theme
colorscheme gotham

" spacecamp theme
" colorscheme spacecamp
" lighter spacecamp
" colorscheme spacecamp_lite

" oceanic theme
" colorscheme oceanic_material

" sunbather theme
" colorscheme sunbather

" hybrid material theme
" If you would like some of the code to be bolded, like functions and language controls, uncomment this
" let g:enable_bold_font = 1
" If you want comments to be in italic, uncomment this
" let g:enable_italic_font = 1
" To use transparent background, uncomment this
" let g:hybrid_transparent_background = 1
" colorscheme hybrid_material
" colorscheme hybrid_reverse

" archery theme
colorscheme archery


" enable true colors support
 set termguicolors
" set opacity
" hi Normal guibg=NONE ctermbg=NONE




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline config
" let g:lightline = {
"       \ 'colorscheme': 'darcula',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveHead'
"       \ },
"       \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show the mode you are on the last line
" set showmode

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
" set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Enable plugins and load plugin for the detected file type.
" filetype plugin on
