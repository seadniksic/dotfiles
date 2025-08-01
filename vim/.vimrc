" Sead's Efficient Vim Config
" ---------------------------

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.  set tabstop=4 " Use space characters instead of tabs.
set expandtab

set tabstop=4

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Show relative line numbers
set rnu

" Ensure skinny cursor in insert
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Set leader to space
let mapleader = " "

" Prevent NERDTree from opening when using stdin (e.g., piping input)
autocmd StdinReadPre * let s:std_in=1

" If Vim is opened in a directory (like 'vim .'), treat it as a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv(0)) | execute 'cd ' . expand(argv(0)) | execute 'NERDTree' | wincmd p | if winnr('$') > 1 | only | endif | endif

" If Vim is opened with a file, open NERDTree in the file's directory
autocmd VimEnter * if argc() == 1 && !isdirectory(argv(0)) | execute 'NERDTree ' . expand('%:p:h') | wincmd p | endif

" Auto save when leaving insert
autocmd InsertLeave * if filereadable(expand('%')) | silent! w | endif

filetype plugin on

" PLUGINS ---------------------------------------------------------------- {{{
call plug#begin('~/.vim/plugged')

    Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons' | Plug 'preservim/nerdcommenter'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
"    Plug 'tyrannicaltoucan/vim-deep-space'
"    Plug 'eskilop/NorthernLights.vim'
"    Plug 'ajlende/nms.vim'
    Plug 'GlennLeo/cobalt2'
    Plug 'Rigellute/rigel'

call plug#end()
" }}}

" MAPPINGS --------------------------------------------------------------- {{{

nnoremap <leader><leader> :Buffers<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>g :RG<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap <C-_> <Plug>NERDCommenterToggle
vnoremap <C-_> <Plug>NERDCommenterToggle

" QuickFix List "
nnoremap <C-c> :copen<CR>
nnoremap <C-c> :cclose<CR>

nnoremap <leader>q :call ToggleQuickfix()<CR>
 "}}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}

" COC Config ------------------------------------------------------------- {{{
"
" https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.vim

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" }}}

" Color scheme configuration {{{
set termguicolors
 syntax on
" For Norther Lights
" colorscheme northernlights
" let g:airline_theme='deep_space'

" For nms
" set t_Co=256
" colorscheme nms
" set background=dark

colorscheme cobalt2
let g:rigel_lightline = 1
let g:lightline = { 'colorscheme': 'rigel' }

" Highlight cursor line underneath the cursor horizontally.
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey20"

" }}}

" Custom Functions --------------------------------------------------------  {{{

" Find -> QuickFix
command! -nargs=+ Fq :cexpr system('rg --vimgrep <args>')
" Replace -> Clear
"command! -nargs=+ Rc :cfdo %s/<args>/g | update | cexpr []
"
"
function! ReplaceAndClearQF(args)
    " First character is the delimiter
    let delimiter = a:args[0]
    let rest = a:args[1:]

    let parts = split(rest, delimiter, 1)
    if len(parts) < 2
        echo "Error: Format should be " . delimiter . "pattern" . delimiter . "replacement" . delimiter
        return
    endif

    let pattern = parts[0]
    let replacement = parts[1]

    " Escape pattern and replacement for literal matching
    let escaped_pattern = escape(pattern, '/\.*$^~[]')
    let escaped_replacement = escape(replacement, '/\&')

    " Use \V for "very nomagic" - treats the pattern as literal text
    execute 'cfdo %s/\V' . escaped_pattern . '/' . escaped_replacement . '/g | update'
    cexpr []
endfunction


function! ReplaceAndClearQFConfirm(args)
    " First character is the delimiter
    let delimiter = a:args[0]
    let rest = a:args[1:]

    let parts = split(rest, delimiter, 1)
    if len(parts) < 2
        echo "Error: Format should be " . delimiter . "pattern" . delimiter . "replacement" . delimiter
        return
    endif

    let pattern = parts[0]
    let replacement = parts[1]

    " Escape pattern and replacement for literal matching
    let escaped_pattern = escape(pattern, '/\.*$^~[]')
    let escaped_replacement = escape(replacement, '/\&')

    " Use \V for "very nomagic" - treats the pattern as literal text
    execute 'cfdo %s/\V' . escaped_pattern . '/' . escaped_replacement . '/gc | update'
    cexpr []
endfunction

"function! ReplaceAndClearQF(args)
    "let [pattern, replacement] = split(a:args, '/')
    "execute 'cfdo %s/' . pattern . '/' . replacement . '/g | update'
    "cexpr []
"endfunction


"function! ReplaceAndClearQFConfirm(args)
    "let [pattern, replacement] = split(a:args, '/')
    "execute 'cfdo %s/' . pattern . '/' . replacement . '/gc | update'
    "cexpr []
"endfunction

command! -nargs=1 Rc call ReplaceAndClearQF(<q-args>)
command! -nargs=1 Rcc call ReplaceAndClearQFConfirm(<q-args>)
"command! -nargs=+ Rcc :cfdo %s/<args>/gc | update | cexpr []
"}}}
"
