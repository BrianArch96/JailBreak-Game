local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )

local bg = display.newImage("endscreen.png")
bg.x = 200
bg.y = 250
bg.xScale = 2
bg.yScale = 2.5

end 


scene:addEventListener( "create", scene )


return scene
