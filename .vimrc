" use pathogen - required by apt-vim

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
set ttimeoutlen=50      "faster switch to normal mode
set mouse=a             "fix mouse scroll in tmux
set number              "show line number
set autowrite   "autowrite changes
"set paste              "paste without commenting by default   breaks neocomplete
set nocompatible
set nobackup
" set showmatch           "show matching brackets
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

" Folding
set nofoldenable
set foldmethod=indent
set foldnestmax=1
set foldlevel=2

" persistend undo
set undofile                " Save undos after file closes
" note create dir manually
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
"----------GENERAL--------------


"--------------TEXT EDITING----------------
"------INSERT MODE
" fix backspace key
set backspace=indent,eol,start
"go to begin of line
inoremap II <Esc>I
"go to end of line
inoremap AA <Esc>A
"create new line one the next row
inoremap OO <Esc>o
"delete from cursor to the EOL
inoremap CC <Esc>ld$a
"delete whole line and stay on it
inoremap SS <Esc>S
"delete line
inoremap DD <Esc>ddi
"copy line
inoremap YY <Esc>yya
"paste
inoremap PP <Esc>pa
"undo
inoremap UU <C-O>u
"redo
inoremap RR <Esc><C-R>a
"forward delete
inoremap XX <Esc>lxi
"move line down
inoremap JJ <Esc>:m .+1<CR>==gi
"move line up
inoremap KK <Esc>:m .-2<CR>==gi
"enter visual than go back to insert mode
inoremap VV <C-O>v
" fold toggle, fold all, unfolf all
inoremap ;ff <Esc>zajA
inoremap ;fa <Esc>zmjA
inoremap ;fu <Esc>zrkkA
"show/close go doc
inoremap QQ <C-O>:GoDoc<CR>
"go to bottom of file
inoremap GG <C-O>G
"go to top of file
inoremap Gg <C-O>gg
" forward and backward search
inoremap FF <C-O>f
inoremap Ff <C-O>F
"go to begin of word
inoremap BB <C-O>b
"go to end of word
inoremap EE <Esc>ea
"create mark
inoremap MM <C-O>m
"go to mark
inoremap '' <C-O>'
" go to definition
inoremap HH <C-O>:GoDef<CR>
" find usages
inoremap NN <C-O>:GoCallers<CR>
" find possible callers based on the definition under the cursor
inoremap LL <C-O>:GoCallees<CR>
" switch opened windows
inoremap ZZ <C-O><C-W><C-W>
"select word, then + or - to expand shrint selection (vim-expand-region required)
" inoremap WW <C-O>:normal +<CR>
" switch window with WW + plus direction h/j/k/l
inoremap WW <C-O><C-W>
"run test (neads vim-test plugin)
":TestFile :TestSuite :TestLast :TestVisit
inoremap TT <C-O>:TestNearest<CR>
"shitch last buffers in insert mode
inoremap <C-z> <C-O> <C-O><C-^>
" delete/next/previous buffer
inoremap ;bd <C-O>:bd<CR>
inoremap ;bn <C-O>:bn<CR>
inoremap ;bp <C-O>:bp<CR>
"force close buffer (not saving changes)
inoremap ;bdd <C-O>:bd!<CR>
"write, write and close buffer
inoremap ;bw <C-O>:w<CR>
inoremap ;bwd <C-O>:w\|bd<CR>
"------INSERT MODE
" close the list
inoremap ;qq <C-O><C-W>c
nnoremap <leader>q :cclose<CR>
" open quickfix
nnoremap <leader>w :copen<CR>

" ------VIM-TEST----------
" let g:test#preserve_screen = 1
" let g:test#strategy = 'vimterminal'
" let test#filename_modifier = ':.' " test/models/user_test.rb (default)
" let test#filename_modifier = ':p' " /User/janko/Code/my_project/test/models/user_test.rb
" let test#filename_modifier = ':~' "~/Code/my_project/test/models/user_test.rb
"-------VIM-TEST----------

"--------------TEXT EDITING----------------

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

"---------GOLANG---------------
" make all lists of type quickfix so we can use only one shourtuct for moving
" through all the kinds of lists
let g:go_list_type = "quickfix"
" let test#go#runner = 'ginkgo'
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
let g:go_auto_type_info=0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_auto_sameids = 1
let g:go_highlight_build_constraints = 1

let g:go_def_mode = 'guru' " guru or godef
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
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_autosave_enabled = ['errcheck']
let g:go_metalinter_deadline = "5s"
"---------GOLANG---------------

"------------NERD-TREE--------------
" auto close vim id the tree is the only one left window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
noremap <C-l> :NERDTreeToggle<CR>

" auto open tree and focus on opened view after starting (instead of NERDTree)
autocmd VimEnter * call s:syncTree()
au VimEnter * :wincmd w

" always highlight active buffer file in the NERDTree
" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! s:syncTree()
  let s:curwnum = winnr()
  NERDTreeFind
  exec s:curwnum . "wincmd w"
endfunction
" " Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()
function! s:syncTreeIf()
  if (winnr("$") > 1)
    call s:syncTree()
  endif
endfunction
  
" Shows NERDTree on start and synchronizes the tree with opened file when switching between opened windows
autocmd BufEnter * call s:syncTreeIf()
"------------NERD-TREE--------------

" Autocompletion
let g:acp_enableAtStartup = 0

"----------NEO-COMPLETE-------------
set nocompatible              " be iMproved, required
"real-time code completion with neocomplete
set omnifunc='flowcomplete#Complete'
let g:neocomplete#enable_at_startup = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" disable the preview window
set completeopt-=preview
" Move up and down in autocomplete with <c-j> and <c-k>
" autocmd VimEnter * inoremap <expr> <c-h> ("\<Left>")
inoremap <expr> <c-j> ("\<Down>")
inoremap <expr> <c-k> ("\<Up>")
" inoremap <expr> <c-h> ("\<Left>") "overriden by vim backspace
inoremap <expr> <c-l> ("\<Right>")
"----------NEO-COMPLETE-------------


"-----------ULTISNIPS--------------
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="horizontal"
"-----------ULTISNIPS--------------

"--------TAB-NEOCOMPLETE+ULTISNIPS----------
" smart TAB - opens neocomplete from index position or autocompletes a snippet
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

function! g:NeoC()
    return pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" :neocomplete#start_manual_complete()
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
"--------TAB-NEOCOMPLETE+ULTISNIPS----------

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

"--------FOLD----------
set foldmethod=syntax
set foldcolumn=0

" Minimal style for folded code
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

"---------FOLD----------

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


"---------THEME--------
" Insert this into .tmux.conf
" set-option -ga terminal-overrides ",xterm-256color:Tc"
" set -g default-terminal "screen-256color"
set t_Co=256 "make sure we use 265 colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_ut=
set background=dark
colorscheme nord
let g:airline_theme = 'nord'
let g:material_terminal_italics = 1
let g:material_theme_style = 'default'
"---------THEME---------

"---------ALE LINTER------------
" Error and warning signs.
let g:ale_enabled = 1
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500
highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#f0ad4e
" all lines which have error signs will turn red
hi Error cterm=bold gui=bold
hi Warning cterm=bold gui=bold guibg=#f0ad4e
highlight link ALEErrorLine Error
" highlight link ALEWarningLine Warning
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
nnoremap <Leader>a :Ack!<Space>
"------------ACK-----------------

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

" call s:run_guru(args)
function! s:guru_cmd(args) range abort
    let mode = a:args.mode
    let format = a:args.format
    let needs_scope = a:args.needs_scope
    let selected = a:args.selected

    let result = {}
    let pkg = go#package#ImportPath()

    " this is important, check it!
    if pkg == -1 && needs_scope
        return {'err': "current directory is not inside of a valid GOPATH"}
    endif

    "return with a warning if the binary doesn't exist
    let bin_path = go#path#CheckBinPath("guru")
    if empty(bin_path)
        return {'err': "bin path not found"}
    endif

    " start constructing the command
    let cmd = [bin_path, '-tags', go#config#BuildTags()]

    if &modified
        let result.stdin_content = go#util#archive()
        call add(cmd, "-modified")
    endif

    " enable outputting in json format
    if format == "json"
        call add(cmd, "-json")
    endif

    let scopes = go#config#GuruScope()
    if empty(scopes)
        " some modes require scope to be defined (such as callers). For these we
        " choose a sensible setting, which is using the current file's package
        if needs_scope
            let scopes = [pkg]
        endif
    endif

    " Add the scope.
    if !empty(scopes)
        " guru expect a comma-separated list of patterns.
        let l:scope = join(scopes, ",")
        let result.scope = l:scope
        call extend(cmd, ["-scope", l:scope])
    endif

    let pos = printf("#%s", go#util#OffsetCursor())
    if selected != -1
        " means we have a range, get it
        let pos1 = go#util#Offset(line("'<"), col("'<"))
        let pos2 = go#util#Offset(line("'>"), col("'>"))
        let pos = printf("#%s,#%s", pos1, pos2)
    endif

    let l:filename = fnamemodify(expand("%"), ':p:gs?\\?/?') . ':' . pos
    call extend(cmd, [mode, l:filename])

    let result.cmd = cmd
    return result
endfunction

function! s:sync_guru(args) abort
    let result = s:guru_cmd(a:args)
    if has_key(result, 'err')
        call go#util#EchoError(result.err)
        return -1
    endif

    if !has_key(a:args, 'disable_progress')
        if a:args.needs_scope
            call go#util#EchoProgress("analysing with scope ". result.scope .
                        \ " (see ':help go-guru-scope' if this doesn't work)...")
        elseif a:args.mode !=# 'what'
            " the query might take time, let us give some feedback
            call go#util#EchoProgress("analysing ...")
        endif
    endif

    " run, forrest run!!!
    if has_key(l:result, 'stdin_content')
        let [l:out, l:err] = go#util#Exec(l:result.cmd, l:result.stdin_content)
    else
        let [l:out, l:err] = go#util#Exec(l:result.cmd)
    endif

    if has_key(a:args, 'custom_parse')
        call a:args.custom_parse(l:err, l:out, a:args.mode)
    endif

    return l:out
endfunc

function! Info()
    function! s:info(exit_val, output, mode)
        if a:exit_val != 0
            return
        endif

        if a:output[0] !=# '{'
            return
        endif

        if empty(a:output) || type(a:output) != type("")
            return
        endif

        let result = json_decode(a:output)
        if type(result) != type({})
            call go#util#EchoError(printf("malformed output from guru: %s", a:output))
            return
        endif

        if !has_key(result, 'detail')
            " if there is no detail check if there is a description and print it
            if has_key(result, "desc")
                call go#util#EchoInfo(result["desc"])
                return
            endif

            call go#util#EchoError("detail key is missing. Please open a bug report on vim-go repo.")
            return
        endif

        let detail = result['detail']
        let info = ""

        " guru gives different information based on the detail mode. Let try to
        " extract the most useful information

        if detail == "value"
            if !has_key(result, 'value')
                call go#util#EchoError("value key is missing. Please open a bug report on vim-go repo.")
                return
            endif

            let val = result["value"]
            if !has_key(val, 'type')
                call go#util#EchoError("type key is missing (value.type). Please open a bug report on vim-go repo.")
                return
            endif

            let info  = val["type"]
        elseif detail == "type"
            if !has_key(result, 'type')
                call go#util#EchoError("type key is missing. Please open a bug report on vim-go repo.")
                return
            endif

            let type = result["type"]
            if !has_key(type, 'type')
                call go#util#EchoError("type key is missing (type.type). Please open a bug report on vim-go repo.")
                return
            endif

            let info  = type["type"]
        elseif detail == "package"
            if !has_key(result, 'package')
                call go#util#EchoError("package key is missing. Please open a bug report on vim-go repo.")
                return
            endif

            let package = result["package"]
            if !has_key(package, 'path')
                call go#util#EchoError("path key is missing (package.path). Please open a bug report on vim-go repo.")
                return
            endif

            let info = printf("package %s", package["path"])
        elseif detail == "unknown"
            let info = result["desc"]
        else
            call go#util#EchoError(printf("unknown detail mode found '%s'. Please open a bug report on vim-go repo", detail))
            return
        endif

        " All credits to fatih from the vim-go plugin for the code above
        "---------------------------------------------------------------

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
            let rightPart = strpart(l:curLine, col + stridx(strpart(l:curLine, col), ")")+1)
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

    let l:args = {
                \ 'mode': 'describe',
                \ 'format': 'json',
                \ 'selected': -1,
                \ 'needs_scope': 0,
                \ 'custom_parse': function('s:info'),
                \ 'disable_progress': 1,
                \ }

    call s:sync_guru(l:args)
endfunction

imap <F3> <C-O>:call Info()<CR>
"------------SNIPPETS----------


