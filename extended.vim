" Colorscheme
" colorscheme molokai
set background=dark
" colorscheme base16-monokai
colorscheme busybee
highlight clear SignColumn
" colorscheme jellybeans
" colorscheme rdark
" let g:colors_name="molokai"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! ~/.vim/<cr>
autocmd! bufwritepost ~/vim/*.vim source %


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" C#
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
let g:syntastic_cs_checkers = ['syntax', 'issues']
autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
let g:neocomplete#sources#omni#input_patterns.cs = '\.*[^=\);]'
let g:neocomplete#sources.cs = ['omni']

set completeopt=longest,menuone,preview
