local utils = require("utils")

local startup = require("startup")
local keys = require("mappings")
local ui = require("ui")

local other_opts = {
  notification_handling = "AlwaysShow",
  use_ime = true,
  -- macos_forward_to_ime_modifier_mask = 'SHIFT',
}
return utils.merge({ other_opts, startup, keys, ui })
