-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

au('BufWrite', '**/nvim/.config/nvim/lua/**/*.lua', 'PackerCompile')
addCommand('Sync', 'PackerSync')
vim.cmd('cnoreabbrev sync Sync')

local packer = {
    -- Packer can manage itself as an optional plugin
    'wbthomason/packer.nvim',
    config = function() cmd('command! PS PackerSync') end
}

local textObjects = {
    {
        'kana/vim-textobj-user',
        config = function()
            vim.cmd [[
        call textobj#user#plugin('custom', {
        \   'block': {
        \     'pattern': '[\{\[\(].*[\)\]\}]',
        \     'select': ['ab', 'ib'],
        \   },
        \ })
        ]]
        end
    },
    'glts/vim-textobj-comment',
    'kana/vim-textobj-indent',
    'wellle/targets.vim',
    {'chaoren/vim-wordmotion', config = require('plugins.vim-wordmotion')},
    {
        'andrewferrier/textobj-diagnostic.nvim',
        config = function()
            require('textobj-diagnostic').setup({create_default_keymaps = false})
            vim.keymap.set({'x', 'o'}, 'id', function()
                require('textobj-diagnostic').next_diag_inclusive()
            end, {silent = true})
            vim.keymap.set({'x', 'o'}, 'ad', function()
                require('textobj-diagnostic').next_diag_inclusive()
            end, {silent = true})
        end
    }
}

local core = {
    -- fix performance bug https://github.com/neovim/neovim/issues/12587 for CursorHold CursorHoldI
    {
        'antoinemadec/FixCursorHold.nvim',
        config = function() vim.g.cursorhold_updatetime = 200 end
    }, -- when yanking do not put cursor at the beginning of yanked text
    -- cache modules to improve load time
    'lewis6991/impatient.nvim',
    'svban/YankAssassin.vim',
    -- abbreviations, substitusion, coercion (transform case)
    {'tpope/vim-abolish', config = require('plugins.abolish-vim')},
    -- add bunch of mappings like ]p ]e ]<space> etc.
    'tpope/vim-unimpaired',
    -- allows repeat via dot for some plugins like surround
    'tpope/vim-repeat', -- add\update\remove surround stuff like ''{}''
    --  'tpope/vim-surround',
    {
        'kylechui/nvim-surround',
        config = function() require('nvim-surround').setup({}) end
    },
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
    {'gbprod/substitute.nvim', config = require('plugins.substitute-nvim')},
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
    },
    {'monaqa/dial.nvim', config = require('plugins.dial-nvim')},
    {
        'anuvyklack/hydra.nvim',
        requires = {'anuvyklack/keymap-layer.nvim'}, -- needed only for pink hydras
        config = require('plugins.hydra-nvim')
    }
}

local git = {
    {
        'kdheepak/lazygit.nvim',
        config = function() cmd [[cnoreabbrev git LazyGit]] end
    },
    {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require'octo'.setup()
            hi('OctoEditable', {bg = 'none'})
        end
    }
}

local session = {
    -- start screen
    {
        'goolord/alpha-nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = require('plugins.alpha-nvim')
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
    'editorconfig/editorconfig-vim',
    {'tpope/vim-dotenv', config = require('plugins.vim-dotenv')}
}

local ui = {
    {
        'noib3/cokeline.nvim',
        requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
        config = require('plugins.cokeline-nvim')
    },
    {
        'feline-nvim/feline.nvim',
        config = require('plugins.feline-nvim'),
        requires = {'kyazdani42/nvim-web-devicons', 'lewis6991/gitsigns.nvim'}
    },
    -- color scheme
    --  {'rmehri01/onenord.nvim'},
    {
        'catppuccin/nvim',
        config = require('plugins.catppuccin'),
        run = ':CatppuccinCompile'
    },
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
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner'
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer'
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer'
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer'
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer'
                        }
                    }
                }
            }
        end
    },
    {'JoosepAlviste/nvim-ts-context-commentstring'},
    {'nvim-treesitter/playground'},
    {'m-demare/hlargs.nvim', config = function() require'hlargs'.setup {} end}
}

local lsp = {
    -- lsp configs placed here
    {
        'williamboman/mason-lspconfig.nvim',
        requires = {'williamboman/mason.nvim', 'neovim/nvim-lspconfig'},
        config = function()
            local lsp = require('lsp')
            require('mason').setup()
            require('mason-lspconfig').setup({
                automatic_installation = false,
                ensure_installed = lsp.servers
            })
        end
    },
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
            'hrsh7th/cmp-emoji',
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
    --  commented for now as there is no filtering unfortunately :(
    --  {
    --  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    --  config = function() require('lsp_lines').setup() end
    --  },
    {'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu'}, -- code action
    {
        'smjonas/inc-rename.nvim',
        config = function()
            require('inc_rename').setup({cmd_name = 'Rename'})
        end
    }, -- code action
    {'j-hui/fidget.nvim', config = require('plugins.fidget-nvim')}, -- code action
    -- shema validation for JSON files
    {'b0o/SchemaStore.nvim'}
}

local other = {
    {'dstein64/vim-startuptime', cmd = {'StartupTime'}},
    {'RishabhRD/nvim-cheat.sh', requires = {'RishabhRD/popfix'}}
}

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
