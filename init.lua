conf=require 'config'

shove=require 'lib.shove'
baton=require 'lib.baton'
color=require 'lib.hex2color'
require 'lib.func'

input=baton.new(conf.input)

lg=love.graphics

shove.setResolution(conf.gW,conf.gH,{fitMethod=conf.fit,scalingFilter=conf.textureFilter,renderMode="direct"})
shove.setWindowMode(conf.wW,conf.wH,{resizable=true,vsync=conf.vsync})

timer=require("lib.hump.timer")