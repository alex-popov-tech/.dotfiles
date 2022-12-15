return function()
  require('smart-splits').setup({
    resize_mode = {
      -- key to exit persistent resize mode
      quit_key = '<ESC>',
      -- keys to use for moving in resize mode
      -- in order of left, down, up' right
      resize_keys = { 'l', 'd', 'u', 'r' },
      -- set to true to silence the notifications
      -- when entering/exiting persistent resize mode
      silent = false,
      -- must be functions, they will be executed when
      -- entering or exiting the resize mode
      hooks = {
        on_enter = nil,
        on_leave = function()
          require('bufresize').register()
        end
      }
    },
    default_amount = 5,
  })
  map("", "<c-h>", require('smart-splits').move_cursor_left)
  map("", "<c-j>", require('smart-splits').move_cursor_down)
  map("", "<c-k>", require('smart-splits').move_cursor_up)
  map("", "<c-l>", require('smart-splits').move_cursor_right)
  map("", "<c-w>", require('smart-splits').start_resize_mode)
end
