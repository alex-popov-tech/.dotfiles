-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

au('BufWrite', '**/nvim/.config/nvim/lua*.lua', 'PackerCompile')

local packer = {
    -- Packer can manage itself as an optional plugin
    'wbthomason/packer.nvim',
    config = function() cmd('command! PS PackerSync') end
}

local textObjects = {
    'kana/vim-textobj-user',
    'glts/vim-textobj-comment',
    'kana/vim-textobj-indent',
    'wellle/targets.vim',
    {'chaoren/vim-wordmotion', config = require('plugins.vim-wordmotion')}
}

local core = {
    -- fix performance bug https://github.com/neovim/neovim/issues/12587 for CursorHold CursorHoldI
    {
        'antoinemadec/FixCursorHold.nvim',
        config = function() vim.g.cursorhold_updatetime = 200 end
    }, -- when yanking do not put cursor at the beginning of yanked text
    'svban/YankAssassin.vim',
    -- abbreviations, substitusion, coercion (transform case)
    {'tpope/vim-abolish', config = require('plugins.abolish-vim')},
    -- add bunch of mappings like ]p ]e ]<space> etc.
    'tpope/vim-unimpaired',
    -- allows repeat via dot for some plugins like surround
    'tpope/vim-repeat', -- add\update\remove surround stuff like ''{}''
    'tpope/vim-surround', -- {
    -- auto brackets
    {
        'ZhiyuanLck/smart-pairs',
        config = function()
            require 'pairs':setup({
                autojump_strategy = {unbalanced = 'all'},
                enter = {enable_mapping = false}
            })
        end,
        event = 'InsertEnter'
    },
    --  shiftwidth/expandtab/etc
    'tpope/vim-sleuth', -- close all buffers but current
    {'schickling/vim-bufonly', config = require('plugins.vim-bufonly')},
    -- close buffer
    {'moll/vim-bbye', config = require('plugins.vim-bbye')},
    -- move to {motion}
    {'svermeulen/vim-subversive', config = require('plugins.vim-subversive')},
    -- highlight for % pairs
    'andymass/vim-matchup', -- removes cursor jumping when opening qf,etc.
    {'luukvbaal/stabilize.nvim', config = require('plugins.stabilize-nvim')},
    -- expectedly resizes splits in different situations
    {
        'kwkarlwang/bufresize.nvim',
        config = function() require('bufresize').setup() end
    }, -- easy motion like.
    {
        'ggandor/lightspeed.nvim',
        requires = {'tpope/vim-repeat'},
        config = require('plugins.lightspeed-nvim')
    }
}

local git = {
    'kdheepak/lazygit.nvim',
    config = function() cmd [[cnoreabbrev git LazyGit]] end
    --  {
    --  'ldelossa/gh.nvim',
    --  requires = {'ldelossa/litee.nvim'},
    --  config = function()
    --  require('litee.lib').setup()
    --  require('litee.gh').setup()
    --  end
    --  }
}

local session = {
    -- start screen
    {
        'goolord/alpha-nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }, -- when navigate to previously opened files - open in last file position
    {'ethanholz/nvim-lastplace', config = require('plugins.nvim-lastplace')}
}

local tmuxAndSplits = {
    -- plugin for vim-tmux interactions
    {'numToStr/Navigator.nvim', config = require('plugins.navigator-nvim')},
    -- resizing windows
    {'talek/obvious-resize', config = require('plugins.obvious-resize')}
}

local term = {
    -- open terminal in floating window
    'numToStr/FTerm.nvim',
    config = require('plugins.fterm-nvim')
}

local filetree = {
    -- file tree
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
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
        },
        config = require('plugins.telescope-nvim')
    },
    {
        'windwp/nvim-spectre',
        config = require('plugins.spectre'),
        requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
        cmd = 'Replace'
    }
}

local coding = {
    -- add commenting for different langs
    -- {'tpope/vim-commentary', config = require('plugins.vim-commentary')},
    {
        'winston0410/commented.nvim',
        config = function()
            require('commented').setup({
                hooks = {
                    before_comment = require('ts_context_commentstring.internal').update_commentstring
                }
            })
        end
    },
    'editorconfig/editorconfig-vim', -- database viewer
    {'tpope/vim-dotenv', config = require('plugins.vim-dotenv')},
    {'hashivim/vim-terraform', config = require('plugins.vim-terraform')}
}

local ui = {
    {
        'noib3/cokeline.nvim',
        requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
        config = require('plugins.cokeline-nvim')
    }, -- statusline
    --  {'windwp/windline.nvim', config = require('plugins.windline-nvim')},
    {
        'nvim-lualine/lualine.nvim',
        config = require('plugins.lualine'),
        requires = {'kyazdani42/nvim-web-devicons', 'tpope/vim-fugitive'}
    },
    -- color scheme
    {'rmehri01/onenord.nvim'},
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
    {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end
    },
    {'JoosepAlviste/nvim-ts-context-commentstring'},
    {'nvim-treesitter/playground'},
    {'m-demare/hlargs.nvim', config = function() require'hlargs'.setup {} end}
}

local lsp = {
    'mattn/emmet-vim',
    -- lsp configs placed here
    'neovim/nvim-lspconfig', -- lsp servers installer
    {
        'williamboman/nvim-lsp-installer',
        config = require('plugins.nvim-lsp-installer')
    }, -- just a bit better ts support
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    -- plugin to add completion possibility
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
    { -- snippeds
        'hrsh7th/vim-vsnip',
        requires = 'hrsh7th/vim-vsnip-integ',
        config = require('plugins.vim-vsnip')
    },
    -- 'folke/lsp-colors.nvim', -- colors for lsp if your theme have nothing
    {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.trouble-nvim')
    }, -- diagnostics
    {'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu'}, -- code action
    {'j-hui/fidget.nvim', config = require('plugins.fidget-nvim')}, -- code action
    -- shema validation for JSON files
    {'b0o/SchemaStore.nvim'}
}

local other = {
    {'dstein64/vim-startuptime', cmd = {'StartupTime'}},
    {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && npm install',
        setup = function() vim.g.mkdp_filetypes = {'markdown'} end,
        ft = {'markdown'}
    }
}

-- vim.cmd("cnoreabbrev ps PackerSync")
require'packer'.startup {
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
        max_jobs = 10, -- Limit the number of simultaneous jobs. nil means no limit
        display = {open_fn = require'packer.util'.float}
    }
}
