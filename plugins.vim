" Set up vim-plug
if !filereadable(expand('~/.vim/autoload/plug.vim'))
    echo "Installing vim-plug..."
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dispatch'
Plug 'bling/vim-airline' "{{{
  let g:airline#extensions#tabline#enabled = 1
  " let g:airline#extensions#tabline#left_sep=' '
  " let g:airline#extensions#tabline#left_alt_sep='¦'
  let g:airline_theme='serene'
"}}}
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' "{{{
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gl :Glog<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gr :Gremove<CR>
  autocmd BufReadPost fugitive://* set bufhidden=delete
"}}}
Plug 'Shougo/neocomplete.vim' "{{{
  let g:neocomplete#data_directory='~/.vim/temp_dirs/neocomplete'
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    " return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  " inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  " inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " inoremap <expr><C-y>  neocomplete#close_popup()
  " inoremap <expr><C-e>  neocomplete#cancel_popup()
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  if !exists('g:neocomplete#sources')
    let g:neocomplete#sources = {}
  endif
"}}}

Plug 'Shougo/neosnippet.vim' "{{{
  let g:neosnippet#enable_snipmate_compatibility=1

  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
  smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
"}}}

Plug 'Shougo/neosnippet-snippets'

Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } "{{{
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=0
  let NERDTreeShowLineNumbers=0
  let NERDTreeChDirMode=0
  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=['\.git$','\.hg','\.meta','\.DS_Store']
  let NERDTreeBookmarksFile='~/.vim/temp_dirs/NerdTreeBookmarks'
  nnoremap <F2> :NERDTreeToggle<CR>
  nnoremap <F3> :NERDTreeFind<CR>
"}}}
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'Shougo/unite.vim' "{{{
  autocmd FileType unite call s:unite_my_settings()
  function! s:unite_my_settings()
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#profile('files', 'context.smartcase', 1)
    call unite#custom#source('line,outline','matchers','matcher_fuzzy')
  endfunction

  let g:unite_data_directory='~/.vim/temp_dirs/unite'
  " let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable=1
  let g:unite_source_rec_max_cache_files=5000
  "let g:unite_prompt='» '

  nmap <space> [unite]
  nnoremap [unite] <nop>

  nnoremap <silent> [unite] :<C-u>Unite -toggle -auto-resize -buffer-name=mixed buffer file_mru bookmark file_rec/async<CR>
  nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files -start-insert file_rec/async:!<CR>
  nnoremap <silent> [unite]e :<C-u>Unite -buffer-name=recent file_mru<CR>
  nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>
  nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
  nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
  nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
  nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
  nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>

  Plug 'Shougo/neomru.vim'
  Plug 'osyo-manga/unite-airline_themes' "{{{
    nnoremap <silent> [unite]a :<C-u>Unite -auto-preview -buffer-name=airline_themes airline_themes<cr>
  "}}}
  Plug 'ujihisa/unite-colorscheme' "{{{
    nnoremap <silent> [unite]c :<C-u>Unite -auto-preview -buffer-name=colorschemes colorscheme<cr>
  "}}}
  Plug 'tsukkee/unite-tag' "{{{
    nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=tag tag tag/file<cr>
  "}}}
  Plug 'Shougo/unite-outline' "{{{
    nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
  "}}}
  Plug 'Shougo/unite-help' "{{{
    nnoremap <silent> [unite]h :<C-u>Unite -auto-resize -buffer-name=help help<cr>
  "}}}
"}}}

Plug 'scrooloose/syntastic'
Plug 'Lokaltog/vim-easymotion'

" Automatic indenting style
Plug 'tpope/vim-sleuth'

Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'fatih/vim-go', {'for': 'go'} "{{{
  let g:go_snippet_engine = "neosnippet"
  let g:go_auto_type_info = 1
  let g:go_fmt_command = "goimports"
"}}}
Plug 'nosami/Omnisharp', {'do': 'sh -c \"cd server && xbuild\"', 'for': 'cs'}
call plug#end()
