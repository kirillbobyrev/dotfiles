-- [[ Leader Key ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Essential Settings ]]
local opt = vim.opt
vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.termguicolors = true     -- Enable true colors
opt.number = true            -- Show line numbers
opt.relativenumber = true    -- Show relative line numbers
opt.expandtab = true         -- Use spaces instead of tabs
opt.shiftwidth = 2           -- Size of an indent (Good for Python/Comp Prog)
opt.tabstop = 2              -- Number of spaces tabs count for
opt.softtabstop = 2          -- Number of spaces tabs count for in editing
opt.smartindent = true       -- Insert indents automatically
opt.wrap = false             -- Do not wrap lines
opt.hlsearch = true          -- Highlight search results
opt.incsearch = true         -- Show search results dynamically
opt.ignorecase = true        -- Ignore case when searching
opt.smartcase = true         -- Ignore case only when search query is all lowercase
opt.scrolloff = 8            -- Keep context lines around cursor
opt.sidescrolloff = 8
opt.signcolumn = "yes"       -- Always show the signcolumn
opt.clipboard = "unnamedplus"  -- Use system clipboard
opt.completeopt = "menu,menuone,noselect" -- Completion options
opt.confirm = true           -- Ask for confirmation when quitting with unsaved changes
opt.undofile = true          -- Persistent undo
opt.mouse = "a"              -- Enable mouse support
opt.splitbelow = true        -- Horizontal splits will automatically be below
opt.splitright = true        -- Vertical splits will automatically be to the right
opt.timeoutlen = 300         -- Lower timeout for key sequences
opt.updatetime = 200         -- Faster update time

-- [[ Plugin Management with lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Essential Dependencies
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/nui.nvim",

  -- Theme: Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({ terminal_colors = true })
      vim.cmd.colorscheme('gruvbox')
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = { theme = 'gruvbox', icons_enabled = true, component_separators = '|', section_separators = { left = '', right = '' }, globalstatus = true },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', {'diagnostics', symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}}}, -- Keep branch/diff for scripts under git
        lualine_c = {{'filename', path = 1}}, lualine_x = {'encoding', 'fileformat', 'filetype'}, lualine_y = {'progress'}, lualine_z = {'location'}
      },
      inactive_sections = { lualine_c = {{'filename', path = 1}}, lualine_x = {'location'} },
      extensions = {'neo-tree'}
    },
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { enable = true }, indent = { enable = true },
      -- Adjusted list for C++, Python, Shell, Markdown, Lua, common formats
      ensure_installed = { "c", "cpp", "python", "bash", "markdown", "markdown_inline", "lua", "toml", "yaml", "json", "vim", "vimdoc" },
      auto_install = true,
    },
  },

  -- Fuzzy Finding
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = { path_display = { "smart" }, layout_config = { prompt_position = 'top' }, sorting_strategy = "ascending", borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' } },
    },
  },

  -- Autocompletion (No Snippets, No lspkind)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(), ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4), ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(), ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, { "i", "s" }),
        }),
        sources = cmp.config.sources({{ name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' }}),
      })
    end,
  },

  -- LSP Configuration (Focused: C++/Python)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Needed for capabilities
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      local function lsp_keymaps(bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr, noremap=true, silent=true }
        map('n', 'gD', vim.lsp.buf.declaration, opts)
        map('n', 'gd', vim.lsp.buf.definition, opts)
        map('n', 'K', vim.lsp.buf.hover, opts)
        map('n', 'gi', vim.lsp.buf.implementation, opts)
        map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        map('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        map('n', '<leader>rn', vim.lsp.buf.rename, opts)
        map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        map('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
      end

      local on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
      end

      -- ======================================================================
      -- MANUAL LSP SERVER CONFIGURATION
      -- ======================================================================
      -- Clangd
      -- Ruff
      -- ======================================================================

      -- Setup clangd (C/C++)
      lspconfig.clangd.setup({ capabilities = capabilities, on_attach = on_attach })

      -- Setup ruff (Python)
      lspconfig.ruff.setup({ capabilities = capabilities, on_attach = on_attach })

      -- Configure diagnostics appearance
      vim.diagnostic.config({ virtual_lines = true })
    end
  },

  -- File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    cmd = "Neotree",
    opts = {
      close_if_last_window = true, popup_border_style = "rounded", window = { width = 30 },
      filesystem = { filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = true } },
      default_component_configs = {
        indent = { indent_size = 2 }, icon = { default = "󰈚", folder_closed = "", folder_open = "", folder_empty = "󰜌" },
        -- Keep git status for scripts/configs that might be in git
        git_status = { symbols = { added = "", modified = "", deleted = "", renamed = "➜", untracked = "?", ignored = "◌", conflicted = ""}},
      },
    }
  },

  -- Keymap Helper
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    opts = { plugins = { spelling = true }, win = { border = "rounded" } },
    config = function(_, opts) require('which-key').setup(opts) end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = { enabled = true },
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
      layout = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true } -- Wrap notifications
        }
      }
    },
  },

  { 'echasnovski/mini.icons', version = false },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- Utility: Autopairs
  { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },

}, { ui = { border = "rounded" } })

-- [[ Basic Keymaps ]]
local map = vim.keymap.set
local opts_noremap_silent = { noremap = true, silent = true }

map('n', '<Esc>', '<cmd>nohlsearch<CR>', opts_noremap_silent)
map('n', '<leader>fe', '<cmd>Neotree toggle<CR>', { desc = 'Toggle File Explorer' })
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find Files' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep' })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find Buffers' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Help Tags' })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = 'Find Old Files' })
map('n', '<C-h>', '<C-w>h', { desc = 'Window Left', silent = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Window Down', silent = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Window Up', silent = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Window Right', silent = true })
