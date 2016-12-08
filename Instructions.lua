local composer = require( "composer" )
local scene = composer.newScene()


local title = display.newImage("title1.png")
title.x = 120
title.y = 260
title.height = 800
title.width =800


local key1 = display.newImage("key.png")
key1.x = -120
key1.y =220
key1.height = 80
key1.width = 80


local shiv1 = display.newImage("knife.png")
shiv1.x = 400
shiv1.y = 225
shiv1.height = 80
shiv1.width = 80


local explain = display.newImage("explain1.png")
explain.x = -120
explain.y = 400
explain.height = 600
explain.width = 600


local explain1 = display.newImage("explain2.png")
explain1.x = 300
explain1.y = 345
explain1.height = 600
explain1.width = 600


local instructions1 = display.newImage("Instructions1.png")
instructions1.x = 220
instructions1.y = 250
instructions1.height = 600
instructions1.width = 600


local goback1 = display.newImage("GOBACK.png")
goback1.id = "ball"
goback1.x = 220
goback1.y =550
goback1.height = 600
goback1.width = 600
music3 = audio.loadSound("doorslam.wav")
--local doorsla3 = audio.play(music3)


function scene:create( event )
local sceneGroup2 = self.view
sceneGroup2:insert(instructions1)
sceneGroup2:insert(explain)
sceneGroup2:insert(explain1)
sceneGroup2:insert(shiv1)
sceneGroup2:insert(key1)
sceneGroup2:insert(title)
sceneGroup2:insert(goback1)

end


local function onObjectTouch4( event )
    if ( event.phase == "began" ) then
        composer.gotoScene("MainMenu1", {effect = "fade", time = 300})
		local doorsla5 = audio.play(music3)
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
    
end

scene:addEventListener( "create", scene )
goback1:addEventListener("touch", onObjectTouch4)
return scene