-- lazy loading helpers for vim.pack plugins.

local M = {}

-- load plugin + run setup on next event loop tick.
-- use for plugins that don't need to be available at the very first frame.
function M.later(fn)
  vim.schedule(fn)
end

-- register stub commands that load a plugin on first use.
-- cmds: list of command names to register as stubs.
-- setup_fn: called once on first command use. should call vim.pack.add(),
--           require().setup(), and re-register any alias commands.
-- after setup_fn, the triggered command is re-executed with its original
-- range and args preserved.
function M.on_cmd(cmds, setup_fn)
  local loaded = false
  for _, cmd in ipairs(cmds) do
    vim.api.nvim_create_user_command(cmd, function(opts)
      if not loaded then
        loaded = true
        -- delete stubs so plugins can register their own commands
        for _, c in ipairs(cmds) do
          pcall(vim.api.nvim_del_user_command, c)
        end
        setup_fn()
      end
      -- re-execute with range and args preserved
      local prefix = ""
      if opts.range == 2 then
        prefix = opts.line1 .. "," .. opts.line2
      elseif opts.range == 1 then
        prefix = tostring(opts.line1)
      end
      vim.cmd(prefix .. cmd .. " " .. (opts.args or ""))
    end, { nargs = "*", range = "%", bang = true })
  end
end

return M
