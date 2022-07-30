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
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vtoggle\nFTerm\frequireÍ\1\1\0\5\0\f\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0'\3\b\0003\4\t\0B\0\4\0016\0\6\0'\2\n\0'\3\b\0'\4\v\0B\0\4\1K\0\1\0005<c-\\><c-n><CMD>lua require('FTerm').toggle()<CR>\6t\0\n<F11>\6n\bmap\15dimensions\1\0\2\vheight\4ÆèÖ◊\aî‹æˇ\3\nwidth\4ÆèÖ◊\aî‹æˇ\3\1\0\1\vborder\frounded\nsetup\nFTerm\frequire\0" },
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
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tleft\14Navigator\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tdown\14Navigator\frequire4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\aup\14Navigator\frequire7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nright\14Navigator\frequire“\1\1\0\5\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0'\2\5\0'\3\6\0003\4\a\0B\0\4\0016\0\4\0'\2\5\0'\3\b\0003\4\t\0B\0\4\0016\0\4\0'\2\5\0'\3\n\0003\4\v\0B\0\4\0016\0\4\0'\2\5\0'\3\f\0003\4\r\0B\0\4\1K\0\1\0\0\n<c-l>\0\n<c-k>\0\n<c-j>\0\n<c-h>\5\bmap\1\0\2\20disable_on_zoom\1\14auto_save\fcurrent\nsetup\14Navigator\frequire\0" },
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
  ["alpha-nvim"] = {
    config = { "\27LJ\2\nÀ\16\0\0\t\0\28\00176\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\2\4\0025\3\6\0=\3\5\0029\2\3\0019\2\a\0024\3\6\0009\4\b\1'\6\t\0'\a\n\0'\b\v\0B\4\4\2>\4\1\0039\4\b\1'\6\f\0'\a\r\0'\b\14\0B\4\4\2>\4\2\0039\4\b\1'\6\15\0'\a\16\0'\b\17\0B\4\4\2>\4\3\0039\4\b\1'\6\18\0'\a\19\0'\b\20\0B\4\4\2>\4\4\0039\4\b\1'\6\21\0'\a\22\0'\b\23\0B\4\4\0?\4\0\0=\3\5\0029\2\3\0019\2\24\0026\3\0\0'\5\25\0B\3\2\2B\3\1\2=\3\5\0029\2\26\0009\4\27\1B\2\2\1K\0\1\0\topts\nsetup\18alpha.fortune\vfooter\f:qa<CR>\21Ôôô  > Quit NVIM\6q\23:PackerInstall<CR>\27P  > Plugins - Install\6i\21:PackerClean<CR>\27P  > Plugins - Cleanup\6c\20:PackerSync<CR>\24P  > Plugins - Sync\6s :ene <BAR> startinsert <CR>\20ÔÖõ  > New file\6e\vbutton\fbuttons\1\21\0\0:                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     à\1  ‚ñà‚ñà‚ñà‚ïó   ‚ñà‚ñà‚ïó‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ïó ‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ïó ‚ñà‚ñà‚ïó   ‚ñà‚ñà‚ïó‚ñà‚ñà‚ïó‚ñà‚ñà‚ñà‚ïó   ‚ñà‚ñà‚ñà‚ïó í\1  ‚ñà‚ñà‚ñà‚ñà‚ïó  ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïî‚ïê‚ïê‚ïê‚ïê‚ïù‚ñà‚ñà‚ïî‚ïê‚ïê‚ïê‚ñà‚ñà‚ïó‚ñà‚ñà‚ïë   ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë‚ñà‚ñà‚ñà‚ñà‚ïó ‚ñà‚ñà‚ñà‚ñà‚ïë å\1  ‚ñà‚ñà‚ïî‚ñà‚ñà‚ïó ‚ñà‚ñà‚ïë‚ñà‚ñà‚ñà‚ñà‚ñà‚ïó  ‚ñà‚ñà‚ïë   ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë   ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë‚ñà‚ñà‚ïî‚ñà‚ñà‚ñà‚ñà‚ïî‚ñà‚ñà‚ïë í\1  ‚ñà‚ñà‚ïë‚ïö‚ñà‚ñà‚ïó‚ñà‚ñà‚ïë‚ñà‚ñà‚ïî‚ïê‚ïê‚ïù  ‚ñà‚ñà‚ïë   ‚ñà‚ñà‚ïë‚ïö‚ñà‚ñà‚ïó ‚ñà‚ñà‚ïî‚ïù‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë‚ïö‚ñà‚ñà‚ïî‚ïù‚ñà‚ñà‚ïë î\1  ‚ñà‚ñà‚ïë ‚ïö‚ñà‚ñà‚ñà‚ñà‚ïë‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ïó‚ïö‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ïî‚ïù ‚ïö‚ñà‚ñà‚ñà‚ñà‚ïî‚ïù ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë ‚ïö‚ïê‚ïù ‚ñà‚ñà‚ïë Ñ\1  ‚ïö‚ïê‚ïù  ‚ïö‚ïê‚ïê‚ïê‚ïù‚ïö‚ïê‚ïê‚ïê‚ïê‚ïê‚ïê‚ïù ‚ïö‚ïê‚ïê‚ïê‚ïê‚ïê‚ïù   ‚ïö‚ïê‚ïê‚ïê‚ïù  ‚ïö‚ïê‚ïù‚ïö‚ïê‚ïù     ‚ïö‚ïê‚ïù :                                                     \bval\vheader\fsection\27alpha.themes.dashboard\nalpha\frequire\vÄÄ¿ô\4\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
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
  ["cokeline.nvim"] = {
    config = { "\27LJ\2\nJ\0\1\4\0\3\0\t6\1\0\0009\3\1\0B\1\2\2\15\0\1\0X\2\3Ä6\1\0\0009\3\2\0B\1\2\2L\1\2\0\rfilename\tpath\21isNonEmptyString?\0\1\5\1\3\0\b9\1\0\0\14\0\1\0X\1\4Ä-\1\0\0'\3\1\0'\4\2\0D\1\3\0K\0\1\0\1¿\afg\fComment\15is_focused \0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ticon\fdevicon!\0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ncolor\fdevicon.\0\1\3\0\2\0\0049\1\0\0009\2\1\0&\1\2\1L\1\2\0\rfilename\18unique_prefixz\0\1\5\2\6\0\0169\1\0\0\15\0\1\0X\2\3Ä-\1\0\0009\1\1\1L\1\2\0009\1\2\0\15\0\1\0X\2\3Ä-\1\0\0009\1\3\1L\1\2\0-\1\1\0'\3\4\0'\4\5\0D\1\3\0\0¿\1¿\afg\fComment\vyellow\16is_modified\nmauve\15is_focused5\0\1\2\0\2\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0+\1\0\0L\1\2\0\vitalic\15is_focused6\0\1\2\0\3\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0'\1\2\0L\1\2\0\5\n üîí\16is_readonly \4\1\0\t\0'\0@6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0029\1\4\0=\1\3\0006\1\0\0'\3\5\0B\1\2\0029\1\6\0015\2\a\0006\3\0\0'\5\b\0B\3\2\0029\3\t\0035\5\v\0005\6\n\0=\6\f\0055\6\14\0003\a\r\0=\a\15\6=\6\16\0055\6\17\0009\a\3\0=\a\3\0063\a\18\0=\a\19\6=\6\20\0054\6\6\0>\2\1\0065\a\22\0003\b\21\0=\b\23\a3\b\24\0=\b\19\a>\a\2\0065\a\26\0003\b\25\0=\b\23\a3\b\27\0=\b\19\a3\b\28\0=\b\29\a>\a\3\0065\a\31\0003\b\30\0=\b\23\a>\a\4\6>\2\5\6=\6 \5B\3\2\0016\3!\0'\5\"\0B\3\2\0016\3!\0'\5#\0B\3\2\0016\3$\0'\5%\0005\6&\0B\3\3\0012\0\0ÄK\0\1\0\1\0\1\nguibg\tnone\16tablinefill\ahi.nmap <S-Down> <Plug>(cokeline-focus-prev),nmap <S-Up> <Plug>(cokeline-focus-next)\bcmd\15components\1\0\0\0\nstyle\0\0\1\0\0\0\0\ttext\1\0\0\0\15default_hl\afg\0\1\0\0\fbuffers\17filter_valid\1\0\0\0\rmappings\1\0\0\1\0\1\20cycle_prev_next\2\nsetup\rcokeline\1\0\1\ttext\6 \fget_hex\19cokeline/utils\tbase\abg\16get_palette\24catppuccin.palettes\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cokeline.nvim",
    url = "https://github.com/noib3/cokeline.nvim"
  },
  ["commented.nvim"] = {
    config = { "\27LJ\2\n©\1\0\0\a\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\a\0005\3\5\0006\4\0\0'\6\3\0B\4\2\0029\4\4\4=\4\6\3=\3\b\2B\0\2\1K\0\1\0\nhooks\1\0\0\19before_comment\1\0\0\25update_commentstring&ts_context_commentstring.internal\nsetup\14commented\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/commented.nvim",
    url = "https://github.com/winston0410/commented.nvim"
  },
  ["dial.nvim"] = {
    config = { "\27LJ\2\n©\6\0\0\n\0(\1g6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1\18\3\1\0009\1\4\0015\4\18\0004\5\6\0009\6\5\0009\6\6\0069\6\a\6>\6\1\0059\6\b\0009\6\6\0069\6\t\6>\6\2\0059\6\b\0009\6\n\0065\b\f\0005\t\v\0=\t\r\bB\6\2\2>\6\3\0059\6\b\0009\6\n\0065\b\15\0005\t\14\0=\t\r\bB\6\2\2>\6\4\0059\6\b\0009\6\n\0065\b\17\0005\t\16\0=\t\r\bB\6\2\0?\6\0\0=\5\19\4B\1\3\0016\1\20\0'\3\21\0'\4\22\0006\5\0\0'\a\23\0B\5\2\0029\5\24\5B\5\1\0025\6\25\0B\1\5\0016\1\20\0'\3\21\0'\4\26\0006\5\0\0'\a\23\0B\5\2\0029\5\27\5B\5\1\0025\6\28\0B\1\5\0016\1\20\0'\3\29\0'\4\22\0006\5\0\0'\a\23\0B\5\2\0029\5\30\5B\5\1\0025\6\31\0B\1\5\0016\1\20\0'\3\29\0'\4\26\0006\5\0\0'\a\23\0B\5\2\0029\5 \5B\5\1\0025\6!\0B\1\5\0016\1\20\0'\3\29\0'\4\"\0006\5\0\0'\a\23\0B\5\2\0029\5#\5B\5\1\0025\6$\0B\1\5\0016\1\20\0'\3\29\0'\4%\0006\5\0\0'\a\23\0B\5\2\0029\5&\5B\5\1\0025\6'\0B\1\5\1K\0\1\0\1\0\1\fnoremap\2\16dec_gvisual\vg<C-x>\1\0\1\fnoremap\2\16inc_gvisual\vg<C-a>\1\0\1\fnoremap\2\15dec_visual\1\0\1\fnoremap\2\15inc_visual\6v\1\0\1\fnoremap\2\15dec_normal\n<C-x>\1\0\1\fnoremap\2\15inc_normal\rdial.map\n<C-a>\6n\bmap\fdefault\1\0\0\1\0\2\vcyclic\2\tword\1\1\3\0\0\a&&\a||\1\0\2\vcyclic\2\tword\2\1\3\0\0\nconst\blet\relements\1\0\2\vcyclic\2\tword\2\1\3\0\0\band\aor\bnew\tbool\rconstant\fdecimal\nalias\finteger\19register_group\faugends\16dial.config\16dial.augend\frequire\vÄÄ¿ô\4\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/dial.nvim",
    url = "https://github.com/monaqa/dial.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["feline.nvim"] = {
    config = { "\27LJ\2\nZ\0\1\a\1\a\0\v6\1\0\0009\1\1\1'\3\2\0005\4\5\0005\5\4\0-\6\0\0009\6\3\6=\6\3\5=\5\6\4\18\5\0\0D\1\4\0\0¿\ahl\1\0\0\1\0\0\abg\tkeep\20tbl_deep_extend\bvims\0\0\4\0\6\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\2\15\0\0\0X\1\5Ä'\1\3\0'\2\4\0\18\3\0\0&\1\3\1L\1\2\0'\1\5\0L\1\2\0\5\6 \bÔëø\20git_info_exists\25feline.providers.git\frequire|\0\1\5\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\0\0005\4\3\0D\1\3\0\1\0\3\23file_modified_icon\5\ttype\vunique\17colored_icon\2\14file_info\26feline.providers.file\frequirex\0\0\3\0\a\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2D\0\2\0\nERROR\rseverity\15diagnostic\bvim\22diagnostics_exist\25feline.providers.lsp\frequirew\0\0\3\0\a\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2D\0\2\0\tWARN\rseverity\15diagnostic\bvim\22diagnostics_exist\25feline.providers.lsp\frequire˙\n\1\0\14\0<\2µ\0016\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0B\0\1\0029\1\6\0=\1\5\0003\1\a\0\18\2\1\0005\4\b\0B\2\2\0026\3\0\0'\5\t\0B\3\2\0029\3\2\0035\5!\0005\6\30\0004\a\3\0004\b\5\0>\2\1\b\18\t\1\0005\v\r\0005\f\n\0005\r\v\0=\r\f\f=\f\14\v5\f\16\0009\r\15\0=\r\17\f=\f\18\v4\f\0\0=\f\19\vB\t\2\2>\t\2\b\18\t\1\0005\v\20\0005\f\22\0009\r\21\0=\r\17\f=\f\18\vB\t\2\2>\t\3\b\18\t\1\0005\v\24\0003\f\23\0=\f\14\v5\f\26\0009\r\25\0=\r\17\f=\f\18\vB\t\2\0?\t\0\0>\b\1\a4\b\3\0\18\t\1\0005\v\27\0005\f\29\0009\r\28\0=\r\17\f9\r\5\0=\r\5\f=\f\18\vB\t\2\2>\t\1\b>\2\2\b>\b\2\a=\a\31\0064\a\0\0=\a \6=\6\"\5B\3\2\0014\3\n\0>\2\1\3\18\4\1\0005\6$\0003\a#\0=\a\14\0065\a%\0009\b\15\0=\b\17\a=\a\18\0064\a\0\0=\a\19\6B\4\2\2>\4\2\3>\2\3\3\18\4\1\0005\6&\0005\a'\0009\b\28\0=\b\17\a9\b\5\0=\b\5\a=\a\18\6B\4\2\2>\4\4\3\18\4\1\0005\6(\0006\a\0\0'\t)\0B\a\2\0029\a*\a=\a+\0065\a-\0009\b,\0=\b\17\a=\a\18\6B\4\2\2>\4\5\3\18\4\1\0005\6.\0006\a\0\0'\t)\0B\a\2\0029\a*\a=\a+\0065\a0\0009\b/\0=\b\17\a=\a\18\6B\4\2\2>\4\6\3\18\4\1\0005\0061\0006\a\0\0'\t)\0B\a\2\0029\a*\a=\a+\0065\a2\0009\b\25\0=\b\17\a=\a\18\6B\4\2\2>\4\a\3\18\4\1\0005\0063\0003\a4\0=\a+\0065\a5\0009\b\25\0=\b\17\a9\b\5\0=\b\5\a=\a\18\6B\4\2\2>\4\b\3\18\4\1\0005\0066\0003\a7\0=\a+\0065\a8\0009\b/\0=\b\17\a9\b\5\0=\b\5\a=\a\18\6B\4\2\0?\4\1\0006\4\0\0'\6\t\0B\4\2\0029\0049\0049\4\2\0045\6;\0005\a:\0004\b\3\0>\3\1\b=\b\31\a4\b\3\0>\3\1\b=\b \a=\a\"\6B\4\2\0012\0\0ÄK\0\1\0\1\0\0\1\0\0\vwinbar\1\0\1\bgui\vitalic\0\1\0\1\rprovider\24diagnostic_warnings\1\0\1\bgui\vitalic\0\1\0\1\rprovider\22diagnostic_errors\1\0\0\1\0\1\rprovider\21git_diff_removed\1\0\0\vyellow\1\0\1\rprovider\21git_diff_changed\1\0\0\ngreen\fenabled\20git_info_exists\25feline.providers.git\1\0\1\rprovider\19git_diff_added\1\0\1\bgui\vitalic\1\0\1\rprovider\rposition\1\0\1\nstyle\vitalic\1\0\0\0\15components\1\0\0\rinactive\vactive\1\0\0\1\0\1\bgui\vitalic\tblue\1\0\1\rprovider\21lsp_client_names\1\0\1\nstyle\vitalic\bred\1\0\0\0\1\0\0\ttext\1\0\1\rprovider\t on \19short_provider\ahl\afg\1\0\1\nstyle\vitalic\tteal\rprovider\1\0\0\topts\1\0\3\23file_modified_icon\b[+]\ttype\rrelative\17colored_icon\2\1\0\1\tname\14file_info\vfeline\1\0\1\rprovider\6 \0\tbase\abg\16get_palette\24catppuccin.palettes\nsetup\rgitsigns\frequire\tÄÄ¿ô\4\19ÄÄ¿ô\4\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/feline.nvim",
    url = "https://github.com/feline-nvim/feline.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n|\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vwindow\1\0\1\nblend\3\0\ttext\1\0\0\1\0\1\fspinner\19dots_scrolling\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["fuzzy.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/fuzzy.nvim",
    url = "https://github.com/tzachar/fuzzy.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hlargs.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vhlargs\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim"
  },
  ["hydra.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tleft\14Navigator\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tdown\14Navigator\frequire4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\aup\14Navigator\frequire7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nright\14Navigator\frequire6\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\23:ObviousResizeLeft\bcmd\bvim6\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\23:ObviousResizeDown\bcmd\bvim4\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\21:ObviousResizeUp\bcmd\bvim7\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\24:ObviousResizeRight\bcmd\bvim›\4\1\0\a\0\25\0/6\0\0\0'\2\1\0B\0\2\2\18\1\0\0005\3\2\0005\4\3\0005\5\4\0=\5\5\4=\4\6\0034\4\n\0005\5\a\0003\6\b\0>\6\2\5>\5\1\0045\5\t\0003\6\n\0>\6\2\5>\5\2\0045\5\v\0003\6\f\0>\6\2\5>\5\3\0045\5\r\0003\6\14\0>\6\2\5>\5\4\0045\5\15\0003\6\16\0>\6\2\5>\5\5\0045\5\17\0003\6\18\0>\6\2\5>\5\6\0045\5\19\0003\6\20\0>\6\2\5>\5\a\0045\5\21\0003\6\22\0>\6\2\5>\5\b\0045\5\23\0>\5\t\4=\4\24\3B\1\2\1K\0\1\0\nheads\1\2\1\0\n<esc>\texit\2\0\1\2\0\0\6L\0\1\2\0\0\6K\0\1\2\0\0\6J\0\1\2\0\0\6H\0\1\2\0\0\6l\0\1\2\0\0\6k\0\1\2\0\0\6j\0\1\2\0\0\6h\vconfig\thint\1\0\2\rposition\vbottom\vborder\frounded\1\0\2\ftimeout\3†\31\19invoke_on_body\2\1\0\4\thintƒ\1 ^^^^^^  Split/Pane  ^^^^^^\n ^^^^^^--------------^^^^^^\n ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^\n _h_ ^ ^ _l_   _H_ ^ ^ _L_\n ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^\n focus^^^^^^   resize^^^^^\n ^ ^ ^ ^ ^ ^   ^ ^ ^ ^ ^ ^\n\tname\18Resizing mode\tmode\6n\tbody\14<leader>w\nhydra\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/hydra.nvim",
    url = "https://github.com/anuvyklack/hydra.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["inc-rename.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\rcmd_name\vRename\nsetup\15inc_rename\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/inc-rename.nvim",
    url = "https://github.com/smjonas/inc-rename.nvim"
  },
  ["keymap-layer.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/keymap-layer.nvim",
    url = "https://github.com/anuvyklack/keymap-layer.nvim"
  },
  ["lazygit.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28cnoreabbrev git LazyGit\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["lightspeed.nvim"] = {
    config = { "\27LJ\2\n~\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\25jump_to_unique_chars\1\0\1\19safety_timeout\3ê\3\1\0\1\16ignore_case\2\nsetup\15lightspeed\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["mason-lspconfig.nvim"] = {
    config = { "\27LJ\2\nß\1\0\0\5\0\b\0\0176\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0016\1\0\0'\3\4\0B\1\2\0029\1\3\0015\3\5\0009\4\6\0=\4\a\3B\1\2\1K\0\1\0\21ensure_installed\fservers\1\0\1\27automatic_installation\1\20mason-lspconfig\nsetup\nmason\blsp\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\n∞\1\0\1\b\0\14\2\0246\1\0\0009\1\1\0019\1\2\0019\3\3\0'\4\4\0B\1\3\0026\2\5\0009\2\6\2\18\4\1\0B\2\2\2\22\2\0\0025\3\t\0006\4\a\0009\4\b\4\18\6\2\0)\a2\0B\4\3\2=\4\n\0036\4\0\0009\4\v\0049\4\f\4\23\4\1\4=\4\r\3L\3\2\0\vheight\nlines\6o\nwidth\1\0\0\bmax\tmath\blen\vstring\a:~\tpath\16fnamemodify\afn\bvim\b\fï\f\1\0\a\0+\00096\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\18\0005\5\17\0=\5\19\4=\4\20\3=\3\21\0025\3\23\0005\4\22\0=\4\24\3=\3\25\0024\3\0\0=\3\26\0025\3\31\0005\4\27\0005\5\28\0=\5\29\0044\5\0\0=\5\30\4=\4 \0035\4&\0005\5\"\0005\6!\0=\6#\0053\6$\0=\6%\5=\5'\0045\5(\0=\5\24\4=\4\25\3=\3)\0024\3\0\0=\3*\0024\3\0\0=\3\20\2B\0\2\1K\0\1\0\fbuffers\15filesystem\1\0\5\6.\rset_root\n<c-x>\17clear_filter\6/\tnoop\6f\21filter_on_submit\6H\18toggle_hidden\npopup\1\0\0\tsize\0\rposition\1\0\0\1\0\2\bcol\t100%\brow\0062\19filtered_items\1\0\3\24follow_current_file\1\26hijack_netrw_behavior\rdisabled\27use_libuv_file_watcher\2\15never_show\17hide_by_name\1\3\0\0\14.DS_Store\14thumbs.db\1\0\3\18hide_dotfiles\1\20hide_gitignored\2\fvisible\1\18nesting_rules\vwindow\rmappings\1\0\0\1\0\18\6a\badd\6R\frefresh\6A\18add_directory\6d\vdelete\6t\16open_tabnew\6x\21cut_to_clipboard\6C\tnoop\6q\17close_window\6c\tcopy\6r\vrename\6y\22copy_to_clipboard\6m\tmove\6s\15open_split\6p\25paste_from_clipboard\6v\16open_vsplit\t<bs>\15close_node\t<cr>\topen\6z\tnoop\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\fdeleted\b‚úñ\rmodified\5\14untracked\bÔÑ®\fignored\bÔë¥\frenamed\bÔïî\runstaged\bÔò∞\nadded\5\vstaged\bÔÅÜ\rconflict\bÓúß\tname\1\0\2\19trailing_slash\1\26use_git_status_colors\2\rmodified\1\0\2\14highlight\20NeoTreeModified\vsymbol\b[+]\ticon\1\0\4\16folder_open\bÓóæ\18folder_closed\bÓóø\17folder_empty\bÔ∞ä\fdefault\6*\vindent\1\0\0\1\0\t\23expander_collapsed\bÔë†\17with_markers\2\14highlight\24NeoTreeIndentMarker\22expander_expanded\bÔëº\18indent_marker\b‚îÇ\23expander_highlight\20NeoTreeExpander\23last_indent_marker\b‚îî\16indent_size\3\2\fpadding\3\1\1\0\4\25close_if_last_window\1\23popup_border_style\frounded\22enable_git_status\2\23enable_diagnostics\1\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 7 nmap <c-f> <cmd>Neotree position=float reveal<cr>\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  nvim = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27colorscheme catppuccin\bcmd\bvimS\1\0\4\0\5\0\n6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0003\2\4\0)\3\0\0B\0\3\1K\0\1\0\0\rdefer_fn\22CatppuccinCompile\bcmd\bvim∏\4\1\0\a\0!\0.6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0003\4\5\0=\4\6\3B\0\3\0016\0\a\0'\2\b\0B\0\2\0029\0\t\0B\0\1\0029\1\v\0=\1\n\0006\1\0\0009\1\f\1'\2\14\0=\2\r\0016\1\a\0'\3\15\0B\1\2\0029\1\16\0015\3\17\0005\4\18\0=\4\19\0035\4\20\0005\5\21\0004\6\0\0=\6\22\0054\6\0\0=\6\23\0054\6\0\0=\6\24\5=\5\25\4=\4\26\0035\4\30\0005\5\27\0009\6\n\0=\6\n\0059\6\28\0=\6\29\5=\5\31\4=\4 \3B\1\2\1K\0\1\0\22custom_highlights\31DiagnosticVirtualTextError\1\0\0\afg\nerror\1\0\0\17integrations\15native_lsp\15underlines\18virtual_lines\17virtual_text\1\0\1\fenabled\2\1\0\2\16lsp_trouble\2\15lightspeed\2\fcompile\1\0\1\fenabled\2\1\0\1\27transparent_background\2\nsetup\15catppuccin\14macchiato\23catppuccin_flavour\6g\tbase\abg\16get_palette\24catppuccin.palettes\frequire\rcallback\0\1\0\1\fpattern\22PackerCompileDone\tUser\24nvim_create_autocmd\bapi\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim",
    url = "https://github.com/catppuccin/nvim"
  },
  ["nvim-cheat.sh"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-cheat.sh",
    url = "https://github.com/RishabhRD/nvim-cheat.sh"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nè\1\0\0\6\0\a\2\0266\0\0\0009\0\1\0'\2\2\0B\0\2\2\23\0\0\0\b\0\1\0X\1\17Ä6\1\0\0009\1\3\1'\3\2\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\2\0]\0\2\n\0\4\0\0186\2\0\0009\2\1\2\18\4\0\0B\2\2\2!\2\2\1'\3\2\0)\4\1\0\18\5\2\0)\6\1\0M\4\4Ä\18\b\3\0'\t\3\0&\3\t\bO\4¸\127\18\4\0\0\18\5\3\0&\4\5\4L\4\2\0\6 \5\blen\vstring;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimÔ\1\0\2\b\2\a\0\0225\2\0\0009\3\1\0009\3\2\0038\3\3\2\v\3\0\0X\4\2Ä=\3\3\1X\4\aÄ-\4\0\0009\6\4\1)\a\b\0B\4\3\2\18\5\3\0&\4\5\4=\4\3\1-\4\1\0009\4\5\0049\6\4\0015\a\6\0B\4\3\2=\4\4\1L\1\2\0\4¿\2¿\1\0\1\14with_text\1\rsymbolic\tkind\tmenu\tname\vsource\1\0\6\vbuffer\n|buf|\15fuzzy_path\v|fpth|\17fuzzy_buffer\v|fbuf|\rnvim_lua\n|api|\rnvim_lsp\n|lsp|\tpath\n|pth|Õ\1\0\1\t\2\t\0\30-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\2\0009\1\3\0019\1\4\0016\3\2\0009\3\5\0039\3\6\3'\5\a\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\b\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\5\t<Up>\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\21select_prev_item\fvisibleœ\1\0\1\t\2\t\0\30-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\2\0009\1\3\0019\1\4\0016\3\2\0009\3\5\0039\3\6\3'\5\a\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\b\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\5\v<Down>\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\21select_next_item\fvisiblee\0\1\4\1\5\0\f-\1\0\0009\1\0\0015\3\1\0B\1\2\2\14\0\1\0X\1\5Ä6\1\2\0'\3\3\0B\1\2\0029\1\4\1B\1\1\1K\0\1\0\0¿\ttype\16pairs.enter\frequire\1\0\1\vselect\1\fconfirmÃ\2\0\1\t\2\v\00126\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\29Ä-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\n\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\n<Tab>\21select_next_item\fvisible\5!<Plug>(vsnip-expand-or-jump)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2˜\1\0\1\t\1\n\1 6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\vÄ-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisible\5\28<Plug>(vsnip-jump-prev)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2Ó\1\0\1\6\1\v\0\0319\1\0\0\18\3\1\0009\1\1\1B\1\2\0029\2\2\1\15\0\2\0X\3\4Ä9\2\2\0019\2\3\2\14\0\2\0X\3\1Ä+\2\1\0\14\0\2\0X\3\16Ä9\3\4\1-\4\0\0009\4\5\4\4\3\4\0X\3\5Ä9\3\4\1-\4\0\0009\4\6\4\5\3\4\0X\3\6Ä6\3\a\0'\5\b\0B\3\2\0029\3\t\3'\5\n\0B\3\2\1K\0\1\0\1¿\6(\14type_left\18pairs.bracket\frequire\rFunction\vMethod\tkind\23funcParensDisabled\tdata\24get_completion_item\nentryê\21\1\0\15\0c\0Ø\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0016\2\0\0'\4\4\0B\2\2\0023\3\5\0003\4\6\0009\5\a\0005\a\t\0005\b\b\0=\b\n\a5\b\14\0005\t\f\0005\n\v\0=\n\r\t=\t\n\b5\t\16\0005\n\15\0=\n\r\t=\t\17\b=\b\18\a5\b\19\0=\b\20\a5\b\22\0003\t\21\0=\t\23\b=\b\24\a5\b\"\0004\t\b\0009\n\25\0009\n\26\n9\n\27\n>\n\1\t9\n\25\0009\n\26\n9\n\28\n>\n\2\t9\n\25\0009\n\26\n9\n\29\n>\n\3\t9\n\25\0009\n\26\n9\n\30\n>\n\4\t9\n\25\0009\n\26\n9\n\31\n>\n\5\t9\n\25\0009\n\26\n9\n \n>\n\6\t9\n\25\0009\n\26\n9\n!\n>\n\a\t=\t#\b=\b$\a4\b\4\0005\t%\0>\t\1\b5\t&\0>\t\2\b5\t'\0>\t\3\b=\b(\a5\b*\0005\t)\0=\t+\b3\t,\0=\t-\b=\b.\a5\b1\0009\t/\0009\t0\t)\v¸ˇB\t\2\2=\t2\b9\t/\0009\t0\t)\v\4\0B\t\2\2=\t3\b9\t/\0009\v/\0009\v4\v5\r7\0009\0145\0009\0146\14=\0148\rB\v\2\0025\f9\0B\t\3\2=\t:\b9\t/\0009\v/\0009\v;\v5\r<\0009\0145\0009\0146\14=\0148\rB\v\2\0025\f=\0B\t\3\2=\t>\b3\t?\0=\t@\b3\tA\0=\tB\b9\t/\0003\vC\0B\t\2\2=\tD\b3\tE\0=\tF\b3\tG\0=\tH\b=\b/\aB\5\2\0019\5I\0\18\a\5\0009\5J\5'\bK\0003\tL\0B\5\4\0019\5\a\0009\5M\5'\aN\0005\bP\0005\tO\0=\t\n\b4\t\3\0005\nQ\0>\n\1\t=\t(\bB\5\3\0019\5\a\0009\5R\5'\aS\0005\bU\0009\t\25\0009\t(\t4\v\3\0005\fT\0>\f\1\vB\t\2\2=\t(\bB\5\3\0016\5V\0'\aR\0'\bW\0'\tX\0'\nY\0'\vZ\0'\f[\0&\t\f\tB\5\4\0016\5V\0'\aR\0'\b\\\0'\t]\0'\n^\0'\v_\0&\t\v\tB\5\4\0016\5`\0009\5a\5'\ab\0B\5\2\0012\0\0ÄK\0\1\0Ñ\6      \" gray\n      highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080\n      \" blue\n      highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6\n      highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6\n      \" light blue\n      highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE\n      highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE\n      highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE\n      \" pink\n      highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0\n      highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0\n      \" front\n      highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4\n      highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4\n      highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4\n    \bcmd\bvim\t } }?{ name = \"look\", keyword_length = 5, max_item_count = 10 }1lua require\"cmp\".setup.buffer { sources = { \23gitcommit,markdown\b}})K{ name = \"nvim_lsp\", trigger_characters = {\".\"}, max_item_count = 20 }\27{ name = \"nvim_lua\" },0lua require\"cmp\".setup.buffer({ sources = {\blua\aau\1\0\0\1\0\1\tname\nemoji\tocto\rfiletype\1\0\1\tname\17fuzzy_buffer\1\0\0\1\0\1\16completeopt#menu,menuone,noinsert,noselect\6/\fcmdline\0\17confirm_done\aon\nevent\f<S-Tab>\0\n<Tab>\0\t<CR>\0\v<Down>\0\t<Up>\0\n<C-p>\1\3\0\0\6i\6s\1\0\0\21select_prev_item\n<C-n>\1\3\0\0\6i\6s\rbehavior\1\0\0\vInsert\19SelectBehavior\21select_next_item\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\15formatting\vformat\0\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsources\1\0\2\tname\tpath\rpriority\3\1\1\0\3\19keyword_length\3\2\tname\vbuffer\19max_item_count\3\n\1\0\3\19keyword_length\3\1\tname\rnvim_lsp\19max_item_count\3\20\fsorting\16comparators\1\0\0\norder\14sort_text\tkind\nscore\nexact\voffset\vlength\fcompare\vconfig\fsnippet\vexpand\1\0\0\0\17experimental\1\0\2\16native_menu\1\15ghost_text\1\vwindow\18documentation\1\0\0\1\t\0\0\b‚îÄ\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚îÄ\b‚Üí\1\0\0\vborder\1\0\2\14scrollbar\b‚ïë\17winhighlightONormal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\15completion\1\0\0\1\0\1\16completeopt\26menu,menuone,noinsert\nsetup\0\0\flspkind\23CompletionItemKind\blsp\bcmp\frequire\0" },
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
  ["nvim-lastplace"] = {
    config = { "\27LJ\2\n⁄\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\30lastplace_ignore_filetype\1\5\0\0\14gitcommit\14gitrebase\bsvn\rhgcommit\29lastplace_ignore_buftype\1\0\1\25lastplace_open_folds\2\1\4\0\0\rquickfix\vnofile\thelp\nsetup\19nvim-lastplace\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-lastplace",
    url = "https://github.com/ethanholz/nvim-lastplace"
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
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\topen\fspectre\frequire∫\2\1\0\4\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0003\3\b\0B\0\3\1K\0\1\0\0\fReplace\15addCommand\14highlight\1\0\3\freplace\15DiffChange\vsearch\15DiffDelete\aui\vString\1\0\4\rline_sep1‚îî-----------------------------------------\19color_devicons\2\19result_padding\t¬¶  \19line_sep_start1‚îå-----------------------------------------\nsetup\fspectre\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/nvim-spectre",
    url = "https://github.com/windwp/nvim-spectre"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nó\5\0\0\6\0\26\0\"6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0025\1\a\0005\2\4\0005\3\5\0=\3\6\2=\2\b\1=\1\3\0006\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\v\0005\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\0044\5\0\0=\5\22\0045\5\23\0=\5\24\4=\4\25\3B\1\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\19highlight_self\1\19goto_right_end\1\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\venable\2\26context_commentstring\1\0\2\19enable_autocmd\2\venable\2\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\2\0\0\fhaskell\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\17install_info\1\0\0\nfiles\1\2\0\0\17src/parser.c\1\0\2\burl5https://github.com/NTBBloodbath/tree-sitter-http\vbranch\tmain\thttp\23get_parser_configs\28nvim-treesitter.parsers\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    config = { "\27LJ\2\nÄ\4\0\0\6\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\18\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\0035\4\b\0005\5\t\0=\5\n\0045\5\v\0=\5\f\0045\5\r\0=\5\14\0045\5\15\0=\5\16\4=\4\17\3=\3\19\2B\0\2\1K\0\1\0\16textobjects\1\0\0\tmove\22goto_previous_end\1\0\2\a[]\17@class.outer\a[M\20@function.outer\24goto_previous_start\1\0\2\a[[\17@class.outer\a[m\20@function.outer\18goto_next_end\1\0\2\a][\17@class.outer\a]M\20@function.outer\20goto_next_start\1\0\2\a]]\17@class.outer\a]m\20@function.outer\1\0\2\venable\2\14set_jumps\2\vselect\1\0\0\fkeymaps\1\0\4\aic\17@class.inner\aac\17@class.outer\aif\20@function.inner\aaf\20@function.outer\1\0\2\14lookahead\2\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
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
  ["octo.nvim"] = {
    config = { "\27LJ\2\n]\0\0\4\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0'\2\4\0005\3\5\0B\0\3\1K\0\1\0\1\0\1\abg\tnone\17OctoEditable\ahi\nsetup\tocto\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/octo.nvim",
    url = "https://github.com/pwntester/octo.nvim"
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
  popfix = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/popfix",
    url = "https://github.com/RishabhRD/popfix"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["smart-pairs"] = {
    config = { "\27LJ\2\nã\1\0\0\5\0\b\0\f6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3B\0\3\1K\0\1\0\nenter\1\0\1\19enable_mapping\1\22autojump_strategy\1\0\0\1\0\1\15unbalanced\ball\nsetup\npairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/smart-pairs",
    url = "https://github.com/ZhiyuanLck/smart-pairs"
  },
  ["stabilize.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/stabilize.nvim",
    url = "https://github.com/luukvbaal/stabilize.nvim"
  },
  ["substitute.nvim"] = {
    config = { "\27LJ\2\n≥\3\0\0\6\0\19\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\r\0'\4\14\0005\5\15\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\16\0'\3\a\0'\4\17\0005\5\18\0B\0\5\1K\0\1\0\1\0\1\fnoremap\0020<cmd>lua require('substitute').visual()<cr>\6x\1\0\1\fnoremap\2-<cmd>lua require('substitute').eol()<cr>\6M\1\0\1\fnoremap\2.<cmd>lua require('substitute').line()<cr>\amm\1\0\1\fnoremap\0022<cmd>lua require('substitute').operator()<cr>\6m\6n\bset\vkeymap\bvim\nsetup\15substitute\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/substitute.nvim",
    url = "https://github.com/gbprod/substitute.nvim"
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
    config = { "\27LJ\2\n)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\1¿\14git_filesR\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\2\14no_ignore\2\vhidden\2\nmerge\15find_files)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\14live_grep(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreW\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\14live_grep+\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\16grep_string(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreY\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\16grep_stringK\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\18sort_lastused\2\nmerge\fbuffersG\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\rcwd_only\2\nmerge\roldfilesª\5\1\0\b\0$\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\b\0'\2\5\0B\0\2\0016\0\0\0'\2\t\0B\0\2\0025\1\n\0005\2\v\0=\2\f\0015\2\r\0005\3\14\0=\3\f\0026\3\15\0'\5\16\0'\6\17\0003\a\18\0B\3\4\0016\3\15\0'\5\16\0'\6\19\0003\a\20\0B\3\4\0016\3\15\0'\5\16\0'\6\21\0003\a\22\0B\3\4\0016\3\15\0'\5\16\0'\6\23\0003\a\24\0B\3\4\0016\3\15\0'\5\16\0'\6\25\0003\a\26\0B\3\4\0016\3\15\0'\5\16\0'\6\27\0003\a\28\0B\3\4\0016\3\15\0'\5\16\0'\6\29\0003\a\30\0B\3\4\0016\3\15\0'\5\16\0'\6\31\0003\a \0B\3\4\0016\3!\0'\5\"\0005\6#\0B\3\3\0012\0\0ÄK\0\1\0\1\0\1\nguibg\tnone\20TelescopeNormal\ahi\0\agh\0\agb\0\agO\0\ago\0\agC\0\agc\0\agF\0\agf\6n\bmap\1\0\2\vheight\4Õô≥Ê\fÃô≥ˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\1\0\1\20layout_strategy\rvertical\18layout_config\1\0\4\18preview_width\4ö≥ÊÃ\tô≥Ê˛\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\vheight\4Õô≥Ê\fÃô≥ˇ\3\vmirror\1\1\0\1\20layout_strategy\15horizontal\22telescope.builtin\19load_extension\15extensions\1\0\0\bfzf\1\0\0\1\0\4\nfuzzy\2\14case_mode\15smart_case\28override_generic_sorter\2\25override_file_sorter\2\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["textobj-diagnostic.nvim"] = {
    config = { "\27LJ\2\nN\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24next_diag_inclusive\23textobj-diagnostic\frequireN\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24next_diag_inclusive\23textobj-diagnostic\frequire‹\1\1\0\6\0\15\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0005\2\a\0'\3\b\0003\4\t\0005\5\n\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0005\2\v\0'\3\f\0003\4\r\0005\5\14\0B\0\5\1K\0\1\0\1\0\1\vsilent\2\0\aad\1\3\0\0\6x\6o\1\0\1\vsilent\2\0\aid\1\3\0\0\6x\6o\bset\vkeymap\bvim\1\0\1\27create_default_keymaps\1\nsetup\23textobj-diagnostic\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/textobj-diagnostic.nvim",
    url = "https://github.com/andrewferrier/textobj-diagnostic.nvim"
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
  ["vim-dotenv"] = {
    config = { "\27LJ\2\n]\0\0\5\0\5\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\4\0'\3\2\0'\4\3\0B\0\4\1K\0\1\0\17BufWritePost\16Dotenv .env\t.env\rVimEnter\aau\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-dotenv",
    url = "https://github.com/tpope/vim-dotenv"
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
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
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
    config = { "\27LJ\2\n‚\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0¬\1        call textobj#user#plugin('custom', {\n        \\   'block': {\n        \\     'pattern': '[\\{\\[\\(].*[\\)\\]\\}]',\n        \\     'select': ['ab', 'ib'],\n        \\   },\n        \\ })\n        \bcmd\bvim\0" },
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
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nè\1\0\0\6\0\a\2\0266\0\0\0009\0\1\0'\2\2\0B\0\2\2\23\0\0\0\b\0\1\0X\1\17Ä6\1\0\0009\1\3\1'\3\2\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\2\0]\0\2\n\0\4\0\0186\2\0\0009\2\1\2\18\4\0\0B\2\2\2!\2\2\1'\3\2\0)\4\1\0\18\5\2\0)\6\1\0M\4\4Ä\18\b\3\0'\t\3\0&\3\t\bO\4¸\127\18\4\0\0\18\5\3\0&\4\5\4L\4\2\0\6 \5\blen\vstring;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimÔ\1\0\2\b\2\a\0\0225\2\0\0009\3\1\0009\3\2\0038\3\3\2\v\3\0\0X\4\2Ä=\3\3\1X\4\aÄ-\4\0\0009\6\4\1)\a\b\0B\4\3\2\18\5\3\0&\4\5\4=\4\3\1-\4\1\0009\4\5\0049\6\4\0015\a\6\0B\4\3\2=\4\4\1L\1\2\0\4¿\2¿\1\0\1\14with_text\1\rsymbolic\tkind\tmenu\tname\vsource\1\0\6\vbuffer\n|buf|\15fuzzy_path\v|fpth|\17fuzzy_buffer\v|fbuf|\rnvim_lua\n|api|\rnvim_lsp\n|lsp|\tpath\n|pth|Õ\1\0\1\t\2\t\0\30-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\2\0009\1\3\0019\1\4\0016\3\2\0009\3\5\0039\3\6\3'\5\a\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\b\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\5\t<Up>\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\21select_prev_item\fvisibleœ\1\0\1\t\2\t\0\30-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\2\0009\1\3\0019\1\4\0016\3\2\0009\3\5\0039\3\6\3'\5\a\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\b\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\5\v<Down>\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\21select_next_item\fvisiblee\0\1\4\1\5\0\f-\1\0\0009\1\0\0015\3\1\0B\1\2\2\14\0\1\0X\1\5Ä6\1\2\0'\3\3\0B\1\2\0029\1\4\1B\1\1\1K\0\1\0\0¿\ttype\16pairs.enter\frequire\1\0\1\vselect\1\fconfirmÃ\2\0\1\t\2\v\00126\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\29Ä-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\n\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\n<Tab>\21select_next_item\fvisible\5!<Plug>(vsnip-expand-or-jump)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2˜\1\0\1\t\1\n\1 6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\vÄ-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisible\5\28<Plug>(vsnip-jump-prev)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2Ó\1\0\1\6\1\v\0\0319\1\0\0\18\3\1\0009\1\1\1B\1\2\0029\2\2\1\15\0\2\0X\3\4Ä9\2\2\0019\2\3\2\14\0\2\0X\3\1Ä+\2\1\0\14\0\2\0X\3\16Ä9\3\4\1-\4\0\0009\4\5\4\4\3\4\0X\3\5Ä9\3\4\1-\4\0\0009\4\6\4\5\3\4\0X\3\6Ä6\3\a\0'\5\b\0B\3\2\0029\3\t\3'\5\n\0B\3\2\1K\0\1\0\1¿\6(\14type_left\18pairs.bracket\frequire\rFunction\vMethod\tkind\23funcParensDisabled\tdata\24get_completion_item\nentryê\21\1\0\15\0c\0Ø\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0016\2\0\0'\4\4\0B\2\2\0023\3\5\0003\4\6\0009\5\a\0005\a\t\0005\b\b\0=\b\n\a5\b\14\0005\t\f\0005\n\v\0=\n\r\t=\t\n\b5\t\16\0005\n\15\0=\n\r\t=\t\17\b=\b\18\a5\b\19\0=\b\20\a5\b\22\0003\t\21\0=\t\23\b=\b\24\a5\b\"\0004\t\b\0009\n\25\0009\n\26\n9\n\27\n>\n\1\t9\n\25\0009\n\26\n9\n\28\n>\n\2\t9\n\25\0009\n\26\n9\n\29\n>\n\3\t9\n\25\0009\n\26\n9\n\30\n>\n\4\t9\n\25\0009\n\26\n9\n\31\n>\n\5\t9\n\25\0009\n\26\n9\n \n>\n\6\t9\n\25\0009\n\26\n9\n!\n>\n\a\t=\t#\b=\b$\a4\b\4\0005\t%\0>\t\1\b5\t&\0>\t\2\b5\t'\0>\t\3\b=\b(\a5\b*\0005\t)\0=\t+\b3\t,\0=\t-\b=\b.\a5\b1\0009\t/\0009\t0\t)\v¸ˇB\t\2\2=\t2\b9\t/\0009\t0\t)\v\4\0B\t\2\2=\t3\b9\t/\0009\v/\0009\v4\v5\r7\0009\0145\0009\0146\14=\0148\rB\v\2\0025\f9\0B\t\3\2=\t:\b9\t/\0009\v/\0009\v;\v5\r<\0009\0145\0009\0146\14=\0148\rB\v\2\0025\f=\0B\t\3\2=\t>\b3\t?\0=\t@\b3\tA\0=\tB\b9\t/\0003\vC\0B\t\2\2=\tD\b3\tE\0=\tF\b3\tG\0=\tH\b=\b/\aB\5\2\0019\5I\0\18\a\5\0009\5J\5'\bK\0003\tL\0B\5\4\0019\5\a\0009\5M\5'\aN\0005\bP\0005\tO\0=\t\n\b4\t\3\0005\nQ\0>\n\1\t=\t(\bB\5\3\0019\5\a\0009\5R\5'\aS\0005\bU\0009\t\25\0009\t(\t4\v\3\0005\fT\0>\f\1\vB\t\2\2=\t(\bB\5\3\0016\5V\0'\aR\0'\bW\0'\tX\0'\nY\0'\vZ\0'\f[\0&\t\f\tB\5\4\0016\5V\0'\aR\0'\b\\\0'\t]\0'\n^\0'\v_\0&\t\v\tB\5\4\0016\5`\0009\5a\5'\ab\0B\5\2\0012\0\0ÄK\0\1\0Ñ\6      \" gray\n      highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080\n      \" blue\n      highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6\n      highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6\n      \" light blue\n      highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE\n      highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE\n      highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE\n      \" pink\n      highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0\n      highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0\n      \" front\n      highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4\n      highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4\n      highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4\n    \bcmd\bvim\t } }?{ name = \"look\", keyword_length = 5, max_item_count = 10 }1lua require\"cmp\".setup.buffer { sources = { \23gitcommit,markdown\b}})K{ name = \"nvim_lsp\", trigger_characters = {\".\"}, max_item_count = 20 }\27{ name = \"nvim_lua\" },0lua require\"cmp\".setup.buffer({ sources = {\blua\aau\1\0\0\1\0\1\tname\nemoji\tocto\rfiletype\1\0\1\tname\17fuzzy_buffer\1\0\0\1\0\1\16completeopt#menu,menuone,noinsert,noselect\6/\fcmdline\0\17confirm_done\aon\nevent\f<S-Tab>\0\n<Tab>\0\t<CR>\0\v<Down>\0\t<Up>\0\n<C-p>\1\3\0\0\6i\6s\1\0\0\21select_prev_item\n<C-n>\1\3\0\0\6i\6s\rbehavior\1\0\0\vInsert\19SelectBehavior\21select_next_item\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\15formatting\vformat\0\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsources\1\0\2\tname\tpath\rpriority\3\1\1\0\3\19keyword_length\3\2\tname\vbuffer\19max_item_count\3\n\1\0\3\19keyword_length\3\1\tname\rnvim_lsp\19max_item_count\3\20\fsorting\16comparators\1\0\0\norder\14sort_text\tkind\nscore\nexact\voffset\vlength\fcompare\vconfig\fsnippet\vexpand\1\0\0\0\17experimental\1\0\2\16native_menu\1\15ghost_text\1\vwindow\18documentation\1\0\0\1\t\0\0\b‚îÄ\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚îÄ\b‚Üí\1\0\0\vborder\1\0\2\14scrollbar\b‚ïë\17winhighlightONormal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\15completion\1\0\0\1\0\1\16completeopt\26menu,menuone,noinsert\nsetup\0\0\flspkind\23CompletionItemKind\blsp\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: vim-wordmotion
time([[Config for vim-wordmotion]], true)
try_loadstring("\27LJ\2\n4\0\0\2\0\3\0\0046\0\0\0'\1\2\0=\1\1\0K\0\1\0\r<leader>\22wordmotion_prefix\6g\0", "config", "vim-wordmotion")
time([[Config for vim-wordmotion]], false)
-- Config for: Navigator.nvim
time([[Config for Navigator.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tleft\14Navigator\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tdown\14Navigator\frequire4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\aup\14Navigator\frequire7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nright\14Navigator\frequire“\1\1\0\5\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0'\2\5\0'\3\6\0003\4\a\0B\0\4\0016\0\4\0'\2\5\0'\3\b\0003\4\t\0B\0\4\0016\0\4\0'\2\5\0'\3\n\0003\4\v\0B\0\4\0016\0\4\0'\2\5\0'\3\f\0003\4\r\0B\0\4\1K\0\1\0\0\n<c-l>\0\n<c-k>\0\n<c-j>\0\n<c-h>\5\bmap\1\0\2\20disable_on_zoom\1\14auto_save\fcurrent\nsetup\14Navigator\frequire\0", "config", "Navigator.nvim")
time([[Config for Navigator.nvim]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\n∞\1\0\1\b\0\14\2\0246\1\0\0009\1\1\0019\1\2\0019\3\3\0'\4\4\0B\1\3\0026\2\5\0009\2\6\2\18\4\1\0B\2\2\2\22\2\0\0025\3\t\0006\4\a\0009\4\b\4\18\6\2\0)\a2\0B\4\3\2=\4\n\0036\4\0\0009\4\v\0049\4\f\4\23\4\1\4=\4\r\3L\3\2\0\vheight\nlines\6o\nwidth\1\0\0\bmax\tmath\blen\vstring\a:~\tpath\16fnamemodify\afn\bvim\b\fï\f\1\0\a\0+\00096\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\18\0005\5\17\0=\5\19\4=\4\20\3=\3\21\0025\3\23\0005\4\22\0=\4\24\3=\3\25\0024\3\0\0=\3\26\0025\3\31\0005\4\27\0005\5\28\0=\5\29\0044\5\0\0=\5\30\4=\4 \0035\4&\0005\5\"\0005\6!\0=\6#\0053\6$\0=\6%\5=\5'\0045\5(\0=\5\24\4=\4\25\3=\3)\0024\3\0\0=\3*\0024\3\0\0=\3\20\2B\0\2\1K\0\1\0\fbuffers\15filesystem\1\0\5\6.\rset_root\n<c-x>\17clear_filter\6/\tnoop\6f\21filter_on_submit\6H\18toggle_hidden\npopup\1\0\0\tsize\0\rposition\1\0\0\1\0\2\bcol\t100%\brow\0062\19filtered_items\1\0\3\24follow_current_file\1\26hijack_netrw_behavior\rdisabled\27use_libuv_file_watcher\2\15never_show\17hide_by_name\1\3\0\0\14.DS_Store\14thumbs.db\1\0\3\18hide_dotfiles\1\20hide_gitignored\2\fvisible\1\18nesting_rules\vwindow\rmappings\1\0\0\1\0\18\6a\badd\6R\frefresh\6A\18add_directory\6d\vdelete\6t\16open_tabnew\6x\21cut_to_clipboard\6C\tnoop\6q\17close_window\6c\tcopy\6r\vrename\6y\22copy_to_clipboard\6m\tmove\6s\15open_split\6p\25paste_from_clipboard\6v\16open_vsplit\t<bs>\15close_node\t<cr>\topen\6z\tnoop\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\fdeleted\b‚úñ\rmodified\5\14untracked\bÔÑ®\fignored\bÔë¥\frenamed\bÔïî\runstaged\bÔò∞\nadded\5\vstaged\bÔÅÜ\rconflict\bÓúß\tname\1\0\2\19trailing_slash\1\26use_git_status_colors\2\rmodified\1\0\2\14highlight\20NeoTreeModified\vsymbol\b[+]\ticon\1\0\4\16folder_open\bÓóæ\18folder_closed\bÓóø\17folder_empty\bÔ∞ä\fdefault\6*\vindent\1\0\0\1\0\t\23expander_collapsed\bÔë†\17with_markers\2\14highlight\24NeoTreeIndentMarker\22expander_expanded\bÔëº\18indent_marker\b‚îÇ\23expander_highlight\20NeoTreeExpander\23last_indent_marker\b‚îî\16indent_size\3\2\fpadding\3\1\1\0\4\25close_if_last_window\1\23popup_border_style\frounded\22enable_git_status\2\23enable_diagnostics\1\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 7 nmap <c-f> <cmd>Neotree position=float reveal<cr>\bcmd\bvim\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: FTerm.nvim
time([[Config for FTerm.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vtoggle\nFTerm\frequireÍ\1\1\0\5\0\f\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0'\3\b\0003\4\t\0B\0\4\0016\0\6\0'\2\n\0'\3\b\0'\4\v\0B\0\4\1K\0\1\0005<c-\\><c-n><CMD>lua require('FTerm').toggle()<CR>\6t\0\n<F11>\6n\bmap\15dimensions\1\0\2\vheight\4ÆèÖ◊\aî‹æˇ\3\nwidth\4ÆèÖ◊\aî‹æˇ\3\1\0\1\vborder\frounded\nsetup\nFTerm\frequire\0", "config", "FTerm.nvim")
time([[Config for FTerm.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: vim-abolish
time([[Config for vim-abolish]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\26cnoreabbrev S Subvert\28cnoreabbrev %S %Subvert\bcmd\0", "config", "vim-abolish")
time([[Config for vim-abolish]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nx\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\25use_diagnostic_signs\2\tmode\25document_diagnostics\15auto_close\2\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: textobj-diagnostic.nvim
time([[Config for textobj-diagnostic.nvim]], true)
try_loadstring("\27LJ\2\nN\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24next_diag_inclusive\23textobj-diagnostic\frequireN\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24next_diag_inclusive\23textobj-diagnostic\frequire‹\1\1\0\6\0\15\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0005\2\a\0'\3\b\0003\4\t\0005\5\n\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0005\2\v\0'\3\f\0003\4\r\0005\5\14\0B\0\5\1K\0\1\0\1\0\1\vsilent\2\0\aad\1\3\0\0\6x\6o\1\0\1\vsilent\2\0\aid\1\3\0\0\6x\6o\bset\vkeymap\bvim\1\0\1\27create_default_keymaps\1\nsetup\23textobj-diagnostic\frequire\0", "config", "textobj-diagnostic.nvim")
time([[Config for textobj-diagnostic.nvim]], false)
-- Config for: lazygit.nvim
time([[Config for lazygit.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28cnoreabbrev git LazyGit\bcmd\0", "config", "lazygit.nvim")
time([[Config for lazygit.nvim]], false)
-- Config for: inc-rename.nvim
time([[Config for inc-rename.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\rcmd_name\vRename\nsetup\15inc_rename\frequire\0", "config", "inc-rename.nvim")
time([[Config for inc-rename.nvim]], false)
-- Config for: substitute.nvim
time([[Config for substitute.nvim]], true)
try_loadstring("\27LJ\2\n≥\3\0\0\6\0\19\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\r\0'\4\14\0005\5\15\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\16\0'\3\a\0'\4\17\0005\5\18\0B\0\5\1K\0\1\0\1\0\1\fnoremap\0020<cmd>lua require('substitute').visual()<cr>\6x\1\0\1\fnoremap\2-<cmd>lua require('substitute').eol()<cr>\6M\1\0\1\fnoremap\2.<cmd>lua require('substitute').line()<cr>\amm\1\0\1\fnoremap\0022<cmd>lua require('substitute').operator()<cr>\6m\6n\bset\vkeymap\bvim\nsetup\15substitute\frequire\0", "config", "substitute.nvim")
time([[Config for substitute.nvim]], false)
-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
-- Config for: stabilize.nvim
time([[Config for stabilize.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0", "config", "stabilize.nvim")
time([[Config for stabilize.nvim]], false)
-- Config for: hlargs.nvim
time([[Config for hlargs.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vhlargs\frequire\0", "config", "hlargs.nvim")
time([[Config for hlargs.nvim]], false)
-- Config for: nvim-lastplace
time([[Config for nvim-lastplace]], true)
try_loadstring("\27LJ\2\n⁄\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\30lastplace_ignore_filetype\1\5\0\0\14gitcommit\14gitrebase\bsvn\rhgcommit\29lastplace_ignore_buftype\1\0\1\25lastplace_open_folds\2\1\4\0\0\rquickfix\vnofile\thelp\nsetup\19nvim-lastplace\frequire\0", "config", "nvim-lastplace")
time([[Config for nvim-lastplace]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n|\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vwindow\1\0\1\nblend\3\0\ttext\1\0\0\1\0\1\fspinner\19dots_scrolling\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: feline.nvim
time([[Config for feline.nvim]], true)
try_loadstring("\27LJ\2\nZ\0\1\a\1\a\0\v6\1\0\0009\1\1\1'\3\2\0005\4\5\0005\5\4\0-\6\0\0009\6\3\6=\6\3\5=\5\6\4\18\5\0\0D\1\4\0\0¿\ahl\1\0\0\1\0\0\abg\tkeep\20tbl_deep_extend\bvims\0\0\4\0\6\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\2\15\0\0\0X\1\5Ä'\1\3\0'\2\4\0\18\3\0\0&\1\3\1L\1\2\0'\1\5\0L\1\2\0\5\6 \bÔëø\20git_info_exists\25feline.providers.git\frequire|\0\1\5\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\0\0005\4\3\0D\1\3\0\1\0\3\23file_modified_icon\5\ttype\vunique\17colored_icon\2\14file_info\26feline.providers.file\frequirex\0\0\3\0\a\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2D\0\2\0\nERROR\rseverity\15diagnostic\bvim\22diagnostics_exist\25feline.providers.lsp\frequirew\0\0\3\0\a\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2D\0\2\0\tWARN\rseverity\15diagnostic\bvim\22diagnostics_exist\25feline.providers.lsp\frequire˙\n\1\0\14\0<\2µ\0016\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0B\0\1\0029\1\6\0=\1\5\0003\1\a\0\18\2\1\0005\4\b\0B\2\2\0026\3\0\0'\5\t\0B\3\2\0029\3\2\0035\5!\0005\6\30\0004\a\3\0004\b\5\0>\2\1\b\18\t\1\0005\v\r\0005\f\n\0005\r\v\0=\r\f\f=\f\14\v5\f\16\0009\r\15\0=\r\17\f=\f\18\v4\f\0\0=\f\19\vB\t\2\2>\t\2\b\18\t\1\0005\v\20\0005\f\22\0009\r\21\0=\r\17\f=\f\18\vB\t\2\2>\t\3\b\18\t\1\0005\v\24\0003\f\23\0=\f\14\v5\f\26\0009\r\25\0=\r\17\f=\f\18\vB\t\2\0?\t\0\0>\b\1\a4\b\3\0\18\t\1\0005\v\27\0005\f\29\0009\r\28\0=\r\17\f9\r\5\0=\r\5\f=\f\18\vB\t\2\2>\t\1\b>\2\2\b>\b\2\a=\a\31\0064\a\0\0=\a \6=\6\"\5B\3\2\0014\3\n\0>\2\1\3\18\4\1\0005\6$\0003\a#\0=\a\14\0065\a%\0009\b\15\0=\b\17\a=\a\18\0064\a\0\0=\a\19\6B\4\2\2>\4\2\3>\2\3\3\18\4\1\0005\6&\0005\a'\0009\b\28\0=\b\17\a9\b\5\0=\b\5\a=\a\18\6B\4\2\2>\4\4\3\18\4\1\0005\6(\0006\a\0\0'\t)\0B\a\2\0029\a*\a=\a+\0065\a-\0009\b,\0=\b\17\a=\a\18\6B\4\2\2>\4\5\3\18\4\1\0005\6.\0006\a\0\0'\t)\0B\a\2\0029\a*\a=\a+\0065\a0\0009\b/\0=\b\17\a=\a\18\6B\4\2\2>\4\6\3\18\4\1\0005\0061\0006\a\0\0'\t)\0B\a\2\0029\a*\a=\a+\0065\a2\0009\b\25\0=\b\17\a=\a\18\6B\4\2\2>\4\a\3\18\4\1\0005\0063\0003\a4\0=\a+\0065\a5\0009\b\25\0=\b\17\a9\b\5\0=\b\5\a=\a\18\6B\4\2\2>\4\b\3\18\4\1\0005\0066\0003\a7\0=\a+\0065\a8\0009\b/\0=\b\17\a9\b\5\0=\b\5\a=\a\18\6B\4\2\0?\4\1\0006\4\0\0'\6\t\0B\4\2\0029\0049\0049\4\2\0045\6;\0005\a:\0004\b\3\0>\3\1\b=\b\31\a4\b\3\0>\3\1\b=\b \a=\a\"\6B\4\2\0012\0\0ÄK\0\1\0\1\0\0\1\0\0\vwinbar\1\0\1\bgui\vitalic\0\1\0\1\rprovider\24diagnostic_warnings\1\0\1\bgui\vitalic\0\1\0\1\rprovider\22diagnostic_errors\1\0\0\1\0\1\rprovider\21git_diff_removed\1\0\0\vyellow\1\0\1\rprovider\21git_diff_changed\1\0\0\ngreen\fenabled\20git_info_exists\25feline.providers.git\1\0\1\rprovider\19git_diff_added\1\0\1\bgui\vitalic\1\0\1\rprovider\rposition\1\0\1\nstyle\vitalic\1\0\0\0\15components\1\0\0\rinactive\vactive\1\0\0\1\0\1\bgui\vitalic\tblue\1\0\1\rprovider\21lsp_client_names\1\0\1\nstyle\vitalic\bred\1\0\0\0\1\0\0\ttext\1\0\1\rprovider\t on \19short_provider\ahl\afg\1\0\1\nstyle\vitalic\tteal\rprovider\1\0\0\topts\1\0\3\23file_modified_icon\b[+]\ttype\rrelative\17colored_icon\2\1\0\1\tname\14file_info\vfeline\1\0\1\rprovider\6 \0\tbase\abg\16get_palette\24catppuccin.palettes\nsetup\rgitsigns\frequire\tÄÄ¿ô\4\19ÄÄ¿ô\4\0", "config", "feline.nvim")
time([[Config for feline.nvim]], false)
-- Config for: octo.nvim
time([[Config for octo.nvim]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0'\2\4\0005\3\5\0B\0\3\1K\0\1\0\1\0\1\abg\tnone\17OctoEditable\ahi\nsetup\tocto\frequire\0", "config", "octo.nvim")
time([[Config for octo.nvim]], false)
-- Config for: obvious-resize
time([[Config for obvious-resize]], true)
try_loadstring("\27LJ\2\nß\2\0\0\5\0\r\0\0276\0\0\0)\1\4\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0006\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\3\0'\2\4\0'\3\a\0'\4\b\0B\0\4\0016\0\3\0'\2\4\0'\3\t\0'\4\n\0B\0\4\0016\0\3\0'\2\4\0'\3\v\0'\4\f\0B\0\4\1K\0\1\0\28:ObviousResizeRight<cr>\14<c-right>\27:ObviousResizeLeft<cr>\r<c-left>\27:ObviousResizeDown<cr>\r<c-down>\25:ObviousResizeUp<cr>\v<c-up>\5\bmap\28obvious_resize_run_tmux\27obvious_resize_default\6g\0", "config", "obvious-resize")
time([[Config for obvious-resize]], false)
-- Config for: cokeline.nvim
time([[Config for cokeline.nvim]], true)
try_loadstring("\27LJ\2\nJ\0\1\4\0\3\0\t6\1\0\0009\3\1\0B\1\2\2\15\0\1\0X\2\3Ä6\1\0\0009\3\2\0B\1\2\2L\1\2\0\rfilename\tpath\21isNonEmptyString?\0\1\5\1\3\0\b9\1\0\0\14\0\1\0X\1\4Ä-\1\0\0'\3\1\0'\4\2\0D\1\3\0K\0\1\0\1¿\afg\fComment\15is_focused \0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ticon\fdevicon!\0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ncolor\fdevicon.\0\1\3\0\2\0\0049\1\0\0009\2\1\0&\1\2\1L\1\2\0\rfilename\18unique_prefixz\0\1\5\2\6\0\0169\1\0\0\15\0\1\0X\2\3Ä-\1\0\0009\1\1\1L\1\2\0009\1\2\0\15\0\1\0X\2\3Ä-\1\0\0009\1\3\1L\1\2\0-\1\1\0'\3\4\0'\4\5\0D\1\3\0\0¿\1¿\afg\fComment\vyellow\16is_modified\nmauve\15is_focused5\0\1\2\0\2\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0+\1\0\0L\1\2\0\vitalic\15is_focused6\0\1\2\0\3\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0'\1\2\0L\1\2\0\5\n üîí\16is_readonly \4\1\0\t\0'\0@6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0029\1\4\0=\1\3\0006\1\0\0'\3\5\0B\1\2\0029\1\6\0015\2\a\0006\3\0\0'\5\b\0B\3\2\0029\3\t\0035\5\v\0005\6\n\0=\6\f\0055\6\14\0003\a\r\0=\a\15\6=\6\16\0055\6\17\0009\a\3\0=\a\3\0063\a\18\0=\a\19\6=\6\20\0054\6\6\0>\2\1\0065\a\22\0003\b\21\0=\b\23\a3\b\24\0=\b\19\a>\a\2\0065\a\26\0003\b\25\0=\b\23\a3\b\27\0=\b\19\a3\b\28\0=\b\29\a>\a\3\0065\a\31\0003\b\30\0=\b\23\a>\a\4\6>\2\5\6=\6 \5B\3\2\0016\3!\0'\5\"\0B\3\2\0016\3!\0'\5#\0B\3\2\0016\3$\0'\5%\0005\6&\0B\3\3\0012\0\0ÄK\0\1\0\1\0\1\nguibg\tnone\16tablinefill\ahi.nmap <S-Down> <Plug>(cokeline-focus-prev),nmap <S-Up> <Plug>(cokeline-focus-next)\bcmd\15components\1\0\0\0\nstyle\0\0\1\0\0\0\0\ttext\1\0\0\0\15default_hl\afg\0\1\0\0\fbuffers\17filter_valid\1\0\0\0\rmappings\1\0\0\1\0\1\20cycle_prev_next\2\nsetup\rcokeline\1\0\1\ttext\6 \fget_hex\19cokeline/utils\tbase\abg\16get_palette\24catppuccin.palettes\frequire\0", "config", "cokeline.nvim")
time([[Config for cokeline.nvim]], false)
-- Config for: vim-bufonly
time([[Config for vim-bufonly]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25cnoreabbrev bo Bonly\bcmd\0", "config", "vim-bufonly")
time([[Config for vim-bufonly]], false)
-- Config for: nvim
time([[Config for nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27colorscheme catppuccin\bcmd\bvimS\1\0\4\0\5\0\n6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0003\2\4\0)\3\0\0B\0\3\1K\0\1\0\0\rdefer_fn\22CatppuccinCompile\bcmd\bvim∏\4\1\0\a\0!\0.6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0003\4\5\0=\4\6\3B\0\3\0016\0\a\0'\2\b\0B\0\2\0029\0\t\0B\0\1\0029\1\v\0=\1\n\0006\1\0\0009\1\f\1'\2\14\0=\2\r\0016\1\a\0'\3\15\0B\1\2\0029\1\16\0015\3\17\0005\4\18\0=\4\19\0035\4\20\0005\5\21\0004\6\0\0=\6\22\0054\6\0\0=\6\23\0054\6\0\0=\6\24\5=\5\25\4=\4\26\0035\4\30\0005\5\27\0009\6\n\0=\6\n\0059\6\28\0=\6\29\5=\5\31\4=\4 \3B\1\2\1K\0\1\0\22custom_highlights\31DiagnosticVirtualTextError\1\0\0\afg\nerror\1\0\0\17integrations\15native_lsp\15underlines\18virtual_lines\17virtual_text\1\0\1\fenabled\2\1\0\2\16lsp_trouble\2\15lightspeed\2\fcompile\1\0\1\fenabled\2\1\0\1\27transparent_background\2\nsetup\15catppuccin\14macchiato\23catppuccin_flavour\6g\tbase\abg\16get_palette\24catppuccin.palettes\frequire\rcallback\0\1\0\1\fpattern\22PackerCompileDone\tUser\24nvim_create_autocmd\bapi\bvim\0", "config", "nvim")
time([[Config for nvim]], false)
-- Config for: vim-vsnip
time([[Config for vim-vsnip]], true)
try_loadstring("\27LJ\2\nx\0\0\4\0\a\0\f6\0\0\0+\1\1\0=\1\1\0006\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0K\0\1\0\v/vsnip\vconfig\fstdpath\afn\22vsnip_snippet_dir\24vsnip_extra_mapping\6g\0", "config", "vim-vsnip")
time([[Config for vim-vsnip]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\nÀ\16\0\0\t\0\28\00176\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\2\4\0025\3\6\0=\3\5\0029\2\3\0019\2\a\0024\3\6\0009\4\b\1'\6\t\0'\a\n\0'\b\v\0B\4\4\2>\4\1\0039\4\b\1'\6\f\0'\a\r\0'\b\14\0B\4\4\2>\4\2\0039\4\b\1'\6\15\0'\a\16\0'\b\17\0B\4\4\2>\4\3\0039\4\b\1'\6\18\0'\a\19\0'\b\20\0B\4\4\2>\4\4\0039\4\b\1'\6\21\0'\a\22\0'\b\23\0B\4\4\0?\4\0\0=\3\5\0029\2\3\0019\2\24\0026\3\0\0'\5\25\0B\3\2\2B\3\1\2=\3\5\0029\2\26\0009\4\27\1B\2\2\1K\0\1\0\topts\nsetup\18alpha.fortune\vfooter\f:qa<CR>\21Ôôô  > Quit NVIM\6q\23:PackerInstall<CR>\27P  > Plugins - Install\6i\21:PackerClean<CR>\27P  > Plugins - Cleanup\6c\20:PackerSync<CR>\24P  > Plugins - Sync\6s :ene <BAR> startinsert <CR>\20ÔÖõ  > New file\6e\vbutton\fbuttons\1\21\0\0:                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     :                                                     à\1  ‚ñà‚ñà‚ñà‚ïó   ‚ñà‚ñà‚ïó‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ïó ‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ïó ‚ñà‚ñà‚ïó   ‚ñà‚ñà‚ïó‚ñà‚ñà‚ïó‚ñà‚ñà‚ñà‚ïó   ‚ñà‚ñà‚ñà‚ïó í\1  ‚ñà‚ñà‚ñà‚ñà‚ïó  ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïî‚ïê‚ïê‚ïê‚ïê‚ïù‚ñà‚ñà‚ïî‚ïê‚ïê‚ïê‚ñà‚ñà‚ïó‚ñà‚ñà‚ïë   ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë‚ñà‚ñà‚ñà‚ñà‚ïó ‚ñà‚ñà‚ñà‚ñà‚ïë å\1  ‚ñà‚ñà‚ïî‚ñà‚ñà‚ïó ‚ñà‚ñà‚ïë‚ñà‚ñà‚ñà‚ñà‚ñà‚ïó  ‚ñà‚ñà‚ïë   ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë   ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë‚ñà‚ñà‚ïî‚ñà‚ñà‚ñà‚ñà‚ïî‚ñà‚ñà‚ïë í\1  ‚ñà‚ñà‚ïë‚ïö‚ñà‚ñà‚ïó‚ñà‚ñà‚ïë‚ñà‚ñà‚ïî‚ïê‚ïê‚ïù  ‚ñà‚ñà‚ïë   ‚ñà‚ñà‚ïë‚ïö‚ñà‚ñà‚ïó ‚ñà‚ñà‚ïî‚ïù‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë‚ïö‚ñà‚ñà‚ïî‚ïù‚ñà‚ñà‚ïë î\1  ‚ñà‚ñà‚ïë ‚ïö‚ñà‚ñà‚ñà‚ñà‚ïë‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ïó‚ïö‚ñà‚ñà‚ñà‚ñà‚ñà‚ñà‚ïî‚ïù ‚ïö‚ñà‚ñà‚ñà‚ñà‚ïî‚ïù ‚ñà‚ñà‚ïë‚ñà‚ñà‚ïë ‚ïö‚ïê‚ïù ‚ñà‚ñà‚ïë Ñ\1  ‚ïö‚ïê‚ïù  ‚ïö‚ïê‚ïê‚ïê‚ïù‚ïö‚ïê‚ïê‚ïê‚ïê‚ïê‚ïê‚ïù ‚ïö‚ïê‚ïê‚ïê‚ïê‚ïê‚ïù   ‚ïö‚ïê‚ïê‚ïê‚ïù  ‚ïö‚ïê‚ïù‚ïö‚ïê‚ïù     ‚ïö‚ïê‚ïù :                                                     \bval\vheader\fsection\27alpha.themes.dashboard\nalpha\frequire\vÄÄ¿ô\4\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: FixCursorHold.nvim
time([[Config for FixCursorHold.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1»\0=\1\2\0K\0\1\0\26cursorhold_updatetime\6g\bvim\0", "config", "FixCursorHold.nvim")
time([[Config for FixCursorHold.nvim]], false)
-- Config for: vim-dotenv
time([[Config for vim-dotenv]], true)
try_loadstring("\27LJ\2\n]\0\0\5\0\5\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\4\0'\3\2\0'\4\3\0B\0\4\1K\0\1\0\17BufWritePost\16Dotenv .env\t.env\rVimEnter\aau\0", "config", "vim-dotenv")
time([[Config for vim-dotenv]], false)
-- Config for: vim-bbye
time([[Config for vim-bbye]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27cnoreabbrev bd Bdelete\bcmd\0", "config", "vim-bbye")
time([[Config for vim-bbye]], false)
-- Config for: nvim-treesitter-textobjects
time([[Config for nvim-treesitter-textobjects]], true)
try_loadstring("\27LJ\2\nÄ\4\0\0\6\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\18\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\0035\4\b\0005\5\t\0=\5\n\0045\5\v\0=\5\f\0045\5\r\0=\5\14\0045\5\15\0=\5\16\4=\4\17\3=\3\19\2B\0\2\1K\0\1\0\16textobjects\1\0\0\tmove\22goto_previous_end\1\0\2\a[]\17@class.outer\a[M\20@function.outer\24goto_previous_start\1\0\2\a[[\17@class.outer\a[m\20@function.outer\18goto_next_end\1\0\2\a][\17@class.outer\a]M\20@function.outer\20goto_next_start\1\0\2\a]]\17@class.outer\a]m\20@function.outer\1\0\2\venable\2\14set_jumps\2\vselect\1\0\0\fkeymaps\1\0\4\aic\17@class.inner\aac\17@class.outer\aif\20@function.inner\aaf\20@function.outer\1\0\2\14lookahead\2\venable\2\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter-textobjects")
time([[Config for nvim-treesitter-textobjects]], false)
-- Config for: dial.nvim
time([[Config for dial.nvim]], true)
try_loadstring("\27LJ\2\n©\6\0\0\n\0(\1g6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1\18\3\1\0009\1\4\0015\4\18\0004\5\6\0009\6\5\0009\6\6\0069\6\a\6>\6\1\0059\6\b\0009\6\6\0069\6\t\6>\6\2\0059\6\b\0009\6\n\0065\b\f\0005\t\v\0=\t\r\bB\6\2\2>\6\3\0059\6\b\0009\6\n\0065\b\15\0005\t\14\0=\t\r\bB\6\2\2>\6\4\0059\6\b\0009\6\n\0065\b\17\0005\t\16\0=\t\r\bB\6\2\0?\6\0\0=\5\19\4B\1\3\0016\1\20\0'\3\21\0'\4\22\0006\5\0\0'\a\23\0B\5\2\0029\5\24\5B\5\1\0025\6\25\0B\1\5\0016\1\20\0'\3\21\0'\4\26\0006\5\0\0'\a\23\0B\5\2\0029\5\27\5B\5\1\0025\6\28\0B\1\5\0016\1\20\0'\3\29\0'\4\22\0006\5\0\0'\a\23\0B\5\2\0029\5\30\5B\5\1\0025\6\31\0B\1\5\0016\1\20\0'\3\29\0'\4\26\0006\5\0\0'\a\23\0B\5\2\0029\5 \5B\5\1\0025\6!\0B\1\5\0016\1\20\0'\3\29\0'\4\"\0006\5\0\0'\a\23\0B\5\2\0029\5#\5B\5\1\0025\6$\0B\1\5\0016\1\20\0'\3\29\0'\4%\0006\5\0\0'\a\23\0B\5\2\0029\5&\5B\5\1\0025\6'\0B\1\5\1K\0\1\0\1\0\1\fnoremap\2\16dec_gvisual\vg<C-x>\1\0\1\fnoremap\2\16inc_gvisual\vg<C-a>\1\0\1\fnoremap\2\15dec_visual\1\0\1\fnoremap\2\15inc_visual\6v\1\0\1\fnoremap\2\15dec_normal\n<C-x>\1\0\1\fnoremap\2\15inc_normal\rdial.map\n<C-a>\6n\bmap\fdefault\1\0\0\1\0\2\vcyclic\2\tword\1\1\3\0\0\a&&\a||\1\0\2\vcyclic\2\tword\2\1\3\0\0\nconst\blet\relements\1\0\2\vcyclic\2\tword\2\1\3\0\0\band\aor\bnew\tbool\rconstant\fdecimal\nalias\finteger\19register_group\faugends\16dial.config\16dial.augend\frequire\vÄÄ¿ô\4\0", "config", "dial.nvim")
time([[Config for dial.nvim]], false)
-- Config for: vim-textobj-user
time([[Config for vim-textobj-user]], true)
try_loadstring("\27LJ\2\n‚\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0¬\1        call textobj#user#plugin('custom', {\n        \\   'block': {\n        \\     'pattern': '[\\{\\[\\(].*[\\)\\]\\}]',\n        \\     'select': ['ab', 'ib'],\n        \\   },\n        \\ })\n        \bcmd\bvim\0", "config", "vim-textobj-user")
time([[Config for vim-textobj-user]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nó\5\0\0\6\0\26\0\"6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0025\1\a\0005\2\4\0005\3\5\0=\3\6\2=\2\b\1=\1\3\0006\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\v\0005\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\0044\5\0\0=\5\22\0045\5\23\0=\5\24\4=\4\25\3B\1\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\19highlight_self\1\19goto_right_end\1\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\venable\2\26context_commentstring\1\0\2\19enable_autocmd\2\venable\2\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\2\0\0\fhaskell\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\17install_info\1\0\0\nfiles\1\2\0\0\17src/parser.c\1\0\2\burl5https://github.com/NTBBloodbath/tree-sitter-http\vbranch\tmain\thttp\23get_parser_configs\28nvim-treesitter.parsers\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: mason-lspconfig.nvim
time([[Config for mason-lspconfig.nvim]], true)
try_loadstring("\27LJ\2\nß\1\0\0\5\0\b\0\0176\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0016\1\0\0'\3\4\0B\1\2\0029\1\3\0015\3\5\0009\4\6\0=\4\a\3B\1\2\1K\0\1\0\21ensure_installed\fservers\1\0\1\27automatic_installation\1\20mason-lspconfig\nsetup\nmason\blsp\frequire\0", "config", "mason-lspconfig.nvim")
time([[Config for mason-lspconfig.nvim]], false)
-- Config for: hydra.nvim
time([[Config for hydra.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tleft\14Navigator\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tdown\14Navigator\frequire4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\aup\14Navigator\frequire7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nright\14Navigator\frequire6\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\23:ObviousResizeLeft\bcmd\bvim6\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\23:ObviousResizeDown\bcmd\bvim4\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\21:ObviousResizeUp\bcmd\bvim7\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\24:ObviousResizeRight\bcmd\bvim›\4\1\0\a\0\25\0/6\0\0\0'\2\1\0B\0\2\2\18\1\0\0005\3\2\0005\4\3\0005\5\4\0=\5\5\4=\4\6\0034\4\n\0005\5\a\0003\6\b\0>\6\2\5>\5\1\0045\5\t\0003\6\n\0>\6\2\5>\5\2\0045\5\v\0003\6\f\0>\6\2\5>\5\3\0045\5\r\0003\6\14\0>\6\2\5>\5\4\0045\5\15\0003\6\16\0>\6\2\5>\5\5\0045\5\17\0003\6\18\0>\6\2\5>\5\6\0045\5\19\0003\6\20\0>\6\2\5>\5\a\0045\5\21\0003\6\22\0>\6\2\5>\5\b\0045\5\23\0>\5\t\4=\4\24\3B\1\2\1K\0\1\0\nheads\1\2\1\0\n<esc>\texit\2\0\1\2\0\0\6L\0\1\2\0\0\6K\0\1\2\0\0\6J\0\1\2\0\0\6H\0\1\2\0\0\6l\0\1\2\0\0\6k\0\1\2\0\0\6j\0\1\2\0\0\6h\vconfig\thint\1\0\2\rposition\vbottom\vborder\frounded\1\0\2\ftimeout\3†\31\19invoke_on_body\2\1\0\4\thintƒ\1 ^^^^^^  Split/Pane  ^^^^^^\n ^^^^^^--------------^^^^^^\n ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^\n _h_ ^ ^ _l_   _H_ ^ ^ _L_\n ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^\n focus^^^^^^   resize^^^^^\n ^ ^ ^ ^ ^ ^   ^ ^ ^ ^ ^ ^\n\tname\18Resizing mode\tmode\6n\tbody\14<leader>w\nhydra\frequire\0", "config", "hydra.nvim")
time([[Config for hydra.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\1¿\14git_filesR\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\2\14no_ignore\2\vhidden\2\nmerge\15find_files)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\14live_grep(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreW\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\14live_grep+\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\16grep_string(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreY\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\16grep_stringK\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\18sort_lastused\2\nmerge\fbuffersG\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\rcwd_only\2\nmerge\roldfilesª\5\1\0\b\0$\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\b\0'\2\5\0B\0\2\0016\0\0\0'\2\t\0B\0\2\0025\1\n\0005\2\v\0=\2\f\0015\2\r\0005\3\14\0=\3\f\0026\3\15\0'\5\16\0'\6\17\0003\a\18\0B\3\4\0016\3\15\0'\5\16\0'\6\19\0003\a\20\0B\3\4\0016\3\15\0'\5\16\0'\6\21\0003\a\22\0B\3\4\0016\3\15\0'\5\16\0'\6\23\0003\a\24\0B\3\4\0016\3\15\0'\5\16\0'\6\25\0003\a\26\0B\3\4\0016\3\15\0'\5\16\0'\6\27\0003\a\28\0B\3\4\0016\3\15\0'\5\16\0'\6\29\0003\a\30\0B\3\4\0016\3\15\0'\5\16\0'\6\31\0003\a \0B\3\4\0016\3!\0'\5\"\0005\6#\0B\3\3\0012\0\0ÄK\0\1\0\1\0\1\nguibg\tnone\20TelescopeNormal\ahi\0\agh\0\agb\0\agO\0\ago\0\agC\0\agc\0\agF\0\agf\6n\bmap\1\0\2\vheight\4Õô≥Ê\fÃô≥ˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\1\0\1\20layout_strategy\rvertical\18layout_config\1\0\4\18preview_width\4ö≥ÊÃ\tô≥Ê˛\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\vheight\4Õô≥Ê\fÃô≥ˇ\3\vmirror\1\1\0\1\20layout_strategy\15horizontal\22telescope.builtin\19load_extension\15extensions\1\0\0\bfzf\1\0\0\1\0\4\nfuzzy\2\14case_mode\15smart_case\28override_generic_sorter\2\25override_file_sorter\2\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nY\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0+\2\0\0005\3\3\0B\0\3\1K\0\1\0\1\0\2\nnames\1\tmode\15foreground\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: packer.nvim
time([[Config for packer.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27command! PS PackerSync\bcmd\0", "config", "packer.nvim")
time([[Config for packer.nvim]], false)
-- Config for: lightspeed.nvim
time([[Config for lightspeed.nvim]], true)
try_loadstring("\27LJ\2\n~\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\25jump_to_unique_chars\1\0\1\19safety_timeout\3ê\3\1\0\1\16ignore_case\2\nsetup\15lightspeed\frequire\0", "config", "lightspeed.nvim")
time([[Config for lightspeed.nvim]], false)
-- Config for: bufresize.nvim
time([[Config for bufresize.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14bufresize\frequire\0", "config", "bufresize.nvim")
time([[Config for bufresize.nvim]], false)
-- Config for: commented.nvim
time([[Config for commented.nvim]], true)
try_loadstring("\27LJ\2\n©\1\0\0\a\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\a\0005\3\5\0006\4\0\0'\6\3\0B\4\2\0029\4\4\4=\4\6\3=\3\b\2B\0\2\1K\0\1\0\nhooks\1\0\0\19before_comment\1\0\0\25update_commentstring&ts_context_commentstring.internal\nsetup\14commented\frequire\0", "config", "commented.nvim")
time([[Config for commented.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Replace lua require("packer.load")({'nvim-spectre'}, { cmd = "Replace", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CodeActionMenu lua require("packer.load")({'nvim-code-action-menu'}, { cmd = "CodeActionMenu", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'smart-pairs'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
