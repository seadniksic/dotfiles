-- Sead's NVim config! --
--
--
-- Set Vim Options
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- vim.opt.termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"

--Add numbers to each line on the left-hand side.
vim.opt.number=true
--Set shift width to 4 spaces.
vim.opt.shiftwidth=2

--Set tab width to 4 columns.  vim.opt.tabstop=4 --Use space characters instead of tabs.
vim.opt.expandtab=true

vim.opt.tabstop=2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

--Do not wrap lines. Allow long lines to extend as far as the line goes.
vim.opt.wrap=false

--While searching though a file incrementally highlight matching characters as you type.
vim.opt.incsearch=true

--Ignore capital letters during search.
vim.opt.ignorecase=true

--Override the ignorecase option if searching for capital letters.
--This will allow you to search specifically for capital letters.
vim.opt.smartcase=true

--Do not let cursor scroll below or above N number of lines when scrolling.
vim.opt.scrolloff=10

--Show partial command you type in the last line of the screen.
vim.opt.showcmd=true

--Show the mode you are on the last line.
vim.opt.showmode=true

--Show matching words during a search.
vim.opt.showmatch=true

--Use highlighting when doing a search.
vim.opt.hlsearch=true

--Set the commands to save in history default number is 20.
vim.opt.history=1000

--Enable auto completion menu after pressing TAB.
vim.opt.wildmenu=true

--Make wildmenu behave like similar to Bash completion.
-- vim.opt.wildmode=list:longest

--There are certain files that we would never want to edit with Vim.
--Wildmenu will ignore files with these extensions.
-- vim.opt.wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

--Show relative line numbers
vim.opt.rnu=true

--
-- neovim specific configuration
--

--
-- add modules with lazy.nvim
--

-- install lazy for module configuration
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- Git related plugins
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',

  'pocco81/auto-save.nvim',

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  --
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvimtree = require("nvim-tree")
    nvimtree.setup({
        git = {
          ignore = false
        }
      })
  end,
  },

 {
    "ntpeters/vim-better-whitespace",
    config = function()
      -- Enable the plugin
      vim.g.better_whitespace_enabled = 1

      -- Highlight trailing whitespace
      vim.g.strip_whitespace_on_save = 1

      -- Strip only modified lines, not the whole file (optional)
      vim.g.strip_whitespace_confirm = 0

      -- To remove trailing whitespace automatically on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        command = "StripWhitespace"
      })
    end
  },

  -- Useful plugin to show you pending keybinds.
  -- { 'folke/which-key.nvim', opts = {} },
 -- {
 --    -- Adds git related signs to the gutter, as well as utilities for managing changes
 --    'lewis6991/gitsigns.nvim',
 --    opts = {
 --      -- See `:help gitsigns.txt`
 --      signs = {
 --        add = { text = '+' },
 --        change = { text = '~' },
 --        delete = { text = '_' },
 --        topdelete = { text = '‾' },
 --        changedelete = { text = '~' },
 --      },
 --      on_attach = function(bufnr)
 --        local gs = package.loaded.gitsigns

 --        local function map(mode, l, r, opts)
 --          opts = opts or {}
 --          opts.buffer = bufnr
 --          vim.keymap.set(mode, l, r, opts)
 --        end

 --        -- Navigation
 --        map({ 'n', 'v' }, ']c', function()
 --          if vim.wo.diff then
 --            return ']c'
 --          end
 --          vim.schedule(function()
 --            gs.next_hunk()
 --          end)
 --          return '<Ignore>'
 --        end, { expr = true, desc = 'Jump to next hunk' })

 --        map({ 'n', 'v' }, '[c', function()
 --          if vim.wo.diff then
 --            return '[c'
 --          end
 --          vim.schedule(function()
 --            gs.prev_hunk()
 --          end)
 --          return '<Ignore>'
 --        end, { expr = true, desc = 'Jump to previous hunk' })

 --        -- Actions
 --        -- visual mode
 --        map('v', '<leader>hs', function()
 --          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
 --        end, { desc = 'stage git hunk' })
 --        map('v', '<leader>hr', function()
 --          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
 --        end, { desc = 'reset git hunk' })
 --        -- normal mode
 --        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
 --        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
 --        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
 --        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
 --        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
 --        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
 --        map('n', '<leader>hb', function()
 --          gs.blame_line { full = false }
 --        end, { desc = 'git blame line' })
 --        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
 --        map('n', '<leader>hD', function()
 --          gs.diffthis '~'
 --        end, { desc = 'git diff against last commit' })

 --        -- Toggles
 --        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
 --        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

 --        -- Text object
 --        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
 --      end,
 --    },
 --  },

  -- {
  --   -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   opts = {
  --     style = 'cool',
  --   },
  --   config = function(_, opts)
  --     require("onedark").setup(opts)
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },

  {
  --   -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help ibl`
  --   main = 'ibl',
  --   opts = {},
  -- },

  -- "gc" to comment visual regions/lines
  -- This is a comment from sead:  gcc comments the current selection or line with line comments, gbc does a block comment
  -- { 'numToStr/Comment.nvim', opts = {
  --           ignore = '^$',
  --           toggler = {
  --               line = '<C-_>',
  --               block = '<leader>bc',
  --           },
  --           opleader = {
  --               line = '<C-_>',
  --               block = '<leader>b',
  --           },
  --        },
  -- },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  -- {
  --   -- Highlight, edit, and navigate code
  --   'nvim-treesitter/nvim-treesitter',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter-textobjects',
  --   },
  --   build = ':TSUpdate',
  -- },

}, {})


--
-- activate modules that were added by lazy
--

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { "clangd", "pyright" },
})

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gl", require('telescope.builtin').diagnostics, 'Get Diagnostics')
  nmap("ge", function()
  vim.diagnostic.open_float(nil, { scope = "line" })
  end, "show line diagnostics")

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {

  clangd = {
    format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
    },
  },
  pyright = {
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
    },
  },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}


require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set('n', '<C-n>', ":NvimTreeToggle<CR>", { desc = 'Toggles NvimTree' })

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })


--
-- Custom Functions
--

local function escape_str(str, chars)
  -- Escape special chars in `chars` by prefixing with `\`
  return (str:gsub("[" .. chars .. "]", "\\%0"))
end

local function parse_args(args)
  local delimiter = args:sub(1,1)
  local rest = args:sub(2)
  local parts = {}
  for part in rest:gmatch("[^" .. delimiter .. "]+") do
    table.insert(parts, part)
  end
  if #parts < 2 then
    vim.api.nvim_err_writeln("Error: Format should be " .. delimiter .. "pattern" .. delimiter .. "replacement" .. delimiter)
    return nil, nil
  end
  return parts[1], parts[2]
end

local function replace_and_clear_qf(args, confirm)
  local pattern, replacement = parse_args(args)
  if not pattern then return end

  -- Escape for literal matching (similar to your Vim escape)
  local escaped_pattern = escape_str(pattern, "/\\.*$^~[]")
  local escaped_replacement = escape_str(replacement, "/&")
  -- Build the substitution command
  local cmd = string.format("cfdo %%s/\\V%s/%s/%sg | update", escaped_pattern, escaped_replacement, confirm and "c" or "")

  -- Run the command
  vim.cmd(cmd)
  -- Clear quickfix list
  vim.fn.setqflist({})
end

-- Commands

vim.api.nvim_create_user_command("Fq", function(opts)
  -- opts.args is the arguments string passed to the command
  local grep_cmd = "rg --vimgrep " .. opts.args
  local result = vim.fn.systemlist(grep_cmd)
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_err_writeln("Error running rg: " .. table.concat(result, "\n"))
    return
  end
  -- Set quickfix list to rg output
  vim.fn.setqflist({}, ' ', { title = 'Rg Search', lines = result })
  -- Open quickfix window
  vim.cmd("copen")
end, { nargs = "+" })

vim.api.nvim_create_user_command("Rc", function(opts)
  replace_and_clear_qf(opts.args, false)
end, { nargs = 1 })

vim.api.nvim_create_user_command("Rcc", function(opts)
  replace_and_clear_qf(opts.args, true)
end, { nargs = 1 })


-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}
