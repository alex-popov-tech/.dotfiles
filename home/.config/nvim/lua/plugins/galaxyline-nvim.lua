local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {"LuaTree", "vista", "dbui"}

local space = {
  Space = {
    provider = function()
      return " "
    end
  }
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

gls.left = {
  {
    FileIcon = {
      provider = "FileIcon",
      condition = buffer_not_empty,
      highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color}
    }
  },
  {
    FileName = {
      provider = function() return vim.fn.expand("%:F") end,
      condition = buffer_not_empty
    }
  },
  {
    DiagnosticError = {
      provider = {"DiagnosticError", "DiagnosticWarn"},
      icon = " "
    }
  },
  {
    DiagnosticWarn = {
      provider = "DiagnosticHint",
      icon = " "
    }
  }
}

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.right = {
  {
    GitIcon = {
      provider = function()
        return " "
      end,
      condition = require("galaxyline.provider_vcs").check_git_workspace
    }
  },
  {
    GitBranch = {
      provider = "GitBranch",
      condition = require("galaxyline.provider_vcs").check_git_workspace
    }
  },
  {
    LineInfo = {
      provider = "LineColumn"
    }
  },
  space
}
