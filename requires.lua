local function import(t,prefix)
    local prefix = prefix or ""
    for i, v in ipairs(t) do
        t[i] = require(prefix .. v)
    end
    return t
end

require 'helpers'
Class = require 'libraries/class'
push = require 'libraries/push'
GS = require 'libraries/gamestate'
Timer = require "libraries/timer"
import({'menu','ended','playing','paused'},'states/')
require 'Button'
require 'Row'
require 'Place'
require 'Pin'
require 'images/sprite'
require 'music/music'
require 'fonts/fonts'