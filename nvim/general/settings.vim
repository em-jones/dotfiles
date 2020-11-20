set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set cursorline                          " Enable highlighting of the current line
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set updatetime=300                      " Faster completion
set timeoutlen=200                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else
set incsearch

" New stuff
" set notimeout nottimeout
" set scrolloff=1
" set sidescroll=1
" set sidescrolloff=1
" set display+=lastline
" set backspace=eol,start,indent
" set nostartofline
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" set mmp=1300
" set autochdir                           " Your working directory will always be the same as your working directory
" set foldcolumn=2                        " Folding abilities

" au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
