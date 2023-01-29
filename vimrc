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

" languages
Plug 'vim-ruby/vim-ruby'
Plug 'python-mode/python-mode'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
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

" Open NERTree automatically when vim starts
" autocmd VimEnter * NERDTree
" autocmd VimEnter * if argc() | wincmd p | endif

" Close NERDTree automatically when vim quits
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" AutoFormat rust files on save
let g:rustfmt_autosave = 1

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

let mapleader = "," " Set my leader key to be a comma

" Base64 Decode Selection
noremap <leader>d6 :% !base64 -d <cr>
noremap <leader>b6 :% !base64 <cr>

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
