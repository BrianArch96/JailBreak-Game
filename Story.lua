local composer = require( "composer" )
local scene = composer.newScene()

local goback1 = display.newImage("GOBACK.png")
goback1.id = "ball"
goback1.x = 300
goback1.y =550
goback1.height = 500
goback1.width = 800
music3 = audio.loadSound("doorslam.wav")
--local doorsla3 = audio.play(music3)

local bobgod = display.newImage("godsdiary.png")
bobgod.x=160
bobgod.y=240
bobgod.height = 450
bobgod.width = 820
music4 = audio.loadSound("doorslam.wav")
local doorsla6 = audio.play(music4)


function scene:create( event )
local sceneGroup = self.view
sceneGroup:insert(bobgod)
sceneGroup:insert(goback1)
end

local function onObjectTouch3( event )
    if ( event.phase == "began" ) then
        composer.gotoScene("MainMenu1", {effect = "fade", time = 300})
		local doorsla6 = audio.play(music4)
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
    
end





scene:addEventListener( "create", scene )
goback1:addEventListener("touch", onObjectTouch3)
return scene