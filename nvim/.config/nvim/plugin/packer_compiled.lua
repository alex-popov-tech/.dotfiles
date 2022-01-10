-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/alexanderpopov/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/alexanderpopov/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/alexanderpopov/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/alexanderpopov/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/alexanderpopov/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FTerm.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vtoggle\nFTerm\frequireÍ\1\1\0\5\0\f\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0'\3\b\0003\4\t\0B\0\4\0016\0\6\0'\2\n\0'\3\b\0'\4\v\0B\0\4\1K\0\1\0005<c-\\><c-n><CMD>lua require('FTerm').toggle()<CR>\6t\0\n<F11>\6n\bmap\15dimensions\1\0\2\nwidth\4ÆèÖ◊\aî‹æˇ\3\vheight\4ÆèÖ◊\aî‹æˇ\3\1\0\1\vborder\frounded\nsetup\nFTerm\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/FTerm.nvim",
    url = "https://github.com/numToStr/FTerm.nvim"
  },
  ["FixCursorHold.nvim"] = {
    config = { "\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1»\0=\1\2\0K\0\1\0\26cursorhold_updatetime\6g\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  ["Navigator.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tleft\14Navigator\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tdown\14Navigator\frequire4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\aup\14Navigator\frequire7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nright\14Navigator\frequire“\1\1\0\5\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0'\2\5\0'\3\6\0003\4\a\0B\0\4\0016\0\4\0'\2\5\0'\3\b\0003\4\t\0B\0\4\0016\0\4\0'\2\5\0'\3\n\0003\4\v\0B\0\4\0016\0\4\0'\2\5\0'\3\f\0003\4\r\0B\0\4\1K\0\1\0\0\n<c-l>\0\n<c-k>\0\n<c-j>\0\n<c-h>\5\bmap\1\0\2\14auto_save\fcurrent\20disable_on_zoom\1\nsetup\14Navigator\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/Navigator.nvim",
    url = "https://github.com/numToStr/Navigator.nvim"
  },
  ["SchemaStore.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/SchemaStore.nvim",
    url = "https://github.com/b0o/SchemaStore.nvim"
  },
  ["YankAssassin.vim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/YankAssassin.vim",
    url = "https://github.com/svban/YankAssassin.vim"
  },
  ["bufresize.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14bufresize\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/bufresize.nvim",
    url = "https://github.com/kwkarlwang/bufresize.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-fuzzy-buffer"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-fuzzy-buffer",
    url = "https://github.com/tzachar/cmp-fuzzy-buffer"
  },
  ["cmp-look"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-look",
    url = "https://github.com/octaltree/cmp-look"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["codi.vim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28cnoreabbrev Eval Codi!!\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/codi.vim",
    url = "https://github.com/metakirby5/codi.vim"
  },
  ["cokeline.nvim"] = {
    config = { "\27LJ\2\nJ\0\1\4\0\3\0\t6\1\0\0009\3\1\0B\1\2\2\15\0\1\0X\2\3Ä6\1\0\0009\3\2\0B\1\2\2L\1\2\0\rfilename\tpath\21isNonEmptyString \0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ticon\fdevicon!\0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ncolor\fdevicon.\0\1\3\0\2\0\0049\1\0\0009\2\1\0&\1\2\1L\1\2\0\rfilename\18unique_prefixZ\0\1\2\0\4\0\v9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0009\1\2\0\15\0\1\0X\2\2Ä'\1\3\0L\1\2\0K\0\1\0\f#EBCB8B\16is_modified\f#B988B0\15is_focused8\0\1\2\0\2\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0+\1\0\0L\1\2\0\14underline\15is_focused6\0\1\2\0\3\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0'\1\2\0L\1\2\0\5\n üîí\16is_readonlyﬁ\4\1\0\v\0*\0A6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\1\3\0006\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\a\0005\5\6\0=\5\b\0045\5\n\0003\6\t\0=\6\v\5=\5\f\0045\5\14\0005\6\r\0=\6\15\0055\6\18\0\18\a\0\0'\t\16\0'\n\17\0B\a\3\2=\a\17\6=\6\19\5=\5\20\0044\5\6\0>\1\1\0055\6\22\0003\a\21\0=\a\23\0065\a\25\0003\b\24\0=\b\17\a=\a\26\6>\6\2\0055\6\28\0003\a\27\0=\a\23\0065\a\30\0003\b\29\0=\b\17\a3\b\31\0=\b \a=\a\26\6>\6\3\0055\6\"\0003\a!\0=\a\23\6>\6\4\5>\1\5\5=\5#\4B\2\2\0016\2$\0'\4%\0B\2\2\0016\2$\0'\4&\0B\2\2\0016\2'\0'\4(\0005\5)\0B\2\3\1K\0\1\0\1\0\1\nguibg\tnone\16tablinefill\ahi.nmap <S-Down> <Plug>(cokeline-focus-prev),nmap <S-Up> <Plug>(cokeline-focus-next)\bcmd\15components\1\0\0\0\nstyle\0\1\0\0\0\1\0\0\0\ahl\1\0\0\0\ttext\1\0\0\0\15default_hl\14unfocused\1\0\1\abg\tnone\afg\fComment\ffocused\1\0\0\1\0\1\abg\tnone\fbuffers\17filter_valid\1\0\0\0\rmappings\1\0\0\1\0\1\20cycle_prev_next\2\nsetup\rcokeline\1\0\1\ttext\6 \fget_hex\19cokeline/utils\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cokeline.nvim",
    url = "https://github.com/noib3/cokeline.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  ["fuzzy.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/fuzzy.nvim",
    url = "https://github.com/tzachar/fuzzy.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["lightspeed.nvim"] = {
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16ignore_case\2\nsetup\15lightspeed\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nè\1\0\0\6\0\a\2\0266\0\0\0009\0\1\0'\2\2\0B\0\2\2\23\0\0\0\b\0\1\0X\1\17Ä6\1\0\0009\1\3\1'\3\2\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\2\0]\0\2\n\0\4\0\0186\2\0\0009\2\1\2\18\4\0\0B\2\2\2!\2\2\1'\3\2\0)\4\1\0\18\5\2\0)\6\1\0M\4\4Ä\18\b\3\0'\t\3\0&\3\t\bO\4¸\18\4\0\0\18\5\3\0&\4\5\4L\4\2\0\6 \5\blen\vstring;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimÔ\1\0\2\b\2\a\0\0225\2\0\0009\3\1\0009\3\2\0038\3\3\2\v\3\0\0X\4\2Ä=\3\3\1X\4\aÄ-\4\0\0009\6\4\1)\a\b\0B\4\3\2\18\5\3\0&\4\5\4=\4\3\1-\4\1\0009\4\5\0049\6\4\0015\a\6\0B\4\3\2=\4\4\1L\1\2\0\3¿\1¿\1\0\1\14with_text\1\rsymbolic\tkind\tmenu\tname\vsource\1\0\6\17fuzzy_buffer\v|fbuf|\rnvim_lsp\n|lsp|\15fuzzy_path\v|fpth|\vbuffer\n|buf|\tpath\n|pth|\rnvim_lua\n|api|Ã\2\0\1\t\2\v\00126\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\29Ä-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\n\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\2¿\n<Tab>\21select_next_item\fvisible\5!<Plug>(vsnip-expand-or-jump)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2˜\1\0\1\t\1\n\1 6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\vÄ-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisible\5\28<Plug>(vsnip-jump-prev)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2ø\r\1\0\14\0V\0ß\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0003\3\4\0009\4\5\0005\6\a\0005\a\6\0=\a\b\0065\a\t\0=\a\n\0065\a\f\0003\b\v\0=\b\r\a=\a\14\0065\a\24\0004\b\b\0009\t\15\0009\t\16\t9\t\17\t>\t\1\b9\t\15\0009\t\16\t9\t\18\t>\t\2\b9\t\15\0009\t\16\t9\t\19\t>\t\3\b9\t\15\0009\t\16\t9\t\20\t>\t\4\b9\t\15\0009\t\16\t9\t\21\t>\t\5\b9\t\15\0009\t\16\t9\t\22\t>\t\6\b9\t\15\0009\t\16\t9\t\23\t>\t\a\b=\b\25\a=\a\26\0064\a\4\0005\b\27\0>\b\1\a5\b\28\0>\b\2\a5\b\29\0>\b\3\a=\a\30\0065\a \0005\b\31\0=\b!\a3\b\"\0=\b#\a=\a$\0065\a'\0009\b%\0009\b&\b)\n¸ˇB\b\2\2=\b(\a9\b%\0009\b&\b)\n\4\0B\b\2\2=\b)\a9\b%\0009\n%\0009\n*\n5\f-\0009\r+\0009\r,\r=\r.\fB\n\2\0025\v/\0B\b\3\2=\b0\a9\b%\0009\n%\0009\n1\n5\f2\0009\r+\0009\r,\r=\r.\fB\n\2\0025\v3\0B\b\3\2=\b4\a9\b%\0009\n%\0009\n*\n5\f5\0009\r+\0009\r,\r=\r.\fB\n\2\0025\v6\0B\b\3\2=\b7\a9\b%\0009\n%\0009\n1\n5\f8\0009\r+\0009\r,\r=\r.\fB\n\2\0025\v9\0B\b\3\2=\b:\a9\b%\0009\n%\0009\n;\n5\f>\0009\r<\0009\r=\r=\r.\fB\n\2\0025\v?\0B\b\3\2=\b@\a3\bA\0=\bB\a3\bC\0=\bD\a=\a%\6B\4\2\0019\4\5\0009\4E\4'\6F\0005\aH\0005\bG\0=\b\b\a4\b\3\0005\tI\0>\t\1\b=\b\30\aB\4\3\0016\4J\0'\6K\0'\aL\0'\bM\0'\tN\0'\nO\0'\vP\0&\b\v\bB\4\4\0016\4J\0'\6K\0'\aQ\0'\bR\0'\tS\0'\nT\0'\vU\0&\b\v\bB\4\4\0012\0\0ÄK\0\1\0\t } }?{ name = \"look\", keyword_length = 5, max_item_count = 10 }-{ name = \"emoji\", max_item_count = 20 },1lua require\"cmp\".setup.buffer { sources = { \23gitcommit,markdown\b}})K{ name = \"nvim_lsp\", trigger_characters = {\".\"}, max_item_count = 20 }\27{ name = \"nvim_lua\" },0lua require\"cmp\".setup.buffer({ sources = {\blua\rfiletype\aau\1\0\1\tname\17fuzzy_buffer\1\0\0\1\0\1\16completeopt#menu,menuone,noinsert,noselect\6/\fcmdline\f<S-Tab>\0\n<Tab>\0\t<CR>\1\3\0\0\6i\6s\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\t<Up>\1\3\0\0\6i\6s\1\0\0\v<Down>\1\3\0\0\6i\6s\1\0\0\n<C-p>\1\3\0\0\6i\6s\1\0\0\21select_prev_item\n<C-n>\1\3\0\0\6i\6s\rbehavior\1\0\0\vInsert\19SelectBehavior\21select_next_item\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\15formatting\vformat\0\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsources\1\0\2\rpriority\3\1\tname\tpath\1\0\3\19max_item_count\3\n\tname\vbuffer\19keyword_length\3\2\1\0\3\19max_item_count\3\n\tname\rnvim_lsp\19keyword_length\3\3\fsorting\16comparators\1\0\0\norder\14sort_text\tkind\nscore\nexact\voffset\vlength\fcompare\vconfig\fsnippet\vexpand\1\0\0\0\17experimental\1\0\2\16native_menu\1\15ghost_text\1\15completion\1\0\0\1\0\1\16completeopt\26menu,menuone,noinsert\nsetup\0\0\flspkind\bcmp\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-code-action-menu"] = {
    commands = { "CodeActionMenu" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/nvim-code-action-menu",
    url = "https://github.com/weilbith/nvim-code-action-menu"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nY\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0+\2\0\0005\3\3\0B\0\3\1K\0\1\0\1\0\2\nnames\1\tmode\15foreground\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils",
    url = "https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-spectre"] = {
    commands = { "Replace" },
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\topen\fspectre\frequire∫\2\1\0\4\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0003\3\b\0B\0\3\1K\0\1\0\0\fReplace\15addCommand\14highlight\1\0\3\freplace\15DiffChange\aui\vString\vsearch\15DiffDelete\1\0\4\19result_padding\t¬¶  \19line_sep_start1‚îå-----------------------------------------\19color_devicons\2\rline_sep1‚îî-----------------------------------------\nsetup\fspectre\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/nvim-spectre",
    url = "https://github.com/windwp/nvim-spectre"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nå\1\0\0\3\0\a\0\0186\0\0\0B\0\1\2\6\0\1\0X\0\4Ä6\0\0\0B\0\1\2\a\0\2\0X\0\5Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\1X\0\4Ä6\0\3\0009\0\4\0'\2\6\0B\0\2\1K\0\1\0\21NvimTreeFindFile\19NvimTreeToggle\bcmd\bvim\rstartify\rNvimTree\aftº\4\1\0\5\0\26\0*6\0\0\0'\2\1\0'\3\2\0003\4\3\0B\0\4\0016\0\4\0'\1\6\0=\1\5\0006\0\4\0)\1\30\0=\1\a\0006\0\4\0)\1\1\0=\1\b\0006\0\4\0)\1\1\0=\1\t\0006\0\4\0)\1\1\0=\1\n\0006\0\4\0)\1\1\0=\1\v\0006\0\4\0005\1\r\0=\1\f\0006\0\4\0005\1\15\0005\2\16\0=\2\17\0015\2\18\0=\2\19\1=\1\14\0006\0\20\0'\2\21\0B\0\2\0029\0\22\0005\2\23\0005\3\24\0=\3\25\2B\0\2\1K\0\1\0\tview\1\0\2\nwidth\0032\tside\nright\1\0\1\15auto_close\2\nsetup\14nvim-tree\frequire\vfolder\1\0\2\topen\bÓóæ\fdefault\bÓóø\bgit\1\0\5\14untracked\b‚òÖ\vstaged\b‚úì\runstaged\b‚úó\frenamed\b‚ûú\runmerged\bÓúß\1\0\2\fdefault\bÓòí\fsymlink\bÔíÅ\20nvim_tree_icons\1\0\3\bgit\3\1\ffolders\3\1\nfiles\3\1\25nvim_tree_show_icons\27nvim_tree_allow_resize\21nvim_tree_git_hl\29nvim_tree_indent_markers\27nvim_tree_quit_on_open\20nvim_tree_width\tleft\19nvim_tree_side\6g\0\n<c-f>\6n\bmap\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\ná\5\0\0\6\0\26\0\"6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0025\1\a\0005\2\4\0005\3\5\0=\3\6\2=\2\b\1=\1\3\0006\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\v\0005\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\0044\5\0\0=\5\22\0045\5\23\0=\5\24\4=\4\25\3B\1\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\19highlight_self\1\venable\2\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\19goto_right_end\1\26context_commentstring\1\0\1\venable\2\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\2\0\0\fhaskell\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\17install_info\1\0\0\nfiles\1\2\0\0\17src/parser.c\1\0\2\vbranch\tmain\burl5https://github.com/NTBBloodbath/tree-sitter-http\thttp\23get_parser_configs\28nvim-treesitter.parsers\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    config = { "\27LJ\2\nu\0\0\3\0\6\0\0146\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\3\0'\2\4\0B\0\2\0029\0\5\0B\0\1\0016\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\nsetup\20nvim-ts-autotag\frequire\22loaded_commentary\6g\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["obvious-resize"] = {
    config = { "\27LJ\2\nß\2\0\0\5\0\r\0\0276\0\0\0)\1\4\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0006\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\3\0'\2\4\0'\3\a\0'\4\b\0B\0\4\0016\0\3\0'\2\4\0'\3\t\0'\4\n\0B\0\4\0016\0\3\0'\2\4\0'\3\v\0'\4\f\0B\0\4\1K\0\1\0\28:ObviousResizeRight<cr>\14<c-right>\27:ObviousResizeLeft<cr>\r<c-left>\27:ObviousResizeDown<cr>\r<c-down>\25:ObviousResizeUp<cr>\v<c-up>\5\bmap\28obvious_resize_run_tmux\27obvious_resize_default\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/obvious-resize",
    url = "https://github.com/talek/obvious-resize"
  },
  ["onenord.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/onenord.nvim",
    url = "https://github.com/rmehri01/onenord.nvim"
  },
  ["packer.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27command! PS PackerSync\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["rest.nvim"] = {
    config = { "\27LJ\2\n®\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\2\fenabled\2\ftimeout\3ñ\1\1\0\3\28result_split_horizontal\1\20jump_to_request\1\26skip_ssl_verification\1\nsetup\14rest-nvim\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/rest.nvim",
    url = "https://github.com/NTBBloodbath/rest.nvim"
  },
  ["stabilize.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/stabilize.nvim",
    url = "https://github.com/luukvbaal/stabilize.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\1¿\14git_filesR\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\2\14no_ignore\2\vhidden\2\nmerge\15find_files)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\14live_grep(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreW\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\14live_grep+\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\16grep_string(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreY\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\16grep_stringK\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\18sort_lastused\2\nmerge\fbuffersG\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\rcmd_only\2\nmerge\roldfiles\3\1\0\b\0\27\00096\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0025\1\4\0005\2\5\0=\2\6\0015\2\a\0005\3\b\0=\3\6\0026\3\t\0'\5\n\0'\6\v\0003\a\f\0B\3\4\0016\3\t\0'\5\n\0'\6\r\0003\a\14\0B\3\4\0016\3\t\0'\5\n\0'\6\15\0003\a\16\0B\3\4\0016\3\t\0'\5\n\0'\6\17\0003\a\18\0B\3\4\0016\3\t\0'\5\n\0'\6\19\0003\a\20\0B\3\4\0016\3\t\0'\5\n\0'\6\21\0003\a\22\0B\3\4\0016\3\t\0'\5\n\0'\6\23\0003\a\24\0B\3\4\0016\3\t\0'\5\n\0'\6\25\0003\a\26\0B\3\4\0012\0\0ÄK\0\1\0\0\agh\0\agb\0\agO\0\ago\0\agC\0\agc\0\agF\0\agf\6n\bmap\1\0\2\nwidth\4Õô≥Ê\fÃô≥ˇ\3\vheight\4Õô≥Ê\fÃô≥ˇ\3\1\0\1\20layout_strategy\rvertical\18layout_config\1\0\4\nwidth\4Õô≥Ê\fÃô≥ˇ\3\vheight\4Õô≥Ê\fÃô≥ˇ\3\18preview_width\4ö≥ÊÃ\tô≥Ê˛\3\vmirror\1\1\0\1\20layout_strategy\15horizontal\22telescope.builtin\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nx\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\25use_diagnostic_signs\2\tmode\25document_diagnostics\15auto_close\2\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-abolish"] = {
    config = { "\27LJ\2\nU\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\26cnoreabbrev S Subvert\28cnoreabbrev %S %Subvert\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-bbye"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27cnoreabbrev bd Bdelete\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-bbye",
    url = "https://github.com/moll/vim-bbye"
  },
  ["vim-bufonly"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25cnoreabbrev bo Bonly\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-bufonly",
    url = "https://github.com/schickling/vim-bufonly"
  },
  ["vim-commentary"] = {
    config = { "\27LJ\2\nÿ\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0$nmap <leader>c <Plug>Commentary$omap <leader>c <Plug>Commentary$xmap <leader>c <Plug>Commentary)nmap <leader>cc <Plug>CommentaryLine\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-dadbod",
    url = "https://github.com/tpope/vim-dadbod"
  },
  ["vim-dadbod-completion"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-dadbod-completion",
    url = "https://github.com/kristijanhusak/vim-dadbod-completion"
  },
  ["vim-dadbod-ui"] = {
    config = { "\27LJ\2\nê\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\25db_ui_use_nerd_fonts\29db_ui_show_database_icon%db_ui_auto_execute_table_helpers\6g\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-dadbod-ui",
    url = "https://github.com/kristijanhusak/vim-dadbod-ui"
  },
  ["vim-dotenv"] = {
    config = { "\27LJ\2\n]\0\0\5\0\5\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\4\0'\3\2\0'\4\3\0B\0\4\1K\0\1\0\17BufWritePost\16Dotenv .env\t.env\rVimEnter\aau\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-dotenv",
    url = "https://github.com/tpope/vim-dotenv"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\nó\2\0\0\5\0\f\0\0266\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\0016\0\0\0'\2\1\0'\3\6\0'\4\a\0B\0\4\0016\0\0\0'\2\1\0'\3\b\0'\4\t\0B\0\4\0016\0\0\0'\2\1\0'\3\n\0'\4\v\0B\0\4\1K\0\1\0\21:diffget //3<cr>\agr\21:diffget //2<cr>\agl\30<cmd>Git push --force<cr>\bgpf8<cmd>exe 'Git push -u origin ' . FugitiveHead()<cr>\15<leader>gp\22<cmd>Git | on<cr>\15<leader>gs\6n\bmap\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-lastplace"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-lastplace",
    url = "https://github.com/farmergreg/vim-lastplace"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-startify"] = {
    config = { "\27LJ\2\nå\2\0\0\a\0\v\0\0236\0\0\0004\1\3\0005\2\2\0004\3\3\0'\4\3\0006\5\4\0009\5\5\5B\5\1\2&\4\5\4>\4\1\3=\3\6\2>\2\1\1=\1\1\0006\0\0\0)\1\1\0=\1\a\0006\0\0\0)\1\1\0=\1\b\0006\0\0\0005\1\n\0=\1\t\0K\0\1\0\1\t\0\0\6a\6r\6e\6t\6o\6s\6i\6n\28startify_custom_indices\28startify_enable_special startify_change_to_vcs_root\vheader\vgetcwd\afn\31 Most recently updated in \1\0\1\ttype\bdir\19startify_lists\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-startify",
    url = "https://github.com/mhinz/vim-startify"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-subversive"] = {
    config = { "\27LJ\2\nÀ\2\0\0\5\0\6\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0ç\1:<c-u>call subversive#singleMotion#substituteLineSetup(v:register, v:count)<cr>:set opfunc=subversive#singleMotion#substituteLine<cr>g@l\ammÜ\1:<c-u>call subversive#singleMotion#preSubstitute(v:register, 0, '')<cr>:set opfunc=subversive#singleMotion#substituteMotion<cr>g@\6m\6n\bmap\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-subversive",
    url = "https://github.com/svermeulen/vim-subversive"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-terraform"] = {
    config = { "\27LJ\2\nS\0\0\2\0\3\0\a6\0\0\0)\1\1\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0K\0\1\0\26terraform_fmt_on_save\28terraform_fold_sections\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-terraform",
    url = "https://github.com/hashivim/vim-terraform"
  },
  ["vim-textobj-comment"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-textobj-comment",
    url = "https://github.com/glts/vim-textobj-comment"
  },
  ["vim-textobj-indent"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-textobj-indent",
    url = "https://github.com/kana/vim-textobj-indent"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    config = { "\27LJ\2\nx\0\0\4\0\a\0\f6\0\0\0+\1\1\0=\1\1\0006\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0K\0\1\0\v/vsnip\vconfig\fstdpath\afn\22vsnip_snippet_dir\24vsnip_extra_mapping\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ",
    url = "https://github.com/hrsh7th/vim-vsnip-integ"
  },
  ["vim-wordmotion"] = {
    config = { "\27LJ\2\n4\0\0\2\0\3\0\0046\0\0\0'\1\2\0=\1\1\0K\0\1\0\r<leader>\22wordmotion_prefix\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  },
  ["windline.nvim"] = {
    config = { "\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 ì\1\0\1\a\0\6\0\t6\1\0\0009\1\1\1'\3\2\0\18\4\0\0005\5\4\0009\6\3\0=\6\5\5B\1\4\2L\1\2\0\17default_blue\1\0\5\abg\tnone\ngreen\f#A3BE8C\bred\f#D57780\tblue\f#81A1C1\vyellow\f#EBCB8B\tblue\nforce\15tbl_extend\bvimŒ\3\0\0\f\0\26\0A'\0\0\0006\1\1\0009\1\2\0019\1\3\1\15\0\1\0X\2\1Ä'\0\4\0'\1\5\0006\2\1\0009\2\2\0029\2\6\2\15\0\2\0X\3\1Ä'\1\a\0006\2\1\0009\2\b\0029\2\t\0026\4\1\0009\4\b\0049\4\n\4'\6\v\0B\4\2\2'\5\f\0B\2\3\0026\3\1\0009\3\b\0039\3\n\3'\5\r\0B\3\2\0026\4\1\0009\4\b\0049\4\n\4'\6\14\0B\4\2\0026\5\15\0'\a\16\0B\5\2\0029\5\17\5\18\a\3\0\18\b\4\0B\5\3\0036\a\18\0'\t\19\0005\n\20\0\f\v\6\0X\v\1Ä'\v\21\0=\v\22\nB\a\3\0014\a\4\0005\b\23\0>\5\1\b>\b\1\a5\b\24\0>\b\2\a4\b\3\0\18\t\0\0\18\n\2\0&\t\n\t>\t\1\b5\t\25\0>\1\1\t>\t\2\b>\b\3\aL\a\2\0\1\3\0\0\0\abg\1\2\0\0\6 \1\3\0\0\0\16WL_icon_tmp\nguifg\nwhite\1\0\1\nguibg\tnone\16WL_icon_tmp\ahi\19get_icon_color\22nvim-web-devicons\frequire\b%:e\b%:t\t:~:.\6%\vexpand\16fnamemodify\afn\vyellow\rmodified\ngreen\nüîí \rreadonly\abo\bvim\5≥\3\0\1\6\1\16\0002-\1\0\0009\1\0\1\18\3\0\0B\1\2\2\14\0\1\0X\1\2Ä'\1\1\0L\1\2\0004\1\6\0004\2\3\0-\3\0\0009\3\2\0035\5\3\0B\3\2\2>\3\1\0025\3\4\0>\3\2\2>\2\1\0015\2\5\0005\3\6\0>\3\2\2>\2\2\0014\2\3\0-\3\0\0009\3\a\0035\5\b\0B\3\2\2>\3\1\0025\3\t\0>\3\2\2>\2\3\0014\2\3\0-\3\0\0009\3\n\0035\5\v\0B\3\2\2>\3\1\0025\3\f\0>\3\2\2>\2\4\0014\2\3\0-\3\0\0009\3\r\0035\5\14\0B\3\2\2>\3\1\0025\3\15\0>\3\2\2>\2\5\1L\1\2\0\3¿\1\3\0\0\tblue\abg\1\0\2\14show_zero\2\vformat\v Ôßâ%s\17diff_changed\1\3\0\0\bred\abg\1\0\2\14show_zero\2\vformat\f ÔÖÜ %s\17diff_removed\1\3\0\0\ngreen\abg\1\0\2\14show_zero\2\vformat\f ÔÉæ %s\15diff_added\1\3\0\0\ngreen\abg\1\2\0\0\n with\1\3\0\0\bred\abg\1\0\1\ticon\n ÓúÇ \15git_branch\5\vis_gitœ\2\0\1\6\1\v\0%-\1\0\0009\1\0\1\18\3\0\0B\1\2\2\14\0\1\0X\1\2Ä5\1\1\0L\1\2\0004\1\4\0004\2\3\0-\3\0\0009\3\2\0035\5\3\0B\3\2\2>\3\1\0025\3\4\0>\3\2\2>\2\1\0014\2\3\0-\3\0\0009\3\5\0035\5\6\0B\3\2\2>\3\1\0025\3\a\0>\3\2\2>\2\2\0014\2\3\0-\3\0\0009\3\b\0035\5\t\0B\3\2\2>\3\1\0025\3\n\0>\3\2\2>\2\3\1L\1\2\0\2¿\1\3\0\0\17default_blue\abg\1\0\2\14show_zero\2\vformat\f Ôüª %s\rlsp_hint\1\3\0\0\vyellow\abg\1\0\2\14show_zero\2\vformat\f ÔÅ± %s\16lsp_warning\1\3\0\0\bred\abg\1\0\2\14show_zero\2\vformat\f ÔÅó %s\14lsp_error\1\2\0\0\5\14check_lspu\0\1\6\1\4\1\17-\1\0\0009\1\0\1\18\3\0\0B\1\2\2\14\0\1\0X\1\2Ä'\1\1\0L\1\2\0004\1\3\0004\2\3\0-\3\0\0009\3\2\0035\5\3\0B\3\2\0?\3\0\0>\2\1\1L\1\2\0\2¿\1\0\1\rseprator\6,\rlsp_name\5\14check_lsp\3ÄÄ¿ô\4Å\5\1\0\14\0!\0C6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0024\4\3\0003\5\5\0>\5\1\0044\5\3\0009\6\6\1>\6\1\0059\6\a\0005\b\t\0003\t\b\0=\t\n\b4\t\3\0005\n\f\0005\v\v\0=\v\r\n4\v\t\0>\4\1\v5\f\14\0003\r\15\0=\r\16\f>\f\2\v5\f\17\0003\r\18\0=\r\16\f>\f\3\v>\5\4\v5\f\19\0003\r\20\0=\r\16\f>\f\5\v>\4\6\v5\f\21\0003\r\22\0=\r\16\f>\f\a\v>\4\b\v=\v\23\n4\v\0\0=\v\24\n>\n\1\t=\t\25\bB\6\2\0016\6\0\0'\b\26\0B\6\2\0029\6\a\0065\b\27\0005\t\28\0=\t\29\b5\t\30\0=\t\31\b4\t\0\0=\t \bB\6\2\0012\0\0ÄK\0\1\0\28floating_show_filetypes\19skip_filetypes\1\3\0\0\rNvimTree\blir\aui\1\0\2\17active_color\tblue\16active_char\6-\1\0\1\rinterval\3¨\2\16wlfloatline\16statuslines\rinactive\vactive\0\1\0\1\tname\rlsp_name\0\1\0\1\tname\15diagnostic\0\1\0\1\tname\bgit\ttext\0\1\0\1\tname\tfile\14filetypes\1\0\0\1\2\0\0\fdefault\16colors_name\1\0\0\0\nsetup\fdivider\0\28windline.components.git\28windline.components.lsp\30windline.components.basic\rwindline\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/windline.nvim",
    url = "https://github.com/windwp/windline.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nY\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0+\2\0\0005\3\3\0B\0\3\1K\0\1\0\1\0\2\nnames\1\tmode\15foreground\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\1¿\14git_filesR\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\2\14no_ignore\2\vhidden\2\nmerge\15find_files)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\14live_grep(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreW\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\14live_grep+\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\16grep_string(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreY\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\16grep_stringK\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\18sort_lastused\2\nmerge\fbuffersG\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\rcmd_only\2\nmerge\roldfiles\3\1\0\b\0\27\00096\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0025\1\4\0005\2\5\0=\2\6\0015\2\a\0005\3\b\0=\3\6\0026\3\t\0'\5\n\0'\6\v\0003\a\f\0B\3\4\0016\3\t\0'\5\n\0'\6\r\0003\a\14\0B\3\4\0016\3\t\0'\5\n\0'\6\15\0003\a\16\0B\3\4\0016\3\t\0'\5\n\0'\6\17\0003\a\18\0B\3\4\0016\3\t\0'\5\n\0'\6\19\0003\a\20\0B\3\4\0016\3\t\0'\5\n\0'\6\21\0003\a\22\0B\3\4\0016\3\t\0'\5\n\0'\6\23\0003\a\24\0B\3\4\0016\3\t\0'\5\n\0'\6\25\0003\a\26\0B\3\4\0012\0\0ÄK\0\1\0\0\agh\0\agb\0\agO\0\ago\0\agC\0\agc\0\agF\0\agf\6n\bmap\1\0\2\nwidth\4Õô≥Ê\fÃô≥ˇ\3\vheight\4Õô≥Ê\fÃô≥ˇ\3\1\0\1\20layout_strategy\rvertical\18layout_config\1\0\4\nwidth\4Õô≥Ê\fÃô≥ˇ\3\vheight\4Õô≥Ê\fÃô≥ˇ\3\18preview_width\4ö≥ÊÃ\tô≥Ê˛\3\vmirror\1\1\0\1\20layout_strategy\15horizontal\22telescope.builtin\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nx\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\25use_diagnostic_signs\2\tmode\25document_diagnostics\15auto_close\2\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: vim-vsnip
time([[Config for vim-vsnip]], true)
try_loadstring("\27LJ\2\nx\0\0\4\0\a\0\f6\0\0\0+\1\1\0=\1\1\0006\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0K\0\1\0\v/vsnip\vconfig\fstdpath\afn\22vsnip_snippet_dir\24vsnip_extra_mapping\6g\0", "config", "vim-vsnip")
time([[Config for vim-vsnip]], false)
-- Config for: vim-bbye
time([[Config for vim-bbye]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27cnoreabbrev bd Bdelete\bcmd\0", "config", "vim-bbye")
time([[Config for vim-bbye]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nå\1\0\0\3\0\a\0\0186\0\0\0B\0\1\2\6\0\1\0X\0\4Ä6\0\0\0B\0\1\2\a\0\2\0X\0\5Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\1X\0\4Ä6\0\3\0009\0\4\0'\2\6\0B\0\2\1K\0\1\0\21NvimTreeFindFile\19NvimTreeToggle\bcmd\bvim\rstartify\rNvimTree\aftº\4\1\0\5\0\26\0*6\0\0\0'\2\1\0'\3\2\0003\4\3\0B\0\4\0016\0\4\0'\1\6\0=\1\5\0006\0\4\0)\1\30\0=\1\a\0006\0\4\0)\1\1\0=\1\b\0006\0\4\0)\1\1\0=\1\t\0006\0\4\0)\1\1\0=\1\n\0006\0\4\0)\1\1\0=\1\v\0006\0\4\0005\1\r\0=\1\f\0006\0\4\0005\1\15\0005\2\16\0=\2\17\0015\2\18\0=\2\19\1=\1\14\0006\0\20\0'\2\21\0B\0\2\0029\0\22\0005\2\23\0005\3\24\0=\3\25\2B\0\2\1K\0\1\0\tview\1\0\2\nwidth\0032\tside\nright\1\0\1\15auto_close\2\nsetup\14nvim-tree\frequire\vfolder\1\0\2\topen\bÓóæ\fdefault\bÓóø\bgit\1\0\5\14untracked\b‚òÖ\vstaged\b‚úì\runstaged\b‚úó\frenamed\b‚ûú\runmerged\bÓúß\1\0\2\fdefault\bÓòí\fsymlink\bÔíÅ\20nvim_tree_icons\1\0\3\bgit\3\1\ffolders\3\1\nfiles\3\1\25nvim_tree_show_icons\27nvim_tree_allow_resize\21nvim_tree_git_hl\29nvim_tree_indent_markers\27nvim_tree_quit_on_open\20nvim_tree_width\tleft\19nvim_tree_side\6g\0\n<c-f>\6n\bmap\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: vim-wordmotion
time([[Config for vim-wordmotion]], true)
try_loadstring("\27LJ\2\n4\0\0\2\0\3\0\0046\0\0\0'\1\2\0=\1\1\0K\0\1\0\r<leader>\22wordmotion_prefix\6g\0", "config", "vim-wordmotion")
time([[Config for vim-wordmotion]], false)
-- Config for: vim-bufonly
time([[Config for vim-bufonly]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25cnoreabbrev bo Bonly\bcmd\0", "config", "vim-bufonly")
time([[Config for vim-bufonly]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\ná\5\0\0\6\0\26\0\"6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0025\1\a\0005\2\4\0005\3\5\0=\3\6\2=\2\b\1=\1\3\0006\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\v\0005\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\0044\5\0\0=\5\22\0045\5\23\0=\5\24\4=\4\25\3B\1\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\19highlight_self\1\venable\2\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\19goto_right_end\1\26context_commentstring\1\0\1\venable\2\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\2\0\0\fhaskell\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\17install_info\1\0\0\nfiles\1\2\0\0\17src/parser.c\1\0\2\vbranch\tmain\burl5https://github.com/NTBBloodbath/tree-sitter-http\thttp\23get_parser_configs\28nvim-treesitter.parsers\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: windline.nvim
time([[Config for windline.nvim]], true)
try_loadstring("\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 ì\1\0\1\a\0\6\0\t6\1\0\0009\1\1\1'\3\2\0\18\4\0\0005\5\4\0009\6\3\0=\6\5\5B\1\4\2L\1\2\0\17default_blue\1\0\5\abg\tnone\ngreen\f#A3BE8C\bred\f#D57780\tblue\f#81A1C1\vyellow\f#EBCB8B\tblue\nforce\15tbl_extend\bvimŒ\3\0\0\f\0\26\0A'\0\0\0006\1\1\0009\1\2\0019\1\3\1\15\0\1\0X\2\1Ä'\0\4\0'\1\5\0006\2\1\0009\2\2\0029\2\6\2\15\0\2\0X\3\1Ä'\1\a\0006\2\1\0009\2\b\0029\2\t\0026\4\1\0009\4\b\0049\4\n\4'\6\v\0B\4\2\2'\5\f\0B\2\3\0026\3\1\0009\3\b\0039\3\n\3'\5\r\0B\3\2\0026\4\1\0009\4\b\0049\4\n\4'\6\14\0B\4\2\0026\5\15\0'\a\16\0B\5\2\0029\5\17\5\18\a\3\0\18\b\4\0B\5\3\0036\a\18\0'\t\19\0005\n\20\0\f\v\6\0X\v\1Ä'\v\21\0=\v\22\nB\a\3\0014\a\4\0005\b\23\0>\5\1\b>\b\1\a5\b\24\0>\b\2\a4\b\3\0\18\t\0\0\18\n\2\0&\t\n\t>\t\1\b5\t\25\0>\1\1\t>\t\2\b>\b\3\aL\a\2\0\1\3\0\0\0\abg\1\2\0\0\6 \1\3\0\0\0\16WL_icon_tmp\nguifg\nwhite\1\0\1\nguibg\tnone\16WL_icon_tmp\ahi\19get_icon_color\22nvim-web-devicons\frequire\b%:e\b%:t\t:~:.\6%\vexpand\16fnamemodify\afn\vyellow\rmodified\ngreen\nüîí \rreadonly\abo\bvim\5≥\3\0\1\6\1\16\0002-\1\0\0009\1\0\1\18\3\0\0B\1\2\2\14\0\1\0X\1\2Ä'\1\1\0L\1\2\0004\1\6\0004\2\3\0-\3\0\0009\3\2\0035\5\3\0B\3\2\2>\3\1\0025\3\4\0>\3\2\2>\2\1\0015\2\5\0005\3\6\0>\3\2\2>\2\2\0014\2\3\0-\3\0\0009\3\a\0035\5\b\0B\3\2\2>\3\1\0025\3\t\0>\3\2\2>\2\3\0014\2\3\0-\3\0\0009\3\n\0035\5\v\0B\3\2\2>\3\1\0025\3\f\0>\3\2\2>\2\4\0014\2\3\0-\3\0\0009\3\r\0035\5\14\0B\3\2\2>\3\1\0025\3\15\0>\3\2\2>\2\5\1L\1\2\0\3¿\1\3\0\0\tblue\abg\1\0\2\14show_zero\2\vformat\v Ôßâ%s\17diff_changed\1\3\0\0\bred\abg\1\0\2\14show_zero\2\vformat\f ÔÖÜ %s\17diff_removed\1\3\0\0\ngreen\abg\1\0\2\14show_zero\2\vformat\f ÔÉæ %s\15diff_added\1\3\0\0\ngreen\abg\1\2\0\0\n with\1\3\0\0\bred\abg\1\0\1\ticon\n ÓúÇ \15git_branch\5\vis_gitœ\2\0\1\6\1\v\0%-\1\0\0009\1\0\1\18\3\0\0B\1\2\2\14\0\1\0X\1\2Ä5\1\1\0L\1\2\0004\1\4\0004\2\3\0-\3\0\0009\3\2\0035\5\3\0B\3\2\2>\3\1\0025\3\4\0>\3\2\2>\2\1\0014\2\3\0-\3\0\0009\3\5\0035\5\6\0B\3\2\2>\3\1\0025\3\a\0>\3\2\2>\2\2\0014\2\3\0-\3\0\0009\3\b\0035\5\t\0B\3\2\2>\3\1\0025\3\n\0>\3\2\2>\2\3\1L\1\2\0\2¿\1\3\0\0\17default_blue\abg\1\0\2\14show_zero\2\vformat\f Ôüª %s\rlsp_hint\1\3\0\0\vyellow\abg\1\0\2\14show_zero\2\vformat\f ÔÅ± %s\16lsp_warning\1\3\0\0\bred\abg\1\0\2\14show_zero\2\vformat\f ÔÅó %s\14lsp_error\1\2\0\0\5\14check_lspu\0\1\6\1\4\1\17-\1\0\0009\1\0\1\18\3\0\0B\1\2\2\14\0\1\0X\1\2Ä'\1\1\0L\1\2\0004\1\3\0004\2\3\0-\3\0\0009\3\2\0035\5\3\0B\3\2\0?\3\0\0>\2\1\1L\1\2\0\2¿\1\0\1\rseprator\6,\rlsp_name\5\14check_lsp\3ÄÄ¿ô\4Å\5\1\0\14\0!\0C6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0024\4\3\0003\5\5\0>\5\1\0044\5\3\0009\6\6\1>\6\1\0059\6\a\0005\b\t\0003\t\b\0=\t\n\b4\t\3\0005\n\f\0005\v\v\0=\v\r\n4\v\t\0>\4\1\v5\f\14\0003\r\15\0=\r\16\f>\f\2\v5\f\17\0003\r\18\0=\r\16\f>\f\3\v>\5\4\v5\f\19\0003\r\20\0=\r\16\f>\f\5\v>\4\6\v5\f\21\0003\r\22\0=\r\16\f>\f\a\v>\4\b\v=\v\23\n4\v\0\0=\v\24\n>\n\1\t=\t\25\bB\6\2\0016\6\0\0'\b\26\0B\6\2\0029\6\a\0065\b\27\0005\t\28\0=\t\29\b5\t\30\0=\t\31\b4\t\0\0=\t \bB\6\2\0012\0\0ÄK\0\1\0\28floating_show_filetypes\19skip_filetypes\1\3\0\0\rNvimTree\blir\aui\1\0\2\17active_color\tblue\16active_char\6-\1\0\1\rinterval\3¨\2\16wlfloatline\16statuslines\rinactive\vactive\0\1\0\1\tname\rlsp_name\0\1\0\1\tname\15diagnostic\0\1\0\1\tname\bgit\ttext\0\1\0\1\tname\tfile\14filetypes\1\0\0\1\2\0\0\fdefault\16colors_name\1\0\0\0\nsetup\fdivider\0\28windline.components.git\28windline.components.lsp\30windline.components.basic\rwindline\frequire\0", "config", "windline.nvim")
time([[Config for windline.nvim]], false)
-- Config for: vim-commentary
time([[Config for vim-commentary]], true)
try_loadstring("\27LJ\2\nÿ\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0$nmap <leader>c <Plug>Commentary$omap <leader>c <Plug>Commentary$xmap <leader>c <Plug>Commentary)nmap <leader>cc <Plug>CommentaryLine\bcmd\bvim\0", "config", "vim-commentary")
time([[Config for vim-commentary]], false)
-- Config for: codi.vim
time([[Config for codi.vim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28cnoreabbrev Eval Codi!!\bcmd\0", "config", "codi.vim")
time([[Config for codi.vim]], false)
-- Config for: nvim-ts-context-commentstring
time([[Config for nvim-ts-context-commentstring]], true)
try_loadstring("\27LJ\2\nu\0\0\3\0\6\0\0146\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\3\0'\2\4\0B\0\2\0029\0\5\0B\0\1\0016\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\nsetup\20nvim-ts-autotag\frequire\22loaded_commentary\6g\bvim\0", "config", "nvim-ts-context-commentstring")
time([[Config for nvim-ts-context-commentstring]], false)
-- Config for: cokeline.nvim
time([[Config for cokeline.nvim]], true)
try_loadstring("\27LJ\2\nJ\0\1\4\0\3\0\t6\1\0\0009\3\1\0B\1\2\2\15\0\1\0X\2\3Ä6\1\0\0009\3\2\0B\1\2\2L\1\2\0\rfilename\tpath\21isNonEmptyString \0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ticon\fdevicon!\0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ncolor\fdevicon.\0\1\3\0\2\0\0049\1\0\0009\2\1\0&\1\2\1L\1\2\0\rfilename\18unique_prefixZ\0\1\2\0\4\0\v9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0009\1\2\0\15\0\1\0X\2\2Ä'\1\3\0L\1\2\0K\0\1\0\f#EBCB8B\16is_modified\f#B988B0\15is_focused8\0\1\2\0\2\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0+\1\0\0L\1\2\0\14underline\15is_focused6\0\1\2\0\3\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0'\1\2\0L\1\2\0\5\n üîí\16is_readonlyﬁ\4\1\0\v\0*\0A6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\1\3\0006\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\a\0005\5\6\0=\5\b\0045\5\n\0003\6\t\0=\6\v\5=\5\f\0045\5\14\0005\6\r\0=\6\15\0055\6\18\0\18\a\0\0'\t\16\0'\n\17\0B\a\3\2=\a\17\6=\6\19\5=\5\20\0044\5\6\0>\1\1\0055\6\22\0003\a\21\0=\a\23\0065\a\25\0003\b\24\0=\b\17\a=\a\26\6>\6\2\0055\6\28\0003\a\27\0=\a\23\0065\a\30\0003\b\29\0=\b\17\a3\b\31\0=\b \a=\a\26\6>\6\3\0055\6\"\0003\a!\0=\a\23\6>\6\4\5>\1\5\5=\5#\4B\2\2\0016\2$\0'\4%\0B\2\2\0016\2$\0'\4&\0B\2\2\0016\2'\0'\4(\0005\5)\0B\2\3\1K\0\1\0\1\0\1\nguibg\tnone\16tablinefill\ahi.nmap <S-Down> <Plug>(cokeline-focus-prev),nmap <S-Up> <Plug>(cokeline-focus-next)\bcmd\15components\1\0\0\0\nstyle\0\1\0\0\0\1\0\0\0\ahl\1\0\0\0\ttext\1\0\0\0\15default_hl\14unfocused\1\0\1\abg\tnone\afg\fComment\ffocused\1\0\0\1\0\1\abg\tnone\fbuffers\17filter_valid\1\0\0\0\rmappings\1\0\0\1\0\1\20cycle_prev_next\2\nsetup\rcokeline\1\0\1\ttext\6 \fget_hex\19cokeline/utils\frequire\0", "config", "cokeline.nvim")
time([[Config for cokeline.nvim]], false)
-- Config for: vim-dadbod-ui
time([[Config for vim-dadbod-ui]], true)
try_loadstring("\27LJ\2\nê\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\25db_ui_use_nerd_fonts\29db_ui_show_database_icon%db_ui_auto_execute_table_helpers\6g\bvim\0", "config", "vim-dadbod-ui")
time([[Config for vim-dadbod-ui]], false)
-- Config for: vim-dotenv
time([[Config for vim-dotenv]], true)
try_loadstring("\27LJ\2\n]\0\0\5\0\5\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\4\0'\3\2\0'\4\3\0B\0\4\1K\0\1\0\17BufWritePost\16Dotenv .env\t.env\rVimEnter\aau\0", "config", "vim-dotenv")
time([[Config for vim-dotenv]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\nó\2\0\0\5\0\f\0\0266\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\0016\0\0\0'\2\1\0'\3\6\0'\4\a\0B\0\4\0016\0\0\0'\2\1\0'\3\b\0'\4\t\0B\0\4\0016\0\0\0'\2\1\0'\3\n\0'\4\v\0B\0\4\1K\0\1\0\21:diffget //3<cr>\agr\21:diffget //2<cr>\agl\30<cmd>Git push --force<cr>\bgpf8<cmd>exe 'Git push -u origin ' . FugitiveHead()<cr>\15<leader>gp\22<cmd>Git | on<cr>\15<leader>gs\6n\bmap\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: FTerm.nvim
time([[Config for FTerm.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vtoggle\nFTerm\frequireÍ\1\1\0\5\0\f\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0'\3\b\0003\4\t\0B\0\4\0016\0\6\0'\2\n\0'\3\b\0'\4\v\0B\0\4\1K\0\1\0005<c-\\><c-n><CMD>lua require('FTerm').toggle()<CR>\6t\0\n<F11>\6n\bmap\15dimensions\1\0\2\nwidth\4ÆèÖ◊\aî‹æˇ\3\vheight\4ÆèÖ◊\aî‹æˇ\3\1\0\1\vborder\frounded\nsetup\nFTerm\frequire\0", "config", "FTerm.nvim")
time([[Config for FTerm.nvim]], false)
-- Config for: lightspeed.nvim
time([[Config for lightspeed.nvim]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16ignore_case\2\nsetup\15lightspeed\frequire\0", "config", "lightspeed.nvim")
time([[Config for lightspeed.nvim]], false)
-- Config for: FixCursorHold.nvim
time([[Config for FixCursorHold.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1»\0=\1\2\0K\0\1\0\26cursorhold_updatetime\6g\bvim\0", "config", "FixCursorHold.nvim")
time([[Config for FixCursorHold.nvim]], false)
-- Config for: packer.nvim
time([[Config for packer.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27command! PS PackerSync\bcmd\0", "config", "packer.nvim")
time([[Config for packer.nvim]], false)
-- Config for: Navigator.nvim
time([[Config for Navigator.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tleft\14Navigator\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tdown\14Navigator\frequire4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\aup\14Navigator\frequire7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nright\14Navigator\frequire“\1\1\0\5\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0'\2\5\0'\3\6\0003\4\a\0B\0\4\0016\0\4\0'\2\5\0'\3\b\0003\4\t\0B\0\4\0016\0\4\0'\2\5\0'\3\n\0003\4\v\0B\0\4\0016\0\4\0'\2\5\0'\3\f\0003\4\r\0B\0\4\1K\0\1\0\0\n<c-l>\0\n<c-k>\0\n<c-j>\0\n<c-h>\5\bmap\1\0\2\14auto_save\fcurrent\20disable_on_zoom\1\nsetup\14Navigator\frequire\0", "config", "Navigator.nvim")
time([[Config for Navigator.nvim]], false)
-- Config for: vim-subversive
time([[Config for vim-subversive]], true)
try_loadstring("\27LJ\2\nÀ\2\0\0\5\0\6\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0ç\1:<c-u>call subversive#singleMotion#substituteLineSetup(v:register, v:count)<cr>:set opfunc=subversive#singleMotion#substituteLine<cr>g@l\ammÜ\1:<c-u>call subversive#singleMotion#preSubstitute(v:register, 0, '')<cr>:set opfunc=subversive#singleMotion#substituteMotion<cr>g@\6m\6n\bmap\0", "config", "vim-subversive")
time([[Config for vim-subversive]], false)
-- Config for: vim-abolish
time([[Config for vim-abolish]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\26cnoreabbrev S Subvert\28cnoreabbrev %S %Subvert\bcmd\0", "config", "vim-abolish")
time([[Config for vim-abolish]], false)
-- Config for: rest.nvim
time([[Config for rest.nvim]], true)
try_loadstring("\27LJ\2\n®\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\2\fenabled\2\ftimeout\3ñ\1\1\0\3\28result_split_horizontal\1\20jump_to_request\1\26skip_ssl_verification\1\nsetup\14rest-nvim\frequire\0", "config", "rest.nvim")
time([[Config for rest.nvim]], false)
-- Config for: stabilize.nvim
time([[Config for stabilize.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0", "config", "stabilize.nvim")
time([[Config for stabilize.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nè\1\0\0\6\0\a\2\0266\0\0\0009\0\1\0'\2\2\0B\0\2\2\23\0\0\0\b\0\1\0X\1\17Ä6\1\0\0009\1\3\1'\3\2\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\2\0]\0\2\n\0\4\0\0186\2\0\0009\2\1\2\18\4\0\0B\2\2\2!\2\2\1'\3\2\0)\4\1\0\18\5\2\0)\6\1\0M\4\4Ä\18\b\3\0'\t\3\0&\3\t\bO\4¸\18\4\0\0\18\5\3\0&\4\5\4L\4\2\0\6 \5\blen\vstring;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimÔ\1\0\2\b\2\a\0\0225\2\0\0009\3\1\0009\3\2\0038\3\3\2\v\3\0\0X\4\2Ä=\3\3\1X\4\aÄ-\4\0\0009\6\4\1)\a\b\0B\4\3\2\18\5\3\0&\4\5\4=\4\3\1-\4\1\0009\4\5\0049\6\4\0015\a\6\0B\4\3\2=\4\4\1L\1\2\0\3¿\1¿\1\0\1\14with_text\1\rsymbolic\tkind\tmenu\tname\vsource\1\0\6\17fuzzy_buffer\v|fbuf|\rnvim_lsp\n|lsp|\15fuzzy_path\v|fpth|\vbuffer\n|buf|\tpath\n|pth|\rnvim_lua\n|api|Ã\2\0\1\t\2\v\00126\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\29Ä-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\n\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\2¿\n<Tab>\21select_next_item\fvisible\5!<Plug>(vsnip-expand-or-jump)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2˜\1\0\1\t\1\n\1 6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\vÄ-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisible\5\28<Plug>(vsnip-jump-prev)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2ø\r\1\0\14\0V\0ß\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0003\3\4\0009\4\5\0005\6\a\0005\a\6\0=\a\b\0065\a\t\0=\a\n\0065\a\f\0003\b\v\0=\b\r\a=\a\14\0065\a\24\0004\b\b\0009\t\15\0009\t\16\t9\t\17\t>\t\1\b9\t\15\0009\t\16\t9\t\18\t>\t\2\b9\t\15\0009\t\16\t9\t\19\t>\t\3\b9\t\15\0009\t\16\t9\t\20\t>\t\4\b9\t\15\0009\t\16\t9\t\21\t>\t\5\b9\t\15\0009\t\16\t9\t\22\t>\t\6\b9\t\15\0009\t\16\t9\t\23\t>\t\a\b=\b\25\a=\a\26\0064\a\4\0005\b\27\0>\b\1\a5\b\28\0>\b\2\a5\b\29\0>\b\3\a=\a\30\0065\a \0005\b\31\0=\b!\a3\b\"\0=\b#\a=\a$\0065\a'\0009\b%\0009\b&\b)\n¸ˇB\b\2\2=\b(\a9\b%\0009\b&\b)\n\4\0B\b\2\2=\b)\a9\b%\0009\n%\0009\n*\n5\f-\0009\r+\0009\r,\r=\r.\fB\n\2\0025\v/\0B\b\3\2=\b0\a9\b%\0009\n%\0009\n1\n5\f2\0009\r+\0009\r,\r=\r.\fB\n\2\0025\v3\0B\b\3\2=\b4\a9\b%\0009\n%\0009\n*\n5\f5\0009\r+\0009\r,\r=\r.\fB\n\2\0025\v6\0B\b\3\2=\b7\a9\b%\0009\n%\0009\n1\n5\f8\0009\r+\0009\r,\r=\r.\fB\n\2\0025\v9\0B\b\3\2=\b:\a9\b%\0009\n%\0009\n;\n5\f>\0009\r<\0009\r=\r=\r.\fB\n\2\0025\v?\0B\b\3\2=\b@\a3\bA\0=\bB\a3\bC\0=\bD\a=\a%\6B\4\2\0019\4\5\0009\4E\4'\6F\0005\aH\0005\bG\0=\b\b\a4\b\3\0005\tI\0>\t\1\b=\b\30\aB\4\3\0016\4J\0'\6K\0'\aL\0'\bM\0'\tN\0'\nO\0'\vP\0&\b\v\bB\4\4\0016\4J\0'\6K\0'\aQ\0'\bR\0'\tS\0'\nT\0'\vU\0&\b\v\bB\4\4\0012\0\0ÄK\0\1\0\t } }?{ name = \"look\", keyword_length = 5, max_item_count = 10 }-{ name = \"emoji\", max_item_count = 20 },1lua require\"cmp\".setup.buffer { sources = { \23gitcommit,markdown\b}})K{ name = \"nvim_lsp\", trigger_characters = {\".\"}, max_item_count = 20 }\27{ name = \"nvim_lua\" },0lua require\"cmp\".setup.buffer({ sources = {\blua\rfiletype\aau\1\0\1\tname\17fuzzy_buffer\1\0\0\1\0\1\16completeopt#menu,menuone,noinsert,noselect\6/\fcmdline\f<S-Tab>\0\n<Tab>\0\t<CR>\1\3\0\0\6i\6s\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\t<Up>\1\3\0\0\6i\6s\1\0\0\v<Down>\1\3\0\0\6i\6s\1\0\0\n<C-p>\1\3\0\0\6i\6s\1\0\0\21select_prev_item\n<C-n>\1\3\0\0\6i\6s\rbehavior\1\0\0\vInsert\19SelectBehavior\21select_next_item\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\15formatting\vformat\0\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsources\1\0\2\rpriority\3\1\tname\tpath\1\0\3\19max_item_count\3\n\tname\vbuffer\19keyword_length\3\2\1\0\3\19max_item_count\3\n\tname\rnvim_lsp\19keyword_length\3\3\fsorting\16comparators\1\0\0\norder\14sort_text\tkind\nscore\nexact\voffset\vlength\fcompare\vconfig\fsnippet\vexpand\1\0\0\0\17experimental\1\0\2\16native_menu\1\15ghost_text\1\15completion\1\0\0\1\0\1\16completeopt\26menu,menuone,noinsert\nsetup\0\0\flspkind\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
-- Config for: vim-terraform
time([[Config for vim-terraform]], true)
try_loadstring("\27LJ\2\nS\0\0\2\0\3\0\a6\0\0\0)\1\1\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0K\0\1\0\26terraform_fmt_on_save\28terraform_fold_sections\6g\0", "config", "vim-terraform")
time([[Config for vim-terraform]], false)
-- Config for: bufresize.nvim
time([[Config for bufresize.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14bufresize\frequire\0", "config", "bufresize.nvim")
time([[Config for bufresize.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: vim-startify
time([[Config for vim-startify]], true)
try_loadstring("\27LJ\2\nå\2\0\0\a\0\v\0\0236\0\0\0004\1\3\0005\2\2\0004\3\3\0'\4\3\0006\5\4\0009\5\5\5B\5\1\2&\4\5\4>\4\1\3=\3\6\2>\2\1\1=\1\1\0006\0\0\0)\1\1\0=\1\a\0006\0\0\0)\1\1\0=\1\b\0006\0\0\0005\1\n\0=\1\t\0K\0\1\0\1\t\0\0\6a\6r\6e\6t\6o\6s\6i\6n\28startify_custom_indices\28startify_enable_special startify_change_to_vcs_root\vheader\vgetcwd\afn\31 Most recently updated in \1\0\1\ttype\bdir\19startify_lists\6g\0", "config", "vim-startify")
time([[Config for vim-startify]], false)
-- Config for: obvious-resize
time([[Config for obvious-resize]], true)
try_loadstring("\27LJ\2\nß\2\0\0\5\0\r\0\0276\0\0\0)\1\4\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0006\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\3\0'\2\4\0'\3\a\0'\4\b\0B\0\4\0016\0\3\0'\2\4\0'\3\t\0'\4\n\0B\0\4\0016\0\3\0'\2\4\0'\3\v\0'\4\f\0B\0\4\1K\0\1\0\28:ObviousResizeRight<cr>\14<c-right>\27:ObviousResizeLeft<cr>\r<c-left>\27:ObviousResizeDown<cr>\r<c-down>\25:ObviousResizeUp<cr>\v<c-up>\5\bmap\28obvious_resize_run_tmux\27obvious_resize_default\6g\0", "config", "obvious-resize")
time([[Config for obvious-resize]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CodeActionMenu lua require("packer.load")({'nvim-code-action-menu'}, { cmd = "CodeActionMenu", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Replace lua require("packer.load")({'nvim-spectre'}, { cmd = "Replace", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
