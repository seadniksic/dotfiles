call plug#begin()
  
  Plug 'tpope/vim-sensible'
  Plug 'preservim/nerdtree'
  Plug 'https://github.com/cappyzawa/trim.nvim'
  Plug 'tomasiser/vim-code-dark'
  Plug 'coderonline/vim-recently-used'
call plug#end()

syntax on

map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

colorscheme codedark
set number

set timeoutlen=1000 ttimeoutlen=0

