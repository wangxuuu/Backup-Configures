call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utilities
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_user_command = 'find %s -type f'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
    let g:ctrlp_clear_cache_on_exit = 0

" NerdTree
Plug 'preservim/nerdtree'
    let g:NERDTreeWinPos = "right"
	let NERDTreeShowHidden=0
	let NERDTreeIgnore = ['\.pyc$', '__pycache__']
	let g:NERDTreeWinSize=35
	map <leader>nn :NERDTreeToggle<cr>
	map <leader>nb :NERDTreeFromBookmark<Space>
	map <leader>nf :NERDTreeFind<cr> 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Languages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Asynchronous Lint Engine
Plug 'dense-analysis/ale'
    let g:ale_linters = {
    \   'javascript': ['jshint'],
    \   'python': ['flake8'],
    \   'go': ['go', 'golint', 'errcheck']
    \}

    nmap <silent> <leader>a <Plug>(ale_next_wrap)

    " Disabling highlighting
    let g:ale_set_highlights = 0

    " Only run linting when saving the file
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0

" Beancount
" Plug 'nathangrigg/vim-beancount'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Theme -> One Dark
Plug 'joshdick/onedark.vim'

" Lightline
Plug 'itchyny/lightline.vim'

call plug#end()
