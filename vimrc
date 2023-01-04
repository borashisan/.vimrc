set number

"バックアップファイルを作らない
set nobackup

" スワップファイルを作らない
set noswapfile

autocmd BufWritePost  ~/.config/nvim/init.vim  so ~/.config/nvim/init.vim

" エンコーディング
set encoding=utf-8
scriptencoding utf-8

noremap ; :

syntax enable

set clipboard=unnamedplus

set expandtab                                                   " tabを複数のspaceに置き換え
set tabstop=2                                                   " tabは半角2文字
set shiftwidth=2

let &t_SI = "\e[6 q"
let &t_EI = "\e[1 q"
set ttimeout
set ttimeoutlen=1
set ttyfast

"Fern
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
let g:fern#default_hidden=1


"vim lsp
if executable('solargraph')
  augroup LspRuby
    au!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'whitelist': ['ruby'],
        \ })
    autocmd FileType ruby setlocal omnifunc=lsp#complete
  augroup END
endif

nnoremap <expr> <C-]> execute('LspPeekDefinition') =~ "not supported" ? "\<C-]>" : ":LspDefinition<cr>"
nmap <silent> gr <plug>(lsp-references)

let g:lsp_diagnostics_enabled=1

let g:lsp_diagnostics_echo_cursor=1

let g:lsp_diagnostics_float_cursor=1

let g:lsp_diagnostics_virtual_text_enabled=0

"asyncomplete
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" neoterm
nnoremap <S-T> :Ttoggle<CR>
let g:neoterm_default_mod = 'belowright'
let g:neoterm_size=20
let g:neoterm_autoinsert = 1

"blamer"
let g:blamer_enabled = 0
let g:blamer_template = '<commit-short> <committer>, <committer-time> • <summary>'

"airline
let g:airline#extensions#tabline#enabled = 1

"control + p, bでタブ切り替え
nmap <S-Left> <Plug>AirlineSelectPrevTab
nmap <S-Right> <Plug>AirlineSelectNextTab

"" fzf.vim
" Ctrl+pでファイル検索を開く
" git管理されていれば:GFiles、そうでなければ:Filesを実行する
"fun! FzfOmniFiles()
"  let is_git = system('git status')
"  if v:shell_error
"    :Files
"  else
"    :GFiles
"  endif
"endfun
"nnoremap <C-p> :call FzfOmniFiles()<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-e> :History<CR>

" Ctrl+gで文字列検索を開く
" <S-?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>

" javascript
set re=0
let g:vim_jsx_pretty_colorful_config = 1

call plug#begin()
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'cohama/lexima.vim'
"Plug 'sainnhe/everforest'
"Plug 'morhetz/gruvbox'
Plug 'doums/darcula'
Plug 'APZelos/blamer.nvim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'yuezk/vim-js'
call plug#end()

colorscheme darcula

" vim透過
augroup TransparentBG
  	autocmd!
	autocmd Colorscheme * highlight Normal ctermbg=none
	autocmd Colorscheme * highlight NonText ctermbg=none
	autocmd Colorscheme * highlight LineNr ctermbg=none
	autocmd Colorscheme * highlight Folded ctermbg=none
	autocmd Colorscheme * highlight EndOfBuffer ctermbg=none
augroup END
