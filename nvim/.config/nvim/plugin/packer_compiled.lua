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
  local success, result = pcall(loadstring(s))
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
  ["Navigator.nvim"] = {
    config = { "\27LJ\2\nÒ\2\0\0\5\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0'\2\5\0'\3\6\0'\4\a\0B\0\4\0016\0\4\0'\2\5\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0'\2\5\0'\3\n\0'\4\v\0B\0\4\0016\0\4\0'\2\5\0'\3\f\0'\4\r\0B\0\4\1K\0\1\0.<CMD>lua require('Navigator').right()<CR>\n<c-l>+<CMD>lua require('Navigator').up()<CR>\n<c-k>-<CMD>lua require('Navigator').down()<CR>\n<c-j>-<CMD>lua require('Navigator').left()<CR>\n<c-h>\5\bmap\1\0\2\20disable_on_zoom\1\14auto_save\fcurrent\nsetup\14Navigator\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/Navigator.nvim"
  },
  ["codi.vim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28cnoreabbrev Eval Codi!!\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/codi.vim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 X\0\0\5\0\5\1\0146\0\0\0009\0\1\0006\2\2\0009\2\0\0029\2\3\2'\4\4\0B\2\2\0A\0\0\2\b\0\0\0X\0\2Ä+\0\2\0L\0\2\0+\0\1\0L\0\2\0\b%:t\vexpand\bvim\nempty\afn\2G\0\0\3\0\3\0\f6\0\0\0009\0\1\0009\0\2\0)\2\0\0B\0\2\2)\1P\0\1\1\0\0X\1\2Ä+\1\2\0L\1\2\0+\1\1\0L\1\2\0\rwinwidth\afn\bvimW\0\0\3\0\4\0\a5\0\0\0006\1\1\0009\1\2\0019\1\3\1B\1\1\0028\1\1\0L\1\2\0\tmode\afn\bvim\1\0\4\6c\fCOMMAND\6V\vVISUAL\6i\vINSERT\6n\vNORMAL˜\1\0\0\a\1\r\0*'\0\0\0006\1\1\0009\1\2\0019\1\3\1\15\0\1\0X\2\3Ä\18\1\0\0'\2\4\0&\0\2\1-\1\0\0B\1\1\2\15\0\1\0X\2\rÄ\18\1\0\0006\2\1\0009\2\5\0029\2\6\0026\4\1\0009\4\5\0049\4\a\4'\6\b\0B\4\2\2'\5\t\0B\2\3\2&\0\2\1X\1\aÄ\18\1\0\0006\2\1\0009\2\5\0029\2\a\2'\4\n\0B\2\2\2&\0\2\0016\1\1\0009\1\2\0019\1\v\1\15\0\1\0X\2\3Ä\18\1\0\0'\2\f\0&\0\2\1L\0\2\0\5¿\n üñç\rmodified\b%:t\t:~:.\6%\vexpand\16fnamemodify\afn\tüîí\rreadonly\abo\bvim\5\20\0\0\1\0\1\0\2'\0\0\0L\0\2\0\tÔû£ ´\f\1\0\r\0D\0ã\0015\0\0\0006\1\1\0'\3\2\0B\1\2\0029\2\3\0015\3\5\0=\3\4\0015\3\f\0005\4\a\0003\5\6\0=\5\b\0044\5\3\0009\6\t\0>\6\1\0059\6\n\0>\6\2\5=\5\v\4=\4\r\0033\4\14\0003\5\15\0004\6\5\0005\a\21\0005\b\18\0003\t\17\0=\t\b\b4\t\3\0009\n\19\0>\n\1\t9\n\20\0>\n\2\t=\t\v\b=\b\22\a>\a\1\6>\3\2\0065\a\27\0005\b\23\0004\t\3\0006\n\1\0'\f\24\0B\n\2\0029\n\25\n>\n\1\t9\n\26\0>\n\2\t=\t\v\b=\b\28\a>\a\3\0065\a\"\0005\b\30\0003\t\29\0=\t\b\b=\4\31\b4\t\3\0009\n \0>\n\1\t9\n!\0>\n\2\t=\t\v\b=\b#\a>\a\4\6=\6\16\0024\6\0\0=\6$\0024\6\a\0005\a)\0005\b&\0004\t\3\0009\n'\0>\n\1\t9\n(\0>\n\2\t=\t\v\b=\b*\a>\a\1\0065\a.\0005\b+\0004\t\3\0009\n,\0>\n\1\t9\n-\0>\n\2\t=\t\v\b=\b/\a>\a\2\0065\a3\0005\b0\0004\t\3\0009\n1\0>\n\1\t9\n2\0>\n\2\t=\t\v\b=\b4\a>\a\3\0065\a6\0005\b5\0004\t\3\0009\n1\0>\n\1\t9\n2\0>\n\2\t=\t\v\b=\b7\a>\a\4\0065\a>\0005\b9\0003\t8\0=\t\b\b6\t\1\0'\v:\0B\t\2\0029\t;\t=\t\31\b4\t\3\0009\n<\0>\n\1\t9\n=\0>\n\2\t=\t\v\b=\b?\a>\a\5\0065\aB\0005\b@\0006\t\1\0'\v:\0B\t\2\0029\t;\t=\t\31\b5\tA\0009\n<\0>\n\1\t9\n=\0>\n\2\t=\t\v\b=\bC\a>\a\6\6=\6%\0022\0\0ÄK\0\1\0\14GitBranch\1\0\0\1\4\0\0\0\0\tbold\1\0\1\rprovider\14GitBranch\fGitIcon\1\0\0\ngitBg\ngitFg\24check_git_workspace\28galaxyline.provider_vcs\1\0\0\0\19DiagnosticInfo\1\0\0\1\0\2\ticon\tÔÇ≠ \rprovider\19DiagnosticInfo\19DiagnosticHint\1\0\0\vhintBg\vhintFg\1\0\2\ticon\tÔÉ´ \rprovider\19DiagnosticHint\19DiagnosticWarn\1\0\0\14warningBg\14warningFg\1\0\2\ticon\tÔÅ± \rprovider\19DiagnosticWarn\20DiagnosticError\1\0\0\ferrorBg\ferrorFg\1\0\2\ticon\tÔÅó \rprovider\20DiagnosticError\nright\bmid\rFilePath\1\0\0\15filepathBg\15filepathFg\14condition\1\0\0\0\rFileIcon\1\0\0\15fileiconBg\24get_file_icon_color!galaxyline.provider_fileinfo\1\0\1\rprovider\rFileIcon\vViMode\1\0\0\vmodeBg\vmodeFg\1\0\0\0\tleft\0\0\nSpace\1\0\0\14highlight\fspaceBg\fspaceFg\rprovider\1\0\0\0\1\n\0\0\fLuaTree\nvista\tdbui\rstartify\tterm\rnerdtree\rfugitive\18fugitiveblame\tplug\20short_line_list\fsection\15galaxyline\frequire\1\0\19\vhintBg\tnone\fspaceFg\tnone\14warningFg\f#e7c664\14warningBg\tnone\15filepathFg\f#e5c463\ferrorFg\f#fc5d7c\ferrorBg\tnone\vinfoBg\tnone\vhintFg\f#7f8490\fspaceBg\tnone\vinfoFg\f#7f8490\vmodeBg\tnone\vlineFg\f#78dce8\vlineBg\tnone\ngitFg\f#78dce8\ngitBg\tnone\15filepathBg\tnone\15fileiconBg\tnone\vmodeFg\f#9ecd6f\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["git-blame.nvim"] = {
    config = { "\27LJ\2\nD\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1)\0à\19L\0\2\0\20show_blame_info\rgitblame\frequire]\1\0\3\0\a\0\v6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\3\0'\2\4\0B\0\2\0029\0\5\0003\2\6\0B\0\2\1K\0\1\0\0\badd\ntimer\frequire\21gitblame_enabled\6g\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/git-blame.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nÑ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\23code_action_prompt\1\0\1\venable\1\1\0\1\29use_saga_diagnostic_sign\1\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\v6\1\0\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\2\a\1\3\0X\1\2Ä+\1\1\0L\1\2\0+\1\2\0L\1\2\0\5\fbufname\afn\bvimØ\5\1\0\6\0\"\0)6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0005\5\22\0=\5\23\4=\4\24\0035\4\25\0=\4\26\3=\3\27\2B\0\2\0016\0\28\0'\2\29\0'\3\30\0'\4\31\0B\0\4\0016\0\28\0'\2\29\0'\3 \0'\4!\0B\0\4\1K\0\1\0\29:BufferLineCyclePrev<cr>\r<S-Down>\29:BufferLineCycleNext<cr>\v<S-Up>\6n\bmap\15highlights\rmodified\1\0\1\nguibg\tnone\23indicator_selected\nguifg\1\0\2\14attribute\abg\14highlight\vNormal\1\0\1\nguibg\tnone\20buffer_selected\1\0\1\nguifg\f#e5c463\14duplicate\1\0\1\nguibg\tnone\btab\1\0\1\nguibg\tnone\15background\1\0\1\nguibg\tnone\tfill\1\0\0\1\0\1\nguibg\tnone\foptions\1\0\0\18custom_filter\0\20separator_style\1\3\0\0\5\5\1\0\b\fnumbers\tnone\tview\16multiwindow\22max_prefix_length\3\0\rtab_size\3\25\20max_name_length\3#\18modified_icon\tüñç\20show_close_icon\1\28show_buffer_close_icons\1\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\nF\0\1\a\0\3\0\b6\1\0\0009\1\1\0019\1\2\1\18\3\0\0+\4\2\0+\5\2\0+\6\2\0D\1\5\0\27nvim_replace_termcodes\bapi\bvimõ\1\0\0\6\0\b\2\0286\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\18Ä6\1\0\0009\1\1\0019\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0Ó\1\0\0\3\2\b\1\"6\0\0\0009\0\1\0009\0\2\0)\2\1\0B\0\2\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\22Ä6\0\0\0009\0\1\0009\0\4\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\5\0D\0\2\0X\0\fÄ-\0\1\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0'\2\6\0D\0\2\0X\0\4Ä6\0\0\0009\0\1\0009\0\a\0D\0\1\0K\0\1\0\0¿\1¿\19compe#complete\n<Tab>\n<C-n>\15pumvisible!<Plug>(vsnip-expand-or-jump)\20vsnip#available\afn\bvim\2µ\1\0\0\3\1\a\1\0256\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\14Ä6\0\0\0009\0\1\0009\0\4\0)\2ˇˇB\0\2\2\t\0\0\0X\0\4Ä-\0\0\0'\2\5\0D\0\2\0X\0\3Ä-\0\0\0'\2\6\0D\0\2\0K\0\1\0\0¿\f<S-Tab>\28<Plug>(vsnip-jump-prev)\19vsnip#jumpable\n<C-p>\15pumvisible\afn\bvim\2Ω\t\1\0\b\0004\1V6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0036\4\a\0009\4\b\0046\6\t\0009\6\n\0069\6\v\6\24\6\0\6B\4\2\2=\4\f\3=\3\r\0025\3\15\0005\4\14\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\0035\4\23\0=\4\24\3=\3\25\2B\0\2\0016\0\26\0'\2\27\0'\3\28\0'\4\29\0005\5\30\0B\0\5\0013\0\31\0003\1 \0006\2!\0003\3#\0=\3\"\0026\2!\0003\3%\0=\3$\0026\2\t\0009\2&\0029\2'\2'\4\27\0'\5(\0'\6)\0005\a*\0B\2\5\0016\2\t\0009\2&\0029\2'\2'\4+\0'\5(\0'\6)\0005\a,\0B\2\5\0016\2\t\0009\2&\0029\2'\2'\4\27\0'\5-\0'\6.\0005\a/\0B\2\5\0016\2\t\0009\2&\0029\2'\2'\4+\0'\5-\0'\6.\0005\a0\0B\2\5\0016\2\t\0009\2&\0029\2'\2'\4\27\0'\0051\0'\0062\0005\a3\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\texpr\0028compe#confirm({ 'keys': '<CR>', 'select': v:true })\t<CR>\1\0\1\texpr\2\1\0\1\texpr\2\27v:lua.s_tab_complete()\f<S-Tab>\1\0\1\texpr\2\6s\1\0\1\texpr\2\25v:lua.tab_complete()\n<Tab>\20nvim_set_keymap\bapi\0\19s_tab_complete\0\17tab_complete\a_G\0\0\1\0\2\vsilent\2\texpr\2\26compe#confirm(\"<cr>\")\t<cr>\6i\bmap\vsource\rnvim_lua\1\0\1\tmenu\t ÔÜ≤\rnvim_lsp\1\0\1\tmenu\n ÔÜ≥ \nvsnip\1\0\1\tmenu\t ÔÉê\vbuffer\1\0\1\tmenu\t Ôôç\tpath\1\0\5\nspell\1\ttags\1\15treesitter\1\26vim_dadbod_completion\2\tcalc\2\1\0\1\tmenu\t ÔÅª\18documentation\15max_height\nlines\6o\bvim\nfloor\tmath\vborder\1\0\4\17winhighlightHNormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder\15min_height\3\1\14min_width\3<\14max_width\3x\1\t\0\0\5\5\5\6 \5\5\5\6 \1\0\r\fenabled\2\ndebug\1\25allow_prefix_unmatch\2\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\20resolve_timeout\3†\6\19source_timeout\3»\1\18throttle_time\3P\14preselect\venable\15min_length\3\1\17autocomplete\2\nsetup\ncompe\frequireÁÃô≥\6≥ÊÃ˛\3\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lsputils"] = {
    config = { "\27LJ\2\næ\5\0\0\4\0\23\0A6\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\5\0B\1\2\0029\1\6\1=\1\3\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\t\1=\1\a\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\v\1=\1\n\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\r\1=\1\f\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\15\1=\1\14\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\17\1=\1\16\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\19\0B\1\2\0029\1\20\1=\1\18\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\19\0B\1\2\0029\1\22\1=\1\21\0K\0\1\0\22workspace_handler\21workspace/symbol\21document_handler\20lsputil.symbols textDocument/documentSymbol\27implementation_handler textDocument/implementation\27typeDefinition_handler textDocument/typeDefinition\24declaration_handler\29textDocument/declaration\23definition_handler\28textDocument/definition\23references_handler\22lsputil.locations\28textDocument/references\24code_action_handler\23lsputil.codeAction\frequire\28textDocument/codeAction\rhandlers\blsp\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-lsputils"
  },
  ["nvim-spectre"] = {
    config = { "\27LJ\2\n¥\3\0\0\6\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0'\3\b\0'\4\t\0004\5\0\0B\0\5\0016\0\6\0'\2\a\0'\3\n\0'\4\v\0004\5\0\0B\0\5\1K\0\1\0+<cmd>lua require(\"spectre\").open()<CR>\14<leader>R1viw:lua require(\"spectre\").open_visual()<CR>\14<leader>r\6n\bmap\14highlight\1\0\3\vsearch\15DiffDelete\aui\vString\freplace\15DiffChange\1\0\4\rline_sep1‚îî-----------------------------------------\19result_padding\t¬¶  \19color_devicons\2\19line_sep_start1‚îå-----------------------------------------\nsetup\fspectre\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-spectre"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n´\4\0\0\5\0\22\0(6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\4\0'\1\6\0=\1\5\0006\0\4\0)\1\30\0=\1\a\0006\0\4\0)\1\1\0=\1\b\0006\0\4\0)\1\1\0=\1\t\0006\0\4\0)\1\1\0=\1\n\0006\0\4\0)\1\1\0=\1\v\0006\0\4\0)\1\1\0=\1\f\0006\0\4\0)\1\1\0=\1\r\0006\0\4\0005\1\15\0=\1\14\0006\0\4\0005\1\17\0005\2\18\0=\2\19\0015\2\20\0=\2\21\1=\1\16\0K\0\1\0\vfolder\1\0\2\topen\bÓóæ\fdefault\bÓóø\bgit\1\0\5\runstaged\b‚úó\14untracked\b‚òÖ\frenamed\b‚ûú\runmerged\bÓúß\vstaged\b‚úì\1\0\2\fsymlink\bÔíÅ\fdefault\bÓòí\20nvim_tree_icons\1\0\3\nfiles\3\1\bgit\3\1\ffolders\3\1\25nvim_tree_show_icons\27nvim_tree_allow_resize\21nvim_tree_git_hl\29nvim_tree_indent_markers\21nvim_tree_follow\27nvim_tree_quit_on_open\25nvim_tree_auto_close\20nvim_tree_width\tleft\19nvim_tree_side\6g\24:NvimTreeToggle<cr>\n<c-f>\6n\bmap\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÇ\3\0\0\5\0\16\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0005\4\a\0=\4\b\3=\3\t\0025\3\n\0004\4\0\0=\4\v\0034\4\0\0=\4\f\0035\4\r\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\venable\2\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\19goto_right_end\1\19highlight_self\1\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\0\0\1\2\0\0\fhaskell\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["obvious-resize"] = {
    config = { "\27LJ\2\nß\2\0\0\5\0\r\0\0276\0\0\0)\1\4\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0006\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\3\0'\2\4\0'\3\a\0'\4\b\0B\0\4\0016\0\3\0'\2\4\0'\3\t\0'\4\n\0B\0\4\0016\0\3\0'\2\4\0'\3\v\0'\4\f\0B\0\4\1K\0\1\0\28:ObviousResizeRight<cr>\14<c-right>\27:ObviousResizeLeft<cr>\r<c-left>\27:ObviousResizeDown<cr>\r<c-down>\25:ObviousResizeUp<cr>\v<c-up>\5\bmap\28obvious_resize_run_tmux\27obvious_resize_default\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/obvious-resize"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["pastefix.vim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/pastefix.vim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  popfix = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/popfix"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["quick-scope"] = {
    config = { "\27LJ\2\n:\0\0\2\0\3\0\0046\0\0\0005\1\2\0=\1\1\0K\0\1\0\1\5\0\0\6f\6F\6t\6T\25qs_highlight_on_keys\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  sonokai = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/sonokai"
  },
  ["splitjoin.vim"] = {
    config = { "\27LJ\2\nf\0\0\5\0\6\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0\24:SplitjoinSplit<cr>\ags\23:SplitjoinJoin<cr>\agj\6n\bmap\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-tmux.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/telescope-tmux.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\ne\0\1\6\1\4\0\n-\1\0\0008\1\0\0016\3\0\0'\5\1\0B\3\2\0029\3\2\0035\5\3\0B\3\2\0A\1\0\1K\0\1\0\0¿\1\0\1\14previewer\1\17get_dropdown\21telescope.themes\frequireW\0\1\6\1\3\0\n-\1\0\0008\1\0\0016\3\0\0'\5\1\0B\3\2\0029\3\2\0034\5\0\0B\3\2\0A\1\0\1K\0\1\0\0¿\17get_dropdown\21telescope.themes\frequireø\f\1\0\n\0009\0b6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0029\4\5\0015\6\23\0005\a\a\0005\b\6\0=\b\b\a5\b\t\0=\b\n\a5\b\v\0=\b\f\a9\b\r\2=\b\14\a9\b\r\2=\b\15\a9\b\16\0039\b\17\b=\b\18\a9\b\19\0039\b\17\b=\b\20\a9\b\21\0039\b\17\b=\b\22\a=\a\24\0065\a\26\0005\b\25\0=\b\27\a5\b\28\0=\b\29\a=\a\30\6B\4\2\0016\4\0\0'\6\2\0B\4\2\0029\4\31\4'\6\27\0B\4\2\0013\4 \0007\4!\0003\4\"\0007\4#\0006\4$\0'\6%\0'\a&\0'\b'\0B\4\4\0016\4$\0'\6%\0'\a(\0'\b)\0B\4\4\0016\4$\0'\6%\0'\a*\0'\b+\0B\4\4\0016\4,\0'\6-\0B\4\2\0016\4$\0'\6%\0'\a.\0'\b/\0B\4\4\0016\4$\0'\6%\0'\a0\0'\b1\0B\4\4\0016\4$\0'\6%\0'\a2\0'\b3\0B\4\4\0016\4$\0'\6%\0'\a4\0'\b5\0005\t6\0B\4\5\0016\4$\0'\6%\0'\a7\0'\b8\0B\4\4\0012\0\0ÄK\0\1\0\":Telescope tmux pane_contents\aga\1\0\2\vsilent\2\fnoremap\2B<CMD>lua TelescopeOpenPrewiev('lsp.document_diagnostics')<cr>\a'D6<CMD>lua TelescopeOpenPrewiev('git_branches')<CR>\bgbrm<CMD>lua require('telescope').extensions.fzf_writer.grep(require'telescope.themes'.get_dropdown({}))<CR>\agc5<CMD>lua TelescopeOpenPrewiev('grep_string')<CR>\ago3cnoreabbrev comm lua TelescopeOpen('commands')\bcmd1<CMD>lua TelescopeOpenPrewiev('buffers')<CR>\agb4<CMD>lua TelescopeOpenPrewiev('find_files')<CR>\agF3<CMD>lua TelescopeOpenPrewiev('git_files')<CR>\agf\6n\bmap\25TelescopeOpenPrewiev\0\18TelescopeOpen\0\19load_extension\15extensions\15fzf_writer\1\0\3\20use_highlighter\2\29minimum_files_characters\3\2\28minimum_grep_characters\3\2\15fzy_native\1\0\0\1\0\2\28override_generic_sorter\2\25override_file_sorter\2\rdefaults\1\0\0\21qflist_previewer\22vim_buffer_qflist\19grep_previewer\23vim_buffer_vimgrep\19file_previewer\bnew\19vim_buffer_cat\19generic_sorter\16file_sorter\19get_fzy_sorter\17path_display\1\2\0\0\fshorten\25file_ignore_patterns\1\3\0\0\v.git/*\17node_modules\22vimgrep_arguments\1\0\2\rwinblend\3\20\19color_devicons\2\1\t\0\0\arg\r--hidden\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\nsetup\25telescope.previewers\22telescope.sorters\14telescope\22telescope.builtin\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["timer.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/timer.nvim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-bbye"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27cnoreabbrev bd Bdelete\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-bbye"
  },
  ["vim-bufonly"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25cnoreabbrev bo Bonly\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-bufonly"
  },
  ["vim-commentary"] = {
    config = { "\27LJ\2\nÿ\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0$nmap <leader>c <Plug>Commentary$omap <leader>c <Plug>Commentary$xmap <leader>c <Plug>Commentary)nmap <leader>cc <Plug>CommentaryLine\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-dadbod"
  },
  ["vim-dadbod-completion"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-dadbod-completion"
  },
  ["vim-dadbod-ui"] = {
    config = { "\27LJ\2\nê\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\25db_ui_use_nerd_fonts\29db_ui_show_database_icon%db_ui_auto_execute_table_helpers\6g\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-dadbod-ui"
  },
  ["vim-dotenv"] = {
    config = { "\27LJ\2\nç\1\0\0\5\0\a\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\4\0'\3\5\0'\4\6\0B\0\4\1K\0\1\0\16Dotenv .env\t.env\17BufWritePost2if !empty(glob('.env')) | Dotenv .env | endif\6*\rVimEnter\aau\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-dotenv"
  },
  ["vim-floaterm"] = {
    config = { "\27LJ\2\nç\2\0\0\5\0\14\1\0246\0\0\0*\1\0\0=\1\1\0006\0\0\0*\1\0\0=\1\2\0006\0\0\0'\1\4\0=\1\3\0006\0\5\0'\2\6\0'\3\a\0'\4\b\0B\0\4\0016\0\5\0'\2\t\0'\3\a\0'\4\n\0B\0\4\0016\0\v\0'\2\f\0005\3\r\0B\0\3\1K\0\1\0\1\0\2\nguifg\tnone\nguibg\tnone\19FloatermBorder\ahi\"<c-\\><c-n>:FloatermToggle<cr>\6t\24:FloatermToggle<cr>\n<F11>\6n\bmap\5\19floaterm_title\20floaterm_height\19floaterm_width\6g›ûäÆ\15î‹æˇ\3\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\nˆ\1\0\0\5\0\v\0\0236\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0016\0\5\0'\2\6\0'\3\a\0'\4\b\0B\0\4\0016\0\5\0'\2\6\0'\3\t\0'\4\n\0B\0\4\1K\0\1\0\21:diffget //3<cr>\agr\21:diffget //2<cr>\agl\6n\bmap\22cnoreabbrev gs Gs\26command! Gs :Git | on%cnoreabbrev gpf Git push --force\28cnoreabbrev gp Git push\bcmd\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-hexokinase"] = {
    config = { "\27LJ\2\nL\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\19foregroundfull\28Hexokinase_highlighters\6g\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-lastplace"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-lastplace"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-sandwich"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-sandwich"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-startify"] = {
    config = { "\27LJ\2\nú\2\0\0\a\0\v\0\0236\0\0\0004\1\3\0005\2\2\0004\3\3\0'\4\3\0006\5\4\0009\5\5\5B\5\1\2&\4\5\4>\4\1\3=\3\6\2>\2\1\1=\1\1\0006\0\0\0)\1\1\0=\1\a\0006\0\0\0)\1\1\0=\1\b\0006\0\0\0005\1\n\0=\1\t\0K\0\1\0\1\17\0\0\6a\6r\6s\6t\6n\6e\6o\6i\3\1\3\2\3\3\3\4\3\a\3\b\3\t\3\0\28startify_custom_indices\28startify_enable_special startify_change_to_vcs_root\vheader\vgetcwd\afn\31 Most recently updated in \1\0\1\ttype\bdir\19startify_lists\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["vim-subversive"] = {
    config = { "\27LJ\2\nÀ\2\0\0\5\0\6\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0ç\1:<c-u>call subversive#singleMotion#substituteLineSetup(v:register, v:count)<cr>:set opfunc=subversive#singleMotion#substituteLine<cr>g@l\ammÜ\1:<c-u>call subversive#singleMotion#preSubstitute(v:register, 0, '')<cr>:set opfunc=subversive#singleMotion#substituteMotion<cr>g@\6m\6n\bmap\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-subversive"
  },
  ["vim-terraform"] = {
    config = { "\27LJ\2\nS\0\0\2\0\3\0\a6\0\0\0)\1\1\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0K\0\1\0\26terraform_fmt_on_save\28terraform_fold_sections\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-terraform"
  },
  ["vim-textobj-comment"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-textobj-comment"
  },
  ["vim-textobj-indent"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-textobj-indent"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-tmux"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-tmux"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    config = { "\27LJ\2\nx\0\0\4\0\a\0\f6\0\0\0+\1\1\0=\1\1\0006\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0K\0\1\0\v/vsnip\vconfig\fstdpath\afn\22vsnip_snippet_dir\24vsnip_extra_mapping\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  ["vim-wordmotion"] = {
    config = { "\27LJ\2\n4\0\0\2\0\3\0\0046\0\0\0'\1\2\0=\1\1\0K\0\1\0\r<leader>\22wordmotion_prefix\6g\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: vim-bbye
time([[Config for vim-bbye]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27cnoreabbrev bd Bdelete\bcmd\0", "config", "vim-bbye")
time([[Config for vim-bbye]], false)
-- Config for: vim-bufonly
time([[Config for vim-bufonly]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25cnoreabbrev bo Bonly\bcmd\0", "config", "vim-bufonly")
time([[Config for vim-bufonly]], false)
-- Config for: vim-vsnip
time([[Config for vim-vsnip]], true)
try_loadstring("\27LJ\2\nx\0\0\4\0\a\0\f6\0\0\0+\1\1\0=\1\1\0006\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0K\0\1\0\v/vsnip\vconfig\fstdpath\afn\22vsnip_snippet_dir\24vsnip_extra_mapping\6g\0", "config", "vim-vsnip")
time([[Config for vim-vsnip]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
try_loadstring("\27LJ\2\nF\0\1\a\0\3\0\b6\1\0\0009\1\1\0019\1\2\1\18\3\0\0+\4\2\0+\5\2\0+\6\2\0D\1\5\0\27nvim_replace_termcodes\bapi\bvimõ\1\0\0\6\0\b\2\0286\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\18Ä6\1\0\0009\1\1\0019\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0Ó\1\0\0\3\2\b\1\"6\0\0\0009\0\1\0009\0\2\0)\2\1\0B\0\2\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\22Ä6\0\0\0009\0\1\0009\0\4\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\5\0D\0\2\0X\0\fÄ-\0\1\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0'\2\6\0D\0\2\0X\0\4Ä6\0\0\0009\0\1\0009\0\a\0D\0\1\0K\0\1\0\0¿\1¿\19compe#complete\n<Tab>\n<C-n>\15pumvisible!<Plug>(vsnip-expand-or-jump)\20vsnip#available\afn\bvim\2µ\1\0\0\3\1\a\1\0256\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\14Ä6\0\0\0009\0\1\0009\0\4\0)\2ˇˇB\0\2\2\t\0\0\0X\0\4Ä-\0\0\0'\2\5\0D\0\2\0X\0\3Ä-\0\0\0'\2\6\0D\0\2\0K\0\1\0\0¿\f<S-Tab>\28<Plug>(vsnip-jump-prev)\19vsnip#jumpable\n<C-p>\15pumvisible\afn\bvim\2Ω\t\1\0\b\0004\1V6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0036\4\a\0009\4\b\0046\6\t\0009\6\n\0069\6\v\6\24\6\0\6B\4\2\2=\4\f\3=\3\r\0025\3\15\0005\4\14\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\0035\4\23\0=\4\24\3=\3\25\2B\0\2\0016\0\26\0'\2\27\0'\3\28\0'\4\29\0005\5\30\0B\0\5\0013\0\31\0003\1 \0006\2!\0003\3#\0=\3\"\0026\2!\0003\3%\0=\3$\0026\2\t\0009\2&\0029\2'\2'\4\27\0'\5(\0'\6)\0005\a*\0B\2\5\0016\2\t\0009\2&\0029\2'\2'\4+\0'\5(\0'\6)\0005\a,\0B\2\5\0016\2\t\0009\2&\0029\2'\2'\4\27\0'\5-\0'\6.\0005\a/\0B\2\5\0016\2\t\0009\2&\0029\2'\2'\4+\0'\5-\0'\6.\0005\a0\0B\2\5\0016\2\t\0009\2&\0029\2'\2'\4\27\0'\0051\0'\0062\0005\a3\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\texpr\0028compe#confirm({ 'keys': '<CR>', 'select': v:true })\t<CR>\1\0\1\texpr\2\1\0\1\texpr\2\27v:lua.s_tab_complete()\f<S-Tab>\1\0\1\texpr\2\6s\1\0\1\texpr\2\25v:lua.tab_complete()\n<Tab>\20nvim_set_keymap\bapi\0\19s_tab_complete\0\17tab_complete\a_G\0\0\1\0\2\vsilent\2\texpr\2\26compe#confirm(\"<cr>\")\t<cr>\6i\bmap\vsource\rnvim_lua\1\0\1\tmenu\t ÔÜ≤\rnvim_lsp\1\0\1\tmenu\n ÔÜ≥ \nvsnip\1\0\1\tmenu\t ÔÉê\vbuffer\1\0\1\tmenu\t Ôôç\tpath\1\0\5\nspell\1\ttags\1\15treesitter\1\26vim_dadbod_completion\2\tcalc\2\1\0\1\tmenu\t ÔÅª\18documentation\15max_height\nlines\6o\bvim\nfloor\tmath\vborder\1\0\4\17winhighlightHNormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder\15min_height\3\1\14min_width\3<\14max_width\3x\1\t\0\0\5\5\5\6 \5\5\5\6 \1\0\r\fenabled\2\ndebug\1\25allow_prefix_unmatch\2\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\20resolve_timeout\3†\6\19source_timeout\3»\1\18throttle_time\3P\14preselect\venable\15min_length\3\1\17autocomplete\2\nsetup\ncompe\frequireÁÃô≥\6≥ÊÃ˛\3\0", "config", "nvim-compe")
time([[Config for nvim-compe]], false)
-- Config for: obvious-resize
time([[Config for obvious-resize]], true)
try_loadstring("\27LJ\2\nß\2\0\0\5\0\r\0\0276\0\0\0)\1\4\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0006\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\3\0'\2\4\0'\3\a\0'\4\b\0B\0\4\0016\0\3\0'\2\4\0'\3\t\0'\4\n\0B\0\4\0016\0\3\0'\2\4\0'\3\v\0'\4\f\0B\0\4\1K\0\1\0\28:ObviousResizeRight<cr>\14<c-right>\27:ObviousResizeLeft<cr>\r<c-left>\27:ObviousResizeDown<cr>\r<c-down>\25:ObviousResizeUp<cr>\v<c-up>\5\bmap\28obvious_resize_run_tmux\27obvious_resize_default\6g\0", "config", "obvious-resize")
time([[Config for obvious-resize]], false)
-- Config for: quick-scope
time([[Config for quick-scope]], true)
try_loadstring("\27LJ\2\n:\0\0\2\0\3\0\0046\0\0\0005\1\2\0=\1\1\0K\0\1\0\1\5\0\0\6f\6F\6t\6T\25qs_highlight_on_keys\6g\0", "config", "quick-scope")
time([[Config for quick-scope]], false)
-- Config for: sonokai
time([[Config for sonokai]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "sonokai")
time([[Config for sonokai]], false)
-- Config for: vim-hexokinase
time([[Config for vim-hexokinase]], true)
try_loadstring("\27LJ\2\nL\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\19foregroundfull\28Hexokinase_highlighters\6g\bvim\0", "config", "vim-hexokinase")
time([[Config for vim-hexokinase]], false)
-- Config for: vim-subversive
time([[Config for vim-subversive]], true)
try_loadstring("\27LJ\2\nÀ\2\0\0\5\0\6\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0ç\1:<c-u>call subversive#singleMotion#substituteLineSetup(v:register, v:count)<cr>:set opfunc=subversive#singleMotion#substituteLine<cr>g@l\ammÜ\1:<c-u>call subversive#singleMotion#preSubstitute(v:register, 0, '')<cr>:set opfunc=subversive#singleMotion#substituteMotion<cr>g@\6m\6n\bmap\0", "config", "vim-subversive")
time([[Config for vim-subversive]], false)
-- Config for: vim-commentary
time([[Config for vim-commentary]], true)
try_loadstring("\27LJ\2\nÿ\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0$nmap <leader>c <Plug>Commentary$omap <leader>c <Plug>Commentary$xmap <leader>c <Plug>Commentary)nmap <leader>cc <Plug>CommentaryLine\bcmd\bvim\0", "config", "vim-commentary")
time([[Config for vim-commentary]], false)
-- Config for: nvim-lsputils
time([[Config for nvim-lsputils]], true)
try_loadstring("\27LJ\2\næ\5\0\0\4\0\23\0A6\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\5\0B\1\2\0029\1\6\1=\1\3\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\t\1=\1\a\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\v\1=\1\n\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\r\1=\1\f\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\15\1=\1\14\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\17\1=\1\16\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\19\0B\1\2\0029\1\20\1=\1\18\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\19\0B\1\2\0029\1\22\1=\1\21\0K\0\1\0\22workspace_handler\21workspace/symbol\21document_handler\20lsputil.symbols textDocument/documentSymbol\27implementation_handler textDocument/implementation\27typeDefinition_handler textDocument/typeDefinition\24declaration_handler\29textDocument/declaration\23definition_handler\28textDocument/definition\23references_handler\22lsputil.locations\28textDocument/references\24code_action_handler\23lsputil.codeAction\frequire\28textDocument/codeAction\rhandlers\blsp\bvim\0", "config", "nvim-lsputils")
time([[Config for nvim-lsputils]], false)
-- Config for: vim-terraform
time([[Config for vim-terraform]], true)
try_loadstring("\27LJ\2\nS\0\0\2\0\3\0\a6\0\0\0)\1\1\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0K\0\1\0\26terraform_fmt_on_save\28terraform_fold_sections\6g\0", "config", "vim-terraform")
time([[Config for vim-terraform]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\v6\1\0\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\2\a\1\3\0X\1\2Ä+\1\1\0L\1\2\0+\1\2\0L\1\2\0\5\fbufname\afn\bvimØ\5\1\0\6\0\"\0)6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0005\5\22\0=\5\23\4=\4\24\0035\4\25\0=\4\26\3=\3\27\2B\0\2\0016\0\28\0'\2\29\0'\3\30\0'\4\31\0B\0\4\0016\0\28\0'\2\29\0'\3 \0'\4!\0B\0\4\1K\0\1\0\29:BufferLineCyclePrev<cr>\r<S-Down>\29:BufferLineCycleNext<cr>\v<S-Up>\6n\bmap\15highlights\rmodified\1\0\1\nguibg\tnone\23indicator_selected\nguifg\1\0\2\14attribute\abg\14highlight\vNormal\1\0\1\nguibg\tnone\20buffer_selected\1\0\1\nguifg\f#e5c463\14duplicate\1\0\1\nguibg\tnone\btab\1\0\1\nguibg\tnone\15background\1\0\1\nguibg\tnone\tfill\1\0\0\1\0\1\nguibg\tnone\foptions\1\0\0\18custom_filter\0\20separator_style\1\3\0\0\5\5\1\0\b\fnumbers\tnone\tview\16multiwindow\22max_prefix_length\3\0\rtab_size\3\25\20max_name_length\3#\18modified_icon\tüñç\20show_close_icon\1\28show_buffer_close_icons\1\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
-- Config for: Navigator.nvim
time([[Config for Navigator.nvim]], true)
try_loadstring("\27LJ\2\nÒ\2\0\0\5\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0'\2\5\0'\3\6\0'\4\a\0B\0\4\0016\0\4\0'\2\5\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0'\2\5\0'\3\n\0'\4\v\0B\0\4\0016\0\4\0'\2\5\0'\3\f\0'\4\r\0B\0\4\1K\0\1\0.<CMD>lua require('Navigator').right()<CR>\n<c-l>+<CMD>lua require('Navigator').up()<CR>\n<c-k>-<CMD>lua require('Navigator').down()<CR>\n<c-j>-<CMD>lua require('Navigator').left()<CR>\n<c-h>\5\bmap\1\0\2\20disable_on_zoom\1\14auto_save\fcurrent\nsetup\14Navigator\frequire\0", "config", "Navigator.nvim")
time([[Config for Navigator.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÇ\3\0\0\5\0\16\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0005\4\a\0=\4\b\3=\3\t\0025\3\n\0004\4\0\0=\4\v\0034\4\0\0=\4\f\0035\4\r\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\venable\2\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\19goto_right_end\1\19highlight_self\1\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\0\0\1\2\0\0\fhaskell\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: codi.vim
time([[Config for codi.vim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28cnoreabbrev Eval Codi!!\bcmd\0", "config", "codi.vim")
time([[Config for codi.vim]], false)
-- Config for: vim-floaterm
time([[Config for vim-floaterm]], true)
try_loadstring("\27LJ\2\nç\2\0\0\5\0\14\1\0246\0\0\0*\1\0\0=\1\1\0006\0\0\0*\1\0\0=\1\2\0006\0\0\0'\1\4\0=\1\3\0006\0\5\0'\2\6\0'\3\a\0'\4\b\0B\0\4\0016\0\5\0'\2\t\0'\3\a\0'\4\n\0B\0\4\0016\0\v\0'\2\f\0005\3\r\0B\0\3\1K\0\1\0\1\0\2\nguifg\tnone\nguibg\tnone\19FloatermBorder\ahi\"<c-\\><c-n>:FloatermToggle<cr>\6t\24:FloatermToggle<cr>\n<F11>\6n\bmap\5\19floaterm_title\20floaterm_height\19floaterm_width\6g›ûäÆ\15î‹æˇ\3\0", "config", "vim-floaterm")
time([[Config for vim-floaterm]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n´\4\0\0\5\0\22\0(6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\4\0'\1\6\0=\1\5\0006\0\4\0)\1\30\0=\1\a\0006\0\4\0)\1\1\0=\1\b\0006\0\4\0)\1\1\0=\1\t\0006\0\4\0)\1\1\0=\1\n\0006\0\4\0)\1\1\0=\1\v\0006\0\4\0)\1\1\0=\1\f\0006\0\4\0)\1\1\0=\1\r\0006\0\4\0005\1\15\0=\1\14\0006\0\4\0005\1\17\0005\2\18\0=\2\19\0015\2\20\0=\2\21\1=\1\16\0K\0\1\0\vfolder\1\0\2\topen\bÓóæ\fdefault\bÓóø\bgit\1\0\5\runstaged\b‚úó\14untracked\b‚òÖ\frenamed\b‚ûú\runmerged\bÓúß\vstaged\b‚úì\1\0\2\fsymlink\bÔíÅ\fdefault\bÓòí\20nvim_tree_icons\1\0\3\nfiles\3\1\bgit\3\1\ffolders\3\1\25nvim_tree_show_icons\27nvim_tree_allow_resize\21nvim_tree_git_hl\29nvim_tree_indent_markers\21nvim_tree_follow\27nvim_tree_quit_on_open\25nvim_tree_auto_close\20nvim_tree_width\tleft\19nvim_tree_side\6g\24:NvimTreeToggle<cr>\n<c-f>\6n\bmap\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: vim-dadbod-ui
time([[Config for vim-dadbod-ui]], true)
try_loadstring("\27LJ\2\nê\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\25db_ui_use_nerd_fonts\29db_ui_show_database_icon%db_ui_auto_execute_table_helpers\6g\bvim\0", "config", "vim-dadbod-ui")
time([[Config for vim-dadbod-ui]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\nˆ\1\0\0\5\0\v\0\0236\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0016\0\5\0'\2\6\0'\3\a\0'\4\b\0B\0\4\0016\0\5\0'\2\6\0'\3\t\0'\4\n\0B\0\4\1K\0\1\0\21:diffget //3<cr>\agr\21:diffget //2<cr>\agl\6n\bmap\22cnoreabbrev gs Gs\26command! Gs :Git | on%cnoreabbrev gpf Git push --force\28cnoreabbrev gp Git push\bcmd\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: vim-dotenv
time([[Config for vim-dotenv]], true)
try_loadstring("\27LJ\2\nç\1\0\0\5\0\a\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\4\0'\3\5\0'\4\6\0B\0\4\1K\0\1\0\16Dotenv .env\t.env\17BufWritePost2if !empty(glob('.env')) | Dotenv .env | endif\6*\rVimEnter\aau\0", "config", "vim-dotenv")
time([[Config for vim-dotenv]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 X\0\0\5\0\5\1\0146\0\0\0009\0\1\0006\2\2\0009\2\0\0029\2\3\2'\4\4\0B\2\2\0A\0\0\2\b\0\0\0X\0\2Ä+\0\2\0L\0\2\0+\0\1\0L\0\2\0\b%:t\vexpand\bvim\nempty\afn\2G\0\0\3\0\3\0\f6\0\0\0009\0\1\0009\0\2\0)\2\0\0B\0\2\2)\1P\0\1\1\0\0X\1\2Ä+\1\2\0L\1\2\0+\1\1\0L\1\2\0\rwinwidth\afn\bvimW\0\0\3\0\4\0\a5\0\0\0006\1\1\0009\1\2\0019\1\3\1B\1\1\0028\1\1\0L\1\2\0\tmode\afn\bvim\1\0\4\6c\fCOMMAND\6V\vVISUAL\6i\vINSERT\6n\vNORMAL˜\1\0\0\a\1\r\0*'\0\0\0006\1\1\0009\1\2\0019\1\3\1\15\0\1\0X\2\3Ä\18\1\0\0'\2\4\0&\0\2\1-\1\0\0B\1\1\2\15\0\1\0X\2\rÄ\18\1\0\0006\2\1\0009\2\5\0029\2\6\0026\4\1\0009\4\5\0049\4\a\4'\6\b\0B\4\2\2'\5\t\0B\2\3\2&\0\2\1X\1\aÄ\18\1\0\0006\2\1\0009\2\5\0029\2\a\2'\4\n\0B\2\2\2&\0\2\0016\1\1\0009\1\2\0019\1\v\1\15\0\1\0X\2\3Ä\18\1\0\0'\2\f\0&\0\2\1L\0\2\0\5¿\n üñç\rmodified\b%:t\t:~:.\6%\vexpand\16fnamemodify\afn\tüîí\rreadonly\abo\bvim\5\20\0\0\1\0\1\0\2'\0\0\0L\0\2\0\tÔû£ ´\f\1\0\r\0D\0ã\0015\0\0\0006\1\1\0'\3\2\0B\1\2\0029\2\3\0015\3\5\0=\3\4\0015\3\f\0005\4\a\0003\5\6\0=\5\b\0044\5\3\0009\6\t\0>\6\1\0059\6\n\0>\6\2\5=\5\v\4=\4\r\0033\4\14\0003\5\15\0004\6\5\0005\a\21\0005\b\18\0003\t\17\0=\t\b\b4\t\3\0009\n\19\0>\n\1\t9\n\20\0>\n\2\t=\t\v\b=\b\22\a>\a\1\6>\3\2\0065\a\27\0005\b\23\0004\t\3\0006\n\1\0'\f\24\0B\n\2\0029\n\25\n>\n\1\t9\n\26\0>\n\2\t=\t\v\b=\b\28\a>\a\3\0065\a\"\0005\b\30\0003\t\29\0=\t\b\b=\4\31\b4\t\3\0009\n \0>\n\1\t9\n!\0>\n\2\t=\t\v\b=\b#\a>\a\4\6=\6\16\0024\6\0\0=\6$\0024\6\a\0005\a)\0005\b&\0004\t\3\0009\n'\0>\n\1\t9\n(\0>\n\2\t=\t\v\b=\b*\a>\a\1\0065\a.\0005\b+\0004\t\3\0009\n,\0>\n\1\t9\n-\0>\n\2\t=\t\v\b=\b/\a>\a\2\0065\a3\0005\b0\0004\t\3\0009\n1\0>\n\1\t9\n2\0>\n\2\t=\t\v\b=\b4\a>\a\3\0065\a6\0005\b5\0004\t\3\0009\n1\0>\n\1\t9\n2\0>\n\2\t=\t\v\b=\b7\a>\a\4\0065\a>\0005\b9\0003\t8\0=\t\b\b6\t\1\0'\v:\0B\t\2\0029\t;\t=\t\31\b4\t\3\0009\n<\0>\n\1\t9\n=\0>\n\2\t=\t\v\b=\b?\a>\a\5\0065\aB\0005\b@\0006\t\1\0'\v:\0B\t\2\0029\t;\t=\t\31\b5\tA\0009\n<\0>\n\1\t9\n=\0>\n\2\t=\t\v\b=\bC\a>\a\6\6=\6%\0022\0\0ÄK\0\1\0\14GitBranch\1\0\0\1\4\0\0\0\0\tbold\1\0\1\rprovider\14GitBranch\fGitIcon\1\0\0\ngitBg\ngitFg\24check_git_workspace\28galaxyline.provider_vcs\1\0\0\0\19DiagnosticInfo\1\0\0\1\0\2\ticon\tÔÇ≠ \rprovider\19DiagnosticInfo\19DiagnosticHint\1\0\0\vhintBg\vhintFg\1\0\2\ticon\tÔÉ´ \rprovider\19DiagnosticHint\19DiagnosticWarn\1\0\0\14warningBg\14warningFg\1\0\2\ticon\tÔÅ± \rprovider\19DiagnosticWarn\20DiagnosticError\1\0\0\ferrorBg\ferrorFg\1\0\2\ticon\tÔÅó \rprovider\20DiagnosticError\nright\bmid\rFilePath\1\0\0\15filepathBg\15filepathFg\14condition\1\0\0\0\rFileIcon\1\0\0\15fileiconBg\24get_file_icon_color!galaxyline.provider_fileinfo\1\0\1\rprovider\rFileIcon\vViMode\1\0\0\vmodeBg\vmodeFg\1\0\0\0\tleft\0\0\nSpace\1\0\0\14highlight\fspaceBg\fspaceFg\rprovider\1\0\0\0\1\n\0\0\fLuaTree\nvista\tdbui\rstartify\tterm\rnerdtree\rfugitive\18fugitiveblame\tplug\20short_line_list\fsection\15galaxyline\frequire\1\0\19\vhintBg\tnone\fspaceFg\tnone\14warningFg\f#e7c664\14warningBg\tnone\15filepathFg\f#e5c463\ferrorFg\f#fc5d7c\ferrorBg\tnone\vinfoBg\tnone\vhintFg\f#7f8490\fspaceBg\tnone\vinfoFg\f#7f8490\vmodeBg\tnone\vlineFg\f#78dce8\vlineBg\tnone\ngitFg\f#78dce8\ngitBg\tnone\15filepathBg\tnone\15fileiconBg\tnone\vmodeFg\f#9ecd6f\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\ne\0\1\6\1\4\0\n-\1\0\0008\1\0\0016\3\0\0'\5\1\0B\3\2\0029\3\2\0035\5\3\0B\3\2\0A\1\0\1K\0\1\0\0¿\1\0\1\14previewer\1\17get_dropdown\21telescope.themes\frequireW\0\1\6\1\3\0\n-\1\0\0008\1\0\0016\3\0\0'\5\1\0B\3\2\0029\3\2\0034\5\0\0B\3\2\0A\1\0\1K\0\1\0\0¿\17get_dropdown\21telescope.themes\frequireø\f\1\0\n\0009\0b6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0029\4\5\0015\6\23\0005\a\a\0005\b\6\0=\b\b\a5\b\t\0=\b\n\a5\b\v\0=\b\f\a9\b\r\2=\b\14\a9\b\r\2=\b\15\a9\b\16\0039\b\17\b=\b\18\a9\b\19\0039\b\17\b=\b\20\a9\b\21\0039\b\17\b=\b\22\a=\a\24\0065\a\26\0005\b\25\0=\b\27\a5\b\28\0=\b\29\a=\a\30\6B\4\2\0016\4\0\0'\6\2\0B\4\2\0029\4\31\4'\6\27\0B\4\2\0013\4 \0007\4!\0003\4\"\0007\4#\0006\4$\0'\6%\0'\a&\0'\b'\0B\4\4\0016\4$\0'\6%\0'\a(\0'\b)\0B\4\4\0016\4$\0'\6%\0'\a*\0'\b+\0B\4\4\0016\4,\0'\6-\0B\4\2\0016\4$\0'\6%\0'\a.\0'\b/\0B\4\4\0016\4$\0'\6%\0'\a0\0'\b1\0B\4\4\0016\4$\0'\6%\0'\a2\0'\b3\0B\4\4\0016\4$\0'\6%\0'\a4\0'\b5\0005\t6\0B\4\5\0016\4$\0'\6%\0'\a7\0'\b8\0B\4\4\0012\0\0ÄK\0\1\0\":Telescope tmux pane_contents\aga\1\0\2\vsilent\2\fnoremap\2B<CMD>lua TelescopeOpenPrewiev('lsp.document_diagnostics')<cr>\a'D6<CMD>lua TelescopeOpenPrewiev('git_branches')<CR>\bgbrm<CMD>lua require('telescope').extensions.fzf_writer.grep(require'telescope.themes'.get_dropdown({}))<CR>\agc5<CMD>lua TelescopeOpenPrewiev('grep_string')<CR>\ago3cnoreabbrev comm lua TelescopeOpen('commands')\bcmd1<CMD>lua TelescopeOpenPrewiev('buffers')<CR>\agb4<CMD>lua TelescopeOpenPrewiev('find_files')<CR>\agF3<CMD>lua TelescopeOpenPrewiev('git_files')<CR>\agf\6n\bmap\25TelescopeOpenPrewiev\0\18TelescopeOpen\0\19load_extension\15extensions\15fzf_writer\1\0\3\20use_highlighter\2\29minimum_files_characters\3\2\28minimum_grep_characters\3\2\15fzy_native\1\0\0\1\0\2\28override_generic_sorter\2\25override_file_sorter\2\rdefaults\1\0\0\21qflist_previewer\22vim_buffer_qflist\19grep_previewer\23vim_buffer_vimgrep\19file_previewer\bnew\19vim_buffer_cat\19generic_sorter\16file_sorter\19get_fzy_sorter\17path_display\1\2\0\0\fshorten\25file_ignore_patterns\1\3\0\0\v.git/*\17node_modules\22vimgrep_arguments\1\0\2\rwinblend\3\20\19color_devicons\2\1\t\0\0\arg\r--hidden\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\nsetup\25telescope.previewers\22telescope.sorters\14telescope\22telescope.builtin\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-spectre
time([[Config for nvim-spectre]], true)
try_loadstring("\27LJ\2\n¥\3\0\0\6\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0'\2\a\0'\3\b\0'\4\t\0004\5\0\0B\0\5\0016\0\6\0'\2\a\0'\3\n\0'\4\v\0004\5\0\0B\0\5\1K\0\1\0+<cmd>lua require(\"spectre\").open()<CR>\14<leader>R1viw:lua require(\"spectre\").open_visual()<CR>\14<leader>r\6n\bmap\14highlight\1\0\3\vsearch\15DiffDelete\aui\vString\freplace\15DiffChange\1\0\4\rline_sep1‚îî-----------------------------------------\19result_padding\t¬¶  \19color_devicons\2\19line_sep_start1‚îå-----------------------------------------\nsetup\fspectre\frequire\0", "config", "nvim-spectre")
time([[Config for nvim-spectre]], false)
-- Config for: git-blame.nvim
time([[Config for git-blame.nvim]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1)\0à\19L\0\2\0\20show_blame_info\rgitblame\frequire]\1\0\3\0\a\0\v6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\3\0'\2\4\0B\0\2\0029\0\5\0003\2\6\0B\0\2\1K\0\1\0\0\badd\ntimer\frequire\21gitblame_enabled\6g\bvim\0", "config", "git-blame.nvim")
time([[Config for git-blame.nvim]], false)
-- Config for: splitjoin.vim
time([[Config for splitjoin.vim]], true)
try_loadstring("\27LJ\2\nf\0\0\5\0\6\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0\24:SplitjoinSplit<cr>\ags\23:SplitjoinJoin<cr>\agj\6n\bmap\0", "config", "splitjoin.vim")
time([[Config for splitjoin.vim]], false)
-- Config for: vim-wordmotion
time([[Config for vim-wordmotion]], true)
try_loadstring("\27LJ\2\n4\0\0\2\0\3\0\0046\0\0\0'\1\2\0=\1\1\0K\0\1\0\r<leader>\22wordmotion_prefix\6g\0", "config", "vim-wordmotion")
time([[Config for vim-wordmotion]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\nÑ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\23code_action_prompt\1\0\1\venable\1\1\0\1\29use_saga_diagnostic_sign\1\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: vim-startify
time([[Config for vim-startify]], true)
try_loadstring("\27LJ\2\nú\2\0\0\a\0\v\0\0236\0\0\0004\1\3\0005\2\2\0004\3\3\0'\4\3\0006\5\4\0009\5\5\5B\5\1\2&\4\5\4>\4\1\3=\3\6\2>\2\1\1=\1\1\0006\0\0\0)\1\1\0=\1\a\0006\0\0\0)\1\1\0=\1\b\0006\0\0\0005\1\n\0=\1\t\0K\0\1\0\1\17\0\0\6a\6r\6s\6t\6n\6e\6o\6i\3\1\3\2\3\3\3\4\3\a\3\b\3\t\3\0\28startify_custom_indices\28startify_enable_special startify_change_to_vcs_root\vheader\vgetcwd\afn\31 Most recently updated in \1\0\1\ttype\bdir\19startify_lists\6g\0", "config", "vim-startify")
time([[Config for vim-startify]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
