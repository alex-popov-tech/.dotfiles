-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.cmd('cnoreabbrev sync PackerSync')
vim.cmd('cnoreabbrev pcomp PackerCompile')

local packer = {
  -- Packer can manage itself as an optional plugin
  'wbthomason/packer.nvim',
  config = function() cmd('command! PS PackerSync') end
}

local core = {
  -- cache modules to improve load time
  'lewis6991/impatient.nvim',
  'svban/YankAssassin.vim',
  -- add bunch of mappings like ]p ]e ]<space> etc.
  'tpope/vim-unimpaired',
  -- allows repeat via dot for some plugins like surround
  'tpope/vim-repeat',
  { 'kylechui/nvim-surround', config = require('plugins.nvim-surround') },
  -- {
  --   'ZhiyuanLck/smart-pairs',
  --   config = function()
  --     require 'pairs':setup({
  --       autojump_strategy = { unbalanced = 'all' },
  --       enter = { enable_mapping = false }
  --     })
  --   end,
  --   event = 'InsertEnter'
  -- },
  --  shiftwidth/expandtab/etc
  -- 'tpope/vim-sleuth',
  -- close all buffers but current
  { 'schickling/vim-bufonly', config = require('plugins.vim-bufonly') },
  -- close buffer
  { 'moll/vim-bbye', config = require('plugins.vim-bbye') },
  -- replace without yankink deleted
  { 'gbprod/substitute.nvim', config = require('plugins.substitute-nvim') },
  -- helps to resize split after closing in more expected way
  {
    'kwkarlwang/bufresize.nvim',
    config = function() require('bufresize').setup() end
  },
  -- {
  --   'ggandor/lightspeed.nvim',
  --   requires = { 'tpope/vim-repeat' },
  --   config = require('plugins.lightspeed-nvim')
  -- },
  -- adding new modes
  -- {
  --   'anuvyklack/hydra.nvim',
  --   requires = { 'anuvyklack/keymap-layer.nvim' },
  --   config = require('plugins.hydra-nvim')
  -- },
  { 'samodostal/image.nvim',
    ft = { 'png', 'jpeg' },
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('image').setup {
        render = {
          min_padding = 5,
          show_label = true,
          use_dither = true,
        },
        events = {
          update_on_nvim_resize = true,
        },
      }
    end },
  -- live preview for norm command
  { 'smjonas/live-command.nvim', cmd = "Norm", config = function()
    require("live_command").setup {
      commands = {
        Norm = { cmd = "norm" },
      },
    }
    vim.cmd [[ cnoreabbrev norm Norm ]]
  end }
}

local textObjects = {
  {
    'echasnovski/mini.nvim',
    config = function() require('mini.ai').setup() end
  },
  { 'Julian/vim-textobj-variable-segment', requires = { 'kana/vim-textobj-user' } }
}

local git = {
  { 'tpope/vim-fugitive', },
  {
    'kdheepak/lazygit.nvim',
    config = function() cmd [[cnoreabbrev git LazyGit]] end
  },
  {
    'pwntester/octo.nvim',
    cmd = { 'Octo' },
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require 'octo'.setup()
      hi('OctoEditable', { bg = 'none' })
    end
  }
}

local session = {
  -- start screen
  {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = require('plugins.alpha-nvim')
  },
  -- when navigate to previously opened files - open in last file position
  { 'ethanholz/nvim-lastplace', config = require('plugins.nvim-lastplace') }
}

local tmuxAndSplits = {
  -- plugin for vim-tmux interactions
  'numToStr/Navigator.nvim', config = require('plugins.navigator-nvim'),
}

local term = {
  -- open terminal in floating window
  'numToStr/FTerm.nvim',
  config = require('plugins.fterm-nvim')
}

local filetree = {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim'
  },
  config = require('plugins.nvim-neo-tree')
}

local fuzzyFinder = {
  {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
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
  { 'glepnir/mcc.nvim', config = function()
    require('mcc').setup({ go = { ':', ':=', ':' }, })
  end },
  { 'numToStr/Comment.nvim',
    requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = require("plugins.comment-nvim")
  },
  -- 'editorconfig/editorconfig-vim',
  -- { 'tpope/vim-dotenv', config = require('plugins.vim-dotenv') }
}

local ui = {
  {
    'catppuccin/nvim',
    config = require('plugins.catppuccin'),
    run = ':CatppuccinCompile'
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup(nil, { names = false, mode = 'foreground' })
    end
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

local lsp = {
  -- temp disabled as it brings too much stuff
  -- { 'lvimuser/lsp-inlayhints.nvim', config = require('plugins.lsp-inlayhints') },
  -- lsp configs placed here
  {
    'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      local lsp = require('lsp')
      require('mason').setup()
      require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = lsp.servers
      })
    end
  },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", requires = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local tools = require('lsp.servers.nullls')
      require 'mason-tool-installer'.setup {
        ensure_installed = tools.list,
        run_on_start = true,
        start_delay = 2000, -- 3 second delay
      }
    end },
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
  {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' }
  },
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
  {
    'smjonas/inc-rename.nvim',
    requires = { { 'stevearc/dressing.nvim', config = function()
      require("dressing").setup {
        input = {
          override = function(conf)
            conf.col = -1
            conf.row = 0
            return conf
          end,
        },
      }
    end } },
    config = function()
      require('inc_rename').setup({ cmd_name = 'Rename', input_buffer_type = "dressing" })
    end
  }, -- code action
  { 'j-hui/fidget.nvim', config = require('plugins.fidget-nvim') }, -- code action
  -- shema validation for JSON files
  { 'b0o/SchemaStore.nvim' }
}

local debug = {
  {
    'mfussenegger/nvim-dap', cmd = "DapContinue", config = require('plugins.nvim-dap')
  },
  {
    'leoluz/nvim-dap-go', config = function()
      require('dap-go').setup()
    end
  },
  { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' }, config = function()
    require("dapui").setup({})
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end }
}

local other = {
  { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } },
  { 'RishabhRD/nvim-cheat.sh', cmd = "Cheat", requires = { 'RishabhRD/popfix' } },
  { 'rcarriga/nvim-notify' }
}

require 'packer'.startup {
  function(use)
    use(packer)
    use(textObjects)
    use(core)
    use(git)
    use(session)
    use(tmuxAndSplits)
    use(term)
    use(filetree)
    use(fuzzyFinder)
    use(coding)
    use(ui)
    use(treesitter)
    use(lsp)
    use(debug)
    use(other)
  end,
  config = {
    max_jobs = 10, -- Limit the number of simultaneous jobs. nil means no limit
    display = { open_fn = require 'packer.util'.float }
  }
}
