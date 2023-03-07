local utils = require 'utils'

local startup = require 'startup'
local keys = require 'keys'
local ui = require 'ui'

local other_opts = {use_ime = false}
return utils.merge({other_opts, startup, keys, ui})
