local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]


vim.cmd('cnoreabbrev psync PackerSync')
vim.cmd('cnoreabbrev pcomp PackerCompile')
vim.cmd('cnoreabbrev pinst PackerInstall')

local core = {
  -- cache modules to improve load time
  'lewis6991/impatient.nvim',
  --  shiftwidth/expandtab/etc
  'tpope/vim-sleuth',
  'svban/YankAssassin.vim',
  -- add bunch of mappings like ]p ]e ]<space> etc.
  'tpope/vim-unimpaired',
  -- allows repeat via dot for some plugins like surround
  'tpope/vim-repeat',
  { 'kylechui/nvim-surround', config = require('plugins.nvim-surround') },
  -- close all buffers but current
  { 'schickling/vim-bufonly', config = require('plugins.vim-bufonly') },
  -- close buffer
  { 'ojroques/nvim-bufdel', config = require('plugins.nvim-bufdel') },
  -- replace without yankink deleted
  { 'gbprod/substitute.nvim', config = require('plugins.substitute-nvim') },
  -- helps to resize split after closing in more expected way
  { 'kwkarlwang/bufresize.nvim', config = require('plugins.bufresize-nvim') },
  -- adding new modes
  -- { 'anuvyklack/hydra.nvim', requires = { 'anuvyklack/keymap-layer.nvim' }, config = require('plugins.hydra-nvim') },
  { 'samodostal/image.nvim', ft = { 'png', 'jpeg' }, requires = { 'nvim-lua/plenary.nvim' },
    config = require('plugins.image-nvim') },
  { "mbbill/undotree", cmd = { "UndotreeToggle" } },
  { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', config = require('plugins.nvim-ufo') },
  { 'smjonas/live-command.nvim', config = require('plugins.live-command-nvim') },
  -- when navigate to previously opened files - open in last file position
  { 'ethanholz/nvim-lastplace', config = require('plugins.nvim-lastplace') },
  -- plugin for vim-tmux interactions
  { 'numToStr/Navigator.nvim', config = require('plugins.navigator-nvim') },
  -- open terminal in floating window
  { 'numToStr/FTerm.nvim', config = require('plugins.fterm-nvim') },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim'
    },
    config = require('plugins.nvim-neo-tree')
  }
}

local textObjects = {
  { 'echasnovski/mini.nvim', config = require('plugins.mini-nvim') },
  { 'Julian/vim-textobj-variable-segment', requires = { 'kana/vim-textobj-user' } }
}

local fuzzyFinder = {
  {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' }
    },
    config = require('plugins.telescope-nvim')
  },
  {
    'windwp/nvim-spectre',
    config = require('plugins.spectre'),
    requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
    cmd = 'Replace'
  }
}

local coding = {
  'numToStr/Comment.nvim',
  requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = require("plugins.comment-nvim")
}

local ui = {
  {
    'catppuccin/nvim',
    config = require('plugins.catppuccin'),
    run = ':CatppuccinCompile'
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function() require 'colorizer'.setup(nil, { names = false, mode = 'foreground' }) end
  },
  {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = require('plugins.bufferline-nvim')
  },
  {
    'feline-nvim/feline.nvim',
    config = require('plugins.feline-nvim'),
    requires = { 'kyazdani42/nvim-web-devicons', 'lewis6991/gitsigns.nvim' }
  }
}

local treesitter = {
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = require('plugins.nvim-treesitter')
  },
  -- autocomplete closing tags, auto rename
  {
    'windwp/nvim-ts-autotag',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function() require('nvim-ts-autotag').setup() end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = require('plugins.nvim-treesitter-textobjects')
  },
  {
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function() require 'hlargs'.setup {} end
  }
}

local tools = {
  {
    'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = require('plugins.mason-lspconfig-nvim')
  },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", requires = { "williamboman/mason.nvim" },
    config = require('plugins.mason-tool-installer-nvim') },
  { "jayp0521/mason-nvim-dap.nvim", requires = { "williamboman/mason.nvim" },
    config = require('plugins.mason-nvim-dap-nvim') },
}

local lsp = {
  -- organize imports
  'jose-elias-alvarez/nvim-lsp-ts-utils',
  {
    'hrsh7th/nvim-cmp',
    config = require('plugins.nvim-cmp'),
    requires = {
      'onsails/lspkind-nvim',
      'octaltree/cmp-look',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-emoji',
      {
        'tzachar/cmp-fuzzy-buffer',
        requires = {
          {
            'tzachar/fuzzy.nvim',
            requires = {
              { 'hrsh7th/cmp-buffer' },
              {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make'
              }
            }
          }
        }
      }
    }
  },
  { 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' } },
  {
    'L3MON4D3/LuaSnip',
    requires = { 'rafamadriz/friendly-snippets' },
    config = require('plugins.luasnip')
  },
  {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = require('plugins.trouble-nvim')
  },
  { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }, -- code action
  { 'j-hui/fidget.nvim', config = require('plugins.fidget-nvim') },
  { 'b0o/SchemaStore.nvim' }
}

-- local debug = {
--   {
--     'mfussenegger/nvim-dap', cmd = "DapContinue", config = require('plugins.nvim-dap')
--   },
--   {
--     'leoluz/nvim-dap-go', cmd = "DapContinue", config = function()
--       require('dap-go').setup()
--     end
--   },
--   { 'rcarriga/nvim-dap-ui', cmd = "DapContinue", requires = { 'mfussenegger/nvim-dap' }, config = function()
--     require("dapui").setup({})
--     local dap, dapui = require("dap"), require("dapui")
--     dap.listeners.after.event_initialized["dapui_config"] = function()
--       dapui.open()
--     end
--     dap.listeners.before.event_terminated["dapui_config"] = function()
--       dapui.close()
--     end
--     dap.listeners.before.event_exited["dapui_config"] = function()
--       dapui.close()
--     end
--   end }
-- }

local other = {
  { 'rcarriga/nvim-notify', config = function()
    require("notify").setup({
      stages = "fade",
      fps = 10
    })
  end
  },
  {
    'pwntester/octo.nvim',
    cmd = { 'Octo' },
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons'
    },
    config = require('plugins.octo-nvim')
  }
  -- {
  --   "folke/noice.nvim",
  --   event = "VimEnter",
  --   -- config = function() require("noice").setup() end,
  --   requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", }
  -- },
  { 'folke/neodev.nvim', config = require('plugins.neodev-nvim') }
}

require 'packer'.startup {
  function(use)
    use 'wbthomason/packer.nvim'
    use(textObjects)
    use(core)
    use(fuzzyFinder)
    use(coding)
    use(ui)
    use(treesitter)
    use(lsp)
    use(tools)
    -- use(debug)
    use(other)
    if packer_bootstap then
      require('packer').sync()
    end
  end,
  config = {
    max_jobs = 10, -- Limit the number of simultaneous jobs. nil means no limit
    display = { open_fn = require 'packer.util'.float }
  }
}
