local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
physics.start()
--physics.setDrawMode("hybrid")
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
local sightRight = 	{0,0, 50,-20, 50,20}
local sightDown = 	{0,0, 20,50, -20,50}
local sightLeft = 	{0,0, -50,20, -50,-20}
local sightUp = 	{0,0, -20,-50, 20,-50}
local area    =     {0,35, 0,-35, 35,0, -35,0}
hasKnife = false
hasKey   = false
canMove  = true
Useonce = true
lastLevel = false
gaurd1exists = true
gaurd2exists = true
gaurd3exists = true
KnifeExists = true
------------USED IN ALL LEVELS--------------------------------------------------------------------------------------


i = 0		--two guard, so two counters, you dig?
j = 0
k = 0

local prisonerSheet
local guardSheet
local options
local sequenceData

local prisoner


---HERE YOU DECLARE EVERYTHING YOU'RE GOING TO USE---->>>>>>>

	--local backround
	local prisoner
	local guard1
	local guard2
	local bg
	local tiles
	local celltop1
	local celltop2
	local wall
	local wall2
	local wall3
	local wall4
	local cooker
	local sink
	local fridge
	local table1
	local table2
	local table3
	local table4
	local chairs1
	local chairs2
	local chairs3
	local chairs4
	local wallbottom1
	local wallbottom2 
	

-----<<<<<<<<<<<----------------------------------------------------------------------


--scene:create()
function scene:create( event )

    local sceneGroup = self.view
		
		
		---------USED EVEY LEVEL---------------------------------------------------------------------------------------------------
		options =	{	width = 50,	height = 100,	numFrames = 24,	sheetContentWidth = 300, 	sheetContentHeight = 400 }
		options1 =	{	width = 100,height = 150,	numFrames = 24,	sheetContentWidth = 600, 	sheetContentHeight = 600 }
		sequenceData =	{
								{name="walkingdown",	frames = {1, 2, 3, 4, 5, 6 },		 time = 600, loopCount = 1},  
								{name="walkingleft",	frames = {7, 8, 9, 10, 11, 12},	     time = 600, loopCount = 1},
								{name="walkingright",	frames = {13, 14, 15, 16, 17, 18},	 time = 600, loopCount = 1},
								{name="walkingup", 		frames = {19, 20, 21, 22, 23, 24}, 	 time = 600, loopCount = 1}
						}

		prisonerSheet = graphics.newImageSheet("PrisonerWalking.png", options)
		guardSheet = graphics.newImageSheet("GuardWalksFlashLight.png", options1)
		-------------------------------------------------------------------USED EVERY LEVEL---------------------------------------
		
		prisoner = display.newSprite( prisonerSheet, sequenceData )	prisoner.x=-230 		prisoner.y=120	 		prisoner.myName = "prisoner"
		guard1 = display.newSprite( guardSheet, sequenceData )								guard1.x=80		guard1.y=180			guard1.type = "guard"
		guard2 = display.newSprite( guardSheet, sequenceData )								guard2.x=100		guard2.y=370	guard2.type = "guard"
		guard3 = display.newSprite( guardSheet, sequenceData )								guard3.x=300		guard3.y=350	guard3.type = "guard"
		
		
		tiles = display.newImage("tiles.png")   tiles.x = 400  tiles.y = 150 tiles.height = 200 tiles.width = 400
		celltop1 = display.newImage("walltop.png") celltop1.x = -100 celltop1.y = 25 celltop1.height = 60 celltop1.width = 500
		celltop2 = display.newImage("walltop.png") celltop2.x = 401 celltop2.y = 25 celltop2.height = 60 celltop2.width = 500
		
		bg = display.newImage("background.jpg")
		
		key1 = display.newImage("key.png")  key1.x = -10 key1.y = 100 key1.height = 50 key1.width = 50
		knife = display.newImage("knife.png")  knife.x = 500 knife.y = 200 knife.height = 50 knife.width = 50
		wall2 = display.newImage("wallrotate.png")  wall2.x = 500 wall2.y = 240 wall2.height = 30 wall2.width = 200

		wall = display.newImage("wall.png") wall.x = 220 wall.y = 150 wall.height = 200 wall.width = 40
		
		wall3 = display.newImage("wall.png") wall3.x = -300 wall3.y = 200 wall3.height = 500 wall3.width = 40
		
		wall4 = display.newImage("wall.png") wall4.x = 610 wall4.y = 200 wall4.height = 500 wall4.width = 40
 
		cooker = display.newImage("cooker.png") cooker.x = 530 cooker.y = 100 cooker.height = 90 cooker.width = 90
 
		sink = display.newImage("sink.png") sink.x = 400 sink.y = 100 sink.height = 80 sink.width = 140
 
		fridge = display.newImage("fridge.png") fridge.x = 290 fridge.y = 100 fridge.height = 90 fridge.width = 60
 
		table1 = display.newImage("table.png") table1.x = -120 table1.y = 70 table1.height = 80 table1.width = 140

		table2 = display.newImage("table.png") table2.x = 130 table2.y = 70 table2.height = 80 table2.width = 145

		table3 = display.newImage("table.png") table3.x = 50 table3.y = 270 table3.height = 90   table3.width = 145
 
		table4 = display.newImage("table.png") table4.x = -180 table4.y = 250 table4.height = 90 table4.width = 140
 
		chairs1 = display.newImage("chairs.png") chairs1.x = -120 chairs1.y = 120 chairs1.height = 47 chairs1.width = 130

		chairs2 = display.newImage("chairs.png") chairs2.x = 130 chairs2.y = 120 chairs2.height = 47 chairs2.width = 130
 
		chairs3 = display.newImage("chairs.png") chairs3.x = -180 chairs3.y = 300 chairs3.height = 47 chairs3.width = 130
 
		chairs4 = display.newImage("chairs.png") chairs4.x = 50 chairs4.y = 320 chairs4.height = 47 chairs4.width = 130
  
		wallbottom1 = display.newImage("wallbottom.png") wallbottom1.x = -100 wallbottom1.y = 450 wallbottom1.height = 60 wallbottom1.width = 500
 
		door = display.newImage("game-door.png") door.x = 527 door.y = 401 door.height = 80 door.width = 40
 
		wallbottom2 = display.newImage("wallbottom.png") wallbottom2.x = 401 wallbottom2.y =450  wallbottom2.height = 60 wallbottom2.width = 500
		
		pausemenu = display.newImage("pause.png")											pausemenu.y = 200		pausemenu.x = 180		pausemenu.height = 250		pausemenu.width = 250
		resume = display.newImage("resume.png")												resume.y = 130	resume.x 	= 175	resume.id = "ball5"			resume.height = 100 resume.width = 150
		comeback = display.newImage("pausemenu.png")										comeback.y = 257		comeback.x = 170		comeback.id = "ball6"		comeback.height = 80 comeback.width = 150
------------inserts----------------------------
		
		--sceneGroup:insert()
		sceneGroup:insert(bg)
		sceneGroup:insert(tiles)
		sceneGroup:insert(celltop1)
		sceneGroup:insert(celltop2)
		sceneGroup:insert(wall)
		sceneGroup:insert(wall3)
		sceneGroup:insert(wall4)
		sceneGroup:insert(cooker)
		sceneGroup:insert(sink)
		sceneGroup:insert(fridge)
		sceneGroup:insert(table1)
		sceneGroup:insert(table2)
		sceneGroup:insert(table3)
		sceneGroup:insert(table4)
		sceneGroup:insert(chairs1)
		sceneGroup:insert(chairs2)
		sceneGroup:insert(chairs3)
		sceneGroup:insert(chairs4)
		sceneGroup:insert(wallbottom1)
		sceneGroup:insert(wallbottom2)
		sceneGroup:insert(wall2)
		sceneGroup:insert(pausemenu)
		sceneGroup:insert(comeback)
		sceneGroup:insert(resume)
		
		sceneGroup:insert(prisoner)
		sceneGroup:insert(guard1)
		sceneGroup:insert(guard2)
		sceneGroup:insert(guard3)
		
		pausemenu.isVisible = false
		comeback.isVisible = false
		resume.isVisible = false


---------------------inserts---------------------
		
	
	--PHYSICS
		--CHARACTERS
		 timer.performWithDelay(10,addshit,1)
		
		function SpawnObjectsWithDelay()
			if Useonce == true then
		physics.addBody( prisoner, "dynamic", { density=0.0, friction=0, radius = 25} )
		physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightLeft } , {density=1.0, friction=1, shape = area} )
		physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightLeft } , {density=1.0, friction=1, shape = area} )
		physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightLeft } , {density=1.0, friction=1, shape = area} )
		--WORLD OBJECTS, PUT ALL OBJECTS PHYSICS HERE
		
		physics.addBody(wall2, "static", { friction = .3})					wall2.collType 		= "worldObject"
		physics.addBody(wall3, "static", { friction = .3})					wall3.collType 		= "worldObject"
		physics.addBody(wall4, "static", { friction = .3})					wall4.collType 		= "worldObject"
		physics.addBody(celltop1, "static", { friction = .3})					celltop1.collType 		= "worldObject"
		physics.addBody(celltop2, "static", { friction = .3})					celltop2.collType 		= "worldObject"
		physics.addBody(wall, 	"static", { friction = .3})					wall.collType 			= "worldObject"
		physics.addBody(cooker, 	"static", { friction = .3})					cooker.collType 			= "worldObject"
		physics.addBody(sink, 	"static", { friction = .3})					sink.collType 			= "worldObject"
		physics.addBody(fridge, 	"static", { friction = .3})					fridge.collType 			= "worldObject"
		physics.addBody(table1, 	"static", { friction = .3})					table1.collType 			= "worldObject"
		physics.addBody(table2, 	"static", { friction = .3})					table2.collType 			= "worldObject"
		physics.addBody(table3, 	"static", { friction = .3})					table3.collType 			= "worldObject"
		physics.addBody(table4, 	"static", { friction = .3})					table4.collType 			= "worldObject"
		physics.addBody(chairs1, 	"static", { friction = .3})					chairs1.collType 			= "worldObject"
		physics.addBody(chairs2, 	"static", { friction = .3})					chairs2.collType 			= "worldObject"
		physics.addBody(chairs3, 	"static", { friction = .3})					chairs3.collType 			= "worldObject"
		physics.addBody(chairs4, 	"static", { friction = .3})					chairs4.collType 			= "worldObject"
		physics.addBody(wallbottom1, 	"static", { friction = .3})				wallbottom1.collType 			= "worldObject"
		physics.addBody(wallbottom2, 	"static", { friction = .3})				wallbottom2.collType 			= "worldObject"
	
		

		--KEY ITEMS
		physics.addBody(door, 			"static", { friction = .3})					door.collType			= "worldObject"			door.type = "door"
		physics.addBody(knife, 			"static", { friction = .3})					knife.collType			= "worldObject"			knife.type = "knife"
		
		physics.addBody(key1, 				"static", { friction = .3, radius = 30})	key1.collType 			= "worldObject"  		key1.type = "key"
		Useonce = false
			end
		end
		Runtime:addEventListener("enterFrame", SpawnObjectsWithDelay )
		
	------GUARD MOVE PATHS----------------------------------------------------------------------------------------------------------------------------------------------------
	
	
	local movePath = {}
	movePath[1] = 	{ x=30, 	y=180, time==800,  	seq = ("walkingleft"), 	sight = 1} 
	movePath[2] = 	{ x=-20,	y=180, time==800,	seq = ("walkingleft"), 	sight = 1}
	movePath[3] = 	{ x=-70, 	y=180, time==800,  	seq = ("walkingleft"), 	sight = 1}
	movePath[4] = 	{ x=-70, 	y=230, time==800, 	seq = ("walkingdown"), 	sight = 2}
	movePath[5] = 	{ x=-70, 	y=280, time==800, 	seq = ("walkingdown"), sight =	2}
	movePath[6] = 	{ x=-70, 	y=330, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath[7] = 	{ x=-70, 	y=380, time==800,  	seq = ("walkingdown"), sight = 2}
	movePath[8] = 	{ x=-20, 	y=380, time==800,  	seq = ("walkingright"),	sight = 3}
	movePath[9] = 	{ x=30, 	y=380, time==800,  	seq = ("walkingright"),	sight = 3}
	movePath[10] = 	{ x=80, 	y=380, time==800,  	seq = ("walkingright"),	sight = 3}
	movePath[11] = 	{ x=140, 	y=380, time==800,  	seq = ("walkingright"),	sight = 3}
	movePath[12] = 	{ x=140, 	y=330, time==800,  	seq = ("walkingup"),	sight = 4}
	movePath[13] = 	{ x=140, 	y=280, time==800,  	seq = ("walkingup"),	sight = 4}
	movePath[14] = 	{ x=140, 	y=230, time==800,  	seq = ("walkingup"),	sight = 4}
	movePath[15] = 	{ x=140, 	y=180, time==800,  	seq = ("walkingup"),	sight = 4}
	movePath[16] = 	{ x=100, 	y=180, time==800,  	seq = ("walkingleft"),	sight = 1}
	
	local movePath2 = {}
	movePath2[1] = 	{ x=150, 	y=370, time==800,	seq = ("walkingright"), sight = 3}
	movePath2[2] = 	{ x=150, 	y=310, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath2[3] = 	{ x=150, 	y=260, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath2[4] = 	{ x=150, 	y=210, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath2[5] = 	{ x=150, 	y=160, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath2[6] = 	{ x=100, 	y=160, time==800, 	seq = ("walkingleft"), sight = 1}
	movePath2[7] = 	{ x=50, 	y=160, time==800, 	seq = ("walkingleft"), sight = 1}
	movePath2[8] = 	{ x=00, 	y=160, time==800, 	seq = ("walkingleft"), sight = 1}
	movePath2[9] = { x=-50, 	y=160, time==800, 	seq = ("walkingleft"), sight = 1}
	movePath2[10] = { x=-50, 	y=210, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath2[11] = { x=-50, 	y=260, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath2[12] = { x=-50, 	y=310, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath2[13] = { x=-50, 	y=360, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath2[14] = { x=00, 	y=360, time==800, 	seq = ("walkingright"), sight = 3}
	movePath2[15] = { x=50, 	y=360, time==800, 	seq = ("walkingright"), sight = 3}
	movePath2[16] = { x=100, 	y=370, time==800, 	seq = ("walkingright"), sight = 3}
	
	local movePath3 = {}
	movePath3[1] = 	{ x=300, 	y=300, time==800,	seq = ("walkingup"), sight = 4}
	movePath3[2] = 	{ x=300, 	y=250, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath3[3] = 	{ x=300, 	y=200, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath3[4] = 	{ x=300, 	y=150, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath3[5] = 	{ x=350, 	y=150, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath3[5] = 	{ x=350, 	y=150, time==800, 	seq = ("walkingright"), 	sight = 3}
	movePath3[6] = { x=350, 	y=200, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath3[7] = { x=350, 	y=250, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath3[8] = { x=350, 	y=300, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath3[9] = { x=350, 	y=350, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath3[10] = { x=350, 	y=400, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath3[11] = { x=300, 	y=400, time==800, 	seq = ("walkingleft"), sight = 1}
	movePath3[12] = { x=300, 	y=350, time==800, 	seq = ("walkingup"), sight = 4}

	
	
	local function setPath1( guard1, path, seq)
		i = i + 1	if i > 16 	then i = 1 end
		-- changes sight for guard1
		if movePath[i].sight == 1 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightLeft }  , {density = 1.0, friction = 1, shape = area} )		end
		if movePath[i].sight == 2 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightDown } , {density = 1.0, friction = 1, shape = area} ) 		end
		if movePath[i].sight == 3 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightRight} , {density = 1.0, friction = 1, shape = area} )			end
		if movePath[i].sight == 4 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightUp }    , {density = 1.0, friction = 1, shape = area} ) 		end
													
		transition.to( guard1, { time=800, x=movePath[i].x, 	y=movePath[i].y, 	guard1:setSequence(movePath[i].seq)	} )
		guard1:play()
	end
	
	local function setPath2( guard2, path, seq)
		j = j + 1	if j > 16 	then j = 1 end
		-- changes sight for guard2
		if movePath2[j].sight == 1 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightLeft }  , {density = 1.0, friction = 1, shape = area} )		end
		if movePath2[j].sight == 2 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightDown } , {density = 1.0, friction = 1, shape = area} ) 		end
		if movePath2[j].sight == 3 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightRight} , {density = 1.0, friction = 1, shape = area} )			end
		if movePath2[j].sight == 4 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightUp }    , {density = 1.0, friction = 1, shape = area} ) 		end
													
		transition.to( guard2, { time=800, x=movePath2[j].x, 	y=movePath2[j].y, 	guard2:setSequence(movePath2[j].seq)	} )
		guard2:play()
	end
	
	
	local function setPath3( guard3, path, seq)
		k = k + 1	if k > 12 	then k = 1 end
		-- changes sight for guard3
		if movePath3[k].sight == 1 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightLeft }  , {density = 1.0, friction = 1, shape = area} )		end
		if movePath3[k].sight == 2 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightDown } , {density = 1.0, friction = 1, shape = area} ) 		end
		if movePath3[k].sight == 3 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightRight} , {density = 1.0, friction = 1, shape = area} )			end
		if movePath3[k].sight == 4 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightUp }    , {density = 1.0, friction = 1, shape = area} ) 		end
													
		transition.to( guard3, { time=800, x=movePath3[k].x, 	y=movePath3[k].y, 	guard3:setSequence(movePath3[k].seq)	} )
		guard3:play()
	end
	
	------------------------------------------------------------------------------GUARD MOVE PATHS----------------------------------------------------------------------------
	local function moving()
			if guard1.exists ~= false then setPath1  ( guard1, path, seq )	end
			if guard2.exists ~= false then setPath2  ( guard2, path, seq )  end
			if guard3.exists ~= false then setPath3 ( guard3, path, seq )  end
	end
	---------KEY EVENT--------------------------------------------------------------------------------------------------------------------------------------------------------
				function onKeyEvent(event)
						--print (event.keyName)
						if lastLevel == false then
							if event.phase == "down" and canMove == true then
							canMove = false
											if 		event.keyName == "s" then
														prisoner:setSequence("walkingdown")
														prisoner:play()
														transition.to( prisoner, { time=600, y = prisoner.y + 50 } )
														moving()
											elseif 	event.keyName == "a" then
														prisoner:setSequence("walkingleft")
														prisoner:play();
														transition.to( prisoner, { time=600, x = prisoner.x - 50 } )
														moving()
											elseif 	event.keyName == "w" then
														prisoner:setSequence("walkingup")
														prisoner:play();
														transition.to( prisoner, { time=600, y = prisoner.y - 50 } )
														moving()
											elseif 	event.keyName == "d" then
														prisoner:setSequence("walkingright")
														prisoner:play();
														transition.to( prisoner, { time=600, x = prisoner.x + 50 } )
														moving()
											end
		
						
				timer.performWithDelay(600, setCanMove)
			end
	end
	
end	
	------------------------------------------------------------------------------KEY EVENT-----------------------------------------------------------------------------------
	
	
	--TIMER TO SET THE PLAYER MOVING AGAIN--
	function setCanMove()
	print("set can move")
	canMove = true
	end
	
	function KeyStart(event)
		print (event.keyName)
		if event.keyName == "enter" then
		promptstart.isVisible=false
		promptstart1.isVisible=false
		promptstart2.isVisible=false
		promptstart3.isVisible=false
		promptstart4.isVisible=false
		Runtime:addEventListener("key", onKeyEvent)
		physics.start()
		resume.isVisible = false
		comeback.isVisible = false
		pausemenu.isVisible = false
		local doorslam3 = audio.play(music2)
		
		end
	end
	
function KeyStop(event)
		if event.keyName =="p" then
		Runtime:removeEventListener("key",onKeyEvent)
		resume.isVisible = true
		comeback.isVisible = true
		pausemenu.isVisible = true
		
	end
end
	
function Touch4(event)
    if ( event.phase == "began" ) then
        composer.gotoScene("mainmenu1", {effect = "fade", time = 300})
		scene:destroy()
		physics.stop()
		if key1.exists ~= false then
			key1:removeSelf()
		end
		if door.exists ~= false then
			door:removeSelf()
		end
		local doorslam2 = audio.play(music2)
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
    
end

function Touch5(event)
    if ( event.phase == "began" ) then
        physics.start()
		resume.isVisible = false
		comeback.isVisible = false
		Runtime:addEventListener("key", onKeyEvent)
		pausemenu.isVisible = false
		local doorslam3 = audio.play(music2)
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
    
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
									local myText = display.newText( "BACK TO YOUR CELL, RUNT!", 125, 325, "BloodLust.ttf", 60 )
									myText:setFillColor( 1, 0, 0 )
									local myText1 = display.newText( "Press CTRL + R to RESTART", 125, 400, "BloodLust.ttf", 60 )
									myText1:setFillColor( 1, 0, 0 )
									sceneGroup:insert(mark)
									sceneGroup:insert(myText)
									sceneGroup:insert(myText1)
									Runtime:removeEventListener("key",onKeyEvent)
									prisoner:setSequence("caught")
									event.other:setSequence("caught")
									--event.other:play();
									local audio1 = audio.loadSound("evil.wav")
									local playaudio = audio.play(audio1)
									--failScreen()
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
									local death3 = audio.loadSound("death.mp3")
									local death4 = audio.play(death3)
								end
							end
			
						--IF THE PLAYER COLLIDES WITH THE KNIFE, "hasKnife" = TRUE
								if event.other.type == "knife" then
									display.remove(knife)
									hasKnife = true
									KnifeExists = false
								end
			
						--IF THE PLAYER COLLIDES WITH THE KEY, "hasKey" = TRUE
								if event.other.type == "key" then
									print("Got the Key")
									display.remove(key1)
									hasKey = true
								end
					
						--IF THE PLAY HAS THE KEY AND HITS THE DOOR
								if event.other.type == "door" then		
									if hasKey == true then
										print("VICTORY")
										--display.remove(prisoner)
										--physics:stop() 
										scene:destroy()
										composer.gotoScene("LastLevel")
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
				
				Runtime:addEventListener("key", KeyStop )
				comeback:addEventListener("touch", Touch4)
				resume:addEventListener("touch", Touch5)
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


--"scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
		if not guard1.exists then 
			guard1:removeSelf()
		end
		if not guard2.exists then 
			guard2:removeSelf()
		end
		if not guard3.exists then 
			guard3:removeSelf()
		end
		
		prisoner:removeSelf()
		
		if KnifeExists == true then
			knife:removeSelf()
		end
	door:removeSelf()
	 bg:removeSelf()
	 tiles:removeSelf()
	 celltop1:removeSelf()
	 celltop2:removeSelf()
	 wall:removeSelf()
	 wall2:removeSelf()
	 cooker:removeSelf()
	 sink:removeSelf()
	 fridge:removeSelf()
	 table1:removeSelf()
	 table2:removeSelf()
	 table3:removeSelf()
	 table4:removeSelf()
	 chairs1:removeSelf()
	 chairs2:removeSelf()
	 chairs3:removeSelf()
	 chairs4:removeSelf()
	 wallbottom1:removeSelf()
	 wallbottom2:removeSelf()
		lastLevel = true
		scene:removeEventListener("create",scene)
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