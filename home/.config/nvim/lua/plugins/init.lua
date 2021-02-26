local ensurePackerInstalled = function()
    local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
    if fn.empty(vim.fn.glob(install_path)) > 0 then
        execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
        execute "packadd packer.nvim"
    end
    cmd("packadd packer.nvim")
end
ensurePackerInstalled()

au("BufWritePost", "**/nvim/lua/plugins/*.lua", "lua reload()")
au("BufWritePost", "**/nvim/lua/plugins/*.lua", "PackerCompile")
-- cmd [[ autocmd BufWritePost **/nvim/lua/plugins/*.lua lua reload() ]]
-- cmd [[ autocmd BufWritePost **/nvim/lua/plugins/*.lua PackerCompile ]]

local packer = {
    -- Packer can manage itself as an optional plugin
    "wbthomason/packer.nvim",
    opt = true
}

local textObjects = {
    "kana/vim-textobj-user",
    "glts/vim-textobj-comment",
    "kana/vim-textobj-indent",
    "wellle/targets.vim",
    {"chaoren/vim-wordmotion", config = require("plugins.vim-wordmotion")}
}

local core = {
    -- abbreviations, substitusion, coercion (transform case)
    "tpope/vim-abolish",
    -- add bunch of mappings like ]p ]e ]<space> etc.
    "tpope/vim-unimpaired",
    -- allows repeat via dot for some plugins like surround
    "tpope/vim-repeat",
    -- add\update\remove surround stuff like ''{}''
    "tpope/vim-surround",
    "machakann/vim-sandwich",
    --  shiftwidth/expandtab/etc
    "tpope/vim-sleuth",
    -- close all buffers but current
    {"schickling/vim-bufonly", config = require("plugins.vim-bufonly")},
    -- close buffer
    {"moll/vim-bbye", config = require("plugins.vim-bbye")},
    -- move to {motion}
    {"svermeulen/vim-subversive", config = require("plugins.vim-subversive")},
    -- gj gs
    {"AndrewRadev/splitjoin.vim", config = require("plugins.splitjoin")},
    "iamcco/markdown-preview.nvim",
    "alex-popov-tech/timer.nvim"
}

local git = {
    "tpope/vim-fugitive",
    config = require("plugins.vim-fugitive")
}

local session = {
    -- start screen
    {"mhinz/vim-startify", config = require("plugins.vim-startify")},
    -- when navigate to previously opened files - open in last file position
    "farmergreg/vim-lastplace"
}

local tmuxAndSplits = {
    -- plugin for vim-tmux interactions
    {"christoomey/vim-tmux-navigator", config = require("plugins.vim-tmux-navigator")},
    -- resizing windows
    {"talek/obvious-resize", config = require("plugins.obvious-resize")},
    -- syntax high, K docs, something else...
    "tmux-plugins/vim-tmux"
}

local term = {
    -- open terminal in floating window
    "voldikss/vim-floaterm",
    config = require("plugins.vim-floaterm")
}

local filetree = {
    -- file tree
    "kyazdani42/nvim-tree.lua",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = require("plugins.nvim-tree")
}

local fuzzyFinder = {
    {
        "junegunn/fzf.vim",
        requires = {{"junegunn/fzf", run = "./install --all"}},
        config = require("plugins.fzf-vim")
    },
    {
        "nvim-telescope/telescope.nvim",
        requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
        config = require("plugins.telescope-nvim")
    }
}

local coding = {
    -- add commenting for different langs
    {"tpope/vim-commentary", config = require("plugins.vim-commentary")},
    -- plugin which allows vim to work with common editorconfig
    "editorconfig/editorconfig-vim",
    -- database viewer
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-ui"
}

local ui = {
    -- top buff line
    {"akinsho/nvim-bufferline.lua", config = require("plugins.nvim-bufferline")},
    -- statusline
    {"glepnir/galaxyline.nvim", config = require("plugins.galaxyline-nvim")},
    -- color scheme
    "christianchiarulli/nvcode-color-schemes.vim"
}

local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate all",
    config = require("plugins.nvim-treesitter")
}

local lsp = {
    -- lsp configs placed here
    "neovim/nvim-lspconfig",
    -- pretty hover and references/implementations/codeaction
    {"glepnir/lspsaga.nvim", config = require("plugins.lspsaga-nvim")},
    -- pretty references/codeaction
    {"RishabhRD/nvim-lsputils", requires = {"RishabhRD/popfix"}, config = require("plugins.nvim-lsputils")},
    -- plugin to add completeion possibility
    {"hrsh7th/nvim-compe", config = require("plugins.nvim-compe")}
    -- {"nvim-lua/completion-nvim", requires = "steelsojka/completion-buffers", config = require("plugins.completion-nvim")},
    -- {"hrsh7th/vim-vsnip", requires = "hrsh7th/vim-vsnip-integ", config = require("plugins.vim-vsnip")}
}

local other = {
    {"dstein64/vim-startuptime", cmd = {"StartupTime"}},
    {"sedm0784/vim-you-autocorrect", config = require("plugins.vim-you-autocorrect")}
}

return require "packer".startup {
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
        display = {
            open_fn = require "packer.util".float
        }
    }
}
