local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
--physics.setDrawMode("hybrid")
physics.start()
physics.setGravity(0,0)


local function failScreen()
		composer.gotoScene("MainMenu")
end

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------
local sightRight = 	{0,0, 50,-20, 50,20}
local sightDown = 	{0,0, 20,50, -20,50}
local sightLeft = 	{0,0, -50,20, -50,-20}
local sightUp = 	{0,0, -20,-50, 20,-50}
local area    =     {0,35, 0,-35, 35,0, -35,0}
	
-- Local forward references should go here
hasKnife = false
hasKey   = false
canMove  = true
nextLevel = false
gaurd1exists = true
gaurd2exists = true
gaurd3exists = true
gaurd4exists = true
KnifeExists = true

i = 0		--two guard, so two counters, you dig?
j = 0
k = 0
l = 0

local prisonerSheet
local guardSheet

local options
local sequenceData

local prisoner
local guard1
local guard2
local guard3
local guard4
local bg
local bed
local bed2
local bed3
local key
local walltop
local walltop2
local wallbottom 
local wallbottom1
local door 
local knife
local wall 
local wall2
local wall3 
local wall4 
local wall5
local wall6
local jailcell1 
local jailcell2 
local jailcell3
local jailcell4 
local jailcell5 
local promptstart1
local promptstart2
local promptstart3
local promptstart4
local promptstart5
local promptstart6
local needkey1
local needkey
local death





-- -------------------------------------------------------------------------------


-- "scene:create()"
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
		
		prisoner = display.newSprite( prisonerSheet, sequenceData )	prisoner.x=-153 prisoner.y=120			prisoner.myName = "prisoner"
		
		guard1 = display.newSprite( guardSheet, sequenceData )								guard1.x=70 			guard1.y=320			guard1.type = "guard"
		guard2 = display.newSprite( guardSheet, sequenceData )								guard2.x=320		guard2.y=120			guard2.type = "guard"
		guard3 = display.newSprite( guardSheet, sequenceData )								guard3.x=-240		guard3.y=400		guard3.type = "guard"
		guard4 = display.newSprite( guardSheet, sequenceData )								guard4.x=430		guard4.y=300		guard4.type = "guard"
		
		
		promptstart = display.newText("Find the key(s) and escape the prison! ", 160,365, "BloodLust.ttf", 40)
		promptstart1 = display.newText("Press", -100,400, "BloodLust.ttf", 40)
		promptstart2 = display.newText("ENTER", -5,400, "BloodLust.ttf", 40)
		promptstart3= display.newText("to begin your" , 160,400, "BloodLust.ttf", 40)
		promptstart4= display.newText("JAILBREAK." , 360,400, "BloodLust.ttf", 40)
		promptstart5 = display.newText("You've used your knife", 160,365, "BloodLust.ttf", 40)
		promptstart6 = display.newText ("to stab the guard!", 160, 380, "BloodLust.ttf", 40)
		promptstart5:setFillColor(0.7,0,0)
		promptstart6:setFillColor(0.7,0,0)
		promptstart4:setFillColor(0.7,0,0)
		promptstart2:setFillColor(0.7,0,0)
		promptstart:setFillColor(0,0,0)
		promptstart1:setFillColor()
		promptstart3:setFillColor(0,0,0)
		promptstart5.isVisible = false
		promptstart6.isVisible = false

		death = audio.loadSound("death.mp3")
		bg = display.newImage("background.jpg")
		bed = display.newImage("bed.png")													bed.x = -80				bed.y = 120
		bed2 = display.newImage("bed.png")													bed2.x = 70				bed2.y = 120
		bed3 = display.newImage("bed.png")													bed3.x = 220			bed3.y = 120
		key = display.newImage("key.png")													key.x = 470				key.y = 150			key.rotation = -30
		walltop = display.newImage("walltop.png")											walltop.x = -50			walltop.y = 20			walltop.xScale = 1.2
		walltop2 = display.newImage("walltop.png")											walltop2.x = 360		walltop2.y = 20			walltop2.xScale = 1.2
		wallbottom = display.newImage("wallbottom.png")										wallbottom.x = -50		wallbottom.y = 460		wallbottom.xScale = 1.2
		wallbottom1 = display.newImage("wallbottom.png")									wallbottom1.x = 360		wallbottom1.y = 460		wallbottom1.xScale = 1.2
		door = display.newImage("game-door.png")											door.x = 560			door.y = 385 door.width =50 door.height = 100
		knife = display.newImage("knife.png")												knife.x = -248			knife.y = 100
		wall = display.newImage("wall.png")													wall.x = -200 			wall.y = 155	 		wall.yScale = 1.13 wall.width = 40
		wall2 = display.newImage("wall.png")												wall2.x = -30 			wall2.y = 155			wall2.yScale = 1.13
		wall3 = display.newImage("wall.png")												wall3.x = 120 			wall3.y = 155			wall3.yScale = 1.13
		wall4 = display.newImage("wall.png")												wall4.x = 270 			wall4.y = 155			wall4.yScale = 1.13
		wall5 = display.newImage("wall.png")												wall5.x = -310 			wall5.y = 200			wall5.height = 550
		wall6 = display.newImage("wall.png")												wall6.x = 610 			wall6.y = 200			wall6.height = 550
		jailcell1 = display.newImage("jailcell.png")										jailcell1.y = 245		jailcell1.x = -80
		jailcell2 = display.newImage("jailcell.png")										jailcell2.y = 245		jailcell2.x = 20
		jailcell3 = display.newImage("jailcell.png")										jailcell3.y = 245		jailcell3.x = 70
		jailcell4 = display.newImage("jailcell.png")										jailcell4.y = 245		jailcell4.x = 170
		jailcell5 = display.newImage("jailcell.png")										jailcell5.y = 245		jailcell5.x = 220
		pausemenu = display.newImage("pause.png")											pausemenu.y = 200		pausemenu.x = 180		pausemenu.height = 250		pausemenu.width = 250
		resume = display.newImage("resume.png")												resume.y = 130	resume.x 	= 175	resume.id = "ball5"			resume.height = 100 resume.width = 150
		comeback = display.newImage("pausemenu.png")										comeback.y = 257		comeback.x = 170		comeback.id = "ball6"		comeback.height = 80 comeback.width = 150
		
		
		pausemenu.isVisible = false
		comeback.isVisible = false
		resume.isVisible = false

		----inserts--------------
		

		sceneGroup:insert(bg)
		sceneGroup:insert(bed)
		sceneGroup:insert(bed2)
		sceneGroup:insert(bed3)
		sceneGroup:insert(key)
		sceneGroup:insert(walltop)
		sceneGroup:insert(walltop2)
		sceneGroup:insert(wallbottom)
		sceneGroup:insert(wallbottom1)
		sceneGroup:insert(door)
		sceneGroup:insert(knife)
		sceneGroup:insert(wall)
		sceneGroup:insert(wall2)
		sceneGroup:insert(wall3)
		sceneGroup:insert(wall4)
		sceneGroup:insert(wall5)
		sceneGroup:insert(wall6)
		sceneGroup:insert(jailcell1)
		sceneGroup:insert(jailcell2)
		sceneGroup:insert(jailcell3)
		sceneGroup:insert(jailcell4)
		sceneGroup:insert(jailcell5)
		
		sceneGroup:insert(prisoner)
		sceneGroup:insert(guard1)
		sceneGroup:insert(guard2)
		sceneGroup:insert(guard3)
		sceneGroup:insert(guard4)
		sceneGroup:insert(promptstart)
		sceneGroup:insert(promptstart1)
		sceneGroup:insert(promptstart2)
		sceneGroup:insert(promptstart3)
		sceneGroup:insert(promptstart4)
		sceneGroup:insert(pausemenu)
		sceneGroup:insert(comeback)
		sceneGroup:insert(resume)
		-------------inserts------
		
	
	--PHYSICS
		--CHARACTERS
		physics.addBody( prisoner, "dynamic", { density=0.0, friction=0, radius = 25} )
		physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightLeft } , {density=1.0, friction=1, shape = area} )
		physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightLeft } , {density=1.0, friction=1, shape = area} )
		physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightLeft } , {density=1.0, friction=1, shape = area} )
		physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightLeft } , {density=1.0, friction=1, shape = area} )
		
		--WORLD OBJECTS
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
		physics.addBody(wall5, 			"static", { friction = .3})					wall5.collType 			= "worldObject"
		physics.addBody(wall6, 			"static", { friction = .3})					wall6.collType 			= "worldObject"
		physics.addBody(jailcell1, 		"static", { friction = .3})					jailcell1.collType 		= "worldObject"
		physics.addBody(jailcell2, 		"static", { friction = .3})					jailcell2.collType 		= "worldObject"
		physics.addBody(jailcell3, 		"static", { friction = .3})					jailcell3.collType 		= "worldObject"
		physics.addBody(jailcell4, 		"static", { friction = .3})					jailcell4.collType 		= "worldObject"
		physics.addBody(jailcell5, 		"static", { friction = .3})					jailcell5.collType 		= "worldObject"

		--KEY ITEMS
		physics.addBody(door, 			"static", { friction = .3})					door.collType			= "worldObject"			door.type = "door"
		physics.addBody(knife, 			"static", { friction = .3})					knife.collType			= "worldObject"			knife.type = "knife"
		physics.addBody(key, 			"static", { friction = .3, radius = 30})	key.collType 			= "worldObject"  		key.type = "key"
	
	------GUARD MOVE PATHS----------------------------------------------------------------------------------------------------------------------------------------------------
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
	
	local movePath2 = {}
	movePath2[1] = 	{ x=-190, 	y=400, time==800,  	seq = ("walkingright"), sight = 3}
	movePath2[2] = 	{ x=-140, 	y=400, time==800,	seq = ("walkingright"), sight = 3}
	movePath2[3] = 	{ x=-140, 	y=360, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath2[4] = 	{ x=-140, 	y=320, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath2[5] = 	{ x=-190, 	y=320, time==800, 	seq = ("walkingleft"), 	sight = 1}
	movePath2[6] = 	{ x=-240, 	y=320, time==800, 	seq = ("walkingleft"), sight = 1}
	movePath2[7] = 	{ x=-240, 	y=360, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath2[8] = 	{ x=-240, 	y=400, time==800, 	seq = ("walkingdown"), sight = 2}
	
	local movePath3 = {}
	movePath3[1] = 	{ x=380, 	y=300, time==800,  	seq = ("walkingleft"), sight = 1}
	movePath3[2] = 	{ x=380, 	y=250, time==800,	seq = ("walkingup"), sight = 4}
	movePath3[3] = 	{ x=380, 	y=200, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath3[4] = 	{ x=380, 	y=150, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath3[5] = 	{ x=380, 	y=100, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath3[6] = 	{ x=430, 	y=100, time==800, 	seq = ("walkingright"), sight = 3}
	movePath3[7] = 	{ x=480, 	y=100, time==800, 	seq = ("walkingright"), sight = 3}
	movePath3[8] = 	{ x=530, 	y=100, time==800, 	seq = ("walkingright"), sight = 3}
	movePath3[9] = 	{ x=530, 	y=150, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath3[10] = { x=530, 	y=200, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath3[11] = { x=530, 	y=250, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath3[12] = { x=530, 	y=300, time==800, 	seq = ("walkingdown"), sight = 2}
	movePath3[13] = { x= 480, 	y=300, time==800, 	seq = ("walkingleft"), sight = 1}
	movePath3[14] = { x= 430, 	y=300, time==800, 	seq = ("walkingleft"), sight = 1}
	
	

	local function setPath1( guard1, path, seq)
		i = i + 1	if i > 8 	then i = 1 end
		-- changes sight for guard1
		if movePath[i].sight == 1 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightLeft }  , {density=1.0, friction=1, shape = area} )		end
		if movePath[i].sight == 2 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightDown } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath[i].sight == 3 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightRight} , {density=1.0, friction=1, shape = area} )			end
		if movePath[i].sight == 4 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightUp }    , {density=1.0, friction=1, shape = area} ) 		end
													
		transition.to( guard1, { time=600, x=movePath[i].x, 	y=movePath[i].y, 	guard1:setSequence(movePath[i].seq)	} )
		guard1:play()
	end
	
	
	
	--Called if GUARD2 exists, 
	local function setPath2( guard2, path, seq)
		j = j + 1	if j > 12	then j = 1 end
		--changes sight for guard2
		if movePath1[j].sight == 1 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightLeft } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath1[j].sight == 2 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightDown } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath1[j].sight == 3 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightRight }, {density=1.0, friction=1, shape = area} ) 		end
		if movePath1[j].sight == 4 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightUp }   , {density=1.0, friction=1, shape = area} ) 		end
								
		transition.to( guard2, { time=600, x=movePath1[j].x, 	y=movePath1[j].y, 	guard2:setSequence(movePath1[j].seq)} )
		guard2:play()	
	end
	
	--Called if GUARD2 exists, 
	local function setPath2( guard2, path, seq)
		j = j + 1	if j > 12	then j = 1 end
		--changes sight for guard2
		if movePath1[j].sight == 1 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightLeft } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath1[j].sight == 2 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightDown } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath1[j].sight == 3 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightRight }, {density=1.0, friction=1, shape = area} ) 		end
		if movePath1[j].sight == 4 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightUp }   , {density=1.0, friction=1, shape = area} ) 		end
								
		transition.to( guard2, { time=600, x=movePath1[j].x, 	y=movePath1[j].y, 	guard2:setSequence(movePath1[j].seq)} )
		guard2:play()	
	end
	
	--Called if GUARD3 exists,
	local function setPath3( guard3, path, seq)
		k = k + 1	if k > 8	then k = 1 end
		-- changes sight for guard1
		if movePath2[k].sight == 1 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightLeft }  , {density=1.0, friction=1, shape = area} )		end
		if movePath2[k].sight == 2 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightDown } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath2[k].sight == 3 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightRight} , {density=1.0, friction=1, shape = area} )			end
		if movePath2[k].sight == 4 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightUp }    , {density=1.0, friction=1, shape = area} ) 		end
													
		transition.to( guard3, { time=600, x=movePath2[k].x, 	y=movePath2[k].y, 	guard3:setSequence(movePath2[k].seq)	} )
		guard3:play()
	end
	
	local function setPath4( guard4, path, seq)
		l = l + 1	if l > 14	then l = 1 end
		-- changes sight for guard1
		if movePath3[l].sight == 1 then	physics.removeBody(guard4) 
								physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightLeft }  , {density=1.0, friction=1, shape = area} )		end
		if movePath3[l].sight == 2 then	physics.removeBody(guard4) 
								physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightDown } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath3[l].sight == 3 then	physics.removeBody(guard4) 
								physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightRight} , {density=1.0, friction=1, shape = area} )			end
		if movePath3[l].sight == 4 then	physics.removeBody(guard4) 
								physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightUp }    , {density=1.0, friction=1, shape = area} ) 		end
													
		transition.to( guard4, { time=600, x=movePath3[l].x, 	y=movePath3[l].y, 	guard4:setSequence(movePath3[l].seq)	} )
		guard4:play()
	end
	------------------------------------------------------------------------------GUARD MOVE PATHS----------------------------------------------------------------------------
	
	local function moving()
			if guard1.exists ~= false then setPath1  ( guard1, path, seq )	end
			if guard2.exists ~= false then setPath2  ( guard2, path, seq )  end
			if guard3.exists ~= false then setPath3 ( guard3, path, seq )  end
			if guard4.exists ~= false then setPath4 (guard4, path, seg)		end
	end
	
	---------KEY EVENT--------------------------------------------------------------------------------------------------------------------------------------------------------
				function onKeyEvent(event)
						--print (event.keyName)
						if nextLevel == false then
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
				promptstart5.isVisible = false
				promptstart6.isVisible = false
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
		promptstart.isVisible=false
		promptstart1.isVisible=false
		promptstart2.isVisible=false
		promptstart3.isVisible=false
		promptstart4.isVisible=false
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
									Runtime:removeEventListener("key", onKeyEvent)
									--prisoner:setSequence("caught")
									--event.other:setSequence("caught")
									--event.other:play();
									local audio1 = audio.loadSound("evil.wav")
									local playaudio = audio.play(audio1)
									
									
								end
						
						
			

						-- IF PLAYER HAS KNIFE, REMOVES THE GUARD!
								if hasKnife == true then 
									physics:removeBody(event.other)
									transition.cancel(prisoner)
									transition.to( prisoner, { time=1000, y = event.other.y, x = event.other.x } )
									event.other.exists = false
									display.remove(event.other, {time = 400}) 
									
									local playdeath = audio.play(death, {time = 1})
									hasKnife = false
								
									promptstart5.isVisible = true
									promptstart6.isVisible = true
									
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
									display.remove(key)
									hasKey = true
								end
					
						--IF THE PLAY HAS THE KEY AND HITS THE DOOR
								if event.other.type == "door" then		
									if hasKey == true then
										print("VICTORY")
										--display.remove(prisoner)
										--physics:stop() 
										scene:destroy()
										composer.gotoScene("kitchen")
										
										--victoryEndGame(prisoner, event)
									end
								end
								
								--IF THE PLAY DOESN'T HAVE THE KEY AND HITS THE DOOR
								if event.other.type == "door" then		
									if hasKey == false then
										
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
				level = true
				
				Runtime:addEventListener("prisoner", onKeyEvent)
				Runtime:addEventListener("key", KeyStart)
				
					
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


-- "scene:destroy()"
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
		if not guard4.exists then 
			guard4:removeSelf()
		end
		prisoner:removeSelf()
		
		door:removeSelf()
		bg:removeSelf()
		bed:removeSelf()
		bed2:removeSelf()
		bed3:removeSelf()
		walltop:removeSelf()
		walltop2:removeSelf()
		wallbottom :removeSelf()
		wallbottom1:removeSelf()
		door :removeSelf()
		if KnifeExists == true then
			knife:removeSelf()
		end
		wall :removeSelf()
		wall2:removeSelf()
		wall3 :removeSelf()
		wall4 :removeSelf()
		jailcell1 :removeSelf()
		jailcell2 :removeSelf()
		jailcell3:removeSelf()
		jailcell4 :removeSelf()
		jailcell5 :removeSelf()
		promptstart1:removeSelf()
		promptstart2:removeSelf()
		promptstart3:removeSelf()
		promptstart4:removeSelf()
		promptstart5:removeSelf()
		promptstart6:removeSelf()
		scene:removeEventListener("create",scene)
		--scene:removeEventListener("show",scene)
		--scene:removeEventListener("hide",scene)
		--scene:removeEventListener("destroy",scene)
		--Runtime:removeEventListener("key", onKeyEvent)
		
		nextLevel = true
		--needkey1:removeSelf()
		--needkey:removeSelf()
		--death:removeSelf()
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