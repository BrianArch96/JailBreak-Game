local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
physics.setDrawMode("hybrid")
physics.start()
physics.setGravity(0,0)


-----BOOLEANS---------------------------------------------------------------------------------
hasKnife = false
hasKey   = false
----SpriteSequenceData------------------------------------------------------------------------
	local options =
	{
    --required parameters
		width = 50,
		height = 100,
		numFrames = 24,
		sheetContentWidth = 300,  -- width of original 1x size of entire sheet
		sheetContentHeight = 400   -- height of original 1x size of entire sheet
	}
	local sequenceData =
	{
		{name="walkingdown",	frames = {1, 2, 3, 4, 5, 6 },		 time = 1000, loopCount = 1},  
		{name="walkingleft",	frames = {7, 8, 9, 10, 11, 12},	     time = 1000, loopCount = 1},
		{name="walkingright",	frames = {13, 14, 15, 16, 17, 18},	 time = 1000, loopCount = 1},
		{name="walkingup", 		frames = {19, 20, 21, 22, 23, 24}, 	 time = 1000, loopCount = 1}
	}
-------------------------------------------------------------SpriteSequenceData------------------
---OBJECTS---------------------------------------------------------------------------------------
local bg = display.newImage("background.jpg")
local bed = display.newImage("bed.png")
	bed.x = -80
	bed.y = 120
	
local bed2 = display.newImage("bed.png")
	bed2.x = 70
	bed2.y = 120
	
local bed3 = display.newImage("bed.png")
	bed3.x = 220
	bed3.y = 120
	
local key = display.newImage("key.png")
	key.x = 470
	key.y = 120
	key.rotation = -30
	
local walltop = display.newImage("walltop.png")
	walltop.x = -50
	walltop.y = 20
	walltop.xScale = 1.2

local walltop2 = display.newImage("walltop.png")
	walltop2.x = 360
	walltop2.y = 20
	walltop2.xScale = 1.2
	
local wallbottom = display.newImage("wallbottom.png")
	wallbottom.x = -50
	wallbottom.y = 460
	wallbottom.xScale = 1.2

local wallbottom1 = display.newImage("wallbottom.png")
	wallbottom1.x = 360
	wallbottom1.y = 460
	wallbottom1.xScale = 1.2
	
local door = display.newImage("game-door.png")
	door.x = 560
	door.y = 385

local knife = display.newImage("knife.png")
	knife.x = -240
	knife.y = 250
local wall = display.newImage("wall.png")	wall.x = -200 wall.y = 155	 	wall.yScale = 1.13
local wall2 = display.newImage("wall.png")	wall2.x = -30 wall2.y = 155		wall2.yScale = 1.13
local wall3 = display.newImage("wall.png")	wall3.x = 120 wall3.y = 155		wall3.yScale = 1.13
local wall4 = display.newImage("wall.png")	wall4.x = 270 wall4.y = 155		wall4.yScale = 1.13

local jailcell1 = display.newImage("jailcell.png")	jailcell1.y = 245	jailcell1.x = -80
local jailcell2 = display.newImage("jailcell.png")	jailcell2.y = 245	jailcell2.x = 20
local jailcell3 = display.newImage("jailcell.png")	jailcell3.y = 245	jailcell3.x = 70
local jailcell4 = display.newImage("jailcell.png")	jailcell4.y = 245	jailcell4.x = 170
local jailcell5 = display.newImage("jailcell.png")	jailcell5.y = 245	jailcell5.x = 220

physics.addBody(bed, 			"static", { friction = .3})					bed.collType 			= "worldObject"
physics.addBody(bed2, 			"static", { friction = .3})					bed2.collType 			= "worldObject"
physics.addBody(bed3, 			"static", { friction = .3})					bed3.collType 			= "worldObject"
physics.addBody(walltop, 		"static", { friction = .3})					walltop.collType 		= "worldObject"
physics.addBody(walltop2, 		"static", { friction = .3})					walltop2.collType 		= "worldObject"
physics.addBody(wallbottom, 	"static", { friction = .3})					wallbottom.collType 	= "worldObject"
physics.addBody(wallbottom1, 	"static", { friction = .3})					wallbottom1.collType 	= "worldObject"
physics.addBody(wall, 			"static", { friction = .3})					wall.collType 			= "worldObject"
physics.addBody(wall2, 			"static", { friction = .3})					wall2.collType 			= "worldObject"
physics.addBody(wall3, 			"static", { friction = .3})					wall3.collType 			= "worldObject"
physics.addBody(wall4, 			"static", { friction = .3})					wall4.collType 			= "worldObject"
physics.addBody(jailcell1, 		"static", { friction = .3})					jailcell1.collType 		= "worldObject"
physics.addBody(jailcell2, 		"static", { friction = .3})					jailcell2.collType 		= "worldObject"
physics.addBody(jailcell3, 		"static", { friction = .3})					jailcell3.collType 		= "worldObject"
physics.addBody(jailcell4, 		"static", { friction = .3})					jailcell4.collType 		= "worldObject"
physics.addBody(jailcell5, 		"static", { friction = .3})					jailcell5.collType 		= "worldObject"

--KEY ITEMS
physics.addBody(door, 			"static", { friction = .3})					door.collType			= "worldObject"			door.type = "door"
physics.addBody(knife, 			"static", { friction = .3})					knife.collType			= "worldObject"			knife.type = "knife"
physics.addBody(key, 			"static", { friction = .3, radius = 30})	key.collType 			= "worldObject"  			key.type = "key"

-------------------------------------------------------------OBJECTS-----------------------------

---PRISONER--------------------------------------------------------------------------------------
	local prisonerSheet = graphics.newImageSheet("PrisonerWalking.png", options)
	local prisoner = display.newSprite( prisonerSheet, sequenceData )
	physics.addBody( prisoner, "dynamic", { density=0.0, friction=0, radius = 25} )
	prisoner.myName = "prisoner"
		prisoner.x=-130 
		prisoner.y=120
----------------------------------------------------------------PRISONER-------------------------
	i = 0 -- declaration for path movements
	j = 0

-----GUARDS--------------------------------------------------------------------------------------
	
	--GUARD1
	local guardSheet = graphics.newImageSheet("GuardWalks.png", options)
	
	local guard1 = display.newSprite( guardSheet, sequenceData )
		guard1.x=70 
		guard1.y=320
		
	--GUARD2
	local guard2 = display.newSprite( guardSheet, sequenceData )
		guard2.x=320 
		guard2.y=120
		
	guard1.type = "guard"
	guard2.type = "guard"
	
	local sightRight = 	{0,0, 100,-20, 100,20}
	local sightDown = 	{0,0, 20,100, -20,100}
	local sightLeft = 	{0,0, -100,20, -100,-20}
	local sightUp = 	{0,0, -20,-100, 20,-100}
	
	area = 	{30,30, 30,-30, -30,30, -30,-30} 
	prisonerBox = {0,30, 0,-30, 30,0, -30,0}
	physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightLeft } , {friction=1, shape = area} )
	physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightLeft } , {friction=1, shape = area} )
	area = guard1
	
-----MovePaths-----------------------------------------------------------------------------------	
	local movePath = {}
	movePath[1] = 	{ x=20, 	y=320, time==800,  	seq = ("walkingleft"), 	sight = 1} 
	movePath[2] = 	{ x=-30,	y=320, time==800,	seq = ("walkingleft"), 	sight = 1}
	movePath[3] = 	{ x=-80, 	y=320, time==800,  	seq = ("walkingleft"), 	sight = 1}
	movePath[4] = 	{ x=-80, 	y=370, time==800, 	seq = ("walkingdown"), 	sight = 2}
	movePath[5] = 	{ x=-30, 	y=370, time==800, 	seq = ("walkingright"), sight =	3}
	movePath[6] = 	{ x=20, 	y=370, time==800, 	seq = ("walkingright"), sight = 3}
	movePath[7] = 	{ x=70, 	y=370, time==800,  	seq = ("walkingright"), sight = 3}
	movePath[8] = 	{ x=70, 	y=320, time==800,  	seq = ("walkingup"),	sight = 4}

	local movePath1 = {}
	movePath1[1] = 	{ x=320, 	y=170, time==800,  	seq = ("walkingdown"), 	sight = 2}
	movePath1[2] = 	{ x=320, 	y=220, time==800,	seq = ("walkingdown"), 	sight = 2}
	movePath1[3] = 	{ x=320, 	y=270, time==800, 	seq = ("walkingdown"), 	sight = 2}
	movePath1[4] = 	{ x=320, 	y=320, time==800, 	seq = ("walkingdown"), 	sight = 2}
	movePath1[5] = 	{ x=320, 	y=370, time==800, 	seq = ("walkingdown"), 	sight = 2}
	movePath1[6] = 	{ x=370, 	y=370, time==800, 	seq = ("walkingright"), sight = 3}
	movePath1[7] = 	{ x=370, 	y=320, time==800, 	seq = ("walkingup"),	sight = 4}
	movePath1[8] = 	{ x=370, 	y=270, time==800,  	seq = ("walkingup"),	sight = 4}
	movePath1[9] = 	{ x=370, 	y=220, time==800,  	seq = ("walkingup"),	sight = 4}
	movePath1[10] = { x=370, 	y=170, time==800,  	seq = ("walkingup"),   	sight = 4}
	movePath1[11] = { x=370, 	y=120, time==800,  	seq = ("walkingup"),   	sight = 4}
	movePath1[12] = { x=320, 	y=120, time==800,  	seq = ("walkingleft"),  sight = 1}
	
	--Called if GUARD1 exists, 
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
	
	--Called if GUARD2 exists, 
	local function setPath2( guard2, path, seq)
		j = j + 1	if j > 12	then j = 1 end
		--changes sight for guard2
		if movePath1[j].sight == 1 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightLeft } , {} ) 		end
		if movePath1[j].sight == 2 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightDown } , {} ) 		end
		if movePath1[j].sight == 3 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightRight }, {} ) 		end
		if movePath1[j].sight == 4 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightUp }   , {} ) 		end
								
		transition.to( guard2, { time=800, x=movePath1[j].x, 	y=movePath1[j].y, 	guard2:setSequence(movePath1[j].seq)} )
		guard2:play()	
	end
-----------------------------------------------------------MovePaths------------------------------
------------------------------------------------------------GUARDS--------------------------------
canMove = true
function setCanMove()
	print("set can move")
	canMove = true
end

---KEYEVENT--------------------------------------------------------------------------------------
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
		
		if guard1.exists ~= false then setPath1  ( guard1, path, seq )	end
		if guard2.exists ~= false then setPath2  ( guard2, path, seq )  end
		
		timer.performWithDelay(800, setCanMove)
	end
	
end	
	
--------------------------------------------------------------KEYEVENT------------

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
				local myText = display.newText( "YOU GOT CAUGHT BITCH ASS NIGGUH!", 100, 200, native.systemFont, 25 )
				myText:setFillColor( 1, 0, 0 )
			end
			

			-- IF PLAYER HAS KNIFE, REMOVES THE GUARD!
			if hasKnife == true then 
				physics:removeBody(event.other)
				transition.cancel(prisoner)
				transition.to( prisoner, { time=600, y = event.other.y, x = event.other.x } )
				event.other.exists = false
				display.remove(event.other, {time = 400}) 
				hasKnife = false
				local myText = display.newText( "THAT BITCH ASS BROKE YO KNIFE, MA NIGGUH!", 100, 200, native.systemFont, 25 )
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
					--victoryEndGame(prisoner, event)
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

local function victoryEndGame(prisoner, event)
		Runtime:removeEventListener("key", onKeyEvent)
		Runtime:removeEventListener("prisoner", onKeyEvent)
		local myText = display.newText( "YOU WIN, MA NIGGUH!", 100, 200, native.systemFont, 25 )
		myText:setFillColor( 1, 0, 0 )
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