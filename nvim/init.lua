-- Starter installation from: https://github.com/VonHeikemen/nvim-starter/tree/04-lsp-installer
-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"
vim.opt.textwidth = 120

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.ms", command="set filetype=bsv | set conceallevel=0" }
)

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.bsv", command="autocmd FileType bsv setlocal conceallevel=0" }
)

-- vim.api.nvim_create_autocmd(
--   { "BufRead", "BufNewFile" },
--   { pattern = "*.ms", command="set filetype=bsv | set conceallevel=0 | echo 'did it'" }
-- )

-- TODO: Get a better thing than netrw
-- vim.g.netrw_list_hide = [[.*\.o$]]
-- vim.g.netrw_banner = 0

-- vim.api.nvim_command('filetype plugin on')

-- For bsv files. Remove this after 6.191 is done
-- vim.opt.conceallevel = 0

-- CoqtailChecked xxx ctermbg=17 guibg=LightGreen

-- vim.cmd[[autocmd ColorScheme * hi def CoqtailSent ctermbg=021]] -- Blue (https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg)
-- vim.cmd[[hi Folded ctermbg=233]]
-- vim.cmd([[
-- augroup CoqtailHighlights
--   autocmd!
--   autocmd ColorScheme *
--     \  hi def CoqtailSent    ctermbg=021 
-- augroup END
-- ]]) -- Blue (https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg)

    -- \| hi def CoqtailChecked ctermbg=199 " Pink

-- ========================================================================== --
-- ==                               REMAPS                                 == --
-- ========================================================================== --

vim.g.mapleader = " "
vim.g.maplocalleader = "," -- This is necessary for Conjure mappings
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", vim.cmd.w)

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>,", vim.cmd.noh)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "c++" },
  callback = function()
    vim.keymap.set("n", "<leader>h", ":ClangdSwitchSourceHeader<CR>", { buffer = true })
  end,
})

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "z=", [[z=1]])

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-v><Esc>", "<Esc>")
-- Terminal mode:
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
-- Insert mode:
vim.keymap.set("i", "<C-h>", "<EsC><C-w>h")
vim.keymap.set("i", "<C-j>", "<EsC><C-w>j")
vim.keymap.set("i", "<C-k>", "<EsC><C-w>k")
vim.keymap.set("i", "<C-l>", "<EsC><C-w>l")


-- Undo tree bindings
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- In OCaml, remove the explicit type of a parameter (x : t) to be just x
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ocaml",
  callback = function()
    vim.keymap.set("n", "<leader>t", "F(eldf)Bx", { buffer = true })
  end,
})


-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command('Wrap', 'set wrap lbr', {})
vim.api.nvim_create_user_command('Fold', 'set foldmethod=indent', {})

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  -- Theming
  -- {'folke/tokyonight.nvim'},
  -- {'joshdick/onedark.vim'},
  -- {'tanvirtin/monokai.nvim'},
  -- {'lunarvim/darkplus.nvim'},
  {'catppuccin/nvim'},
  {'kyazdani42/nvim-web-devicons'},

  {'nvim-lualine/lualine.nvim'},
  -- {'akinsho/bufferline.nvim'},
  {'lukas-reineke/indent-blankline.nvim', version = '3.x'},

  -- File explorer
  {'kyazdani42/nvim-tree.lua', lazy = false },

  -- File/text finding
  -- {'nvim-telescope/telescope.nvim', branch = '0.1.x'},
  -- {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
  {
    'https://github.com/junegunn/fzf.vim',
    -- I have the fzf binary installed already, that's why I don't need to run build step here
    dependencies = { { 'https://github.com/junegunn/fzf' } },
    -- You must ':call fzf#install()' at least once. Idk how to make it do this on startup
  },
  {'theprimeagen/harpoon'},

  -- Git
  {'lewis6991/gitsigns.nvim'},
  {'tpope/vim-fugitive'},
  {'mbbill/undotree'},
  {'psliwka/vim-smoothie'},

  -- Code manipulation
  {'nvim-treesitter/nvim-treesitter'},
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  {'numToStr/Comment.nvim'},
  {'tpope/vim-surround'},
  {'wellle/targets.vim'},
  {'tpope/vim-repeat'},

  -- Language support
  {'whonore/Coqtail'},
  {'lervag/vimtex'},
  {'mtikekar/vim-bsv'},
  {'tikhomirov/vim-glsl'},
  {'Olical/conjure'},
  { "julienvincent/nvim-paredit" },  -- Paredit for scheme

  -- Utilities
  {'nvim-lua/plenary.nvim'},
  {'akinsho/toggleterm.nvim'},

  -- LSP support
  {'williamboman/mason.nvim', lazy = false},
  {'williamboman/mason-lspconfig.nvim', lazy = false},
  {'neovim/nvim-lspconfig', lazy = false},

  -- Autocomplete
  -- {'hrsh7th/nvim-cmp'},
  -- {'hrsh7th/cmp-buffer'},
  -- {'hrsh7th/cmp-path'},
  -- {'saadparwaiz1/cmp_luasnip'},
  -- {'hrsh7th/cmp-nvim-lsp'},
  -- {'hrsh7th/cmp-nvim-lua'},

  -- Snippets
  -- {'L3MON4D3/LuaSnip'},
  -- {'rafamadriz/friendly-snippets'},
})


-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
vim.cmd.colorscheme('catppuccin')


---
-- lualine.nvim (statusline)
---
vim.opt.showmode = false

-- See :help lualine.txt
require('lualine').setup({
  options = {
    theme = 'catppuccin',
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
      statusline = {'NvimTree'},
    },
  },
})


---
-- bufferline
---
-- See :help bufferline-settings
-- require('bufferline').setup({
--   options = {
--     mode = 'buffers',
--     offsets = {
--       {filetype = 'NvimTree'}
--     },
--   },
--   -- :help bufferline-highlights
--   highlights = {
--     buffer_selected = {
--       italic = false
--     },
--     indicator_selected = {
--       fg = {attribute = 'fg', highlight = 'Function'},
--       italic = false
--     }
--   }
-- })


---
-- Treesitter
---
-- See :help nvim-treesitter-modules
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  -- :help nvim-treesitter-textobjects-modules
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
  },
  ensure_installed = {
    'typescript',
    'tsx',
    'lua',
    'vim',
    'css',
    'json',
    'python',
    'c',
    'ocaml',
  },
  sync_install = false,
})


---
-- Comment.nvim
---
require('Comment').setup({})


---
-- Indent-blankline
---
-- See :help ibl.setup()
require('ibl').setup({
  enabled = false,
  scope = {
    enabled = false,
  },
  indent = {
    char = '▏',
  },
})


---
-- Gitsigns
---
-- See :help gitsigns-usage
require('gitsigns').setup({
  signs = {
    add = {text = '▎'},
    change = {text = '▎'},
    delete = {text = '➤'},
    topdelete = {text = '➤'},
    changedelete = {text = '▎'},
  }
})


---
-- Telescope
---
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
-- local additional_rg_args = { "--hidden", "--glob", "!**/.git/*", "--glob", "!**/node_modules/*" }
-- require('telescope').setup {
--   extensions = {
--     fzf = {
--       fuzzy = true,                    -- false will only do exact matching
--       override_generic_sorter = true,  -- override the generic sorter
--       override_file_sorter = true,     -- override the file sorter
--       case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
--     },
--     ["ui-select"] = {
--       require("telescope.themes").get_dropdown({}),
--     },
--   },
--   defaults = {},
--   pickers = {
--     find_files = {
--       -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
--       find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
--     },
--     live_grep = { additional_args = additional_rg_args },
--     grep_string = { additional_args = additional_rg_args },
--   },
-- }
-- 
-- require('telescope').load_extension('fzf')
-- 
-- -- See :help telescope.builtin
-- vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
-- vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
-- vim.keymap.set('n', '<C-s>', '<cmd>Telescope find_files<cr>')
-- vim.keymap.set('n', '<C-g>', '<cmd>Telescope live_grep<cr>')
-- vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
-- vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
-- fzf maps
vim.keymap.set("n", "<C-g>", ":Rg<CR>")
vim.keymap.set("n", "<C-s>", ":Files<CR>")
vim.keymap.set("n", "<C-s>", ":GFiles<CR>")
-- -- TODO: look into telescope.builtin.lsp_definitions


-- Harpoon bindings
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>0", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)


---
-- nvim-tree (File explorer)
---
-- See :help nvim-tree-setup
require('nvim-tree').setup({
  -- hijack_cursor = false,
  -- on_attach = function(bufnr)
  --   local bufmap = function(lhs, rhs, desc)
  --     vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
  --   end

  --   -- :help nvim-tree.api
  --   local api = require('nvim-tree.api')

  --   -- default mappings
  --   api.config.mappings.default_on_attach(bufnr)

  --   bufmap('L', api.node.open.edit, 'Expand folder or go to file')
  --   bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
  --   bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
  -- end
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

---
-- Conjure bindings
---
vim.g["conjure#filetypes"] = { "scheme" } -- Only use Conjure for scheme
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scheme" },
  callback = function()
    vim.keymap.set("n", "<localleader>rs", ":ConjureSchemeStop<CR>:ConjureSchemeStart<CR>", { buffer = true })
  end,
})

---
-- Paredit bindings
---
local paredit = require("nvim-paredit")
-- Make these keys do their usual function
local function reset_paredit_binding(keys)
  local result = {}
  for _, key in ipairs(keys) do
    result[key] = {
      function() vim.api.nvim_feedkeys(key, 'n', false) end,
      mode = { 'n' },
    }
  end
  return result
end

local pareditConfig = {
  keys = reset_paredit_binding({ "E", "W", "B", "gE" }),
  indent = { enabled = true },
}


paredit.setup(pareditConfig)

---
-- toggleterm
---
-- See :help toggleterm-roadmap
require('toggleterm').setup({
  open_mapping = '<C-t>',
  direction = 'vertical',
  shade_terminals = false,
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
})


---
-- Luasnip (snippet engine)
---
-- See :help luasnip-loaders
-- require('luasnip.loaders.from_vscode').lazy_load()


---
-- nvim-cmp (autocomplete)
---
--[[
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require('cmp')
cmp.setup({})

local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

-- See :help cmp-config
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  -- See :help cmp-mapping
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})


---
-- Diagnostic customization
---
local sign = function(opts)
  -- See :help sign_define()
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = '»'})

-- See :help vim.diagnostic.config()
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

---
-- LSP Keybindings
---
vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})


---
-- LSP servers
---
-- See :help mason-settings
require('mason').setup({
  ui = {border = 'rounded'}
})

local lspconfig = require('lspconfig')
-- Setup OCAML lsp to run without mason
-- local opts = {
--   on_attach = M.on_attach,
--   capabilities = M.common_capabilities(),
-- }
lspconfig.ocamllsp.setup({})


local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- See :help mason-lspconfig-settings
require('mason-lspconfig').setup({
  ensure_installed = {
    -- 'tsserver',
    'eslint',
    'html',
    'cssls'
  },
  -- See :help mason-lspconfig.setup_handlers()
  handlers = {
    function(server)
      -- See :help lspconfig-setup
      lspconfig[server].setup({
        capabilities = lsp_capabilities,
      })
    end,
    -- ['tsserver'] = function()
    --   lspconfig.tsserver.setup({
    --     capabilities = lsp_capabilities,
    --     settings = {
    --       completions = {
    --         completeFunctionCalls = true
    --       }
    --     }
    --   })
    -- end,
  }
})
--]]





require("mason").setup()
require("mason-lspconfig").setup()

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").lua_ls.setup {}
-- require("lspconfig").rust_analyzer.setup {}
-- ...

require("lspconfig").ocamllsp.setup {}

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()
    print("attaching")
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})





