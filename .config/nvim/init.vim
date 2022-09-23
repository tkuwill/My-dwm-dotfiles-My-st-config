" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/site/plugged')

" Declare the list of plugins.
" Plug ''
Plug 'mattn/emmet-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
" Color theme plugins
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()


""Background, color setting
set background=light
colorscheme PaperColor    
"autocmd vimenter * ++nested colorscheme gruvbox
"let g:gruvbox_contrast_light = 'hard'
"let g:gruvbox_hls_cursor = 'blue'
"colorscheme gruvbox
set t_Co=256

""general config
set cursorline
set splitbelow splitright
set ruler
" set hidden
" Enable blinking together with different cursor shapes for insert/command mode, and cursor highlighting:
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-block
  \,sm:block-blinkwait175-blinkoff150-blinkon175

    
set number
syntax on
set hlsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set listchars=tab:>~,space:.
set cindent
set ai
" set laststatus=2
" Some funky status bar code its seems
" https://stackoverflow.com/questions/9065941/how-can-i-change-vim-status-line-colour
" Formats the statusline------------------------------------------------------------------------
set laststatus=2            " set the bottom status bar

"function! ModifiedColor()
"    if &mod == 1
"        hi statusline guibg=White ctermfg=8 guifg=OrangeRed4 ctermbg=15
"    else
"        hi statusline guibg=White ctermfg=8 guifg=DarkSlateGray ctermbg=15
"    endif
"endfunction

"au InsertLeave,InsertEnter,BufWritePost   * call ModifiedColor()
" default the statusline when entering Vim
"hi statusline guibg=White ctermfg=8 guifg=DarkSlateGray ctermbg=15

" Formats the statusline
" set statusline=%F                           " file path and name
" set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
" set statusline+=%{&ff}] "file format
" set statusline+=%y      "filetype
" set statusline+=%h      "help file flag
" set statusline+=[%{getbufvar(bufnr('%'),'&mod')?'modified':'saved'}]      
"modified flag

" set statusline+=%r      "read only flag

" set statusline+=\ %=                        " align left
" set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
" set statusline+=\ Col:%c                    " current column
"set statusline+=\ Buf:%n                    " Buffer number
"set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

""encoding fixing

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

set termencoding=utf-8

set fileencoding=utf-8

set encoding=utf-8

" keymapping
nnoremap <F8> :set nowrap<cr>
nnoremap <F9> :set wrap<cr>
nnoremap <F3> :set background=light<cr>
nnoremap <F4> :set background=dark<cr>
map <F5> :NERDTreeToggle<CR>

