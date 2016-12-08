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


---HERE YOU DECLARE EVERYTHING YOU'RE GOING TO USE




local desert 
local fencetop 
local fenceside  
local stoneground  
local court 
local table1 
local table2
local fencetop 
local door  
local bench  
local barbell 
local benchside
local bin1
local bin2
local binside 
local binside1
local bench1
local bench2 
local bench3
local bench4
local needkey
local needkey1


	

-----<<<<<<<<<<<-----------------------------------------------------------------------


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
		
		prisoner = display.newSprite( prisonerSheet, sequenceData )		prisoner.x = 100 prisoner.y =100 			prisoner.myName = "prisoner"
		guard1 = display.newSprite( guardSheet, sequenceData )								guard1.x=70 			guard1.y=320			guard1.type = "guard"
		guard2 = display.newSprite( guardSheet, sequenceData )								guard2.x=320		guard2.y=120			guard2.type = "guard"
		guard3 = display.newSprite( guardSheet, sequenceData )								guard3.x=-240		guard3.y=400		guard3.type = "guard"
		guard4 = display.newSprite( guardSheet, sequenceData )								guard4.x=430		guard4.y=300		guard4.type = "guard"
		
		needkey = display.newText("You need the key to", 160, 380, "BloodLust.ttf", 60)
		needkey1 = display.newText("open the door!!!", 160, 420, "BloodLust.ttf", 60)
		needkey:setFillColor(0,0,0)
		needkey1:setFillColor(0,0,0)
		needkey.isVisible = false
		needkey1.isVisible = false
		


 desert = display.newImage("desert.jpg")
desert.x = 100
desert.y = 100
desert.height = 1000
desert.width = 1000

fencetop = display.newImage("fencetop.png")
fencetop.x = 230
fencetop.y = 30
fencetop.height = 60
fencetop.width = 1000

fenceside  = display.newImage("fenceside.png")
fenceside.x = -257
fenceside.y = 270
fenceside.height = 420
fenceside.width = 20

stoneground  = display.newImage("ground.jpe")
stoneground.x = 400
stoneground.y = 300
stoneground.height = 485
stoneground.width = 600

court = display.newImage("court.jpg")
court.x = 400
court.y = 160
court.height = 200
court.width = 400

table1 = display.newImage("table.png")
table1.x = 200
table1.y = 370
table1.heigth = 40
table1.width = 130

table2 = display.newImage("table.png")
table2.x = 400
table2.y = 370
table2.heigth = 40
table2.width = 130

fencetop = display.newImage("fencetop.png")
fencetop.x = 230
fencetop.y = 455
fencetop.height = 60
fencetop.width = 1000

door = display.newImage("endwall.png")
door.x = 533
door.y = 455
door.height = 60
door.width = 70

bench1 = display.newImage("benchside.png")
bench1.x = 180
bench1.y = 135
bench1.height = 155
bench1.width = 35

barbell = display.newImage("barbell.jpg")
barbell.x = -100
barbell.y = 400
barbell.height = 30
barbell.width = 150

benchside = display.newImage("benchside.png")
benchside.x = 85
benchside.y = 72
benchside.height = 31
benchside.width = 160

bin1 = display.newImage("bin.png")
bin1.x = 50
bin1.y = 400
bin1.height = 50
bin1.width = 40

bin2 = display.newImage("bin.png")
bin2.x = 80
bin2.y = 400
bin2.height = 50
bin2.width = 40

binside1 = display.newImage("binside.png")
binside1.x = -220
binside1.y = 227
binside1.height = 40
binside1.width = 50

binside2 = display.newImage("binside.png")
binside2.x = -220
binside2.y = 180
binside2.height = 40
binside2.width = 50

bench2 = display.newImage("benchside.png")
bench2.x = 400
bench2.y = 410
bench2.height = 30
bench2.width = 160

bench3 = display.newImage("benchside.png")
bench3.x = 200
bench3.y = 410
bench3.height = 30
bench3.width = 160

bench4 = display.newImage("benchside.png")
bench4.x = 400
bench4.y = 330
bench4.height = 30
bench4.width = 160

bench = display.newImage("benchside.png")
bench.x = 200
bench.y = 330
bench.height = 30
bench.width = 160

		
------------inserts----------------------------
		
		--sceneGroup:insert()
sceneGroup:insert(stoneground)
sceneGroup:insert(desert)
sceneGroup:insert(fencetop)
sceneGroup:insert(court)
sceneGroup:insert(bench)
sceneGroup:insert(bench1)
sceneGroup:insert(bench3)
sceneGroup:insert(bench4)
sceneGroup:insert(bench2)
sceneGroup:insert(binside1)
sceneGroup:insert(binside2)
sceneGroup:insert(bin1)
sceneGroup:insert(bin2)
sceneGroup:insert(benchside)
sceneGroup:insert(barbell)
sceneGroup:insert(door)
sceneGroup:insert(fenceside)
sceneGroup:insert(desert)
sceneGroup:insert(table1)
sceneGroup:insert(table2)
sceneGroup:insert(prisoner)
sceneGroup:insert(guard1)
sceneGroup:insert(guard2)
sceneGroup:insert(guard3)
sceneGroup:insert(guard4)


		
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