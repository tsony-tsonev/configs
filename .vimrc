" example insert output of command
":imap <F2> <C-R>=system('ls -lah')<C-M>

execute pathogen#infect()
call pathogen#helptags()

" make cursor in insert mode |
if exists('$TMUX')
    let &t_SI = "\ePtmux;\e\e[5 q\e\\"
    let &t_EI = "\ePtmux;\e\e[2 q\e\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

"----------GENERAL--------------
if (has("termguicolors"))
    set termguicolors
endif

" default leader 1
:let mapleader = ";"
filetype off                  " required
filetype plugin indent on
syntax on               "enable languages syntax
syntax enable

" make autocomplete not auto insert the first match
set completeopt=longest,menuone
" fix backspace key
set backspace=indent,eol,start
set ttimeoutlen=50      "faster switch to normal mode
set mouse=a             "fix mouse scroll in tmux
set number              "show line number
" set autowrite           "autowrite changes
"set paste              "paste without commenting by default   breaks neocomplete
set nocompatible
set nobackup
set showmatch           "show matching brackets
set ignorecase
set showmode
set ts=4
set sw=4
set autoindent
set smartindent
set smarttab
set softtabstop=4
set expandtab
set number
set hlsearch
set title
set ttyfast
set background=dark
set encoding=utf-8
set scrolloff=3
set shiftwidth=4
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ruler
set backspace=indent,eol,start
set laststatus=2
set showcmd
set smartcase
set gdefault
set incsearch
set showmatch
set wrap
set textwidth=79
set formatoptions=qrn1

" persistend undo
set undofile                " Save undos after file closes
" note create dir manually
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" keep cursor and window position
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif

" persist folds between vim sessions
augroup AutoSaveFolds
    autocmd!
    " view files are about 500 bytes
    " bufleave but not bufwinleave captures closing 2nd tab
    " nested is needed by bufwrite* (if triggered via other autocmd)
    autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
    autocmd BufWinEnter ?* silent! loadview
augroup end
set viewoptions=folds,cursor
set sessionoptions=folds

" keep cursor position per buffer between sessions
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" fix whole file mixed identation
map <F7> gg=G<C-o><C-o>
"----------GENERAL--------------


"--------------TEXT EDITING----------------
"------INSERT MODE
"---LETTER KEYS--- sorted Q-P A-L Z-M
" "show/close go doc
" inoremap QQ <C-O>:GoDoc<CR>
" "select word, then + or - to expand shrint selection (vim-expand-region required)
" " inoremap WW <C-O>:normal +<CR>
" " switch window with WW + plus direction h/j/k/l
" inoremap WW <C-O><C-W>
" "go to end of word
" inoremap EE <Esc>ea
" "redo
" inoremap RR <Esc><C-R>a
" "run test (neads vim-test plugin)
" ":TestFile :TestSuite :TestLast :TestVisit
" inoremap TT <C-O>:TestNearest<CR>
" " CUSOMT remove if not used
" inoremap Tt <C-O>:TestNearest -config=`pwd`/config-local.json<CR>
" "copy line
" inoremap YY <Esc>yya
" "undo
" inoremap UU <C-O>u
" "go to begin of line
" inoremap II <Esc>I
" "create new line one the next row
" inoremap OO <Esc>o
" "paste
" inoremap PP <Esc>pa
" "go to end of line
" inoremap AA <Esc>A
" "delete whole line and stay on it
" inoremap SS <Esc>S
" "delete line
" inoremap DD <Esc>ddi
" " forward and backward search
" inoremap FF <C-O>f
" inoremap Ff <C-O>F
" " golang rename variable
" inoremap GG <C-O>:GoRename<CR>
" " go to definition
" inoremap HH <C-O>:GoDef<CR>
" "move line down
" inoremap JJ <Esc>:m .+1<CR>==gi
" " move line up
" inoremap KK <Esc>:m .-2<CR>==gi
" " find implements or implementators
" inoremap LL <C-O>:GoImplements<CR>
" " switch opened windows
" inoremap ZZ <C-O><C-W><C-W>
" "forward delete
" inoremap XX <Esc>lxi
" "delete from cursor to the EOL
" inoremap CC <Esc>ld$a
" "enter visual than go back to insert mode
" inoremap VV <C-O>v
" "go to begin of word
" inoremap BB <C-O>b
" " find usages
" inoremap NN <C-O>:GoCallers<CR>
" "create mark
" inoremap MM <C-O>m
" "---LETTER KEYS---
" "quick command
" inoremap :: <C-O>:
" "go to mark
" inoremap ;; <C-O>'
" "switch last buffers in insert mode
" inoremap <C-^> <Esc> <C-^>i
" " fold toggle, fold all, unfolf all
" inoremap ;za <Esc>zajA
" inoremap ;zm <Esc>zmjA
" inoremap ;zr <Esc>zrkkA
" " delete/next/previous buffer
" inoremap ;bd <Esc>:bp<CR>:bd #<CR>i
" inoremap ;bn <C-O>:bn<CR>
" inoremap ;bp <C-O>:bp<CR>
" "force close buffer (not saving changes)
" "switch to previous buffer and then closing it due to bug with NERDTree
" inoremap ;bdx <Esc>:bp<CR>:bd! #<CR>i
" "write, write and close buffer
" inoremap ;bw <C-O>:w<CR>
" inoremap ;bwd <C-O>:w\|bd<CR>
" "go to top and bottom of file
" inoremap ;gg <C-O>gg
" inoremap ;G <C-O>G
" " switch from test to source and the opposite
" inoremap ;T <Esc>:GoAlternate<CR>a
" " close window
" inoremap ;qq <C-O><C-W>c
" " quick search
" inoremap ;/ <Esc>/
" " search with ack
" inoremap ;ac <Esc>:Ack!
" " togge nerd tree
" inoremap !! <Esc>:NERDTreeToggle<CR><C-W>la
"
" "Move up and down in autocomplete with <c-j> and <c-k>
" " autocmd VimEnter * inoremap <expr> <c-h> ("\<Left>")
" inoremap <expr> <c-k> ("\<Up>")
" inoremap <expr> <c-j> ("\<Down>")
" " inoremap <expr> <c-h> ("\<Left>") "overriden by vim backspace
" inoremap <expr> <c-l> ("\<Right>")
"------INSERT MODE
"--------------TEXT EDITING----------------

"----------NERDTree Git------------
let g:WebDevIconsUnicodeDecorateFolderNodes = 1  "enables nodes icons
let g:DevIconsEnableFoldersOpenClose = 1 "enables different icon for expandable/not expandable icons
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' ' "symbo after the icon
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ' ' "symbol before the icon
let g:NERDTreeDirArrowExpandable = nr2char(8200)  "sets expandable character to none - hides it
let g:NERDTreeDirArrowCollapsible = nr2char(8200)  "sets collapsible character to none - hides it
augroup nerdtree
  autocmd!
  autocmd FileType nerdtree syntax clear NERDTreeFlags
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
  autocmd FileType nerdtree setlocal conceallevel=3
  autocmd FileType nerdtree setlocal concealcursor=nvic
augroup END

" nerdtree highlight not only icons but also file names
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
let g:NERDTreeSyntaxEnabledExtensions = ['go', 'js', 'css', 'py', 'sh']

let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "⋆",
            \ "Staged"    : "•",
            \ "Untracked" : "∘",
            \ "Renamed"   : "®",
            \ 'Ignored'   : '☒',
            \ "Dirty"     : "⁖",
            \ "Clean"     : "✔︎",
            \ "Unmerged"  : "≄",
            \ "Deleted"   : "♻",
            \ "Unknown"   : "✗"
            \ }

let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeGitStatusWithFlags = 1
" let g:NERDTreeShowIgnoredStatus = 1

"----------NERDTree Git------------

"----Stock File Tree--------
" NERDTree like setup
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"----Stock File Tree--------

" ------VIM-TEST----------
" fix orders of command arguments
" by defualt :TestNearest puts the -run 'TestName$' at the end of the command
" but if we provie some flags like :TestNearest -foo=bar
" they must be provided after the -run 'TestName$'
" this fix depends entirly on the fact that vim-test plugin
" is putting the -run 'TestName' part at the end of the command
function! GoTransform(cmd) abort
    let runArgIdx = stridx(a:cmd, '-run')
    let runArgs = strpart(a:cmd, runArgIdx)
    let cmdPart = strpart(a:cmd, 0, runArgIdx)
    return "go test " . runArgs . strpart(cmdPart, len("go test"))
endfunction

let g:test#custom_transformations = {'go': function('GoTransform')}
let g:test#transformation = 'go'
" preserv logs from previous test runs
let g:test#preserve_screen = 1
"-------VIM-TEST----------

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

"---------GOLANG---------------
" make all lists of type quickfix so we can use only one shourtuct for moving
" through all the kinds of lists
let g:go_list_type = "quickfix"

nnoremap <leader>q :cclose<CR>
" open quickfix
nnoremap <leader>w :copen<CR>

noremap <leader>i :GoDoc<CR>
noremap <leader>T :GoAlternate<CR>

" gofmt will fix also imports
let g:go_fmt_command = "goimports"

"filetype plugin on
let g:go_disable_autoinstall = 0
" go open documentation
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
" go to implementation
au FileType go nmap <Leader>s <Plug>(go-implements)
" rename
au FileType go nmap <Leader>e <Plug>(go-rename)
" go to definition
au FileType go nmap gd <Plug>(go-def)

" Highlight
let g:go_auto_sameids = 1
let g:go_auto_type_info= 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0

" fix auto fold on GoFmt
let g:go_fmt_experimental = 1

let g:go_doc_popup_window = 1

let g:go_def_mode = 'gopls' " guru or godef or gopls
let g:go_info_mode = 'gopls' " guru or godef or gopls
let g:go_def_mapping_enabled=0
" Override vim-go's hidden override of C-t :)
nnoremap <buffer> <silent> <C-t> :TagbarToggle<cr>

" leader-b - build, leader-r -run, leader-t run tests, leader-c coverage toggle
let g:go_test_timeout = '10s'
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
" alternate (_test.go) in horizontal split, vertical split new tab or same tab
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

" error checks on save
let g:go_metalinter_command='golangci-lint'
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_autosave_enabled = ['errcheck']
let g:go_metalinter_deadline = "5s"

let g:go_gocode_unimported_packages = 1
let g:go_gocode_propose_builtins = 1                                                                                                         
"shourtucts

"experiment for importing libraries when the vim-go plugin autocomplete from
"not imported dependencies was not working
inoremap ;gi <Esc>:call GoImp()<CR>a

fun! GoImp()
    let word_under_cursor = expand("<cWORD>")
    " list packages in $GOPATH and $GOROOT
    "(export GO111MODULE=off && bash -c "go list ./`echo $GOPATH | cut -d '/' -f $(($(echo $HOME | tr -cd '/'| wc -c) +2))-`/src...")
    "(export GO111MODULE=off && bash -c "go list ./`echo $GOROOT | cut -d '/' -f $(($(echo $HOME | tr -cd '/'| wc -c) +2))-`/src...")
    "TODO filter the word from the available imports for example http and
    "shourtuct should try to import package net/http
    call setline(".", substitute(getline("."), word_under_cursor, split(word_under_cursor, "/")[-1], ""))
    execute "GoImport ".word_under_cursor
endfun

"---------GOLANG---------------

"------------NERD-TREE--------------
" auto close vim id the tree is the only one left window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
noremap <C-l> :NERDTreeToggle<CR>

" toggling packages, and not opening files on single click
let g:NERDTreeMouseMode=2

function! s:syncTree()
    if (winnr("$") > 1)
        let s:curwnum = winnr()
        NERDTreeFind
        
    endif
endfunction
" sync nerd tree to highlight the opened buffer only if tree is opened
" autocmd BufEnter * if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1) | call s:syncTree() | endif
"------------NERD-TREE--------------

"------------DEOPLETE----------------
set nocompatible
" disable the preview window
"set completeopt+=preview
let g:deoplete#enable_at_startup = 1
let g:python3_host_skip_check = 1
call deoplete#custom#option('enable_smart_case', 1)
call deoplete#custom#option('omni_patterns', {'go': '[^. *\t]\.\w*'})

let g:python3_host_prog = substitute(system('which python3.6'), '^\s*\(.\{-}\)\s*\n\+$', '\1', '')
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" let g:deoplete#sources#go#source_importer = 1
let g:deoplete#sources#go#unimported_packages = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'var', 'const', 'type']
let g:deoplete#sources#go#builtin_objects = 1

" let g:deoplete#sources#go = ['vim-go']

" fix neopairs closing the parenthesis
let g:neopairs#enable = 1
call deoplete#custom#source('_', 'converters', ['converter_auto_paren'])
"------------DEOPLETE----------------

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"-----------ULTISNIPS--------------
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="horizontal"
"-----------ULTISNIPS--------------

"--------TAB-DEOPLETE+ULTISNIPS----------
" smart TAB - opens deoplete or autocompletes a snippet
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

function! g:NeoC()
    return pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" :deoplete#manual_complete()
endfunction

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
                " return "\<Tab>"
                return NeoC()
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
"--------TAB-DEOMPLETE+ULTISNIPS----------

"----------CTRLP-------------- Search for files
set rtp+=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
"----------CTRLP--------------

"---------VIM-AIRLINE-----------
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
"---------VIM-AIRLINE-----------


"---------TAG-BAR----------
map <C-t> :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_autoclose=1
let g:easytags_async=1
set tags=./tags;
let g:easytags_dynamic_files = 1
let g:easytags_events = ['BufWritePost']

let g:tagbar_type_go = {
            \'ctagstype':'go',
            \'kinds': [
            \'p:package',
            \'i:imports',
            \'c:constants',
            \'v:variables',
            \'t:types',
            \'n:interfaces',
            \'w:fields',
            \'e:embedded',
            \'m:methods',
            \'r:constructor',
            \'f:functions'
            \],
            \'sro':'.',
            \'kind2scope':{
            \'t':'ctype',
            \'n':'ntype'
            \},
            \'scope2kind':{
            \'ctype':'t',
            \'ntype':'n'
            \},
            \'ctagsbin':'gotags',
            \'ctagsargs':'-sort -silent'
            \}

" Regenerate tags for edited file
"autocmd BufWritePost ?* !ctags %"
"---------TAG-BAR----------

"------GITGUTTER-------
" highlight clear SignColumn
autocmd ColorScheme * hi GitGutterChange guibg=#2E3440 guifg=#374752
autocmd ColorScheme * hi GitGutterAdd guibg=#2E3440 guifg=#384C38
autocmd ColorScheme * hi GitGutterDelete guibg=#2E3440 guifg=#656E76
autocmd ColorScheme * hi GitGutterChangeDelete guibg=#2E3440 guifg=#656E76
let g:gitgutter_sign_added = '█'
let g:gitgutter_sign_modified = '█'
"⬊  ▸ ↘  ⇲  ⤥  ➘  ➴  ➷ 
let g:gitgutter_sign_removed = '↘'
let g:gitgutter_sign_modified_removed = '↘'
"------GITGUTTER-------


"---------THEME--------
" Insert this into .tmux.conf
" set-option -ga terminal-overrides ",xterm-256color:Tc"
" set -g default-terminal "screen-256color"
set t_Co=256 "make sure we use 265 colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_ut=
set background=dark

" colorscheme based on file type inside the current working directory
" we could change the depth if we want to triger the theme at other level 
if system('find `pwd` -maxdepth 1 -regex ".*\.go" | wc -l') !=# 0
    " set autowrite
    "GIT-GUTTER
    autocmd ColorScheme * hi GitGutterChange guibg=#323232 guifg=#374752
    autocmd ColorScheme * hi GitGutterAdd guibg=#323232 guifg=#384C38
    autocmd ColorScheme * hi GitGutterDelete guibg=#323232 guifg=#656E76
    autocmd ColorScheme * hi GitGutterChangeDelete guibg=#323232 guifg=#656E76
    colorscheme darcula "theme should be set after the git-gutter colors
    " let g:airline_theme = 'biogoo'
    let g:airline_theme = 'zenburn' 
else
    colorscheme nord
    let g:airline_theme = 'nord'
endif

" activate underlining of typos
set spell
hi clear SpellBad
hi SpellBad cterm=underline
"---------THEME---------

"---------ALE LINTER------------
" Error and warning signs.
let g:ale_enabled = 1
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"

let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1

" activate line customizations for error and waringns
highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#9B3833 guibg=#323232
highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#f0ad4e guibg=#323232
" all warnings will be bold, could and ,underline to underline them too
hi Warning cterm=bold
" all lines which have error will turn red
hi ALEErrorLine cterm=bold gui=bold guibg=#9B3833
highlight link ALEErrorLine Error
highlight link ALEWarningLine Warning


" highlight link ALEInfoLine error
" let g:ale_sign_error = '!'
" let g:ale_sign_warning = '?'
" let g:ale_statusline_format = ['⤫ %d', '⚠ %d', '⬥ ok']
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = " "
let airline#extensions#ale#warning_symbol = " "
" let g:airline_section_z = '⇅%3p%%%3l/%L:%3v'

"See :help ale-highlights for more information.
" Only run linters named in ale_linters settings.
" let g:ale_linters_explici" t = 1
" let g:ale_linters = {'go': ['gometalinter', 'gofmt']}
" let g:ale_go_gometalinter_options = '
" \ --aggregate
" \ --fast
" \ --sort=line
" \ --vendor
" \ --vendored-linters
" \ --disable=gas
" \ --disable=goconst
" \ --disable=gocyclo
" \ '
"---------ALE LINTER------------

"------------MIMIMAP---------
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'
let g:minimap_highlight='Visual'
"------------MIMIMAP---------

"------------SHIFT-SELECTION-------------
"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv
"------------SHIFT-SELECTION-------------

"------------ACK-----------------
cnoreabbrev Ack Ack!
nnoremap <Leader>ac :Ack!<Space>
"------------ACK-----------------

"-----------Balloon-PopUp-------------
set ttymouse=sgr
set balloondelay=250
set ballooneval
set balloonevalterm

" Returns either the contents of a fold or godef.
function! BalloonExpr()
  let foldStart = foldclosed(v:beval_lnum)

  " check if we are in a fold
  if foldStart >= 0
    let foldEnd = foldclosedend(v:beval_lnum)
    let numLines = foldEnd - foldStart + 1
    let lines = []
    " Up to 31 lines get shown okay; beyond that, only 30 lines are shown with
    " ellipsis in between to indicate too much. The reason why 31 get shown ok
    " is that 30 lines plus one of ellipsis is 31 anyway.
    if ( numLines > 31 )
      let lines = getline( foldStart, foldStart + 14 )
      let lines += [ '-- Snipped ' . ( numLines - 30 ) . ' lines --' ]
      let lines += getline( foldEnd - 14, foldEnd )
    else
      let lines = getline( foldStart, foldEnd )
    endif
    
    "return join( lines, has( "balloon_multiline" ) ? "\n" : " " )
    call popup_beval(lines, #{mousemoved:'word'})
    return ""
  endif

  " check if there is a lint error on the line
  let l:loclist = get(g:ale_buffer_info, v:beval_bufnr, {'loclist': []}).loclist
  let l:index = ale#util#BinarySearch(l:loclist, v:beval_bufnr, v:beval_lnum, v:beval_col)
  " get the lint message if found
  if l:index >= 0
    "not works unless ale_set_balloons is set, but if set overrides balloonexpr
    "return ale#balloon#Expr() 
    return l:loclist[l:index].text
  endif
  
  " use golang as default
  return go#tool#DescribeBalloon() 
endfunction
set balloonexpr=BalloonExpr()
"-----------Balloon-PopUp-------------


"------------SNIPPETS----------
" type fast ;ff to insert the snippet
imap ;fpf fmt.Printf("")<left><left>
imap ;fp fmt.Println()<left>
imap ;er if err != nil {<CR>return err}<CR><CR>
imap ;tt func Test(t *testing.T){<CR>}<CR><Up><Up><Up><Right><Right><Right><Right><Right><Right><Right><Right><Right>
imap ;st struct {<CR>}{}<CR><Up><Up><Tab><Tab>
imap ;in interface {}
imap ;st struct {<CR>}{}<CR><UP><UP><TAB><TAB>
imap ;sin []interface {}{<CR>}<CR><Up><Up><Tab><Tab>
imap ;def deffer func() {}()<Left><Left><Left>
imap ;tbl cases := []struct{<CR>}{<CR>{},}<Up><Up><Up><Tab><Tab>
imap ;deq if !reflect.DeepEqual( ,) {<CR>t.Errorf(" Got:%v", )<CR>t.Errorf("Want:%v", )}<Up><Up><Up><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right>
imap ;ter if err != nil {<CR>t.Errorf("not expecting error here, but got:%v", err)}<CR>
imap ;ts ts := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {<CR>}))<CR>
            \index := strings.LastIndex(ts.URL, ":")<CR>
            \host, port := ts.URL[7:index], ts.URL[index+1:]<CR><Up><UP><UP><UP><Tab><Tab>
imap ;tmh router := mux.NewRouter()<CR>
            \router.HandleFunc("/dummy-endpoint", ).Methods("GET")<CR><CR>
            \req := httptest.NewRequest("GET", "http://example.com/dummy-endpoint", bytes.NewReader(nil))<CR>
            \w := httptest.NewRecorder()<CR>
            \router.ServeHTTP(w, req)<CR><CR>
            \resp := w.Result()<CR>
            \body, err := ioutil.ReadAll(resp.Body)<CR>
            \if err != nil {<CR>t.Error("Error reading response body", err)}<CR><Up><Up><Up><Up><Up><Up><Up><Up><Up><Up><Up><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right>
imap ;th req := httptest.NewRequest("GET", "http://example.com", bytes.NewReader(nil))<CR>
            \w := httptest.NewRecorder()<CR>
            \(w, req)<CR><CR>
            \resp := w.Result()<CR>
            \body, err := ioutil.ReadAll(resp.Body)<CR>
            \if err != nil {<CR>t.Error("Error reading response body", err)}<CR><Up><Up><Up><Up><Up><Up><Up>
imap ;nh func (w http.ResponseWriter, r *http.Request) {<CR>}<Up><Up><Right><Right><Right><Right>

function! Info()
        let info = "func Println(a ...interface{}) (n int, err error)"
        "" get the return type
        let l:returnPart = strpart(info, stridx(info, ")")+2)
        " remove parenthesis '()' from the return part if any and split the types
        let l:returnPart = substitute(l:returnPart, "(", "", "")
        let l:returnPart = substitute(l:returnPart, ")", "", "")
        let l:returnTypes = split(returnPart, ",")

        let col = col(".")
        let l:curLine = getline(".")
        let l:strippedLine = substitute(l:curLine, '^\s*\(.\{-}\)\s*$', '\1', '')
        let l:lineOffset = substitute(l:curLine, l:strippedLine, '', '')
        " chech if the function that we want to extract is inner call inside
        " another function
        let isInner = stridx(strpart(l:curLine, 0, col), "(") != -1
        " define the extrated function call return types, later append the types
        let ret = ''

        " handle single return type
        if len(l:returnTypes) == 1
            "handle named and unnmaed return types
            let ret .= split(l:returnTypes[0], " ")[0]
        else " handle multi return types
            let l:returnVars = ""
            let i = 0
            for l:key in l:returnTypes
                " handle named and unnamed return types
                if i != len(l:returnTypes) - 1
                    let ret .= split(l:key, " ")[0] . ', '
                else
                    let ret .= split(l:key, " ")[0]
                endif
                let i += 1
            endfor
        endif

        if isInner
            " left and right parts of the outer fucntion wraping the extracted one
            let leftPart = strpart(strpart(l:curLine, 0, col), 0, strridx(strpart(l:curLine, 0, col), '(')+1)
            let rightPart = strpart(l:curLine, col + stridx(strpart(l:curLine, col), ")"))
            call append('.', '') " append new line
            " set the extracted function call on the current line
            call setline(".", l:lineOffset . ret . " := " . strpart(l:strippedLine, len(leftPart)-1, len(l:curLine) - len(leftPart) - len(rightPart)))
            normal! j
            " set on the new line the initial one, but instead the function call use
            " the first return type of the extracnted function
            call setline(".", leftPart . split(ret, ",")[0] . rightPart)
            normal! j
        endif

        if !isInner
            " call append('.', '') " append new line
            call setline(".", l:lineOffset . ret . " := " . l:strippedLine)
            normal! j
        endif

endfunction
imap <F3> <C-O>:call Info()<CR>
"---extract golang variable
"
"------------SNIPPETS----------

"--------FOLD----------
set nofoldenable
" set foldcolumn=0
" set foldlevel=2
set foldmethod=syntax
set foldnestmax=1
let g:go_fmt_experimental = 1


" Minimal style for folded code
function! MyFoldText() " {{{
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth 
    let foldedlinecount = v:foldend - v:foldstart

    let line = getline(v:foldstart)
    let lastLine = getline(v:foldend)
    let lastLineLastChar = lastLine[len(lastLine)-1]
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len("⊞ ...") - len("⇲")

    " ☟ ⚶  ⊎ ≻ ≺ ⇲ ↯ ⚞ ⚟
    return "⊞ " . line . '...' . lastLineLastChar . repeat(" ", fillcharcount) . foldedlinecount . '⇲ '

endfunction " }}}
set foldtext=MyFoldText()

"fix folded code highlight - this line must at the end of script, 
"because it is overridden by some of the rest of the plugins
hi! link Folded SignColumn
"---------FOLD----------
