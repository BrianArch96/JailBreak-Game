local composer = require( "composer" )
local scene = composer.newScene()
--local physics = require("physics")
--physics.setDrawMode("hybrid")
physics.start()
physics.setGravity(0,0)

local bg = display.newImage("titlescreen.jpg")
bg.x = 149
bg.y = 178
bg.xScale = 0.3
bg.yScale = 0.27


local text1 = display.newImage("MenuText1.png")
text1.id = "ball"
text1.x = 150
text1.y = 410
text1.height = 250
text1.width = 320

local text2 = display.newImage("Instructions.png")
text2.id = "ball2"
text2.x = -150
text2.y = 420
text2.height = 300
text2.width = 300



local text3 = display.newImage("Backstory.png")
text3.id = "ball3"
text3.x = 500
text3.y = 360
text3.height = 280
text3.width = 300




local music1 = audio.loadSound("doorslam.wav")
--local doorsla2 = audio.play(music1)
--local doorsla1 = audio.play(music1)
--local doorsla3 = audio.play(music1)


local function onObjectTouch( event )
    if ( event.phase == "began" ) then
        composer.gotoScene("Level1", {effect = "fade", time = 300})
		local doorsla3 = audio.play(music1)
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
    
end

local function onObjectTouch1( event )
    if ( event.phase == "began" ) then
        composer.gotoScene("instructions", {effect = "fade", time = 300})
	local doorsla1 = audio.play(music1)
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
    
end

local function onObjectTouch2( event )
    if ( event.phase == "began" ) then
        composer.gotoScene("story", {effect = "fade", time = 300})
		local doorsla2 = audio.play(music1)
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
    
end








function scene:create( event )
local sceneGroup1 = self.view
sceneGroup1:insert(bg)
sceneGroup1:insert(text1)
sceneGroup1:insert(text2)
sceneGroup1:insert(text3)
end





-- "scene:show()"

function scene:show( event )

    local sceneGroup1 = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup1 = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup1 = self.view

    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene ) 
text1:addEventListener("touch", onObjectTouch)
text2:addEventListener("touch", onObjectTouch1)
text3:addEventListener("touch", onObjectTouch2)

-- -------------------------------------------------------------------------------

return scene





