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
  ["alpha-nvim"] = {
    config = { "\27LJ\2\n`\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\2B\0\2\1K\0\1\0\vconfig\26alpha.themes.startify\nsetup\nalpha\frequire\0" },
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
    config = { "\27LJ\2\nJ\0\1\4\0\3\0\t6\1\0\0009\3\1\0B\1\2\2\15\0\1\0X\2\3Ä6\1\0\0009\3\2\0B\1\2\2L\1\2\0\rfilename\tpath\21isNonEmptyString?\0\1\5\1\3\0\b9\1\0\0\14\0\1\0X\1\4Ä-\1\0\0'\3\1\0'\4\2\0D\1\3\0K\0\1\0\0¿\afg\fComment\15is_focused \0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ticon\fdevicon!\0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ncolor\fdevicon.\0\1\3\0\2\0\0049\1\0\0009\2\1\0&\1\2\1L\1\2\0\rfilename\18unique_prefixZ\0\1\2\0\4\0\v9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0009\1\2\0\15\0\1\0X\2\2Ä'\1\3\0L\1\2\0K\0\1\0\f#EBCB8B\16is_modified\f#B988B0\15is_focused8\0\1\2\0\2\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0+\1\0\0L\1\2\0\14underline\15is_focused6\0\1\2\0\3\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0'\1\2\0L\1\2\0\5\n üîí\16is_readonlyÜ\4\1\0\b\0#\00076\0\0\0'\2\1\0B\0\2\0029\0\2\0005\1\3\0006\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\a\0005\5\6\0=\5\b\0045\5\n\0003\6\t\0=\6\v\5=\5\f\0045\5\r\0003\6\14\0=\6\15\5=\5\16\0044\5\6\0>\1\1\0055\6\18\0003\a\17\0=\a\19\0063\a\20\0=\a\15\6>\6\2\0055\6\22\0003\a\21\0=\a\19\0063\a\23\0=\a\15\0063\a\24\0=\a\25\6>\6\3\0055\6\27\0003\a\26\0=\a\19\6>\6\4\5>\1\5\5=\5\28\4B\2\2\0016\2\29\0'\4\30\0B\2\2\0016\2\29\0'\4\31\0B\2\2\0016\2 \0'\4!\0005\5\"\0B\2\3\0012\0\0ÄK\0\1\0\1\0\1\nguibg\tnone\16tablinefill\ahi.nmap <S-Down> <Plug>(cokeline-focus-prev),nmap <S-Up> <Plug>(cokeline-focus-next)\bcmd\15components\1\0\0\0\nstyle\0\0\1\0\0\0\0\ttext\1\0\0\0\15default_hl\afg\0\1\0\1\abg\tnone\fbuffers\17filter_valid\1\0\0\0\rmappings\1\0\0\1\0\1\20cycle_prev_next\2\nsetup\rcokeline\1\0\1\ttext\6 \fget_hex\19cokeline/utils\frequire\0" },
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
  ["hlargs.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vhlargs\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim"
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
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 \18\0\0\1\0\1\0\2'\0\0\0L\0\2\0\aonˆ\2\0\0\14\0\19\0025'\0\0\0006\1\1\0009\1\2\0019\1\3\1)\3\0\0'\4\4\0B\1\3\0026\2\1\0009\2\5\0029\2\6\2B\2\1\0026\3\a\0\18\5\2\0B\3\2\2\v\3\0\0X\3\1ÄL\0\2\0004\3\0\0006\4\b\0\18\6\2\0B\4\2\4X\a\17Ä9\t\t\b9\t\n\t\15\0\t\0X\n\rÄ6\n\1\0009\n\v\n9\n\f\n\18\f\t\0\18\r\1\0B\n\3\2\b\n\0\0X\n\5Ä6\n\r\0009\n\14\n\18\f\3\0009\r\15\bB\n\3\1E\a\3\3R\aÌ\1276\4\1\0009\4\16\4\18\6\3\0B\4\2\2\t\4\1\0X\4\1ÄL\0\2\0006\4\r\0009\4\17\4\18\6\3\0'\a\18\0D\4\3\0\6|\vconcat\14tbl_count\tname\vinsert\ntable\nindex\afn\14filetypes\vconfig\vipairs\tnext\23get_active_clients\blsp\rfiletype\24nvim_buf_get_option\bapi\bvim\18No Active Lsp˛ˇˇˇ\31\0˜\f\1\0\v\0L\0ó\0016\0\0\0'\2\1\0B\0\2\0025\1\2\0005\2\5\0003\3\3\0>\3\1\0025\3\4\0=\3\6\0025\3\b\0009\4\a\1=\4\a\3=\3\t\0029\3\n\0005\5\23\0005\6\v\0005\a\15\0005\b\r\0005\t\f\0=\t\14\b=\b\16\a=\a\17\0065\a\18\0=\a\19\0065\a\20\0=\a\21\0064\a\0\0=\a\22\6=\6\24\0055\6\25\0004\a\0\0=\a\26\0064\a\0\0=\a\27\0064\a\v\0>\2\1\a5\b\28\0005\t\29\0=\t\6\b>\b\2\a>\2\3\a5\b\30\0005\t\31\0=\t \b5\t\"\0009\n!\1=\n#\t9\n\a\1=\n\a\t=\t\t\b5\t$\0=\t\6\b>\b\4\a>\2\5\a5\b(\0003\t%\0>\t\1\b5\t'\0009\n&\1=\n#\t9\n\a\1=\n\a\t=\t\t\b5\t)\0=\t\6\b>\b\6\a>\2\a\a5\b*\0005\t+\0=\t\6\b5\t-\0009\n,\1=\n#\t9\n\a\1=\n\a\t=\t\t\b>\b\b\a>\2\t\a5\b.\0005\t/\0009\n,\1=\n#\t9\n\a\1=\n\a\t=\t\t\b5\t0\0=\t\6\b>\b\n\a=\a1\0064\a\0\0=\a2\0064\a\0\0=\a3\0064\a\5\0005\b4\0005\t5\0=\t6\b5\t7\0=\t8\b5\t9\0009\n,\1=\n:\t9\n;\1=\n<\t=\t=\b5\t>\0=\t \b5\t?\0=\t\6\b5\t@\0009\n\a\1=\n\a\t=\t\t\b>\b\1\a>\2\2\a5\bB\0003\tA\0>\t\1\b5\tC\0009\n&\1=\n#\t9\n\a\1=\n\a\t=\t\t\b5\tD\0=\t\6\b>\b\3\a5\bE\0>\b\4\a=\aF\6=\0068\0055\6G\0004\a\0\0=\a\26\0064\a\0\0=\a\27\0064\a\0\0=\a1\0064\a\0\0=\a2\0064\a\0\0=\a3\0064\a\0\0=\aF\6=\6H\0054\6\0\0=\6I\0055\6J\0=\6K\5B\3\2\1K\0\1\0\15extensions\1\5\0\0\14nvim-tree\rfugitive\rquickfix\15toggleterm\ftabline\22inactive_sections\1\0\0\14lualine_z\1\2\0\0\n%l:%c\1\0\2\tleft\3\0\nright\3\0\1\0\1\bgui\vitalic\1\0\1\ticon\tÔÇÖ \0\1\0\0\1\0\2\tleft\3\0\nright\3\0\1\0\2\nerror\tÔÅó \twarn\tÔÅ± \22diagnostics_color\15color_warn\vyellow\16color_error\1\0\0\rsections\1\3\0\0\nerror\twarn\fsources\1\2\0\0\rnvim_lsp\1\2\3\0\16diagnostics\21update_in_insert\1\19always_visible\2\fcolored\2\14lualine_y\14lualine_x\14lualine_c\1\0\2\tleft\3\0\nright\3\0\1\0\0\1\2\1\0\tdiff\ticon\bÔëø\1\0\1\bgui\vitalic\bred\1\0\2\tleft\3\0\nright\3\0\1\2\1\0\vbranch\ticon\bÔëø\1\0\2\tleft\3\0\nright\3\0\1\0\0\1\0\0\tblue\0\1\0\2\tleft\3\0\nright\3\0\afg\1\0\1\bgui\vitalic\ngreen\fsymbols\1\0\3\funnamed\14[No Name]\rmodified\b[+]\rreadonly\tüîí\1\2\3\0\rfilename\20shorting_target\3(\16file_status\2\tpath\3\1\1\0\2\tleft\3\0\nright\3\0\1\2\2\0\rfiletype\fcolored\2\14icon_only\2\14lualine_b\14lualine_a\1\0\0\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\tleft\5\nright\5\25component_separators\1\0\2\tleft\5\nright\5\ntheme\vnormal\1\0\0\6c\1\0\0\1\0\1\abg\tnone\1\0\3\17globalstatus\2\25always_divide_middle\2\18icons_enabled\2\nsetup\ncolor\1\0\0\abg\fpadding\1\0\0\1\0\2\tleft\3\0\nright\3\0\0\1\0\5\vyellow\f#EBCB8B\tblue\f#81A1C1\abg\tnone\ngreen\f#A3BE8C\bred\f#D57780\flualine\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\n∞\1\0\1\b\0\14\2\0246\1\0\0009\1\1\0019\1\2\0019\3\3\0'\4\4\0B\1\3\0026\2\5\0009\2\6\2\18\4\1\0B\2\2\2\22\2\0\0025\3\t\0006\4\a\0009\4\b\4\18\6\2\0)\a2\0B\4\3\2=\4\n\0036\4\0\0009\4\v\0049\4\f\4\23\4\1\4=\4\r\3L\3\2\0\vheight\nlines\6o\nwidth\1\0\0\bmax\tmath\blen\vstring\a:~\tpath\16fnamemodify\afn\bvim\b\fë\f\1\0\a\0+\00096\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\18\0005\5\17\0=\5\19\4=\4\20\3=\3\21\0025\3\23\0005\4\22\0=\4\24\3=\3\25\0024\3\0\0=\3\26\0025\3\31\0005\4\27\0005\5\28\0=\5\29\0044\5\0\0=\5\30\4=\4 \0035\4&\0005\5\"\0005\6!\0=\6#\0053\6$\0=\6%\5=\5'\0045\5(\0=\5\24\4=\4\25\3=\3)\0024\3\0\0=\3*\0024\3\0\0=\3\20\2B\0\2\1K\0\1\0\fbuffers\15filesystem\1\0\5\6H\18toggle_hidden\n<c-x>\17clear_filter\6f\21filter_on_submit\6/\tnoop\6.\rset_root\npopup\1\0\0\tsize\0\rposition\1\0\0\1\0\2\bcol\t100%\brow\0062\19filtered_items\1\0\3\27use_libuv_file_watcher\2\24follow_current_file\1\26hijack_netrw_behavior\rdisabled\15never_show\17hide_by_name\1\3\0\0\14.DS_Store\14thumbs.db\1\0\3\20hide_gitignored\2\18hide_dotfiles\1\fvisible\1\18nesting_rules\vwindow\rmappings\1\0\0\1\0\18\t<cr>\topen\6m\tmove\6d\vdelete\t<bs>\15close_node\6c\tcopy\6r\vrename\6t\16open_tabnew\6x\21cut_to_clipboard\6y\22copy_to_clipboard\6A\18add_directory\6s\15open_split\6v\16open_vsplit\6a\badd\6p\25paste_from_clipboard\6z\tnoop\6q\17close_window\6R\frefresh\6C\tnoop\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\fdeleted\b‚úñ\nadded\5\rconflict\bÓúß\vstaged\bÔÅÜ\runstaged\bÔò∞\fignored\bÔë¥\14untracked\bÔÑ®\rmodified\5\frenamed\bÔïî\tname\1\0\2\26use_git_status_colors\2\19trailing_slash\1\rmodified\1\0\2\vsymbol\b[+]\14highlight\20NeoTreeModified\ticon\1\0\4\17folder_empty\bÔ∞ä\16folder_open\bÓóæ\fdefault\6*\18folder_closed\bÓóø\vindent\1\0\0\1\0\t\14highlight\24NeoTreeIndentMarker\23expander_collapsed\bÔë†\23last_indent_marker\b‚îî\18indent_marker\b‚îÇ\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\22expander_expanded\bÔëº\1\0\4\23enable_diagnostics\1\22enable_git_status\2\23popup_border_style\frounded\25close_if_last_window\1\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 3 nmap <c-f> :Neotree position=float reveal<cr>\bcmd\bvim\0" },
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
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nè\1\0\0\6\0\a\2\0266\0\0\0009\0\1\0'\2\2\0B\0\2\2\23\0\0\0\b\0\1\0X\1\17Ä6\1\0\0009\1\3\1'\3\2\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\2\0]\0\2\n\0\4\0\0186\2\0\0009\2\1\2\18\4\0\0B\2\2\2!\2\2\1'\3\2\0)\4\1\0\18\5\2\0)\6\1\0M\4\4Ä\18\b\3\0'\t\3\0&\3\t\bO\4¸\127\18\4\0\0\18\5\3\0&\4\5\4L\4\2\0\6 \5\blen\vstring;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimÔ\1\0\2\b\2\a\0\0225\2\0\0009\3\1\0009\3\2\0038\3\3\2\v\3\0\0X\4\2Ä=\3\3\1X\4\aÄ-\4\0\0009\6\4\1)\a\b\0B\4\3\2\18\5\3\0&\4\5\4=\4\3\1-\4\1\0009\4\5\0049\6\4\0015\a\6\0B\4\3\2=\4\4\1L\1\2\0\4¿\2¿\1\0\1\14with_text\1\rsymbolic\tkind\tmenu\tname\vsource\1\0\6\rnvim_lsp\n|lsp|\rnvim_lua\n|api|\tpath\n|pth|\15fuzzy_path\v|fpth|\17fuzzy_buffer\v|fbuf|\vbuffer\n|buf|Õ\1\0\1\t\2\t\0\30-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\2\0009\1\3\0019\1\4\0016\3\2\0009\3\5\0039\3\6\3'\5\a\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\b\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\5\t<Up>\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\21select_prev_item\fvisibleœ\1\0\1\t\2\t\0\30-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\2\0009\1\3\0019\1\4\0016\3\2\0009\3\5\0039\3\6\3'\5\a\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\b\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\5\v<Down>\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\21select_next_item\fvisiblee\0\1\4\1\5\0\f-\1\0\0009\1\0\0015\3\1\0B\1\2\2\14\0\1\0X\1\5Ä6\1\2\0'\3\3\0B\1\2\0029\1\4\1B\1\1\1K\0\1\0\0¿\ttype\16pairs.enter\frequire\1\0\1\vselect\1\fconfirmÃ\2\0\1\t\2\v\00126\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\29Ä-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\n\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\n<Tab>\21select_next_item\fvisible\5!<Plug>(vsnip-expand-or-jump)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2˜\1\0\1\t\1\n\1 6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\vÄ-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisible\5\28<Plug>(vsnip-jump-prev)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2Ó\1\0\1\6\1\v\0\0319\1\0\0\18\3\1\0009\1\1\1B\1\2\0029\2\2\1\15\0\2\0X\3\4Ä9\2\2\0019\2\3\2\14\0\2\0X\3\1Ä+\2\1\0\14\0\2\0X\3\16Ä9\3\4\1-\4\0\0009\4\5\4\4\3\4\0X\3\5Ä9\3\4\1-\4\0\0009\4\6\4\5\3\4\0X\3\6Ä6\3\a\0'\5\b\0B\3\2\0029\3\t\3'\5\n\0B\3\2\1K\0\1\0\1¿\6(\14type_left\18pairs.bracket\frequire\rFunction\vMethod\tkind\23funcParensDisabled\tdata\24get_completion_item\nentry \20\1\0\15\0`\0£\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0016\2\0\0'\4\4\0B\2\2\0023\3\5\0003\4\6\0009\5\a\0005\a\t\0005\b\b\0=\b\n\a5\b\14\0005\t\f\0005\n\v\0=\n\r\t=\t\n\b5\t\16\0005\n\15\0=\n\r\t=\t\17\b=\b\18\a5\b\19\0=\b\20\a5\b\22\0003\t\21\0=\t\23\b=\b\24\a5\b\"\0004\t\b\0009\n\25\0009\n\26\n9\n\27\n>\n\1\t9\n\25\0009\n\26\n9\n\28\n>\n\2\t9\n\25\0009\n\26\n9\n\29\n>\n\3\t9\n\25\0009\n\26\n9\n\30\n>\n\4\t9\n\25\0009\n\26\n9\n\31\n>\n\5\t9\n\25\0009\n\26\n9\n \n>\n\6\t9\n\25\0009\n\26\n9\n!\n>\n\a\t=\t#\b=\b$\a4\b\4\0005\t%\0>\t\1\b5\t&\0>\t\2\b5\t'\0>\t\3\b=\b(\a5\b*\0005\t)\0=\t+\b3\t,\0=\t-\b=\b.\a5\b1\0009\t/\0009\t0\t)\v¸ˇB\t\2\2=\t2\b9\t/\0009\t0\t)\v\4\0B\t\2\2=\t3\b9\t/\0009\v/\0009\v4\v5\r7\0009\0145\0009\0146\14=\0148\rB\v\2\0025\f9\0B\t\3\2=\t:\b9\t/\0009\v/\0009\v;\v5\r<\0009\0145\0009\0146\14=\0148\rB\v\2\0025\f=\0B\t\3\2=\t>\b3\t?\0=\t@\b3\tA\0=\tB\b9\t/\0003\vC\0B\t\2\2=\tD\b3\tE\0=\tF\b3\tG\0=\tH\b=\b/\aB\5\2\0019\5I\0\18\a\5\0009\5J\5'\bK\0003\tL\0B\5\4\0019\5\a\0009\5M\5'\aN\0005\bP\0005\tO\0=\t\n\b4\t\3\0005\nQ\0>\n\1\t=\t(\bB\5\3\0016\5R\0'\aS\0'\bT\0'\tU\0'\nV\0'\vW\0'\fX\0&\t\f\tB\5\4\0016\5R\0'\aS\0'\bY\0'\tZ\0'\n[\0'\v\\\0&\t\v\tB\5\4\0016\5]\0009\5^\5'\a_\0B\5\2\0012\0\0ÄK\0\1\0Ñ\6      \" gray\n      highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080\n      \" blue\n      highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6\n      highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6\n      \" light blue\n      highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE\n      highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE\n      highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE\n      \" pink\n      highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0\n      highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0\n      \" front\n      highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4\n      highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4\n      highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4\n    \bcmd\bvim\t } }?{ name = \"look\", keyword_length = 5, max_item_count = 10 }1lua require\"cmp\".setup.buffer { sources = { \23gitcommit,markdown\b}})K{ name = \"nvim_lsp\", trigger_characters = {\".\"}, max_item_count = 20 }\27{ name = \"nvim_lua\" },0lua require\"cmp\".setup.buffer({ sources = {\blua\rfiletype\aau\1\0\1\tname\17fuzzy_buffer\1\0\0\1\0\1\16completeopt#menu,menuone,noinsert,noselect\6/\fcmdline\0\17confirm_done\aon\nevent\f<S-Tab>\0\n<Tab>\0\t<CR>\0\v<Down>\0\t<Up>\0\n<C-p>\1\3\0\0\6i\6s\1\0\0\21select_prev_item\n<C-n>\1\3\0\0\6i\6s\rbehavior\1\0\0\vInsert\19SelectBehavior\21select_next_item\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\15formatting\vformat\0\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsources\1\0\2\tname\tpath\rpriority\3\1\1\0\3\tname\vbuffer\19keyword_length\3\2\19max_item_count\3\n\1\0\3\tname\rnvim_lsp\19keyword_length\3\1\19max_item_count\3\20\fsorting\16comparators\1\0\0\norder\14sort_text\tkind\nscore\nexact\voffset\vlength\fcompare\vconfig\fsnippet\vexpand\1\0\0\0\17experimental\1\0\2\15ghost_text\1\16native_menu\1\vwindow\18documentation\1\0\0\1\t\0\0\b‚îÄ\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚îÄ\b‚Üí\1\0\0\vborder\1\0\2\17winhighlightONormal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None\14scrollbar\b‚ïë\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\15completion\1\0\0\1\0\1\16completeopt\26menu,menuone,noinsert\nsetup\0\0\flspkind\23CompletionItemKind\blsp\bcmp\frequire\0" },
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
  ["nvim-lsp-installer"] = {
    config = { "\27LJ\2\n°\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\1\27automatic_installation\2\1\5\0\0\16sumneko_lua\vjsonls\rtsserver\rls_emmet\nsetup\23nvim-lsp-installer\frequire\0" },
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
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\topen\fspectre\frequire∫\2\1\0\4\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0003\3\b\0B\0\3\1K\0\1\0\0\fReplace\15addCommand\14highlight\1\0\3\vsearch\15DiffDelete\freplace\15DiffChange\aui\vString\1\0\4\rline_sep1‚îî-----------------------------------------\19result_padding\t¬¶  \19line_sep_start1‚îå-----------------------------------------\19color_devicons\2\nsetup\fspectre\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/nvim-spectre",
    url = "https://github.com/windwp/nvim-spectre"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nó\5\0\0\6\0\26\0\"6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0025\1\a\0005\2\4\0005\3\5\0=\3\6\2=\2\b\1=\1\3\0006\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\v\0005\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\0044\5\0\0=\5\22\0045\5\23\0=\5\24\4=\4\25\3B\1\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\venable\2\19goto_right_end\1\19highlight_self\1\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\26context_commentstring\1\0\2\venable\2\19enable_autocmd\2\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\2\0\0\fhaskell\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\17install_info\1\0\0\nfiles\1\2\0\0\17src/parser.c\1\0\2\vbranch\tmain\burl5https://github.com/NTBBloodbath/tree-sitter-http\thttp\23get_parser_configs\28nvim-treesitter.parsers\frequire\0" },
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
    config = { "\27LJ\2\n)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\1¿\14git_filesR\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\2\vhidden\2\14no_ignore\2\nmerge\15find_files)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\14live_grep(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreW\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\14live_grep+\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\16grep_string(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreY\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\16grep_stringK\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\18sort_lastused\2\nmerge\fbuffersG\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\rcmd_only\2\nmerge\roldfilesª\5\1\0\b\0$\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\b\0'\2\5\0B\0\2\0016\0\0\0'\2\t\0B\0\2\0025\1\n\0005\2\v\0=\2\f\0015\2\r\0005\3\14\0=\3\f\0026\3\15\0'\5\16\0'\6\17\0003\a\18\0B\3\4\0016\3\15\0'\5\16\0'\6\19\0003\a\20\0B\3\4\0016\3\15\0'\5\16\0'\6\21\0003\a\22\0B\3\4\0016\3\15\0'\5\16\0'\6\23\0003\a\24\0B\3\4\0016\3\15\0'\5\16\0'\6\25\0003\a\26\0B\3\4\0016\3\15\0'\5\16\0'\6\27\0003\a\28\0B\3\4\0016\3\15\0'\5\16\0'\6\29\0003\a\30\0B\3\4\0016\3\15\0'\5\16\0'\6\31\0003\a \0B\3\4\0016\3!\0'\5\"\0005\6#\0B\3\3\0012\0\0ÄK\0\1\0\1\0\1\nguibg\tnone\20TelescopeNormal\ahi\0\agh\0\agb\0\agO\0\ago\0\agC\0\agc\0\agF\0\agf\6n\bmap\1\0\2\vheight\4Õô≥Ê\fÃô≥ˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\1\0\1\20layout_strategy\rvertical\18layout_config\1\0\4\vheight\4Õô≥Ê\fÃô≥ˇ\3\18preview_width\4ö≥ÊÃ\tô≥Ê˛\3\vmirror\1\nwidth\4Õô≥Ê\fÃô≥ˇ\3\1\0\1\20layout_strategy\15horizontal\22telescope.builtin\19load_extension\15extensions\1\0\0\bfzf\1\0\0\1\0\4\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\14case_mode\15smart_case\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nx\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\25use_diagnostic_signs\2\15auto_close\2\tmode\25document_diagnostics\nsetup\ftrouble\frequire\0" },
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
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
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
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: markdown-preview.nvim
time([[Setup for markdown-preview.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\rmarkdown\19mkdp_filetypes\6g\bvim\0", "setup", "markdown-preview.nvim")
time([[Setup for markdown-preview.nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n|\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vwindow\1\0\1\nblend\3\0\ttext\1\0\0\1\0\1\fspinner\19dots_scrolling\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: vim-dotenv
time([[Config for vim-dotenv]], true)
try_loadstring("\27LJ\2\n]\0\0\5\0\5\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\4\0'\3\2\0'\4\3\0B\0\4\1K\0\1\0\17BufWritePost\16Dotenv .env\t.env\rVimEnter\aau\0", "config", "vim-dotenv")
time([[Config for vim-dotenv]], false)
-- Config for: vim-vsnip
time([[Config for vim-vsnip]], true)
try_loadstring("\27LJ\2\nx\0\0\4\0\a\0\f6\0\0\0+\1\1\0=\1\1\0006\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0K\0\1\0\v/vsnip\vconfig\fstdpath\afn\22vsnip_snippet_dir\24vsnip_extra_mapping\6g\0", "config", "vim-vsnip")
time([[Config for vim-vsnip]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nx\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\25use_diagnostic_signs\2\15auto_close\2\tmode\25document_diagnostics\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nY\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0+\2\0\0005\3\3\0B\0\3\1K\0\1\0\1\0\2\nnames\1\tmode\15foreground\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: hlargs.nvim
time([[Config for hlargs.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vhlargs\frequire\0", "config", "hlargs.nvim")
time([[Config for hlargs.nvim]], false)
-- Config for: vim-abolish
time([[Config for vim-abolish]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\26cnoreabbrev S Subvert\28cnoreabbrev %S %Subvert\bcmd\0", "config", "vim-abolish")
time([[Config for vim-abolish]], false)
-- Config for: vim-wordmotion
time([[Config for vim-wordmotion]], true)
try_loadstring("\27LJ\2\n4\0\0\2\0\3\0\0046\0\0\0'\1\2\0=\1\1\0K\0\1\0\r<leader>\22wordmotion_prefix\6g\0", "config", "vim-wordmotion")
time([[Config for vim-wordmotion]], false)
-- Config for: lazygit.nvim
time([[Config for lazygit.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28cnoreabbrev git LazyGit\bcmd\0", "config", "lazygit.nvim")
time([[Config for lazygit.nvim]], false)
-- Config for: vim-bufonly
time([[Config for vim-bufonly]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25cnoreabbrev bo Bonly\bcmd\0", "config", "vim-bufonly")
time([[Config for vim-bufonly]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\n`\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\2B\0\2\1K\0\1\0\vconfig\26alpha.themes.startify\nsetup\nalpha\frequire\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: stabilize.nvim
time([[Config for stabilize.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0", "config", "stabilize.nvim")
time([[Config for stabilize.nvim]], false)
-- Config for: nvim-lsp-installer
time([[Config for nvim-lsp-installer]], true)
try_loadstring("\27LJ\2\n°\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\1\27automatic_installation\2\1\5\0\0\16sumneko_lua\vjsonls\rtsserver\rls_emmet\nsetup\23nvim-lsp-installer\frequire\0", "config", "nvim-lsp-installer")
time([[Config for nvim-lsp-installer]], false)
-- Config for: bufresize.nvim
time([[Config for bufresize.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14bufresize\frequire\0", "config", "bufresize.nvim")
time([[Config for bufresize.nvim]], false)
-- Config for: vim-subversive
time([[Config for vim-subversive]], true)
try_loadstring("\27LJ\2\nÀ\2\0\0\5\0\6\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0ç\1:<c-u>call subversive#singleMotion#substituteLineSetup(v:register, v:count)<cr>:set opfunc=subversive#singleMotion#substituteLine<cr>g@l\ammÜ\1:<c-u>call subversive#singleMotion#preSubstitute(v:register, 0, '')<cr>:set opfunc=subversive#singleMotion#substituteMotion<cr>g@\6m\6n\bmap\0", "config", "vim-subversive")
time([[Config for vim-subversive]], false)
-- Config for: packer.nvim
time([[Config for packer.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27command! PS PackerSync\bcmd\0", "config", "packer.nvim")
time([[Config for packer.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 \18\0\0\1\0\1\0\2'\0\0\0L\0\2\0\aonˆ\2\0\0\14\0\19\0025'\0\0\0006\1\1\0009\1\2\0019\1\3\1)\3\0\0'\4\4\0B\1\3\0026\2\1\0009\2\5\0029\2\6\2B\2\1\0026\3\a\0\18\5\2\0B\3\2\2\v\3\0\0X\3\1ÄL\0\2\0004\3\0\0006\4\b\0\18\6\2\0B\4\2\4X\a\17Ä9\t\t\b9\t\n\t\15\0\t\0X\n\rÄ6\n\1\0009\n\v\n9\n\f\n\18\f\t\0\18\r\1\0B\n\3\2\b\n\0\0X\n\5Ä6\n\r\0009\n\14\n\18\f\3\0009\r\15\bB\n\3\1E\a\3\3R\aÌ\1276\4\1\0009\4\16\4\18\6\3\0B\4\2\2\t\4\1\0X\4\1ÄL\0\2\0006\4\r\0009\4\17\4\18\6\3\0'\a\18\0D\4\3\0\6|\vconcat\14tbl_count\tname\vinsert\ntable\nindex\afn\14filetypes\vconfig\vipairs\tnext\23get_active_clients\blsp\rfiletype\24nvim_buf_get_option\bapi\bvim\18No Active Lsp˛ˇˇˇ\31\0˜\f\1\0\v\0L\0ó\0016\0\0\0'\2\1\0B\0\2\0025\1\2\0005\2\5\0003\3\3\0>\3\1\0025\3\4\0=\3\6\0025\3\b\0009\4\a\1=\4\a\3=\3\t\0029\3\n\0005\5\23\0005\6\v\0005\a\15\0005\b\r\0005\t\f\0=\t\14\b=\b\16\a=\a\17\0065\a\18\0=\a\19\0065\a\20\0=\a\21\0064\a\0\0=\a\22\6=\6\24\0055\6\25\0004\a\0\0=\a\26\0064\a\0\0=\a\27\0064\a\v\0>\2\1\a5\b\28\0005\t\29\0=\t\6\b>\b\2\a>\2\3\a5\b\30\0005\t\31\0=\t \b5\t\"\0009\n!\1=\n#\t9\n\a\1=\n\a\t=\t\t\b5\t$\0=\t\6\b>\b\4\a>\2\5\a5\b(\0003\t%\0>\t\1\b5\t'\0009\n&\1=\n#\t9\n\a\1=\n\a\t=\t\t\b5\t)\0=\t\6\b>\b\6\a>\2\a\a5\b*\0005\t+\0=\t\6\b5\t-\0009\n,\1=\n#\t9\n\a\1=\n\a\t=\t\t\b>\b\b\a>\2\t\a5\b.\0005\t/\0009\n,\1=\n#\t9\n\a\1=\n\a\t=\t\t\b5\t0\0=\t\6\b>\b\n\a=\a1\0064\a\0\0=\a2\0064\a\0\0=\a3\0064\a\5\0005\b4\0005\t5\0=\t6\b5\t7\0=\t8\b5\t9\0009\n,\1=\n:\t9\n;\1=\n<\t=\t=\b5\t>\0=\t \b5\t?\0=\t\6\b5\t@\0009\n\a\1=\n\a\t=\t\t\b>\b\1\a>\2\2\a5\bB\0003\tA\0>\t\1\b5\tC\0009\n&\1=\n#\t9\n\a\1=\n\a\t=\t\t\b5\tD\0=\t\6\b>\b\3\a5\bE\0>\b\4\a=\aF\6=\0068\0055\6G\0004\a\0\0=\a\26\0064\a\0\0=\a\27\0064\a\0\0=\a1\0064\a\0\0=\a2\0064\a\0\0=\a3\0064\a\0\0=\aF\6=\6H\0054\6\0\0=\6I\0055\6J\0=\6K\5B\3\2\1K\0\1\0\15extensions\1\5\0\0\14nvim-tree\rfugitive\rquickfix\15toggleterm\ftabline\22inactive_sections\1\0\0\14lualine_z\1\2\0\0\n%l:%c\1\0\2\tleft\3\0\nright\3\0\1\0\1\bgui\vitalic\1\0\1\ticon\tÔÇÖ \0\1\0\0\1\0\2\tleft\3\0\nright\3\0\1\0\2\nerror\tÔÅó \twarn\tÔÅ± \22diagnostics_color\15color_warn\vyellow\16color_error\1\0\0\rsections\1\3\0\0\nerror\twarn\fsources\1\2\0\0\rnvim_lsp\1\2\3\0\16diagnostics\21update_in_insert\1\19always_visible\2\fcolored\2\14lualine_y\14lualine_x\14lualine_c\1\0\2\tleft\3\0\nright\3\0\1\0\0\1\2\1\0\tdiff\ticon\bÔëø\1\0\1\bgui\vitalic\bred\1\0\2\tleft\3\0\nright\3\0\1\2\1\0\vbranch\ticon\bÔëø\1\0\2\tleft\3\0\nright\3\0\1\0\0\1\0\0\tblue\0\1\0\2\tleft\3\0\nright\3\0\afg\1\0\1\bgui\vitalic\ngreen\fsymbols\1\0\3\funnamed\14[No Name]\rmodified\b[+]\rreadonly\tüîí\1\2\3\0\rfilename\20shorting_target\3(\16file_status\2\tpath\3\1\1\0\2\tleft\3\0\nright\3\0\1\2\2\0\rfiletype\fcolored\2\14icon_only\2\14lualine_b\14lualine_a\1\0\0\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\tleft\5\nright\5\25component_separators\1\0\2\tleft\5\nright\5\ntheme\vnormal\1\0\0\6c\1\0\0\1\0\1\abg\tnone\1\0\3\17globalstatus\2\25always_divide_middle\2\18icons_enabled\2\nsetup\ncolor\1\0\0\abg\fpadding\1\0\0\1\0\2\tleft\3\0\nright\3\0\0\1\0\5\vyellow\f#EBCB8B\tblue\f#81A1C1\abg\tnone\ngreen\f#A3BE8C\bred\f#D57780\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nó\5\0\0\6\0\26\0\"6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0025\1\a\0005\2\4\0005\3\5\0=\3\6\2=\2\b\1=\1\3\0006\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\v\0005\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\0044\5\0\0=\5\22\0045\5\23\0=\5\24\4=\4\25\3B\1\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\venable\2\19goto_right_end\1\19highlight_self\1\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\26context_commentstring\1\0\2\venable\2\19enable_autocmd\2\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\2\0\0\fhaskell\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\17install_info\1\0\0\nfiles\1\2\0\0\17src/parser.c\1\0\2\vbranch\tmain\burl5https://github.com/NTBBloodbath/tree-sitter-http\thttp\23get_parser_configs\28nvim-treesitter.parsers\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\1¿\14git_filesR\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\2\vhidden\2\14no_ignore\2\nmerge\15find_files)\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\14live_grep(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreW\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\14live_grep+\0\0\3\2\1\0\5-\0\0\0009\0\0\0-\2\1\0B\0\2\1K\0\1\0\0¿\2¿\16grep_string(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\3\0\0\r--hidden\16--no-ignoreY\1\0\a\2\5\0\n-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\3\0003\6\2\0=\6\4\5B\2\3\0A\0\0\1K\0\1\0\0¿\2¿\20additional_args\1\0\0\0\nmerge\16grep_stringK\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\18sort_lastused\2\nmerge\fbuffersG\0\0\6\2\3\0\b-\0\0\0009\0\0\0006\2\1\0-\4\1\0005\5\2\0B\2\3\0A\0\0\1K\0\1\0\0¿\1¿\1\0\1\rcmd_only\2\nmerge\roldfilesª\5\1\0\b\0$\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\b\0'\2\5\0B\0\2\0016\0\0\0'\2\t\0B\0\2\0025\1\n\0005\2\v\0=\2\f\0015\2\r\0005\3\14\0=\3\f\0026\3\15\0'\5\16\0'\6\17\0003\a\18\0B\3\4\0016\3\15\0'\5\16\0'\6\19\0003\a\20\0B\3\4\0016\3\15\0'\5\16\0'\6\21\0003\a\22\0B\3\4\0016\3\15\0'\5\16\0'\6\23\0003\a\24\0B\3\4\0016\3\15\0'\5\16\0'\6\25\0003\a\26\0B\3\4\0016\3\15\0'\5\16\0'\6\27\0003\a\28\0B\3\4\0016\3\15\0'\5\16\0'\6\29\0003\a\30\0B\3\4\0016\3\15\0'\5\16\0'\6\31\0003\a \0B\3\4\0016\3!\0'\5\"\0005\6#\0B\3\3\0012\0\0ÄK\0\1\0\1\0\1\nguibg\tnone\20TelescopeNormal\ahi\0\agh\0\agb\0\agO\0\ago\0\agC\0\agc\0\agF\0\agf\6n\bmap\1\0\2\vheight\4Õô≥Ê\fÃô≥ˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\1\0\1\20layout_strategy\rvertical\18layout_config\1\0\4\vheight\4Õô≥Ê\fÃô≥ˇ\3\18preview_width\4ö≥ÊÃ\tô≥Ê˛\3\vmirror\1\nwidth\4Õô≥Ê\fÃô≥ˇ\3\1\0\1\20layout_strategy\15horizontal\22telescope.builtin\19load_extension\15extensions\1\0\0\bfzf\1\0\0\1\0\4\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\14case_mode\15smart_case\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: vim-bbye
time([[Config for vim-bbye]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27cnoreabbrev bd Bdelete\bcmd\0", "config", "vim-bbye")
time([[Config for vim-bbye]], false)
-- Config for: nvim-lastplace
time([[Config for nvim-lastplace]], true)
try_loadstring("\27LJ\2\n⁄\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\30lastplace_ignore_filetype\1\5\0\0\14gitcommit\14gitrebase\bsvn\rhgcommit\29lastplace_ignore_buftype\1\0\1\25lastplace_open_folds\2\1\4\0\0\rquickfix\vnofile\thelp\nsetup\19nvim-lastplace\frequire\0", "config", "nvim-lastplace")
time([[Config for nvim-lastplace]], false)
-- Config for: FTerm.nvim
time([[Config for FTerm.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vtoggle\nFTerm\frequireÍ\1\1\0\5\0\f\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0'\3\b\0003\4\t\0B\0\4\0016\0\6\0'\2\n\0'\3\b\0'\4\v\0B\0\4\1K\0\1\0005<c-\\><c-n><CMD>lua require('FTerm').toggle()<CR>\6t\0\n<F11>\6n\bmap\15dimensions\1\0\2\vheight\4ÆèÖ◊\aî‹æˇ\3\nwidth\4ÆèÖ◊\aî‹æˇ\3\1\0\1\vborder\frounded\nsetup\nFTerm\frequire\0", "config", "FTerm.nvim")
time([[Config for FTerm.nvim]], false)
-- Config for: cokeline.nvim
time([[Config for cokeline.nvim]], true)
try_loadstring("\27LJ\2\nJ\0\1\4\0\3\0\t6\1\0\0009\3\1\0B\1\2\2\15\0\1\0X\2\3Ä6\1\0\0009\3\2\0B\1\2\2L\1\2\0\rfilename\tpath\21isNonEmptyString?\0\1\5\1\3\0\b9\1\0\0\14\0\1\0X\1\4Ä-\1\0\0'\3\1\0'\4\2\0D\1\3\0K\0\1\0\0¿\afg\fComment\15is_focused \0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ticon\fdevicon!\0\1\2\0\2\0\0039\1\0\0009\1\1\1L\1\2\0\ncolor\fdevicon.\0\1\3\0\2\0\0049\1\0\0009\2\1\0&\1\2\1L\1\2\0\rfilename\18unique_prefixZ\0\1\2\0\4\0\v9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0009\1\2\0\15\0\1\0X\2\2Ä'\1\3\0L\1\2\0K\0\1\0\f#EBCB8B\16is_modified\f#B988B0\15is_focused8\0\1\2\0\2\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0+\1\0\0L\1\2\0\14underline\15is_focused6\0\1\2\0\3\0\a9\1\0\0\15\0\1\0X\2\2Ä'\1\1\0L\1\2\0'\1\2\0L\1\2\0\5\n üîí\16is_readonlyÜ\4\1\0\b\0#\00076\0\0\0'\2\1\0B\0\2\0029\0\2\0005\1\3\0006\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\a\0005\5\6\0=\5\b\0045\5\n\0003\6\t\0=\6\v\5=\5\f\0045\5\r\0003\6\14\0=\6\15\5=\5\16\0044\5\6\0>\1\1\0055\6\18\0003\a\17\0=\a\19\0063\a\20\0=\a\15\6>\6\2\0055\6\22\0003\a\21\0=\a\19\0063\a\23\0=\a\15\0063\a\24\0=\a\25\6>\6\3\0055\6\27\0003\a\26\0=\a\19\6>\6\4\5>\1\5\5=\5\28\4B\2\2\0016\2\29\0'\4\30\0B\2\2\0016\2\29\0'\4\31\0B\2\2\0016\2 \0'\4!\0005\5\"\0B\2\3\0012\0\0ÄK\0\1\0\1\0\1\nguibg\tnone\16tablinefill\ahi.nmap <S-Down> <Plug>(cokeline-focus-prev),nmap <S-Up> <Plug>(cokeline-focus-next)\bcmd\15components\1\0\0\0\nstyle\0\0\1\0\0\0\0\ttext\1\0\0\0\15default_hl\afg\0\1\0\1\abg\tnone\fbuffers\17filter_valid\1\0\0\0\rmappings\1\0\0\1\0\1\20cycle_prev_next\2\nsetup\rcokeline\1\0\1\ttext\6 \fget_hex\19cokeline/utils\frequire\0", "config", "cokeline.nvim")
time([[Config for cokeline.nvim]], false)
-- Config for: vim-terraform
time([[Config for vim-terraform]], true)
try_loadstring("\27LJ\2\nS\0\0\2\0\3\0\a6\0\0\0)\1\1\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0K\0\1\0\26terraform_fmt_on_save\28terraform_fold_sections\6g\0", "config", "vim-terraform")
time([[Config for vim-terraform]], false)
-- Config for: FixCursorHold.nvim
time([[Config for FixCursorHold.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1»\0=\1\2\0K\0\1\0\26cursorhold_updatetime\6g\bvim\0", "config", "FixCursorHold.nvim")
time([[Config for FixCursorHold.nvim]], false)
-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
-- Config for: obvious-resize
time([[Config for obvious-resize]], true)
try_loadstring("\27LJ\2\nß\2\0\0\5\0\r\0\0276\0\0\0)\1\4\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0006\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\3\0'\2\4\0'\3\a\0'\4\b\0B\0\4\0016\0\3\0'\2\4\0'\3\t\0'\4\n\0B\0\4\0016\0\3\0'\2\4\0'\3\v\0'\4\f\0B\0\4\1K\0\1\0\28:ObviousResizeRight<cr>\14<c-right>\27:ObviousResizeLeft<cr>\r<c-left>\27:ObviousResizeDown<cr>\r<c-down>\25:ObviousResizeUp<cr>\v<c-up>\5\bmap\28obvious_resize_run_tmux\27obvious_resize_default\6g\0", "config", "obvious-resize")
time([[Config for obvious-resize]], false)
-- Config for: Navigator.nvim
time([[Config for Navigator.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tleft\14Navigator\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tdown\14Navigator\frequire4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\aup\14Navigator\frequire7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nright\14Navigator\frequire“\1\1\0\5\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0'\2\5\0'\3\6\0003\4\a\0B\0\4\0016\0\4\0'\2\5\0'\3\b\0003\4\t\0B\0\4\0016\0\4\0'\2\5\0'\3\n\0003\4\v\0B\0\4\0016\0\4\0'\2\5\0'\3\f\0003\4\r\0B\0\4\1K\0\1\0\0\n<c-l>\0\n<c-k>\0\n<c-j>\0\n<c-h>\5\bmap\1\0\2\14auto_save\fcurrent\20disable_on_zoom\1\nsetup\14Navigator\frequire\0", "config", "Navigator.nvim")
time([[Config for Navigator.nvim]], false)
-- Config for: lightspeed.nvim
time([[Config for lightspeed.nvim]], true)
try_loadstring("\27LJ\2\n~\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\25jump_to_unique_chars\1\0\1\19safety_timeout\3ê\3\1\0\1\16ignore_case\2\nsetup\15lightspeed\frequire\0", "config", "lightspeed.nvim")
time([[Config for lightspeed.nvim]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\n∞\1\0\1\b\0\14\2\0246\1\0\0009\1\1\0019\1\2\0019\3\3\0'\4\4\0B\1\3\0026\2\5\0009\2\6\2\18\4\1\0B\2\2\2\22\2\0\0025\3\t\0006\4\a\0009\4\b\4\18\6\2\0)\a2\0B\4\3\2=\4\n\0036\4\0\0009\4\v\0049\4\f\4\23\4\1\4=\4\r\3L\3\2\0\vheight\nlines\6o\nwidth\1\0\0\bmax\tmath\blen\vstring\a:~\tpath\16fnamemodify\afn\bvim\b\fë\f\1\0\a\0+\00096\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\18\0005\5\17\0=\5\19\4=\4\20\3=\3\21\0025\3\23\0005\4\22\0=\4\24\3=\3\25\0024\3\0\0=\3\26\0025\3\31\0005\4\27\0005\5\28\0=\5\29\0044\5\0\0=\5\30\4=\4 \0035\4&\0005\5\"\0005\6!\0=\6#\0053\6$\0=\6%\5=\5'\0045\5(\0=\5\24\4=\4\25\3=\3)\0024\3\0\0=\3*\0024\3\0\0=\3\20\2B\0\2\1K\0\1\0\fbuffers\15filesystem\1\0\5\6H\18toggle_hidden\n<c-x>\17clear_filter\6f\21filter_on_submit\6/\tnoop\6.\rset_root\npopup\1\0\0\tsize\0\rposition\1\0\0\1\0\2\bcol\t100%\brow\0062\19filtered_items\1\0\3\27use_libuv_file_watcher\2\24follow_current_file\1\26hijack_netrw_behavior\rdisabled\15never_show\17hide_by_name\1\3\0\0\14.DS_Store\14thumbs.db\1\0\3\20hide_gitignored\2\18hide_dotfiles\1\fvisible\1\18nesting_rules\vwindow\rmappings\1\0\0\1\0\18\t<cr>\topen\6m\tmove\6d\vdelete\t<bs>\15close_node\6c\tcopy\6r\vrename\6t\16open_tabnew\6x\21cut_to_clipboard\6y\22copy_to_clipboard\6A\18add_directory\6s\15open_split\6v\16open_vsplit\6a\badd\6p\25paste_from_clipboard\6z\tnoop\6q\17close_window\6R\frefresh\6C\tnoop\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\fdeleted\b‚úñ\nadded\5\rconflict\bÓúß\vstaged\bÔÅÜ\runstaged\bÔò∞\fignored\bÔë¥\14untracked\bÔÑ®\rmodified\5\frenamed\bÔïî\tname\1\0\2\26use_git_status_colors\2\19trailing_slash\1\rmodified\1\0\2\vsymbol\b[+]\14highlight\20NeoTreeModified\ticon\1\0\4\17folder_empty\bÔ∞ä\16folder_open\bÓóæ\fdefault\6*\18folder_closed\bÓóø\vindent\1\0\0\1\0\t\14highlight\24NeoTreeIndentMarker\23expander_collapsed\bÔë†\23last_indent_marker\b‚îî\18indent_marker\b‚îÇ\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\22expander_expanded\bÔëº\1\0\4\23enable_diagnostics\1\22enable_git_status\2\23popup_border_style\frounded\25close_if_last_window\1\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 3 nmap <c-f> :Neotree position=float reveal<cr>\bcmd\bvim\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nè\1\0\0\6\0\a\2\0266\0\0\0009\0\1\0'\2\2\0B\0\2\2\23\0\0\0\b\0\1\0X\1\17Ä6\1\0\0009\1\3\1'\3\2\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\2\0]\0\2\n\0\4\0\0186\2\0\0009\2\1\2\18\4\0\0B\2\2\2!\2\2\1'\3\2\0)\4\1\0\18\5\2\0)\6\1\0M\4\4Ä\18\b\3\0'\t\3\0&\3\t\bO\4¸\127\18\4\0\0\18\5\3\0&\4\5\4L\4\2\0\6 \5\blen\vstring;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimÔ\1\0\2\b\2\a\0\0225\2\0\0009\3\1\0009\3\2\0038\3\3\2\v\3\0\0X\4\2Ä=\3\3\1X\4\aÄ-\4\0\0009\6\4\1)\a\b\0B\4\3\2\18\5\3\0&\4\5\4=\4\3\1-\4\1\0009\4\5\0049\6\4\0015\a\6\0B\4\3\2=\4\4\1L\1\2\0\4¿\2¿\1\0\1\14with_text\1\rsymbolic\tkind\tmenu\tname\vsource\1\0\6\rnvim_lsp\n|lsp|\rnvim_lua\n|api|\tpath\n|pth|\15fuzzy_path\v|fpth|\17fuzzy_buffer\v|fbuf|\vbuffer\n|buf|Õ\1\0\1\t\2\t\0\30-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\2\0009\1\3\0019\1\4\0016\3\2\0009\3\5\0039\3\6\3'\5\a\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\b\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\5\t<Up>\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\21select_prev_item\fvisibleœ\1\0\1\t\2\t\0\30-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\2\0009\1\3\0019\1\4\0016\3\2\0009\3\5\0039\3\6\3'\5\a\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\b\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\5\v<Down>\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\21select_next_item\fvisiblee\0\1\4\1\5\0\f-\1\0\0009\1\0\0015\3\1\0B\1\2\2\14\0\1\0X\1\5Ä6\1\2\0'\3\3\0B\1\2\0029\1\4\1B\1\1\1K\0\1\0\0¿\ttype\16pairs.enter\frequire\1\0\1\vselect\1\fconfirmÃ\2\0\1\t\2\v\00126\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\29Ä-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\20Ä-\1\1\0B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\n\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\3¿\n<Tab>\21select_next_item\fvisible\5!<Plug>(vsnip-expand-or-jump)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2˜\1\0\1\t\1\n\1 6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\vÄ-\1\0\0009\1\b\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\t\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisible\5\28<Plug>(vsnip-jump-prev)\27nvim_replace_termcodes\bapi\rfeedkeys\20vsnip#available\afn\bvim\2Ó\1\0\1\6\1\v\0\0319\1\0\0\18\3\1\0009\1\1\1B\1\2\0029\2\2\1\15\0\2\0X\3\4Ä9\2\2\0019\2\3\2\14\0\2\0X\3\1Ä+\2\1\0\14\0\2\0X\3\16Ä9\3\4\1-\4\0\0009\4\5\4\4\3\4\0X\3\5Ä9\3\4\1-\4\0\0009\4\6\4\5\3\4\0X\3\6Ä6\3\a\0'\5\b\0B\3\2\0029\3\t\3'\5\n\0B\3\2\1K\0\1\0\1¿\6(\14type_left\18pairs.bracket\frequire\rFunction\vMethod\tkind\23funcParensDisabled\tdata\24get_completion_item\nentry \20\1\0\15\0`\0£\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0016\2\0\0'\4\4\0B\2\2\0023\3\5\0003\4\6\0009\5\a\0005\a\t\0005\b\b\0=\b\n\a5\b\14\0005\t\f\0005\n\v\0=\n\r\t=\t\n\b5\t\16\0005\n\15\0=\n\r\t=\t\17\b=\b\18\a5\b\19\0=\b\20\a5\b\22\0003\t\21\0=\t\23\b=\b\24\a5\b\"\0004\t\b\0009\n\25\0009\n\26\n9\n\27\n>\n\1\t9\n\25\0009\n\26\n9\n\28\n>\n\2\t9\n\25\0009\n\26\n9\n\29\n>\n\3\t9\n\25\0009\n\26\n9\n\30\n>\n\4\t9\n\25\0009\n\26\n9\n\31\n>\n\5\t9\n\25\0009\n\26\n9\n \n>\n\6\t9\n\25\0009\n\26\n9\n!\n>\n\a\t=\t#\b=\b$\a4\b\4\0005\t%\0>\t\1\b5\t&\0>\t\2\b5\t'\0>\t\3\b=\b(\a5\b*\0005\t)\0=\t+\b3\t,\0=\t-\b=\b.\a5\b1\0009\t/\0009\t0\t)\v¸ˇB\t\2\2=\t2\b9\t/\0009\t0\t)\v\4\0B\t\2\2=\t3\b9\t/\0009\v/\0009\v4\v5\r7\0009\0145\0009\0146\14=\0148\rB\v\2\0025\f9\0B\t\3\2=\t:\b9\t/\0009\v/\0009\v;\v5\r<\0009\0145\0009\0146\14=\0148\rB\v\2\0025\f=\0B\t\3\2=\t>\b3\t?\0=\t@\b3\tA\0=\tB\b9\t/\0003\vC\0B\t\2\2=\tD\b3\tE\0=\tF\b3\tG\0=\tH\b=\b/\aB\5\2\0019\5I\0\18\a\5\0009\5J\5'\bK\0003\tL\0B\5\4\0019\5\a\0009\5M\5'\aN\0005\bP\0005\tO\0=\t\n\b4\t\3\0005\nQ\0>\n\1\t=\t(\bB\5\3\0016\5R\0'\aS\0'\bT\0'\tU\0'\nV\0'\vW\0'\fX\0&\t\f\tB\5\4\0016\5R\0'\aS\0'\bY\0'\tZ\0'\n[\0'\v\\\0&\t\v\tB\5\4\0016\5]\0009\5^\5'\a_\0B\5\2\0012\0\0ÄK\0\1\0Ñ\6      \" gray\n      highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080\n      \" blue\n      highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6\n      highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6\n      \" light blue\n      highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE\n      highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE\n      highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE\n      \" pink\n      highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0\n      highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0\n      \" front\n      highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4\n      highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4\n      highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4\n    \bcmd\bvim\t } }?{ name = \"look\", keyword_length = 5, max_item_count = 10 }1lua require\"cmp\".setup.buffer { sources = { \23gitcommit,markdown\b}})K{ name = \"nvim_lsp\", trigger_characters = {\".\"}, max_item_count = 20 }\27{ name = \"nvim_lua\" },0lua require\"cmp\".setup.buffer({ sources = {\blua\rfiletype\aau\1\0\1\tname\17fuzzy_buffer\1\0\0\1\0\1\16completeopt#menu,menuone,noinsert,noselect\6/\fcmdline\0\17confirm_done\aon\nevent\f<S-Tab>\0\n<Tab>\0\t<CR>\0\v<Down>\0\t<Up>\0\n<C-p>\1\3\0\0\6i\6s\1\0\0\21select_prev_item\n<C-n>\1\3\0\0\6i\6s\rbehavior\1\0\0\vInsert\19SelectBehavior\21select_next_item\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\15formatting\vformat\0\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsources\1\0\2\tname\tpath\rpriority\3\1\1\0\3\tname\vbuffer\19keyword_length\3\2\19max_item_count\3\n\1\0\3\tname\rnvim_lsp\19keyword_length\3\1\19max_item_count\3\20\fsorting\16comparators\1\0\0\norder\14sort_text\tkind\nscore\nexact\voffset\vlength\fcompare\vconfig\fsnippet\vexpand\1\0\0\0\17experimental\1\0\2\15ghost_text\1\16native_menu\1\vwindow\18documentation\1\0\0\1\t\0\0\b‚îÄ\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚îÄ\b‚Üí\1\0\0\vborder\1\0\2\17winhighlightONormal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None\14scrollbar\b‚ïë\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\15completion\1\0\0\1\0\1\16completeopt\26menu,menuone,noinsert\nsetup\0\0\flspkind\23CompletionItemKind\blsp\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: commented.nvim
time([[Config for commented.nvim]], true)
try_loadstring("\27LJ\2\n©\1\0\0\a\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\a\0005\3\5\0006\4\0\0'\6\3\0B\4\2\0029\4\4\4=\4\6\3=\3\b\2B\0\2\1K\0\1\0\nhooks\1\0\0\19before_comment\1\0\0\25update_commentstring&ts_context_commentstring.internal\nsetup\14commented\frequire\0", "config", "commented.nvim")
time([[Config for commented.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CodeActionMenu lua require("packer.load")({'nvim-code-action-menu'}, { cmd = "CodeActionMenu", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Replace lua require("packer.load")({'nvim-spectre'}, { cmd = "Replace", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
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
