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
    config = { "\27LJ\2\nÒ\2\0\0\5\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0'\2\5\0'\3\6\0'\4\a\0B\0\4\0016\0\4\0'\2\5\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0'\2\5\0'\3\n\0'\4\v\0B\0\4\0016\0\4\0'\2\5\0'\3\f\0'\4\r\0B\0\4\1K\0\1\0.<CMD>lua require('Navigator').right()<CR>\n<c-l>+<CMD>lua require('Navigator').up()<CR>\n<c-k>-<CMD>lua require('Navigator').down()<CR>\n<c-j>-<CMD>lua require('Navigator').left()<CR>\n<c-h>\5\bmap\1\0\2\14auto_save\fcurrent\20disable_on_zoom\1\nsetup\14Navigator\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/Navigator.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-emoji"
  },
  ["cmp-look"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-look"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-spell"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/cmp-vsnip"
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
    config = { "\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 X\0\0\5\0\5\1\0146\0\0\0009\0\1\0006\2\2\0009\2\0\0029\2\3\2'\4\4\0B\2\2\0A\0\0\2\b\0\0\0X\0\2Ä+\0\2\0L\0\2\0+\0\1\0L\0\2\0\b%:t\vexpand\bvim\nempty\afn\2G\0\0\3\0\3\0\f6\0\0\0009\0\1\0009\0\2\0)\2\0\0B\0\2\2)\1P\0\1\1\0\0X\1\2Ä+\1\2\0L\1\2\0+\1\1\0L\1\2\0\rwinwidth\afn\bvimW\0\0\3\0\4\0\a5\0\0\0006\1\1\0009\1\2\0019\1\3\1B\1\1\0028\1\1\0L\1\2\0\tmode\afn\bvim\1\0\4\6i\vINSERT\6n\vNORMAL\6c\fCOMMAND\6V\vVISUAL˜\1\0\0\a\1\r\0*'\0\0\0006\1\1\0009\1\2\0019\1\3\1\15\0\1\0X\2\3Ä\18\1\0\0'\2\4\0&\0\2\1-\1\0\0B\1\1\2\15\0\1\0X\2\rÄ\18\1\0\0006\2\1\0009\2\5\0029\2\6\0026\4\1\0009\4\5\0049\4\a\4'\6\b\0B\4\2\2'\5\t\0B\2\3\2&\0\2\1X\1\aÄ\18\1\0\0006\2\1\0009\2\5\0029\2\a\2'\4\n\0B\2\2\2&\0\2\0016\1\1\0009\1\2\0019\1\v\1\15\0\1\0X\2\3Ä\18\1\0\0'\2\f\0&\0\2\1L\0\2\0\5¿\n üñç\rmodified\b%:t\t:~:.\6%\vexpand\16fnamemodify\afn\tüîí\rreadonly\abo\bvim\5\20\0\0\1\0\1\0\2'\0\0\0L\0\2\0\tÔû£ ´\f\1\0\r\0D\0ã\0015\0\0\0006\1\1\0'\3\2\0B\1\2\0029\2\3\0015\3\5\0=\3\4\0015\3\f\0005\4\a\0003\5\6\0=\5\b\0044\5\3\0009\6\t\0>\6\1\0059\6\n\0>\6\2\5=\5\v\4=\4\r\0033\4\14\0003\5\15\0004\6\5\0005\a\21\0005\b\18\0003\t\17\0=\t\b\b4\t\3\0009\n\19\0>\n\1\t9\n\20\0>\n\2\t=\t\v\b=\b\22\a>\a\1\6>\3\2\0065\a\27\0005\b\23\0004\t\3\0006\n\1\0'\f\24\0B\n\2\0029\n\25\n>\n\1\t9\n\26\0>\n\2\t=\t\v\b=\b\28\a>\a\3\0065\a\"\0005\b\30\0003\t\29\0=\t\b\b=\4\31\b4\t\3\0009\n \0>\n\1\t9\n!\0>\n\2\t=\t\v\b=\b#\a>\a\4\6=\6\16\0024\6\0\0=\6$\0024\6\a\0005\a)\0005\b&\0004\t\3\0009\n'\0>\n\1\t9\n(\0>\n\2\t=\t\v\b=\b*\a>\a\1\0065\a.\0005\b+\0004\t\3\0009\n,\0>\n\1\t9\n-\0>\n\2\t=\t\v\b=\b/\a>\a\2\0065\a3\0005\b0\0004\t\3\0009\n1\0>\n\1\t9\n2\0>\n\2\t=\t\v\b=\b4\a>\a\3\0065\a6\0005\b5\0004\t\3\0009\n1\0>\n\1\t9\n2\0>\n\2\t=\t\v\b=\b7\a>\a\4\0065\a>\0005\b9\0003\t8\0=\t\b\b6\t\1\0'\v:\0B\t\2\0029\t;\t=\t\31\b4\t\3\0009\n<\0>\n\1\t9\n=\0>\n\2\t=\t\v\b=\b?\a>\a\5\0065\aB\0005\b@\0006\t\1\0'\v:\0B\t\2\0029\t;\t=\t\31\b5\tA\0009\n<\0>\n\1\t9\n=\0>\n\2\t=\t\v\b=\bC\a>\a\6\6=\6%\0022\0\0ÄK\0\1\0\14GitBranch\1\0\0\1\4\0\0\0\0\tbold\1\0\1\rprovider\14GitBranch\fGitIcon\1\0\0\ngitBg\ngitFg\24check_git_workspace\28galaxyline.provider_vcs\1\0\0\0\19DiagnosticInfo\1\0\0\1\0\2\rprovider\19DiagnosticInfo\ticon\tÔÇ≠ \19DiagnosticHint\1\0\0\vhintBg\vhintFg\1\0\2\rprovider\19DiagnosticHint\ticon\tÔÉ´ \19DiagnosticWarn\1\0\0\14warningBg\14warningFg\1\0\2\rprovider\19DiagnosticWarn\ticon\tÔÅ± \20DiagnosticError\1\0\0\ferrorBg\ferrorFg\1\0\2\rprovider\20DiagnosticError\ticon\tÔÅó \nright\bmid\rFilePath\1\0\0\15filepathBg\15filepathFg\14condition\1\0\0\0\rFileIcon\1\0\0\15fileiconBg\24get_file_icon_color!galaxyline.provider_fileinfo\1\0\1\rprovider\rFileIcon\vViMode\1\0\0\vmodeBg\vmodeFg\1\0\0\0\tleft\0\0\nSpace\1\0\0\14highlight\fspaceBg\fspaceFg\rprovider\1\0\0\0\1\n\0\0\fLuaTree\nvista\tdbui\rstartify\tterm\rnerdtree\rfugitive\18fugitiveblame\tplug\20short_line_list\fsection\15galaxyline\frequire\1\0\19\vhintFg\f#7f8490\vhintBg\tnone\14warningFg\f#e7c664\14warningBg\tnone\ferrorFg\f#fc5d7c\ferrorBg\tnone\15filepathFg\f#e5c463\15filepathBg\tnone\15fileiconBg\tnone\vmodeFg\f#9ecd6f\vmodeBg\tnone\fspaceFg\tnone\fspaceBg\tnone\vlineFg\f#78dce8\vlineBg\tnone\ngitFg\f#78dce8\ngitBg\tnone\vinfoFg\f#7f8490\vinfoBg\tnone\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n∫\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\23code_action_prompt\1\0\4\venable\2\18sign_priority\3\20\tsign\1\17virtual_text\2\1\0\2\21code_action_icon\5\29use_saga_diagnostic_sign\2\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\v6\1\0\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\2\a\1\3\0X\1\2Ä+\1\1\0L\1\2\0+\1\2\0L\1\2\0\5\fbufname\afn\bvimØ\5\1\0\6\0\"\0)6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0005\5\22\0=\5\23\4=\4\24\0035\4\25\0=\4\26\3=\3\27\2B\0\2\0016\0\28\0'\2\29\0'\3\30\0'\4\31\0B\0\4\0016\0\28\0'\2\29\0'\3 \0'\4!\0B\0\4\1K\0\1\0\29:BufferLineCyclePrev<cr>\r<S-Down>\29:BufferLineCycleNext<cr>\v<S-Up>\6n\bmap\15highlights\rmodified\1\0\1\nguibg\tnone\23indicator_selected\nguifg\1\0\2\14highlight\vNormal\14attribute\abg\1\0\1\nguibg\tnone\20buffer_selected\1\0\1\nguifg\f#e5c463\14duplicate\1\0\1\nguibg\tnone\btab\1\0\1\nguibg\tnone\15background\1\0\1\nguibg\tnone\tfill\1\0\0\1\0\1\nguibg\tnone\foptions\1\0\0\18custom_filter\0\20separator_style\1\3\0\0\5\5\1\0\b\22max_prefix_length\3\0\rtab_size\3\25\20max_name_length\3#\18modified_icon\tüñç\20show_close_icon\1\28show_buffer_close_icons\1\fnumbers\tnone\tview\16multiwindow\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nè\1\0\0\6\0\a\2\0266\0\0\0009\0\1\0'\2\2\0B\0\2\2\23\0\0\0\b\0\1\0X\1\17Ä6\1\0\0009\1\3\1'\3\2\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\2\0;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim:\0\2\4\1\3\0\a-\2\0\0009\2\1\0029\2\2\0029\3\0\0018\2\3\2=\2\0\1L\1\2\0\2¿\fdefault\fpresets\tkind\2\0\1\t\1\f\1=6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1(Ä6\1\0\0009\1\1\0019\1\b\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\t\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\20Ä-\1\0\0B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\v\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\3¿\n<Tab>\5!<Plug>(vsnip-expand-or-jump)\20vsnip#available\6n\n<C-n>\27nvim_replace_termcodes\bapi\rfeedkeys\15pumvisible\afn\bvim\2õ\2\0\1\t\0\v\1+6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\22Ä6\1\0\0009\1\1\0019\1\b\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\t\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\5\28<Plug>(vsnip-jump-prev)\20vsnip#available\6n\n<C-p>\27nvim_replace_termcodes\bapi\rfeedkeys\15pumvisible\afn\bvim\2˜\a\1\0\r\0:\0]6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0023\3\4\0009\4\5\0005\6\b\0009\a\1\0019\a\6\a9\a\a\a=\a\t\0065\a\n\0=\a\v\0065\a\f\0=\a\r\0065\a\15\0003\b\14\0=\b\16\a=\a\17\0065\a\19\0003\b\18\0=\b\20\a=\a\21\0064\a\5\0005\b\22\0>\b\1\a5\b\23\0>\b\2\a5\b\24\0>\b\3\a5\b\25\0>\b\4\a=\a\26\0065\a\29\0009\b\27\0009\b\28\b)\n¸ˇB\b\2\2=\b\30\a9\b\27\0009\b\28\b)\n\4\0B\b\2\2=\b\31\a9\b\27\0009\b \b)\n¸ˇB\b\2\2=\b!\a9\b\27\0009\b\"\b)\n\4\0B\b\2\2=\b#\a9\b\27\0009\b$\bB\b\1\2=\b%\a9\b\27\0009\b&\bB\b\1\2=\b'\a9\b\27\0009\b(\b5\n+\0009\v)\0009\v*\v=\v,\nB\b\2\2=\b-\a3\b.\0=\b/\a3\b0\0=\b1\a=\a\27\6B\4\2\0016\0042\0'\0063\0'\a4\0'\b5\0'\t6\0'\n7\0'\v8\0'\f9\0&\b\f\bB\4\4\0012\0\0ÄK\0\1\0\t } }+{ name = 'look', max_item_count = 10 }\24{ name = 'emoji' },-{ name = 'spell', max_item_count = 10 },1lua require'cmp'.setup.buffer { sources = { \23gitcommit,markdown\rfiletype\aau\f<S-Tab>\0\n<Tab>\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-p>\21select_next_item\n<C-n>\21select_prev_item\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\fsources\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\2\19max_item_count\3\20\tname\rnvim_lsp\1\0\1\tname\nvsnip\15formatting\vformat\1\0\0\0\fsnippet\vexpand\1\0\0\0\17experimental\1\0\1\15ghost_text\2\15completion\1\0\1\16completeopt\26menu,menuone,noinsert\14preselect\1\0\0\tItem\18PreselectMode\nsetup\0\flspkind\14cmp.types\bcmp\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-code-action-menu"] = {
    commands = { "CodeActionMenu" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/opt/nvim-code-action-menu"
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
    config = { "\27LJ\2\nÌ\2\0\0\4\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0B\0\2\1K\0\1\0002command! Replace :lua require'spectre'.open()\17nvim_command\bapi\bvim\14highlight\1\0\3\vsearch\15DiffDelete\aui\vString\freplace\15DiffChange\1\0\4\rline_sep1‚îî-----------------------------------------\19result_padding\t¬¶  \19line_sep_start1‚îå-----------------------------------------\19color_devicons\2\nsetup\fspectre\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-spectre"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\në\5\0\0\5\0\24\0(6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\4\0'\1\6\0=\1\5\0006\0\4\0)\1\30\0=\1\a\0006\0\4\0)\1\1\0=\1\b\0006\0\4\0)\1\1\0=\1\t\0006\0\4\0)\1\1\0=\1\n\0006\0\4\0)\1\1\0=\1\v\0006\0\4\0005\1\r\0=\1\f\0006\0\4\0005\1\15\0005\2\16\0=\2\17\0015\2\18\0=\2\19\1=\1\14\0006\0\20\0'\2\21\0B\0\2\0029\0\22\0005\2\23\0B\0\2\1K\0\1\0\1\0\1\15auto_close\2\nsetup\14nvim-tree\frequire\vfolder\1\0\2\topen\bÓóæ\fdefault\bÓóø\bgit\1\0\5\14untracked\b‚òÖ\frenamed\b‚ûú\runmerged\bÓúß\vstaged\b‚úì\runstaged\b‚úó\1\0\2\fsymlink\bÔíÅ\fdefault\bÓòí\20nvim_tree_icons\1\0\3\nfiles\3\1\ffolders\3\1\bgit\3\1\25nvim_tree_show_icons\27nvim_tree_allow_resize\21nvim_tree_git_hl\29nvim_tree_indent_markers\27nvim_tree_quit_on_open\20nvim_tree_width\tleft\19nvim_tree_side\6g}:lua if ft() == 'NvimTree' or ft() == 'startify' then vim.cmd('NvimTreeToggle') else vim.cmd('NvimTreeFindFile') end<cr>\n<c-f>\6n\bmap\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n…\4\0\0\6\0\24\0 6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0025\1\a\0005\2\4\0005\3\5\0=\3\6\2=\2\b\1=\1\3\0006\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\f\0005\4\v\0=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0004\5\0\0=\5\19\0044\5\0\0=\5\20\0045\5\21\0=\5\22\4=\4\23\3B\1\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\venable\2\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\19goto_right_end\1\19highlight_self\1\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\0\0\1\2\0\0\fhaskell\nsetup\28nvim-treesitter.configs\17install_info\1\0\0\nfiles\1\2\0\0\17src/parser.c\1\0\2\burl5https://github.com/NTBBloodbath/tree-sitter-http\vbranch\tmain\thttp\23get_parser_configs\28nvim-treesitter.parsers\frequire\0" },
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
  ["rest.nvim"] = {
    config = { "\27LJ\2\n®\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\2\ftimeout\3ñ\1\fenabled\2\1\0\3\26skip_ssl_verification\1\28result_split_horizontal\1\20jump_to_request\1\nsetup\14rest-nvim\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/rest.nvim"
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
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n÷\b\0\0\t\0\24\0F6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1'\0\3\0'\1\4\0006\2\5\0'\4\6\0'\5\a\0'\6\b\0\18\a\0\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\n\0'\6\v\0\18\a\0\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\f\0'\6\r\0\18\a\1\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\14\0'\6\15\0\18\a\1\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\16\0'\6\17\0\18\a\1\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\18\0'\6\19\0\18\a\1\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\20\0'\6\21\0\18\a\0\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\22\0'\6\23\0B\2\4\1K\0\1\0007<CMD>lua require('telescope.builtin').resume()<CR>\agrG<CMD>lua require('telescope.builtin').buffers({sort_lastused=true,\agbÅ\1<CMD>lua require('telescope.builtin').grep_string({additional_args=function(options) return {'--hidden', '--no-ignore'} end,\agO8<CMD>lua require('telescope.builtin').grep_string({\ago<CMD>lua require('telescope.builtin').live_grep({additional_args=function(options) return {'--hidden', '--no-ignore'} end,\agC6<CMD>lua require('telescope.builtin').live_grep({\agcR<CMD>lua require('telescope.builtin').find_files({hidden=true,no_ignore=true,\agF\v})<CR>6<CMD>lua require('telescope.builtin').git_files({\agf\6n\bmapElayout_strategy='vertical',layout_config={width=0.9, height=0.9}hlayout_strategy='horizontal',layout_config={width=0.9, height=0.9, mirror=false, preview_width=0.6}\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["treesitter-unit"] = {
    config = { "\27LJ\2\nõ\3\0\0\6\0\15\0!6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\4\0'\4\v\0005\5\f\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\a\0'\4\r\0005\5\14\0B\0\5\1K\0\1\0\1\0\1\fnoremap\0028:<c-u>lua require\"treesitter-unit\".select(true)<CR>\1\0\1\fnoremap\0024:<c-u>lua require\"treesitter-unit\".select()<CR>\6o\1\0\1\fnoremap\0023:lua require\"treesitter-unit\".select(true)<CR>\aau\1\0\1\fnoremap\2/:lua require\"treesitter-unit\".select()<CR>\aiu\6x\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/treesitter-unit"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nÄ\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\tmode\29lsp_document_diagnostics\29use_lsp_diagnostic_signs\2\15auto_close\2\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/alexanderpopov/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["vim-abolish"] = {
    config = { "\27LJ\2\nU\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\26cnoreabbrev S Subvert\28cnoreabbrev %S %Subvert\bcmd\0" },
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
-- Config for: vim-dotenv
time([[Config for vim-dotenv]], true)
try_loadstring("\27LJ\2\nç\1\0\0\5\0\a\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\4\0'\3\5\0'\4\6\0B\0\4\1K\0\1\0\16Dotenv .env\t.env\17BufWritePost2if !empty(glob('.env')) | Dotenv .env | endif\6*\rVimEnter\aau\0", "config", "vim-dotenv")
time([[Config for vim-dotenv]], false)
-- Config for: nvim-spectre
time([[Config for nvim-spectre]], true)
try_loadstring("\27LJ\2\nÌ\2\0\0\4\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0B\0\2\1K\0\1\0002command! Replace :lua require'spectre'.open()\17nvim_command\bapi\bvim\14highlight\1\0\3\vsearch\15DiffDelete\aui\vString\freplace\15DiffChange\1\0\4\rline_sep1‚îî-----------------------------------------\19result_padding\t¬¶  \19line_sep_start1‚îå-----------------------------------------\19color_devicons\2\nsetup\fspectre\frequire\0", "config", "nvim-spectre")
time([[Config for nvim-spectre]], false)
-- Config for: vim-terraform
time([[Config for vim-terraform]], true)
try_loadstring("\27LJ\2\nS\0\0\2\0\3\0\a6\0\0\0)\1\1\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0K\0\1\0\26terraform_fmt_on_save\28terraform_fold_sections\6g\0", "config", "vim-terraform")
time([[Config for vim-terraform]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\n\17\0\0\1\0\1\0\2'\0\0\0L\0\2\0\6 X\0\0\5\0\5\1\0146\0\0\0009\0\1\0006\2\2\0009\2\0\0029\2\3\2'\4\4\0B\2\2\0A\0\0\2\b\0\0\0X\0\2Ä+\0\2\0L\0\2\0+\0\1\0L\0\2\0\b%:t\vexpand\bvim\nempty\afn\2G\0\0\3\0\3\0\f6\0\0\0009\0\1\0009\0\2\0)\2\0\0B\0\2\2)\1P\0\1\1\0\0X\1\2Ä+\1\2\0L\1\2\0+\1\1\0L\1\2\0\rwinwidth\afn\bvimW\0\0\3\0\4\0\a5\0\0\0006\1\1\0009\1\2\0019\1\3\1B\1\1\0028\1\1\0L\1\2\0\tmode\afn\bvim\1\0\4\6i\vINSERT\6n\vNORMAL\6c\fCOMMAND\6V\vVISUAL˜\1\0\0\a\1\r\0*'\0\0\0006\1\1\0009\1\2\0019\1\3\1\15\0\1\0X\2\3Ä\18\1\0\0'\2\4\0&\0\2\1-\1\0\0B\1\1\2\15\0\1\0X\2\rÄ\18\1\0\0006\2\1\0009\2\5\0029\2\6\0026\4\1\0009\4\5\0049\4\a\4'\6\b\0B\4\2\2'\5\t\0B\2\3\2&\0\2\1X\1\aÄ\18\1\0\0006\2\1\0009\2\5\0029\2\a\2'\4\n\0B\2\2\2&\0\2\0016\1\1\0009\1\2\0019\1\v\1\15\0\1\0X\2\3Ä\18\1\0\0'\2\f\0&\0\2\1L\0\2\0\5¿\n üñç\rmodified\b%:t\t:~:.\6%\vexpand\16fnamemodify\afn\tüîí\rreadonly\abo\bvim\5\20\0\0\1\0\1\0\2'\0\0\0L\0\2\0\tÔû£ ´\f\1\0\r\0D\0ã\0015\0\0\0006\1\1\0'\3\2\0B\1\2\0029\2\3\0015\3\5\0=\3\4\0015\3\f\0005\4\a\0003\5\6\0=\5\b\0044\5\3\0009\6\t\0>\6\1\0059\6\n\0>\6\2\5=\5\v\4=\4\r\0033\4\14\0003\5\15\0004\6\5\0005\a\21\0005\b\18\0003\t\17\0=\t\b\b4\t\3\0009\n\19\0>\n\1\t9\n\20\0>\n\2\t=\t\v\b=\b\22\a>\a\1\6>\3\2\0065\a\27\0005\b\23\0004\t\3\0006\n\1\0'\f\24\0B\n\2\0029\n\25\n>\n\1\t9\n\26\0>\n\2\t=\t\v\b=\b\28\a>\a\3\0065\a\"\0005\b\30\0003\t\29\0=\t\b\b=\4\31\b4\t\3\0009\n \0>\n\1\t9\n!\0>\n\2\t=\t\v\b=\b#\a>\a\4\6=\6\16\0024\6\0\0=\6$\0024\6\a\0005\a)\0005\b&\0004\t\3\0009\n'\0>\n\1\t9\n(\0>\n\2\t=\t\v\b=\b*\a>\a\1\0065\a.\0005\b+\0004\t\3\0009\n,\0>\n\1\t9\n-\0>\n\2\t=\t\v\b=\b/\a>\a\2\0065\a3\0005\b0\0004\t\3\0009\n1\0>\n\1\t9\n2\0>\n\2\t=\t\v\b=\b4\a>\a\3\0065\a6\0005\b5\0004\t\3\0009\n1\0>\n\1\t9\n2\0>\n\2\t=\t\v\b=\b7\a>\a\4\0065\a>\0005\b9\0003\t8\0=\t\b\b6\t\1\0'\v:\0B\t\2\0029\t;\t=\t\31\b4\t\3\0009\n<\0>\n\1\t9\n=\0>\n\2\t=\t\v\b=\b?\a>\a\5\0065\aB\0005\b@\0006\t\1\0'\v:\0B\t\2\0029\t;\t=\t\31\b5\tA\0009\n<\0>\n\1\t9\n=\0>\n\2\t=\t\v\b=\bC\a>\a\6\6=\6%\0022\0\0ÄK\0\1\0\14GitBranch\1\0\0\1\4\0\0\0\0\tbold\1\0\1\rprovider\14GitBranch\fGitIcon\1\0\0\ngitBg\ngitFg\24check_git_workspace\28galaxyline.provider_vcs\1\0\0\0\19DiagnosticInfo\1\0\0\1\0\2\rprovider\19DiagnosticInfo\ticon\tÔÇ≠ \19DiagnosticHint\1\0\0\vhintBg\vhintFg\1\0\2\rprovider\19DiagnosticHint\ticon\tÔÉ´ \19DiagnosticWarn\1\0\0\14warningBg\14warningFg\1\0\2\rprovider\19DiagnosticWarn\ticon\tÔÅ± \20DiagnosticError\1\0\0\ferrorBg\ferrorFg\1\0\2\rprovider\20DiagnosticError\ticon\tÔÅó \nright\bmid\rFilePath\1\0\0\15filepathBg\15filepathFg\14condition\1\0\0\0\rFileIcon\1\0\0\15fileiconBg\24get_file_icon_color!galaxyline.provider_fileinfo\1\0\1\rprovider\rFileIcon\vViMode\1\0\0\vmodeBg\vmodeFg\1\0\0\0\tleft\0\0\nSpace\1\0\0\14highlight\fspaceBg\fspaceFg\rprovider\1\0\0\0\1\n\0\0\fLuaTree\nvista\tdbui\rstartify\tterm\rnerdtree\rfugitive\18fugitiveblame\tplug\20short_line_list\fsection\15galaxyline\frequire\1\0\19\vhintFg\f#7f8490\vhintBg\tnone\14warningFg\f#e7c664\14warningBg\tnone\ferrorFg\f#fc5d7c\ferrorBg\tnone\15filepathFg\f#e5c463\15filepathBg\tnone\15fileiconBg\tnone\vmodeFg\f#9ecd6f\vmodeBg\tnone\fspaceFg\tnone\fspaceBg\tnone\vlineFg\f#78dce8\vlineBg\tnone\ngitFg\f#78dce8\ngitBg\tnone\vinfoFg\f#7f8490\vinfoBg\tnone\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n÷\b\0\0\t\0\24\0F6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1'\0\3\0'\1\4\0006\2\5\0'\4\6\0'\5\a\0'\6\b\0\18\a\0\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\n\0'\6\v\0\18\a\0\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\f\0'\6\r\0\18\a\1\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\14\0'\6\15\0\18\a\1\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\16\0'\6\17\0\18\a\1\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\18\0'\6\19\0\18\a\1\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\20\0'\6\21\0\18\a\0\0'\b\t\0&\6\b\6B\2\4\0016\2\5\0'\4\6\0'\5\22\0'\6\23\0B\2\4\1K\0\1\0007<CMD>lua require('telescope.builtin').resume()<CR>\agrG<CMD>lua require('telescope.builtin').buffers({sort_lastused=true,\agbÅ\1<CMD>lua require('telescope.builtin').grep_string({additional_args=function(options) return {'--hidden', '--no-ignore'} end,\agO8<CMD>lua require('telescope.builtin').grep_string({\ago<CMD>lua require('telescope.builtin').live_grep({additional_args=function(options) return {'--hidden', '--no-ignore'} end,\agC6<CMD>lua require('telescope.builtin').live_grep({\agcR<CMD>lua require('telescope.builtin').find_files({hidden=true,no_ignore=true,\agF\v})<CR>6<CMD>lua require('telescope.builtin').git_files({\agf\6n\bmapElayout_strategy='vertical',layout_config={width=0.9, height=0.9}hlayout_strategy='horizontal',layout_config={width=0.9, height=0.9, mirror=false, preview_width=0.6}\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: vim-floaterm
time([[Config for vim-floaterm]], true)
try_loadstring("\27LJ\2\nç\2\0\0\5\0\14\1\0246\0\0\0*\1\0\0=\1\1\0006\0\0\0*\1\0\0=\1\2\0006\0\0\0'\1\4\0=\1\3\0006\0\5\0'\2\6\0'\3\a\0'\4\b\0B\0\4\0016\0\5\0'\2\t\0'\3\a\0'\4\n\0B\0\4\0016\0\v\0'\2\f\0005\3\r\0B\0\3\1K\0\1\0\1\0\2\nguifg\tnone\nguibg\tnone\19FloatermBorder\ahi\"<c-\\><c-n>:FloatermToggle<cr>\6t\24:FloatermToggle<cr>\n<F11>\6n\bmap\5\19floaterm_title\20floaterm_height\19floaterm_width\6g›ûäÆ\15î‹æˇ\3\0", "config", "vim-floaterm")
time([[Config for vim-floaterm]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\nˆ\1\0\0\5\0\v\0\0236\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0016\0\5\0'\2\6\0'\3\a\0'\4\b\0B\0\4\0016\0\5\0'\2\6\0'\3\t\0'\4\n\0B\0\4\1K\0\1\0\21:diffget //3<cr>\agr\21:diffget //2<cr>\agl\6n\bmap\22cnoreabbrev gs Gs\26command! Gs :Git | on%cnoreabbrev gpf Git push --force\28cnoreabbrev gp Git push\bcmd\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: treesitter-unit
time([[Config for treesitter-unit]], true)
try_loadstring("\27LJ\2\nõ\3\0\0\6\0\15\0!6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\4\0'\4\v\0005\5\f\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\a\0'\4\r\0005\5\14\0B\0\5\1K\0\1\0\1\0\1\fnoremap\0028:<c-u>lua require\"treesitter-unit\".select(true)<CR>\1\0\1\fnoremap\0024:<c-u>lua require\"treesitter-unit\".select()<CR>\6o\1\0\1\fnoremap\0023:lua require\"treesitter-unit\".select(true)<CR>\aau\1\0\1\fnoremap\2/:lua require\"treesitter-unit\".select()<CR>\aiu\6x\20nvim_set_keymap\bapi\bvim\0", "config", "treesitter-unit")
time([[Config for treesitter-unit]], false)
-- Config for: nvim-lsputils
time([[Config for nvim-lsputils]], true)
try_loadstring("\27LJ\2\næ\5\0\0\4\0\23\0A6\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\5\0B\1\2\0029\1\6\1=\1\3\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\t\1=\1\a\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\v\1=\1\n\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\r\1=\1\f\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\15\1=\1\14\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\b\0B\1\2\0029\1\17\1=\1\16\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\19\0B\1\2\0029\1\20\1=\1\18\0006\0\0\0009\0\1\0009\0\2\0006\1\4\0'\3\19\0B\1\2\0029\1\22\1=\1\21\0K\0\1\0\22workspace_handler\21workspace/symbol\21document_handler\20lsputil.symbols textDocument/documentSymbol\27implementation_handler textDocument/implementation\27typeDefinition_handler textDocument/typeDefinition\24declaration_handler\29textDocument/declaration\23definition_handler\28textDocument/definition\23references_handler\22lsputil.locations\28textDocument/references\24code_action_handler\23lsputil.codeAction\frequire\28textDocument/codeAction\rhandlers\blsp\bvim\0", "config", "nvim-lsputils")
time([[Config for nvim-lsputils]], false)
-- Config for: vim-hexokinase
time([[Config for vim-hexokinase]], true)
try_loadstring("\27LJ\2\nL\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\19foregroundfull\28Hexokinase_highlighters\6g\bvim\0", "config", "vim-hexokinase")
time([[Config for vim-hexokinase]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nÄ\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\tmode\29lsp_document_diagnostics\29use_lsp_diagnostic_signs\2\15auto_close\2\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: vim-abolish
time([[Config for vim-abolish]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\26cnoreabbrev S Subvert\28cnoreabbrev %S %Subvert\bcmd\0", "config", "vim-abolish")
time([[Config for vim-abolish]], false)
-- Config for: vim-vsnip
time([[Config for vim-vsnip]], true)
try_loadstring("\27LJ\2\nx\0\0\4\0\a\0\f6\0\0\0+\1\1\0=\1\1\0006\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0K\0\1\0\v/vsnip\vconfig\fstdpath\afn\22vsnip_snippet_dir\24vsnip_extra_mapping\6g\0", "config", "vim-vsnip")
time([[Config for vim-vsnip]], false)
-- Config for: Navigator.nvim
time([[Config for Navigator.nvim]], true)
try_loadstring("\27LJ\2\nÒ\2\0\0\5\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0'\2\5\0'\3\6\0'\4\a\0B\0\4\0016\0\4\0'\2\5\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0'\2\5\0'\3\n\0'\4\v\0B\0\4\0016\0\4\0'\2\5\0'\3\f\0'\4\r\0B\0\4\1K\0\1\0.<CMD>lua require('Navigator').right()<CR>\n<c-l>+<CMD>lua require('Navigator').up()<CR>\n<c-k>-<CMD>lua require('Navigator').down()<CR>\n<c-j>-<CMD>lua require('Navigator').left()<CR>\n<c-h>\5\bmap\1\0\2\14auto_save\fcurrent\20disable_on_zoom\1\nsetup\14Navigator\frequire\0", "config", "Navigator.nvim")
time([[Config for Navigator.nvim]], false)
-- Config for: vim-startify
time([[Config for vim-startify]], true)
try_loadstring("\27LJ\2\nú\2\0\0\a\0\v\0\0236\0\0\0004\1\3\0005\2\2\0004\3\3\0'\4\3\0006\5\4\0009\5\5\5B\5\1\2&\4\5\4>\4\1\3=\3\6\2>\2\1\1=\1\1\0006\0\0\0)\1\1\0=\1\a\0006\0\0\0)\1\1\0=\1\b\0006\0\0\0005\1\n\0=\1\t\0K\0\1\0\1\17\0\0\6a\6r\6s\6t\6n\6e\6o\6i\3\1\3\2\3\3\3\4\3\a\3\b\3\t\3\0\28startify_custom_indices\28startify_enable_special startify_change_to_vcs_root\vheader\vgetcwd\afn\31 Most recently updated in \1\0\1\ttype\bdir\19startify_lists\6g\0", "config", "vim-startify")
time([[Config for vim-startify]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\v6\1\0\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\2\a\1\3\0X\1\2Ä+\1\1\0L\1\2\0+\1\2\0L\1\2\0\5\fbufname\afn\bvimØ\5\1\0\6\0\"\0)6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0005\5\22\0=\5\23\4=\4\24\0035\4\25\0=\4\26\3=\3\27\2B\0\2\0016\0\28\0'\2\29\0'\3\30\0'\4\31\0B\0\4\0016\0\28\0'\2\29\0'\3 \0'\4!\0B\0\4\1K\0\1\0\29:BufferLineCyclePrev<cr>\r<S-Down>\29:BufferLineCycleNext<cr>\v<S-Up>\6n\bmap\15highlights\rmodified\1\0\1\nguibg\tnone\23indicator_selected\nguifg\1\0\2\14highlight\vNormal\14attribute\abg\1\0\1\nguibg\tnone\20buffer_selected\1\0\1\nguifg\f#e5c463\14duplicate\1\0\1\nguibg\tnone\btab\1\0\1\nguibg\tnone\15background\1\0\1\nguibg\tnone\tfill\1\0\0\1\0\1\nguibg\tnone\foptions\1\0\0\18custom_filter\0\20separator_style\1\3\0\0\5\5\1\0\b\22max_prefix_length\3\0\rtab_size\3\25\20max_name_length\3#\18modified_icon\tüñç\20show_close_icon\1\28show_buffer_close_icons\1\fnumbers\tnone\tview\16multiwindow\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
-- Config for: vim-bbye
time([[Config for vim-bbye]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27cnoreabbrev bd Bdelete\bcmd\0", "config", "vim-bbye")
time([[Config for vim-bbye]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\në\5\0\0\5\0\24\0(6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\4\0'\1\6\0=\1\5\0006\0\4\0)\1\30\0=\1\a\0006\0\4\0)\1\1\0=\1\b\0006\0\4\0)\1\1\0=\1\t\0006\0\4\0)\1\1\0=\1\n\0006\0\4\0)\1\1\0=\1\v\0006\0\4\0005\1\r\0=\1\f\0006\0\4\0005\1\15\0005\2\16\0=\2\17\0015\2\18\0=\2\19\1=\1\14\0006\0\20\0'\2\21\0B\0\2\0029\0\22\0005\2\23\0B\0\2\1K\0\1\0\1\0\1\15auto_close\2\nsetup\14nvim-tree\frequire\vfolder\1\0\2\topen\bÓóæ\fdefault\bÓóø\bgit\1\0\5\14untracked\b‚òÖ\frenamed\b‚ûú\runmerged\bÓúß\vstaged\b‚úì\runstaged\b‚úó\1\0\2\fsymlink\bÔíÅ\fdefault\bÓòí\20nvim_tree_icons\1\0\3\nfiles\3\1\ffolders\3\1\bgit\3\1\25nvim_tree_show_icons\27nvim_tree_allow_resize\21nvim_tree_git_hl\29nvim_tree_indent_markers\27nvim_tree_quit_on_open\20nvim_tree_width\tleft\19nvim_tree_side\6g}:lua if ft() == 'NvimTree' or ft() == 'startify' then vim.cmd('NvimTreeToggle') else vim.cmd('NvimTreeFindFile') end<cr>\n<c-f>\6n\bmap\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nè\1\0\0\6\0\a\2\0266\0\0\0009\0\1\0'\2\2\0B\0\2\2\23\0\0\0\b\0\1\0X\1\17Ä6\1\0\0009\1\3\1'\3\2\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2\v\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\2\0;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim:\0\2\4\1\3\0\a-\2\0\0009\2\1\0029\2\2\0029\3\0\0018\2\3\2=\2\0\1L\1\2\0\2¿\fdefault\fpresets\tkind\2\0\1\t\1\f\1=6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1(Ä6\1\0\0009\1\1\0019\1\b\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\t\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\20Ä-\1\0\0B\1\1\2\15\0\1\0X\2\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\v\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\3¿\n<Tab>\5!<Plug>(vsnip-expand-or-jump)\20vsnip#available\6n\n<C-n>\27nvim_replace_termcodes\bapi\rfeedkeys\15pumvisible\afn\bvim\2õ\2\0\1\t\0\v\1+6\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\6\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\a\0B\1\3\1X\1\22Ä6\1\0\0009\1\1\0019\1\b\1B\1\1\2\t\1\0\0X\1\14Ä6\1\0\0009\1\1\0019\1\3\0016\3\0\0009\3\4\0039\3\5\3'\5\t\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\n\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\5\28<Plug>(vsnip-jump-prev)\20vsnip#available\6n\n<C-p>\27nvim_replace_termcodes\bapi\rfeedkeys\15pumvisible\afn\bvim\2˜\a\1\0\r\0:\0]6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0023\3\4\0009\4\5\0005\6\b\0009\a\1\0019\a\6\a9\a\a\a=\a\t\0065\a\n\0=\a\v\0065\a\f\0=\a\r\0065\a\15\0003\b\14\0=\b\16\a=\a\17\0065\a\19\0003\b\18\0=\b\20\a=\a\21\0064\a\5\0005\b\22\0>\b\1\a5\b\23\0>\b\2\a5\b\24\0>\b\3\a5\b\25\0>\b\4\a=\a\26\0065\a\29\0009\b\27\0009\b\28\b)\n¸ˇB\b\2\2=\b\30\a9\b\27\0009\b\28\b)\n\4\0B\b\2\2=\b\31\a9\b\27\0009\b \b)\n¸ˇB\b\2\2=\b!\a9\b\27\0009\b\"\b)\n\4\0B\b\2\2=\b#\a9\b\27\0009\b$\bB\b\1\2=\b%\a9\b\27\0009\b&\bB\b\1\2=\b'\a9\b\27\0009\b(\b5\n+\0009\v)\0009\v*\v=\v,\nB\b\2\2=\b-\a3\b.\0=\b/\a3\b0\0=\b1\a=\a\27\6B\4\2\0016\0042\0'\0063\0'\a4\0'\b5\0'\t6\0'\n7\0'\v8\0'\f9\0&\b\f\bB\4\4\0012\0\0ÄK\0\1\0\t } }+{ name = 'look', max_item_count = 10 }\24{ name = 'emoji' },-{ name = 'spell', max_item_count = 10 },1lua require'cmp'.setup.buffer { sources = { \23gitcommit,markdown\rfiletype\aau\f<S-Tab>\0\n<Tab>\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-p>\21select_next_item\n<C-n>\21select_prev_item\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\fsources\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\2\19max_item_count\3\20\tname\rnvim_lsp\1\0\1\tname\nvsnip\15formatting\vformat\1\0\0\0\fsnippet\vexpand\1\0\0\0\17experimental\1\0\1\15ghost_text\2\15completion\1\0\1\16completeopt\26menu,menuone,noinsert\14preselect\1\0\0\tItem\18PreselectMode\nsetup\0\flspkind\14cmp.types\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: vim-bufonly
time([[Config for vim-bufonly]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25cnoreabbrev bo Bonly\bcmd\0", "config", "vim-bufonly")
time([[Config for vim-bufonly]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n…\4\0\0\6\0\24\0 6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0025\1\a\0005\2\4\0005\3\5\0=\3\6\2=\2\b\1=\1\3\0006\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\f\0005\4\v\0=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0004\5\0\0=\5\19\0044\5\0\0=\5\20\0045\5\21\0=\5\22\4=\4\23\3B\1\2\1K\0\1\0\npairs\fkeymaps\1\0\1\17goto_partner\14<leader>%\26highlight_pair_events\fdisable\1\0\4\venable\2\24fallback_cmd_normal)call matchit#Match_wrapper('',1,'n')\19goto_right_end\1\19highlight_self\1\14highlight\vindent\1\0\1\venable\2\1\0\2\venable\2\21use_languagetree\2\19ignore_install\1\0\0\1\2\0\0\fhaskell\nsetup\28nvim-treesitter.configs\17install_info\1\0\0\nfiles\1\2\0\0\17src/parser.c\1\0\2\burl5https://github.com/NTBBloodbath/tree-sitter-http\vbranch\tmain\thttp\23get_parser_configs\28nvim-treesitter.parsers\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: obvious-resize
time([[Config for obvious-resize]], true)
try_loadstring("\27LJ\2\nß\2\0\0\5\0\r\0\0276\0\0\0)\1\4\0=\1\1\0006\0\0\0)\1\1\0=\1\2\0006\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\3\0'\2\4\0'\3\a\0'\4\b\0B\0\4\0016\0\3\0'\2\4\0'\3\t\0'\4\n\0B\0\4\0016\0\3\0'\2\4\0'\3\v\0'\4\f\0B\0\4\1K\0\1\0\28:ObviousResizeRight<cr>\14<c-right>\27:ObviousResizeLeft<cr>\r<c-left>\27:ObviousResizeDown<cr>\r<c-down>\25:ObviousResizeUp<cr>\v<c-up>\5\bmap\28obvious_resize_run_tmux\27obvious_resize_default\6g\0", "config", "obvious-resize")
time([[Config for obvious-resize]], false)
-- Config for: quick-scope
time([[Config for quick-scope]], true)
try_loadstring("\27LJ\2\n:\0\0\2\0\3\0\0046\0\0\0005\1\2\0=\1\1\0K\0\1\0\1\5\0\0\6f\6F\6t\6T\25qs_highlight_on_keys\6g\0", "config", "quick-scope")
time([[Config for quick-scope]], false)
-- Config for: vim-commentary
time([[Config for vim-commentary]], true)
try_loadstring("\27LJ\2\nÿ\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0$nmap <leader>c <Plug>Commentary$omap <leader>c <Plug>Commentary$xmap <leader>c <Plug>Commentary)nmap <leader>cc <Plug>CommentaryLine\bcmd\bvim\0", "config", "vim-commentary")
time([[Config for vim-commentary]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\n∫\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\23code_action_prompt\1\0\4\venable\2\18sign_priority\3\20\tsign\1\17virtual_text\2\1\0\2\21code_action_icon\5\29use_saga_diagnostic_sign\2\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: rest.nvim
time([[Config for rest.nvim]], true)
try_loadstring("\27LJ\2\n®\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\2\ftimeout\3ñ\1\fenabled\2\1\0\3\26skip_ssl_verification\1\28result_split_horizontal\1\20jump_to_request\1\nsetup\14rest-nvim\frequire\0", "config", "rest.nvim")
time([[Config for rest.nvim]], false)
-- Config for: vim-wordmotion
time([[Config for vim-wordmotion]], true)
try_loadstring("\27LJ\2\n4\0\0\2\0\3\0\0046\0\0\0'\1\2\0=\1\1\0K\0\1\0\r<leader>\22wordmotion_prefix\6g\0", "config", "vim-wordmotion")
time([[Config for vim-wordmotion]], false)
-- Config for: vim-subversive
time([[Config for vim-subversive]], true)
try_loadstring("\27LJ\2\nÀ\2\0\0\5\0\6\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0ç\1:<c-u>call subversive#singleMotion#substituteLineSetup(v:register, v:count)<cr>:set opfunc=subversive#singleMotion#substituteLine<cr>g@l\ammÜ\1:<c-u>call subversive#singleMotion#preSubstitute(v:register, 0, '')<cr>:set opfunc=subversive#singleMotion#substituteMotion<cr>g@\6m\6n\bmap\0", "config", "vim-subversive")
time([[Config for vim-subversive]], false)
-- Config for: sonokai
time([[Config for sonokai]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "sonokai")
time([[Config for sonokai]], false)
-- Config for: vim-dadbod-ui
time([[Config for vim-dadbod-ui]], true)
try_loadstring("\27LJ\2\nê\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\25db_ui_use_nerd_fonts\29db_ui_show_database_icon%db_ui_auto_execute_table_helpers\6g\bvim\0", "config", "vim-dadbod-ui")
time([[Config for vim-dadbod-ui]], false)
-- Config for: codi.vim
time([[Config for codi.vim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28cnoreabbrev Eval Codi!!\bcmd\0", "config", "codi.vim")
time([[Config for codi.vim]], false)
-- Config for: splitjoin.vim
time([[Config for splitjoin.vim]], true)
try_loadstring("\27LJ\2\nf\0\0\5\0\6\0\v6\0\0\0'\2\1\0'\3\2\0'\4\3\0B\0\4\0016\0\0\0'\2\1\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0\24:SplitjoinSplit<cr>\ags\23:SplitjoinJoin<cr>\agj\6n\bmap\0", "config", "splitjoin.vim")
time([[Config for splitjoin.vim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CodeActionMenu lua require("packer.load")({'nvim-code-action-menu'}, { cmd = "CodeActionMenu", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
