local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(vim.fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end
cmd("packadd packer.nvim")

cmd [[ autocmd BufWritePost **/nvim/lua/plugins/*.lua lua reload() ]]
cmd [[ autocmd BufWritePost **/nvim/lua/plugins/*.lua PackerCompile ]]

require("packer").startup(
    {
        function()
            -- Packer can manage itself as an optional plugin
            use {"wbthomason/packer.nvim", opt = true, config = require("plugins.packer-nvim")}
            use {"dstein64/vim-startuptime", cmd = {"StartupTime"}}
            -- text objects
            use "kana/vim-textobj-user"
            use "glts/vim-textobj-comment"
            use "kana/vim-textobj-indent"
            use "wellle/targets.vim"
            -- abbreviations, substitusion, coercion (transform case)
            use "tpope/vim-abolish"
            -- add bunch of mappings like ]p ]e ]<space> etc.
            use "tpope/vim-unimpaired"
            -- allows repeat via dot for some plugins like surround
            use "tpope/vim-repeat"
            -- add\update\remove surround stuff like '"{}"'
            use "tpope/vim-surround"
            --  shiftwidth/expandtab/etc
            use "tpope/vim-sleuth"
            -- git plugin
            use {"tpope/vim-fugitive", config = require("plugins.vim-fugitive")}
            -- auto placing paired signs like {} [] '' "" etc
            -- use {"windwp/nvim-autopairs", config = require("plugins.vim-autopairs")}
            -- when navigate to previously opened files - open in last file position
            use "farmergreg/vim-lastplace"
            use {"schickling/vim-bufonly", config = require("plugins.vim-bufonly")}
            use {"moll/vim-bbye", config = require("plugins.vim-bbye")}
            -- start screen
            use {"mhinz/vim-startify", config = require("plugins.vim-startify")}
            -- text object camel case word
            use {"chaoren/vim-wordmotion", config = require("plugins.vim-wordmotion")}
            -- open terminal in floating window
            use {"voldikss/vim-floaterm", config = require("plugins.vim-floaterm")}
            -- move to {motion}
            use {"svermeulen/vim-subversive", config = require("plugins.vim-subversive")}
            -- icons for lua
            use "kyazdani42/nvim-web-devicons"
            -- file tree
            use {"kyazdani42/nvim-tree.lua", config = require("plugins.nvim-tree")}
            use {"AndrewRadev/splitjoin.vim", config = require("plugins.splitjoin")}
            -- plugin for vim-tmux interactions
            use {"christoomey/vim-tmux-navigator", config = require("plugins.vim-tmux-navigator")}
            -- resizing windows
            use {"talek/obvious-resize", config = require("plugins.obvious-resize")}
            -- fzf
            use {
                "junegunn/fzf.vim",
                requires = {{"junegunn/fzf", run = "./install --all"}},
                config = require("plugins.fzf-vim")
            }
            use {
                "nvim-telescope/telescope.nvim",
                requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
                config = require("plugins.telescope-nvim")
            }
            -- add commenting for different langs via gcc
            use "tpope/vim-commentary"
            -- plugin which allows vim to work with common editorconfig
            use "editorconfig/editorconfig-vim"
            -- " database viewer
            use "tpope/vim-dadbod"
            use "kristijanhusak/vim-dadbod-ui"
            -- main lsp plugin to enable servers communication
            -- top buff line
            use {"akinsho/nvim-bufferline.lua", config = require("plugins.nvim-bufferline")}
            -- statusline
            use {"glepnir/galaxyline.nvim", config = require("plugins.galaxyline-nvim")}
            -- parser
            use {"nvim-treesitter/nvim-treesitter", cmd = "TSUpdate all", config = require("plugins.nvim-treesitter")}
            -- color scheme
            use "christianchiarulli/nvcode-color-schemes.vim"
            -- lsp configs placed here
            use "neovim/nvim-lspconfig"
            -- pretty hover and references/implementations/codeaction
            use {"glepnir/lspsaga.nvim", config = require("plugins.lspsaga-nvim")}
            -- pretty references/codeaction
            use {"RishabhRD/nvim-lsputils", requires = {"RishabhRD/popfix"}, config = require("plugins.nvim-lsputils")}
            -- plugin to add completeion possibility
            use {"nvim-lua/completion-nvim", config = require("plugins.completion-nvim")}
            use "steelsojka/completion-buffers"
            -- use {"aca/completion-tabnine", run = "version=3.1.9 ./install.sh"}
            use {"hrsh7th/vim-vsnip", requires = "hrsh7th/vim-vsnip-integ", config = require("plugins.vim-vsnip")}
            -- syntax high, K docs, something else...
            use "tmux-plugins/vim-tmux"
            -- file tree
            use {"ms-jpq/chadtree", branch = "chad", run = "python3 -m chadtree deps", config = require("plugins.chadtree") }
        end,
        config = {
            display = {
                open_fn = require "packer.util".float
            }
        }
    }
)
