call plug#begin()
" features
Plug 'rking/ag.vim'
Plug 'bling/vim-airline'
Plug 'Chiel92/vim-autoformat'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'ddollar/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fugitive'
Plug 'drujensen/vim-test-recall'
Plug 'github/copilot.vim'

" languages
Plug 'vim-ruby/vim-ruby'
Plug 'python-mode/python-mode'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'keith/swift.vim'
Plug 'rhysd/vim-crystal'
Plug 'tfnico/vim-gradle'
Plug 'tpope/vim-classpath'
Plug 'jvenant/vim-java-imports'
call plug#end()

filetype plugin indent on

syntax on
set background=dark
set gfn=Monaco:h14
set history=10000

set vb
set nocp
set hidden
set expandtab
set autoindent
set nocompatible
set noswapfile
set showmatch
set incsearch
set number
set hlsearch
set tabstop=2
set shiftwidth=2
set softtabstop=2
set clipboard=unnamed
set textwidth=0 wrapmargin=0
set laststatus=2 " In order for airline to show with NerdTree, need to set the laststatus=2
set mouse=ar mousemodel=extend
set exrc
set secure
set splitright
set splitbelow
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set tags=.git/tags,tags;

" vim-ruby / vim-rails
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" treat all .md files as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" treat ejs as html
autocmd BufNewFile,BufReadPost *.ejs set filetype=html

" Open NERTree automatically when vim starts
" autocmd VimEnter * NERDTree
" autocmd VimEnter * if argc() | wincmd p | endif

" Close NERDTree automatically when vim quits
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Autoformat crystal files on save
let g:crystal_auto_format=1

" AutoFormat rust files on save
let g:rustfmt_autosave = 1

" enable copilot for all files
let g:copilot_filetypes = { '*': v:true, }

" Toggle paste mode with Alt-p
nnoremap π :set invpaste paste?<CR>
set pastetoggle=π

"Paste in visual mode without copying
xnoremap p pgvy

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" F3 will AutoFormat Settings
noremap <F3> :Autoformat<CR>

" F5 will remove all trailing spaces
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" F6 will toggle syntastic
silent! nnoremap <F6> :SyntasticToggleMode<CR>

" Tab/Shift Tab in Visual mode to indent text
vnoremap <Tab> >gv
vnoremap <s-Tab> <gv

" Tab between splits
nmap <Tab> <c-w><c-w>
nmap <s-Tab> <c-w><s-w>

map <C-l>  :TagbarToggle<CR>
map <C-b>  :buffers<CR>:buffer<Space>
map <C-n>  :NERDTreeToggle<CR>
map <C-f>  :NERDTreeFind<CR>
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
map <C-\>  <Esc>:sp<Space>\|<Space>term<Space>bash<CR>

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" The Silver Searcher - brew install the_silver_searcher
" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
let g:ag_working_path_mode="r"

let mapleader = "," " Set my leader key to be a comma

" Map all the run test calls provided by vim-test-recall
map <leader>t :call RunCurrentTests()<cr>
map <leader>s :call RunNearestTest()<cr>
map <leader>a :call RunAllTests()<cr>

let g:vim_test_recall_py = 'execute("sp | term pytest {spec}")'
let g:vim_test_recall_rb = 'execute("sp | term rspec {spec}")'
let g:vim_test_recall_js = 'execute("sp | term npm test --cf {spec}")'
let g:vim_test_recall_cr = 'execute("sp | term crystal spec {spec}")'
let g:vim_test_recall_go = 'execute("sp | term go test {spec}")'
let g:vim_test_recall_rs = 'execute("sp | term cargo test {spec}")'
let g:vim_test_recall_cl = 'execute("sp | term lein test {spec}")'
let g:vim_test_recall_sw = 'execute("sp | term swift test")'
let g:vim_test_recall_ja = 'execute("sp | term gradle test")'
let g:vim_test_recall_kt = 'execute("sp | term gradle test")'

" Base64 Decode Selection
noremap <leader>d6 :% !base64 -d <cr>
noremap <leader>b6 :% !base64 <cr>

" Remap Java Imports
map <unique> <Leader>js <Plug>JavaSortImport
map <unique> <Leader>ji <Plug>JavaInsertImport
map <unique> <Leader>jp <Plug>JavaInsertPackage

" Binary Editor
augroup Binary
  au!
  au BufReadPre  *.bin,*.out let &bin=1
  au BufReadPost *.bin,*.out if &bin | %!xxd
  au BufReadPost *.bin,*.out set ft=xxd | endif
  au BufWritePre *.bin,*.out if &bin | %!xxd -r
  au BufWritePre *.bin,*.out endif
  au BufWritePost *.bin,*.out if &bin | %!xxd
  au BufWritePost *.bin,*.out set nomod | endif
augroup END

" NERDTree settings
let g:nerdtree_tabs_focus_on_files=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Git settings
nnoremap <leader>g  :Git<Space>
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gr :Git restore --staged %<CR>
nnoremap <leader>gc :Git commit -v -q<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gp :Git pull<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gv :Git lg<CR>
nnoremap <Leader>gn :cnext<CR>
nnoremap <Leader>gp :cprev<CR>

" Custom Global Find
function! GlobalFind()
  let word = inputdialog('Search: ', expand('<cword>'), '')
  if word != ''
    exec ':Ag --ignore-dir=log --ignore-dir=generated ' . word
  endif
endfunction
map <leader>f :call GlobalFind()<CR>

function! SearchAndReplace()
  let search = inputdialog('Search: ', expand('<cword>'), '')
  if search != ''
    let replace = inputdialog('Replace: ', '', '')
    if replace != ''
      exec ':%s/' . search . '/' . replace . '/gc'
    endif
  endif
endfunction
map <leader>r :call SearchAndReplace()<CR>

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
