local conf = {}

conf.gW = 160
conf.gH = 128

conf.wW = conf.gW*5
conf.wH = conf.gH*5

conf.textureFilter = "nearest"
conf.fit = "aspect"
conf.render="direct"
conf.vsync=true

conf.input={
    controls={
        left={"key:left"},
        right={"key:right"}
    },
    pairs={

    },
    joystick = love.joystick.getJoysticks()[1],
}

return conf