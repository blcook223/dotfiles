" based on http://dougblack.io/words/a-good-vimrc.html

" Colors -------------------------------------
colorscheme badwolf " badwolf colorscheme
syntax enable       " enable syntax processing

" Spaces and Tabs ----------------------------
set tabstop=4       " visual spaces per tab
set softtabstop=4   " spaces per tab when editing
set expandtab       " replace tabs with spaces

" UI -----------------------------------------
set number          " show line numbers
set showcmd         " show last command entered
set cursorline      " highlight current line
filetype indent on  " load filetype-specific indent files
set wildmenu        " enable visual autocomplete for commands
set lazyredraw      " don't redraw unnecessarily
set showmatch       " highlight matching brackets

" Searching ----------------------------------
set incsearch       " search as charachters are entered
set hlsearch        " highlight search results

" clear highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Folding ------------------------------------
set foldenable          " enable folding
set foldlevelstart=10   " expand folds up to 10 levels by default
set foldnestmax=10      " max 10 nested folds
nnoremap <space> za     " toggle folds with space
set foldmethod=syntax   " fold based on syntax

" Movement -----------------------------------
nnoremap j gj       " move up by visual line
nnoremap k gk       " move down by visual line
nnoremap B ^        " move to beginning of line
nnoremap E $        " move to end of line
nnoremap ^ <nop>    " ^ does nothing
nnoremap $ <nop>    " $ does nothing
nnoremap gV `[v`]   " highlight last-inserted block of characters

" Vim Control --------------------------------
let mapleader=","   " leader is comma

" save session
nnoremap <leader>s :mksession<CR>

" set various filetype-dependent commands
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType javascript setlocal tabstop=2
    autocmd FileType javascript softtabstop=2
    autocmd FileType javascript shiftwidth=2
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

" strips trailing whitespace at the end of files
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Backup -------------------------------------
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
