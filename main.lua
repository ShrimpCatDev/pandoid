require("init")

bump=require("lib.bump")

function love.load()

    font=love.graphics.newImageFont("assets/font.png","abcdefghijklmnopqrstuvwxyz1234567890 !?()+-./*",1)
    love.graphics.setFont(font)

    love.window.setTitle("Freakout")
    state={
        lvl=require("level"),
        title=require("title")
    }
    gs=require "lib.hump.gamestate"
    gs.registerEvents()
    gs.switch(state.lvl)
end

function love.update(dt)
    input:update()
end 

function love.draw()

end