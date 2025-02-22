vim9script
# disable compatibility with vi which can cause unexpected issues.
set nocompatible

# open the quickfix window whenever a quickfix command is executed
autocmd! QuickFixCmdPost [^l]* cwindow

# quick exit some filetypes
autocmd! FileType help,qf,diff,fugitive,fugitiveblame nnoremap <silent> <buffer> q :q<cr>

# ==============================================================================
# general settings / options
# ==============================================================================
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

# specify regex engine
set regexpengine=2
# turn syntax highlighting on.
syntax enable

# show invisible characters
set list
# set the characters for the invisibles
set listchars=tab:⇀\ ,eol:¬,nbsp:␣,trail:⋅
set showbreak=↪

# auto copy indent and auto read file change
set autoindent
set autoread

# enable break indent
set breakindent
set visualbell
set signcolumn=yes

# allow backspacing over listed items and belloff
set backspace=indent,eol,start
set belloff=all

# scan to put in completion
set complete=.,w,b,u,t
# sequence of letters which describes how automatic formatting is to be done
set formatoptions=tcqj

# add numbers to each line on the left-hand side.
set number
set relativenumber
set ruler
set hidden

# set default indentation
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set shiftround

# do not save temporary files.
set nobackup
set noswapfile
set nowrap

# split behaviour
set splitbelow
set splitright

# program to use for the :grep command
if executable('rg') > 0
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --column\ --hidden
endif

# enable title string and sidescrolloff
set sidescrolloff=10
set title

# searching
set incsearch
set hlsearch
set ignorecase
set smartcase
set matchpairs+=<:>

# enable type file detection
filetype on
filetype plugin on
# load an indent file for the detected file type.
filetype indent on
filetype plugin indent on

# limit command height to 1 line
set cmdheight=1
set nopaste
set completeopt=menu,preview

# show several useful info
set showcmd
set showmode
set showmatch

# the cursor is kept in the same column
set nostartofline
set cursorline

# this option controls the behavior when switching between buffers
set switchbuf=uselast
set tabpagemax=50

# timeout behaviour
set ttimeout
set ttimeoutlen=50
# decrease update time
set updatetime=250
# decrease mapped sequence wait time
set timeoutlen=300

# set the commands to save in history default number is 20.
set history=10000
set ttyfast

# enable auto completion menu after pressing tab.
set wildmode=full
set wildcharm=<c-z>
set wildmenu
# wildmenu options
set wildoptions=pum,tagfile

# basic theming
set background=dark
set termguicolors
set laststatus=2

# re-map leader key
nnoremap <space> <nop>
g:mapleader = ' '

# ==============================================================================
# plugins
# ==============================================================================
call plug#begin()
# the default plugin directory will be as follows:
#   - vim (linux/macos): '~/.vim/plugged'
#   - vim (windows): '~/vimfiles/plugged'
#   - neovim (linux/macos/windows): stdpath('data') . '/plugged'
# you can specify a custom plugin directory by passing it as the argument
#   - e.g. `call plug#begin('~/.vim/plugged')`
#   - avoid using standard vim directory names like 'plugin'

# make sure you use single quotes

# a git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

# comment stuff out
Plug 'tpope/vim-commentary'

# delete/change/add parentheses/quotes/xml-tags/much more with ease
Plug 'tpope/vim-surround'

# enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

# shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks
Plug 'airblade/vim-gitgutter'

# language server protocol (lsp) plugin for vim9
Plug 'yegappan/lsp'

# soho vibes for vim
Plug 'rose-pine/vim', { 'as': 'rose-pine' }

# call plug#end to update &runtimepath and initialize the plugin system.
# - it automatically executes `filetype plugin indent on` and `syntax enable`
call plug#end()
# you can revert the settings after the call like so:
#   filetype indent off   # disable file-type-specific indentation
#   syntax off            # disable syntax highlighting

# ==============================================================================
# keymaps
# ==============================================================================
# use ctrl+<hjkl> to switch between windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
# same but between terminals
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

# re-size split windows using arrow keys
nnoremap <silent> <up> :resize -2<cr>
nnoremap <silent> <right> :vertical resize +2<cr>
nnoremap <silent> <down> :resize +2<cr>
nnoremap <silent> <left> :vertical resize -2<cr>

# navigate through quickfix list
nnoremap <silent> ]q :cnext<cr>zz
nnoremap <silent> [q :cprev<cr>zz

# search current marked text
vnoremap // y/\v<c-r>=escape(@",'/\')<cr><cr>

# copy marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

# default fuzzy find
nmap <leader>f :find **/*
vmap <leader>f "0y:find **/*<c-r>0<c-z>
nmap <leader>F :find **/*<c-r><c-w><c-z>
nmap <leader>e :e %:.:h<c-z>
nmap <leader>b :b <c-z>
nmap <leader>B :bd <c-z>
nmap <leader>j :jumps<cr>
nmap <leader>m :marks<cr>
nmap <leader>g :silent grep! ''<left>
vmap <leader>g "0y:silent grep! '<c-r>0'<left>
nmap <leader>G :silent grep! '<c-r><c-w>'<cr><cr>

# find and replace
nnoremap <leader>r :%s/<c-r><c-w>//g<left><left>
vnoremap <leader>r "0y:%s/<c-r>0//g<left><left>

# copy, move and remove file
nnoremap <leader>sc :!cp -r %:.<c-z> %:.:h<c-z>
nnoremap <leader>sm :!mv %:.<c-z> %:.:h<c-z>
nnoremap <leader>sr :!rm -rf %:.<c-z>

# ==============================================================================
# commands and autocmds
# ==============================================================================
autocmd! FileType c,cpp setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd! FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd! FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd! FileType javascript,typescript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

# custom find command
if executable('fd')
  def OpenFile(item: string)
    if filereadable(item) || isdirectory(item)
      execute 'edit' item
      return
    endif

    var matches = CompleteFind(item, '', 0)
    if len(matches) > 0
      execute 'edit' matches[0]
    else
      echo 'no files or directories found!'
    endif
  enddef

  def CompleteFind(pattern: string, cmdline: string, cursorpos: number): list<string>
    var cmd = 'fd -H -tf -td "' .. pattern .. '" --strip-cwd-prefix=always'
    if isdirectory(pattern)
      cmd = 'fd -H -tf -td . ' .. pattern
    endif
    return systemlist(cmd)
  enddef
  command! -nargs=1 -complete=customlist,CompleteFind Find call OpenFile(<f-args>)

  # remap fuzzy find
  nnoremap <leader>f :Find .*
  vnoremap <leader>f "0y:Find .*<c-r>0<c-z>
  nnoremap <leader>F :Find .*<c-r><c-w><c-z>
endif

# create session directory if not exist
def GetSessionDir(): string
  var session_dir = expand('~/.vim/sessions')

  if !isdirectory(session_dir)
    mkdir(session_dir, 'p')
  endif

  return session_dir
enddef

# make session automatically when save a buffer or exit vim
def VimAutoSessionizer(): void
  if !empty(argv()) && argv(0) != getcwd()
    return
  endif

  var session_dir = GetSessionDir()
  var session_name = fnamemodify(getcwd(), ':p:h:t')

  execute 'silent! mksession! ' .. session_dir .. '/' .. session_name .. '.vim'
enddef
autocmd! BufWritePost,VimLeavePre * call VimAutoSessionizer()

# load session automatically when start vim
def VimAutoSession(): void
  if !empty(argv()) && argv(0) != getcwd()
    return
  endif

  var session_dir = GetSessionDir()
  var session_name = fnamemodify(getcwd(), ':p:h:t')
  var session_file = session_dir .. '/' .. session_name .. '.vim'

  if filereadable(session_file)
    var choice = confirm("", "load last session? &yes\n&no\n&clear", 2)
    if choice == 1
      execute 'silent! source ' .. session_file
    elseif choice == 3
      delete(session_file)
    endif
  endif
enddef
autocmd! VimEnter * call VimAutoSession()

# ==============================================================================
# plugins configuration
# ==============================================================================
# color schemes should be loaded after plug#end().
# we prepend it with 'silent!' to ignore errors when it's not yet installed.
silent! colorscheme rosepine
highlight link netrwMarkFile Search

# gitgutter
g:gitgutter_map_keys = 0
nmap ]h <plug>(GitGutterNextHunk)
nmap [h <plug>(GitGutterPrevHunk)
nmap <leader>h <plug>(GitGutterPreviewHunk)
highlight! link SignColumn LineNr

# lsp features
var lsp_opts = {
  highlightDiagInline: v:false, # must be false
  autoHighlightDiags: v:true,
  autoComplete: v:false,
  diagSignErrorText: '↯',
  diagSignHintText: '↝',
  diagSignInfoText: '⇌',
  diagSignWarningText: '↺',
  ignoreMissingServer: v:true,
  keepFocusInDiags: v:true,
  keepFocusInReferences: v:true,
  hoverInPreview: v:true,
  showDiagInBalloon: v:false,
  showDiagInPopup: v:false,
  omniComplete: v:true,
  showSignature: v:false,
}
autocmd User LspSetup call LspOptionsSet(lsp_opts)
# servers
var lsp_servers = [{
  name: 'clangd',
  filetype: ['c', 'cpp'],
  path: 'clangd',
},
{
  name: 'gopls',
  filetype: 'go',
  path: 'gopls',
},
{
  name: 'pyright',
  filetype: 'python',
  path: 'pyright-langserver',
  args: ['--stdio'],
},
{
  name: 'tsserver',
  filetype: ['javascript', 'typescript'],
  path: 'typescript-language-server',
  args: ['--stdio'],
}]
autocmd User LspSetup call LspAddServer(lsp_servers)
# lsp
augroup lsp_keymaps
  autocmd!
  autocmd FileType lspgfm nnoremap <silent> <buffer> q :q<cr>
  # goto
  autocmd FileType c,cpp,go,python,javascript,typescript nnoremap gd :LspGotoDefinition<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript nnoremap gD :LspGotoDeclaration<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript nnoremap gy :LspGotoTypeDef<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript nnoremap gi :LspGotoImpl<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript nnoremap gr :LspShowReferences<cr>
  # action
  autocmd FileType c,cpp,go,python,javascript,typescript noremap K :LspHover<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript noremap ga :LspCodeAction<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript noremap gR :LspRename<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript noremap gq :LspFormat<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript noremap gq :LspFormat<cr>
  # diagnostics
  autocmd FileType c,cpp,go,python,javascript,typescript noremap ]d :LspDiagNext<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript noremap [d :LspDiagPrev<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript noremap <leader>k :LspDiagCurrent<cr>
  autocmd FileType c,cpp,go,python,javascript,typescript noremap <leader>d :LspDiagShow<cr>
augroup END

# statusline hl
highlight Statusline ctermbg=NONE guibg=NONE

# compile funcs
defcompile
