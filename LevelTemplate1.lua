local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
physics.start()
physics.setDrawMode("hybrid")
physics.setGravity(0,0)

local function failScreen()
		--set to remove event listeners and stuff
		composer.removeScene("Level1")
		composer.gotoScene("MainMenu")
end

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

------------USED IN ALL LEVELS--------------------------------------------------------------------------------------
local sightRight = 	{0,0, 100,-20, 100,20}
local sightDown = 	{0,0, 20,100, -20,100}
local sightLeft = 	{0,0, -100,20, -100,-20}
local sightUp = 	{0,0, -20,-100, 20,-100}

hasKnife = false
hasKey   = false
canMove  = true
------------USED IN ALL LEVELS--------------------------------------------------------------------------------------


i = 0		--two guard, so two counters, you dig?
j = 0

local prisonerSheet
local guardSheet
local options
local sequenceData

local prisoner

--[[
---HERE YOU DECLARE EVERYTHING YOU'RE GOING TO USE---->>>>>>>

	local chair
	local wall
	local key 
	etc

-----<<<<<<<<<<<-----------------------------------------------------------------------]]


-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
	
		
		---------USED EVEY LEVEL---------------------------------------------------------------------------------------------------
		options =	{	width = 50,	height = 100,	numFrames = 24,	sheetContentWidth = 300, 	sheetContentHeight = 400 }
		sequenceData =	{
								{name="walkingdown",	frames = {1, 2, 3, 4, 5, 6 },		 time = 1000, loopCount = 1},  
								{name="walkingleft",	frames = {7, 8, 9, 10, 11, 12},	     time = 1000, loopCount = 1},
								{name="walkingright",	frames = {13, 14, 15, 16, 17, 18},	 time = 1000, loopCount = 1},
								{name="walkingup", 		frames = {19, 20, 21, 22, 23, 24}, 	 time = 1000, loopCount = 1}
						}

		prisonerSheet = graphics.newImageSheet("PrisonerWalking.png", options)
		guardSheet = graphics.newImageSheet("GuardWalks.png", options)
		-------------------------------------------------------------------USED EVERY LEVEL---------------------------------------
		
		prisoner = display.newSprite( prisonerSheet, sequenceData )		 																	prisoner.myName = "prisoner"
		
------------inserts----------------------------
		
		--sceneGroup:insert()
		
---------------------inserts---------------------
		
	
	--PHYSICS
		--CHARACTERS
		physics.addBody( prisoner, "dynamic", { density=0.0, friction=0, radius = 25} )
		
		--WORLD OBJECTS, PUT ALL OBJECTS PHYSICS HERE
		
		--physics.addBody("object", 	"static", { friction = .3})					"object".collType 			= "worldObject"
		

		--KEY ITEMS
		--physics.addBody(door, 			"static", { friction = .3})					door.collType			= "worldObject"			door.type = "door"
		--physics.addBody(knife, 			"static", { friction = .3})					knife.collType			= "worldObject"			knife.type = "knife"
		--physics.addBody(key, 				"static", { friction = .3, radius = 30})	key.collType 			= "worldObject"  		key.type = "key"
	
	------GUARD MOVE PATHS----------------------------------------------------------------------------------------------------------------------------------------------------
	
	--[[
	local movePath = {}
	movePath[1] = 	{ x=20, 	y=320, time==800,  	seq = ("walkingleft"), 	sight = 1} 
	movePath[2] = 	{ x=-30,	y=320, time==800,	seq = ("walkingleft"), 	sight = 1}
	movePath[3] = 	{ x=-80, 	y=320, time==800,  	seq = ("walkingleft"), 	sight = 1}
	movePath[4] = 	{ x=-80, 	y=370, time==800, 	seq = ("walkingdown"), 	sight = 2}
	movePath[5] = 	{ x=-30, 	y=370, time==800, 	seq = ("walkingright"), sight =	3}
	movePath[6] = 	{ x=20, 	y=370, time==800, 	seq = ("walkingright"), sight = 3}
	movePath[7] = 	{ x=70, 	y=370, time==800,  	seq = ("walkingright"), sight = 3}
	movePath[8] = 	{ x=70, 	y=320, time==800,  	seq = ("walkingup"),	sight = 4}
	]]

	
	
	--[[
	local function setPath1( guard1, path, seq)
		i = i + 1	if i > 8 	then i = 1 end
		-- changes sight for guard1
		if movePath[i].sight == 1 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightLeft }  , {} )		end
		if movePath[i].sight == 2 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightDown } , {} ) 		end
		if movePath[i].sight == 3 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightRight} , {} )			end
		if movePath[i].sight == 4 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightUp }    , {} ) 		end
													
		transition.to( guard1, { time=800, x=movePath[i].x, 	y=movePath[i].y, 	guard1:setSequence(movePath[i].seq)	} )
		guard1:play()
	end
	]]
	
	------------------------------------------------------------------------------GUARD MOVE PATHS----------------------------------------------------------------------------
	
	---------KEY EVENT--------------------------------------------------------------------------------------------------------------------------------------------------------
				function onKeyEvent(event)
						--print (event.keyName)
							if event.phase == "down" and canMove == true then
							canMove = false
											if 		event.keyName == "s" then
														prisoner:setSequence("walkingdown")
														prisoner:play()
														transition.to( prisoner, { time=800, y = prisoner.y + 50 } )
											elseif 	event.keyName == "a" then
														prisoner:setSequence("walkingleft")
														prisoner:play();
														transition.to( prisoner, { time=800, x = prisoner.x - 50 } )
											elseif 	event.keyName == "w" then
														prisoner:setSequence("walkingup")
														prisoner:play();
														transition.to( prisoner, { time=800, y = prisoner.y - 50 } )
											elseif 	event.keyName == "d" then
														prisoner:setSequence("walkingright")
														prisoner:play();
														transition.to( prisoner, { time=800, x = prisoner.x + 50 } )
											end
		
							--if guard1.exists ~= false then setPath1  ( guard1, path, seq )	end
		
				timer.performWithDelay(1800, setCanMove)
	end
	
end	
	------------------------------------------------------------------------------KEY EVENT-----------------------------------------------------------------------------------
	
	
	--TIMER TO SET THE PLAYER MOVING AGAIN--
	function setCanMove()
	print("set can move")
	canMove = true
	end
	
	-------EVERY THING TO DO WITH COLLISION (USED IN EVERY LEVEL)-------------------------------------------------------------------------------------------------------------
				local function onPreCollision( self, event ) 
						--DISABLES COLLISION FOR GUARDS FOR OTHER OBJECTS IN THE WORLD (WALLS, DOORS, KEYS ETC)
						local object = event.other
						if (object.collType == "worldObject") then
							event.contact.isEnabled = false
						end
				end


				local function prisonerCollision( self, event )
						if event.phase == "began" then 
		
						--IF THE PLAYER COMES INTO CONTACT WITH A GUARD
							if event.other.type == "guard" then
								if hasKnife == false then
									prisoner:pause()
									event.other:pause()
									transition.cancel(prisoner)
									transition.cancel(event.other)
									local mark = display.newImage("caught.png")
									mark.x = event.other.x
									mark.y = event.other.y - 80
									mark.xScale = .5
									mark.yScale = .5
									local myText = display.newText( "YOU GOT CAUGHT SON!", 100, 200, native.systemFont, 25 )
									myText:setFillColor( 1, 0, 0 )
									sceneGroup:insert(mark)
									sceneGroup:insert(myText)
									failScreen()
								end
			

						-- IF PLAYER HAS KNIFE, REMOVES THE GUARD!
								if hasKnife == true then 
									physics:removeBody(event.other)
									transition.cancel(prisoner)
									transition.to( prisoner, { time=1000, y = event.other.y, x = event.other.x } )
									event.other.exists = false
									display.remove(event.other, {time = 400}) 
									hasKnife = false
									local myText = display.newText( "THE KNIFE BROKE!", 100, 200, native.systemFont, 25 )
									myText:setFillColor( 1, 0, 0 )
								end
							end
			
						--IF THE PLAYER COLLIDES WITH THE KNIFE, "hasKnife" = TRUE
								if event.other.type == "knife" then
									display.remove(knife)
									hasKnife = true
								end
			
						--IF THE PLAYER COLLIDES WITH THE KEY, "hasKey" = TRUE
								if event.other.type == "key" then
									print("Got the Key")
									display.remove(key)
									hasKey = true
								end
					
						--IF THE PLAY HAS THE KEY AND HITS THE DOOR
								if event.other.type == "door" then		
									if hasKey == true then
										print("VICTORY")
										display.remove(prisoner)
										--winScreen()
									end
								end
			
							local object = event.other
								if (object.collType == "worldObject") then
									print("collided")
									prisoner:pause()
									transition.cancel(prisoner)
								end
			
				end
				prisoner.rotation = 0
				end

			local function objectCollide( self, event)

			--IF PLAYER HITS AN OBJECT IN THE WORLD (NOT GUARD, KEY, OR KNIFE)
					local object = event.other
						if (object.collType == "worldObject") then
							print("collided")
							prisoner:pause()
							transition.cancel(prisoner)
							event.contact.isEnabled = false
							if (event.other.x > prisoner.x) then transition.to( prisoner, { time=.1, x = prisoner.x - 1 } ) end
							if (event.other.x < prisoner.x) then transition.to( prisoner, { time=.1, x = prisoner.x + 1 } ) end
							if (event.other.y > prisoner.y) then transition.to( prisoner, { time=.1, y = prisoner.y - 1 } ) end
							if (event.other.y < prisoner.y) then transition.to( prisoner, { time=.1, y = prisoner.y + 1 } ) end
						end
			end
			
	-------------------------------------------------------------------------------------------------------------------COLLISION----------------------------------------------
				prisoner.collision = prisonerCollision
				prisoner:addEventListener( "collision", prisoner )

				prisoner.preCollision = objectCollide
				prisoner:addEventListener( "preCollision", prisoner )

				guard1.preCollision = onPreCollision
				guard1:addEventListener	( "preCollision", guard1 )

				guard2.preCollision = onPreCollision
				guard2:addEventListener( "preCollision", guard2 )
		
				Runtime:addEventListener("key", onKeyEvent)
				Runtime:addEventListener("prisoner", onKeyEvent)
	
	------------------------EVENT LISTENERS-----------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------EVENT LISTENERS----------------------------------------
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
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

    local sceneGroup = self.view
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

    local sceneGroup = self.view

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

-- -------------------------------------------------------------------------------

return scene