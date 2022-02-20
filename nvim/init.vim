" Vim setup {{{
" -----------------------

" general settings {{{
" -----------------------

    set title
    filetype plugin on
    set foldlevelstart=1
    "hybrid line numbers
    set number relativenumber
    set nocompatible
    filetype plugin on
    syntax enable 
    syntax on
    filetype plugin indent on
    " set spell correction language
    set spelllang=en
    set spell
    "remapping +register copy/pasting
    set clipboard=unnamed
    " ignore case when searching
    set ignorecase              
    " search as characters are entered
    set incsearch           
    set encoding=UTF-8

    set wildmode=longest,list,full
    set wildmenu
    set wildignore+=**/node_modules/*

    " tabs over spaces {{{
    " -----------------------

        set expandtab
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set autoindent
        set textwidth=80

    "}}}
    " performance improvements {{{
    " -----------------------

        set synmaxcol=200 "Don't bother highlighting anything over 200 chars
        let did_install_default_menus = 1 "No point loading gvim menu stuff
        let loaded_matchparen = 1 "highlighting matching pairs so slow

    "}}}
    
"}}}
" autocommands {{{
" -----------------------

" auto shebang insert on shell script creation 
"au bufnewfile *.sh 0r $NVIM/snips/sh

"au bufnewfile *.md 0r $NVIM/snips/md

" setup almanac (notebook) environment
"autocmd BufRead,BufNewFile */almanac/** call Wiki()

" update tmux window names
""autocmd BufReadPost,FileReadPost,BufNewFile,BufLeave * call system("tmux rename-window " . expand("%:t"))
""autocmd VimLeave * call system("tmux rename-window $(basename \"$PWD\")")

"}}}
" mapping {{{
" -----------------------

" defining leader key
let mapleader = ","

" remapping vim pane movement
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" turn off search highlights
nnoremap <Leader>h :nohlsearch <CR>

" toggle Fold
nnoremap <Leader>m za

" autocorrect to first match 
nnoremap <Leader>c z=1 <CR> <CR>

" show copy buffer registers
nnoremap <Leader>p :reg <CR>

"command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
"inoremap <Space><Space> <Esc>/<++><Enter>"_c4l

"}}}
" plugins {{{
" -----------------------

call plug#begin('~/.config/nvim/plugged')
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'vimpostor/vim-tpipeline'
Plug 'yuezk/vim-js'
Plug 'itchyny/lightline.vim'
Plug 'pangloss/vim-javascript'
"Plug 'vimwiki/vimwiki'
Plug 'maxmellon/vim-jsx-pretty'
"Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'https://tpope.io/vim/fugitive.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
"Plug 'mcchrish/nnn.vim'
"Plug 'preservim/nerdtree'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/gorodinskiy/vim-coloresque.git'
Plug 'morhetz/gruvbox'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'pbrisbin/vim-mkdir'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'jkramer/vim-checkbox', { 'for': 'markdown' }
Plug 'preservim/nerdcommenter'
" deoplete {{{
" -----------------------

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"}}}
call plug#end()
" unused {{{
" -----------------------

"Plug 'christoomey/vim-tmux-navigator'
"Plug 'https://github.com/junegunn/goyo.vim'
"Plug 'https://github.com/ryanoasis/vim-devicons'
"Plug 'junegunn/fzf.vim'
"Plug 'dylanaraps/wal.vim'
"Plug 'mhinz/vim-startify'
"Plug 'sedm0784/vim-you-autocorrect'
"Plug 'https://github.com/liuchengxu/space-vim-dark'
"Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"Plug 'https://github.com/kien/ctrlp.vim'
"Plug 'https://github.com/ervandew/supertab'
"Plug 'vimwiki/vimwiki'
"Plug 'https://github.com/jonhiggs/MacDict.vim'
"Plug 'shmargum/vim-sass-colors'
"Plug 'Yggdroot/indentLine'
"Plug 'whatyouhide/vim-gotham'
"Plug 'vimwiki/vimwiki'
"Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
"Plug 'jkramer/vim-checkbox', { 'for': 'markdown' }
"Plug 'preservim/nerdtree'
"Plug 'preservim/nerdcommenter'

"}}}

"}}}
" plugins' settings {{{
" -----------------------

" coc for deoplete {{{
" -----------------------

let g:neocomplete#enable_at_startup = 1

let g:syntastic_javascript_checkers = ['eslint']
let g:jsx_ext_required = 0 
" Makes JSX React closing tags different a color than opening tags.
let g:vim_jsx_pretty_highlight_close_tag = 1
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
"set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


"}}}
" indent-line {{{
" -----------------------

let g:indentLine_char_list = ['|', '¦', '┆', '┊']
set listchars=tab:\|\ 
set list

"}}}
" easy align plugin {{{
" -----------------------

"Start interactive easy align in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
"Start interactive easy align for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

"}}}
" nnn-vim {{{
" -----------------------

"let g:nnn#layout = { 'window': { 'width': 0.7, 'height': 0.6, 'highlight': 'Debug' } }

" }}}
" Limelight {{{
" -------------
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight! 
"}}}
"}}}
" almanac {{{
" -----------------------

" shortcut to open almanac
"nnoremap <Leader>w :w <cr> :e ~/Documents/almanac/index.md<cr>

" custom almanac navigation {{{
" -----------------------

" function runs every time file in almanac directory is opened
"function Wiki()
"    set syntax=markdown
"    nnoremap <tab> /\[.*\](.*)<CR>:nohlsearch<CR>
"    nnoremap <S-tab> /\[.*\](.*)<CR> NNN :nohlsearch<CR>
"    nnoremap <Leader><tab> /\[.*\](.*)<CR>:nohlsearch<CR>
"    nnoremap <CR> f(gf
"    nnoremap <BS> :e ~/Documents/almanac/index.md<CR>
"endfunction
"autocmd FileType markdown 
"    \ set formatoptions-=q |
"    \ set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*\[-*+]\\s\\+

"}}}

"}}}
" colorscheme & theming {{{
" -----------------------

" just use 256 terminal colors
set t_Co=256
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
set background=dark    " Setting dark mode
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
" colorscheme ayu
    " required for ayu to work properly
    "set termguicolors
    "let ayucolor="dark" 
    
" custom post-color-scheme highlighting {{{
" -----------------------

    hi Normal guibg=NONE ctermbg=NONE
    "hi CursorLineNr guibg=NONE ctermbg=NONE
    "hi LineNr guibg=NONE ctermbg=NONE
    "hi SpellBad gui=italic guibg=NONE ctermbg=NONE 
    "hi Comment gui=italic
    hi Folded ctermbg=NONE 
"}}}
" markdown highlighting {{{
" -----------------------

    hi markdownItalic gui=italic guifg=250             
    hi markdownBold gui=bold 
    hi markdownHeadingDelimiter guifg=75 gui=bold
    hi mardownRule guifg=12
    hi markdownLinkText guifg=75

"}}}

" unused {{{
" -----------------------

    "highlight markdownItalic gui=italic,inverse guifg=250  
    "highlight markdownBold ctermfg=7            cterm=bold
    "highlight Title ctermfg=7 cterm=bold
    "hi Folded guibg=grey ctermbg=grey ctermgf=

"}}}
    
"}}}
" folding {{{
" -----------------------

set foldlevel=0
set foldmethod=marker
set modelines=1

" markdown folding {{{
" -----------------------

function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "=" 
endfunction
au BufEnter *.md,*.txt setlocal foldexpr=MarkdownLevel()  
au BufEnter *.md,*.txt setlocal foldmethod=expr

"}}}
    
"}}}
"unused {{{
" -----------------------

" Copying vim settings for nvim use {{{
"set runtimepath^=~/.config/.vim runtimepath+=~/.config/.vim/after
"    let &packpath = &runtimepath
"    source ~/.config/vim/.vimrc
"}}}
" checking for Plug installation {{{
" -----------------------
"if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
"	echo "Downloading junegunn/vim-plug to manage plugins..."
"	silent !mkdir -p ~/.config/nvim/autoload/
"	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
"	autocmd VimEnter * PlugInstall
"endif
"}}}
" keuze CTRL-P replacement {{{
" -----------------------
"function! Kies()
"  let selection = system('bash -c "(git ls-files -co --exclude-standard || ls) 2>/dev/null | lsblank | keuze -p \"open\""')
"  if empty(selection) | echo "Canceled" | return | end
"
"  exec ":e " . selection
"endfunction
"
"nnoremap <C-P> :call Kies()<CR>
"}}}
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"let &t_SI = "\<Esc>[6 q"
"let &t_SR = "\<Esc>[4 q"
"let &t_EI = "\<Esc>[2 q"
"let &t_8f = "\e[38;2;%lu;%lu;%lum"
"let &t_8b = "\e[48;2;%lu;%lu;%lum"

"}}}
"map <C-j> <C-W>j<C-W>_
"map <C-k> <C-W>k<C-W>_
" Moving between panes
map <C-l> <C-W>l<C-W>_
map <C-h> <C-W>h<C-W>_
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE

" Customize fzf colors to match your color scheme
"let g:fzf_colors =
"\ { 'fg':      ['fg', 'Normal'],
"  \ 'bg':      ['bg', 'Normal'],
"  \ 'hl':      ['fg', 'Comment'],
"  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"  \ 'hl+':     ['fg', 'Statement'],
"  \ 'info':    ['fg', 'PreProc'],
"  \ 'border':  ['fg', 'Ignore'],
"  \ 'prompt':  ['fg', 'Conditional'],
"  \ 'pointer': ['fg', 'Exception'],
"  \ 'marker':  ['fg', 'Keyword'],
"  \ 'spinner': ['fg', 'Label'],
"  \ 'header':  ['fg', 'Comment'] }

" Dont know what this does
"function! s:buflist()
"  redir => ls
"  silent ls
"  redir END
"  return split(ls, '\n')
"endfunction
"
"function! s:bufopen(e)
"  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
"endfunction

" FZF fuzzy finding {{{
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>g :Rg<CR>
nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})
" }}}

" Moving between buffers using <Tab>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>


"Statusline {{{
"hi User2 ctermbg=NONE guifg=white guibg=NONE 
"set statusline=
"set statusline+=%1*\ \ Buf:\ 
"set statusline+=%2*[%n%H%M%R%W]                         " flags and buf no
"set statusline+=%1*\ \ \ file:\ 
"set statusline+=%2*[%f%*]
"set statusline+=%2*%10((%1*line:%2*%l,\ %1*col:%2*%c)%)\ " line and column
"set statusline+=%2*\ %= 
"set statusline+=%2*%10((%1*line:%2*%l,\ %1*col:%2*%c)%)\ " line and column

" COC Status Line integration
function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, 'E' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, 'W' . info['warning'])
    endif
    return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

"}}}
"}}}

set showtabline=0
set cmdheight=1
let g:indentLine_setConceal = 0
set conceallevel=0
set laststatus=2
set nojs
set mouse=a


"function! NewJournalEntry()
"    nnoremap <Leader>d :r! date "\%d-\%m-\%Y"<CR>
"endfunction
"
"nnoremap <Leader>d :r! date "+\%a, \%d-\%m-\%Y"<CR>kJ0i[**<ESC>A**](./<ESC>:r! date "+\%d-\%m-\%Y"<CR>kJx<ESC>A.md)<ESC> :! touch "./journal/$(date "+\%d-\%m-\%Y").md"<CR>
"
"let g:vimwiki_list = [{'path': '~/documents/vimwiki/',
"                      \ 'syntax': 'markdown', 'ext': '.md'}]
"
"command! Diary VimwikiDiaryIndex
"augroup vimwikigroup
"    autocmd!
"    " automatically update links on read diary
"    autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
"augroup end
"
"
"
"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window left.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"    \ quit | endif

lua require("tyronyiu")
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

" searches from the word below cursor
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
" shows buffers
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
" shows git branches
nnoremap <leader>gc :lua require('telescope').git_branches()<CR>
" nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>


" copying from the cursor to the rest of the line
nnoremap Y y$

" Keeping movement centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-j> :cnext<CR>zzzv

" better undoing, setting 'safe check-points' while typing
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Remap for format selected region
"nmap <leader>k  <Plug>(coc-format-selected)
"xmap <leader>k  <Plug>(coc-format-selected)

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-k> <esc>:m .-2<CR>==
inoremap <C-j> <esc>:m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Give more space for displaying messages.
set cmdheight=2
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <leader>gd <Plug>(coc-definitions)
nmap <leader>gr <Plug>(coc-references)


set ttyfast "fast terminal connection
silent! set stl=%!tpipeline#stl#line()
set laststatus=2 "always show the statusline
"keep selected text selected when indenting
xnoremap < <gv
xnoremap > >gv
"allow completions from the dictionary
set complete+=kspell
set diffopt+=vertical,algorithm:patience
"tpipeline
let g:tpipeline_cursormoved = 1
