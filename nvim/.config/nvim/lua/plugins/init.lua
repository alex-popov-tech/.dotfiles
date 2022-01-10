-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local packer = {
    -- Packer can manage itself as an optional plugin
    "wbthomason/packer.nvim",
    opt = true
}

local textObjects = {
    "kana/vim-textobj-user", "glts/vim-textobj-comment",
    "kana/vim-textobj-indent", "wellle/targets.vim",
    {"chaoren/vim-wordmotion", config = require("plugins.vim-wordmotion")}
}

local core = {
    -- fix performance bug https://github.com/neovim/neovim/issues/12587 for CursorHold CursorHoldI
    {
        "antoinemadec/FixCursorHold.nvim",
        config = function() vim.g.cursorhold_updatetime = 200 end
    }, -- when yanking do not put cursor at the begginning of yanked text
    {"svban/YankAssassin.vim"}, -- improve load time with better 'filetype'
    -- {"nathom/filetype.nvim"},
    -- abbreviations, substitusion, coercion (transform case)
    {"tpope/vim-abolish", config = require("plugins.abolish-vim")},
    -- add bunch of mappings like ]p ]e ]<space> etc.
    "tpope/vim-unimpaired",
    -- allows repeat via dot for some plugins like surround
    "tpope/vim-repeat", -- add\update\remove surround stuff like ''{}''
    "tpope/vim-surround", -- {
    --     "machakann/vim-sandwich",
    -- },
    -- auto brackets
    -- "cohama/lexima.vim",
    --  shiftwidth/expandtab/etc
    "tpope/vim-sleuth", -- close all buffers but current
    {"schickling/vim-bufonly", config = require("plugins.vim-bufonly")},
    -- close buffer
    {"moll/vim-bbye", config = require("plugins.vim-bbye")},
    -- move to {motion}
    {"svermeulen/vim-subversive", config = require("plugins.vim-subversive")},
    -- highlight for % pairs
    "andymass/vim-matchup", -- removes cursor jumping when opening qf,etc.
    {"luukvbaal/stabilize.nvim", config = require("plugins.stabilize-nvim")},
    -- expectedly resizes splits in different situations
    {
        "kwkarlwang/bufresize.nvim",
        config = function() require("bufresize").setup() end
    }, -- easy motion like.
    {
        "ggandor/lightspeed.nvim",
        requires = {"tpope/vim-repeat"},
        config = require("plugins.lightspeed-nvim")
    }
}

local git = {
    {"tpope/vim-fugitive", config = require("plugins.vim-fugitive")}, {
        "lewis6991/gitsigns.nvim",
        config = function() require("gitsigns").setup() end
    }
}

local session = {
    -- start screen
    {"mhinz/vim-startify", config = require("plugins.vim-startify")},
    -- when navigate to previously opened files - open in last file position
    "farmergreg/vim-lastplace"
}

local tmuxAndSplits = {
    -- plugin for vim-tmux interactions
    {"numToStr/Navigator.nvim", config = require("plugins.navigator-nvim")},
    -- resizing windows
    {"talek/obvious-resize", config = require("plugins.obvious-resize")}
}

local term = {
    -- open terminal in floating window
    "numToStr/FTerm.nvim",
    config = require("plugins.fterm-nvim")
}

local filetree = {
    -- file tree
    "kyazdani42/nvim-tree.lua",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = require("plugins.nvim-tree")
}

local fuzzyFinder = {
    {
        "nvim-telescope/telescope.nvim",
        requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
        config = require("plugins.telescope-nvim")
    }, {
        "windwp/nvim-spectre",
        config = require("plugins.spectre"),
        requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
        cmd = "Replace"
    }
}

local coding = {
    -- add commenting for different langs
    {"tpope/vim-commentary", config = require("plugins.vim-commentary")},
    -- plugin which allows vim to work with common editorconfig
    "editorconfig/editorconfig-vim", -- database viewer
    {
        "kristijanhusak/vim-dadbod-ui",
        config = require("plugins.vim-dadbod"),
        requires = {"tpope/vim-dadbod", "kristijanhusak/vim-dadbod-completion"}
    }, {"tpope/vim-dotenv", config = require("plugins.vim-dotenv")},
    {"hashivim/vim-terraform", config = require("plugins.vim-terraform")},
    -- interactive eval whole buff
    {"metakirby5/codi.vim", config = require("plugins.codi-vim")}
}

local ui = {
    {
        "noib3/cokeline.nvim",
        requires = "kyazdani42/nvim-web-devicons", -- If you want devicons
        config = require("plugins.cokeline-nvim")
    }, -- statusline
    {"windwp/windline.nvim", config = require("plugins.windline-nvim")},
    -- color scheme
    { 'rmehri01/onenord.nvim' },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require'colorizer'.setup(nil, {names = false, mode = 'foreground'})
        end
    }
}

local treesitter = {
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require('plugins.nvim-treesitter')
    },
    {'windwp/nvim-ts-autotag', config = function() require('nvim-ts-autotag').setup() end},
    {'JoosepAlviste/nvim-ts-context-commentstring', config = function()
      -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/blob/097df33c9ef5bbd3828105e4bee99965b758dc3f/lua/ts_context_commentstring/internal.lua#L86-L89
      vim.g.loaded_commentary = 0
      require('nvim-ts-autotag').setup()
      vim.g.loaded_commentary = 1
    end},
    {'nvim-treesitter/playground'}
}

local lsp = {
    -- lsp configs placed here
    "neovim/nvim-lspconfig", -- lsp servers installer
    {"williamboman/nvim-lsp-installer"}, -- just a bit better ts support
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    -- plugin to add completeion possibility
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
                            {'hrsh7th/cmp-buffer'},
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
        requires = {'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig'}
    },
    }, -- colors for lsp if your theme have not
    "folke/lsp-colors.nvim", -- diagnostics
    {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = require("plugins.trouble-nvim")
    }, -- code action
    {"weilbith/nvim-code-action-menu", cmd = "CodeActionMenu"},
    -- shema validation for JSON files
    {"b0o/SchemaStore.nvim"}
}

local other = {
    {"dstein64/vim-startuptime", cmd = {"StartupTime"}},
    {"iamcco/markdown-preview.nvim"}, {
        "NTBBloodbath/rest.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = require("plugins.rest-nvim")
    }
}

-- vim.cmd("cnoreabbrev ps PackerSync")
require"packer".startup {
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
        use(other)
    end,
    config = {
        max_jobs = 5, -- Limit the number of simultaneous jobs. nil means no limit
        display = {open_fn = require"packer.util".float}
    }
}
