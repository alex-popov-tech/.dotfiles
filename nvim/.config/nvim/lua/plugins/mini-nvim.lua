return function()
  require('mini.ai').setup()

  local map = require('mini.map')
  map.setup(
    {
      -- Highlight integrations (none by default)
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns(),
      },
      -- Symbols used to display data
      symbols = {
        encode = map.gen_encode_symbols.dot('4x2'),
      },
      -- Window options
      window = {
        -- Side to stick ('left' or 'right')
        side = 'right',
        -- Whether to show count of multiple integration highlights
        show_integration_count = false,
        -- Total width
        width = 10,
        -- Value of 'winblend' option
        winblend = 0,
      },
    })
  map.open()
end
