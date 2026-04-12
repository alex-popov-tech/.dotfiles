local wezterm = require("wezterm")

local session = require("session")
local keys = require("mappings")
local ui = require("ui")

local config = wezterm.config_builder()
for _, tbl in ipairs({ session, keys, ui }) do
  for k, v in pairs(tbl) do
    config[k] = v
  end
end
return config
