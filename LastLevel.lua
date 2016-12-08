local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
physics.start()
--physics.setDrawMode("hybrid")
physics.setGravity(0,0)

local function failScreen()
		--set to remove event listeners and stuff
		composer.removeScene("LastLevel")
		composer.gotoScene("")
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
once = true
ExistsKnife = true
ExistsGuard1 = true
ExistsGuard2 = true
ExistsGuard3 = true
ExistsGuard4 = true
------------USED IN ALL LEVELS--------------------------------------------------------------------------------------
a= 0 -- nu of keys collected

i = 0		--four guard, so four counters, you dig?
j = 0
k = 0
l = 0

local prisonerSheet
local guardSheet
local options
local sequenceData

local prisoner


---HERE YOU DECLARE EVERYTHING YOU'RE GOING TO USE



local background
local desert 
local fencetop 
local fenceside  
local fenceside1
--local stoneground  
local table1 
local table2
local fencetop 
local door  
local bench  
--local barbell 
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
local knife

	

-----<<<<<<<<<<<-----------------------------------------------------------------------


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
		
		prisoner = display.newSprite( prisonerSheet, sequenceData )		prisoner.x = -215 prisoner.y =100		prisoner.myName = "prisoner"
		guard1 = display.newSprite( guardSheet, sequenceData )								guard1.x=40 		guard1.y=350		guard1.type = "guard"
		guard2 = display.newSprite( guardSheet, sequenceData )								guard2.x=500		guard2.y=100	guard2.type = "guard"
		guard3 = display.newSprite( guardSheet, sequenceData )								guard3.x=-220		guard3.y=400		guard3.type = "guard"
		guard4 = display.newSprite( guardSheet, sequenceData )								guard4.x=480		guard4.y=280		guard4.type = "guard"
		
		
		
		
background = display.newImage("outsidebg.png") background.x = 120 background.y = 250 background.height = 560 background.width = 1000
	
 --desert = display.newImage("desert.jpg")											desert.x = 100			desert.y = 100			desert.height = 1000			desert.width = 1000
 
fencetop = display.newImage("wall.png")											fencetop.x = 230		fencetop.y = 30			fencetop.height = 1000	 		fencetop.width = 60 fencetop.rotation = 90
	
fenceside  = display.newImage("fenceside.png")										fenceside.x = -257		fenceside.y = 270		fenceside.height = 420		fenceside.width = 20

fenceside1  = display.newImage("fenceside.png")										fenceside1.x = 610		fenceside1.y = 270		fenceside1.height = 420		fenceside.width = 20

--stoneground  = display.newImage("ground.jpe")										stoneground.x = 400		stoneground.y = 300		stoneground.height = 485	stoneground.width = 600


table1 = display.newImage("table.png")												table1.x = 160		table1.y = 370			table1.heigth = 40			table1.width = 130
		
table2 = display.newImage("table.png")												table2.x = 450			table2.y = 370			table2.heigth = 40			table2.width = 130

fencetop1 = display.newImage("wall.png")											fencetop1.x = 230		fencetop1.y = 455		fencetop1.height = 1000		fencetop1.width = 60 fencetop1.rotation = 90

door = display.newImage("endwall.png")												door.x = 560			door.y = 455			door.height = 60			door.width = 70

bench1 = display.newImage("benchside.png")											bench1.x = 180			bench1.y = 135			bench1.height = 155			bench1.width = 35

--barbell = display.newImage("barbell.jpg")											barbell.x = -100		barbell.y = 400			barbell.height = 30			barbell.width = 150

benchside = display.newImage("benchside.png")										benchside.x = 85		benchside.y = 72		benchside.height = 31		benchside.width = 160

bin1 = display.newImage("bin.png")													bin1.x = 20				bin1.y = 400			bin1.height = 50			bin1.width = 40

bin2 = display.newImage("bin.png")													bin2.x = 50				bin2.y = 400			bin2.height = 50			bin2.width = 40

binside1 = display.newImage("binside.png")											binside1.x = -220		binside1.y = 227		binside1.height = 40		binside1.width = 50

binside2 = display.newImage("binside.png")											binside2.x = -220		binside2.y = 180		binside2.height = 40		binside2.width = 50

bench2 = display.newImage("benchside.png")											bench2.x = 450			bench2.y = 410			bench2.height = 30			bench2.width = 160

bench3 = display.newImage("benchside.png")											bench3.x = 160			bench3.y = 410			bench3.height = 30			bench3.width = 160
				
bench4 = display.newImage("benchside.png")											bench4.x = 450			bench4.y = 330			bench4.height = 30			bench4.width = 160

bench = display.newImage("benchside.png")											bench.x = 160			bench.y = 330			bench.height = 30			bench.width = 160

knife = display.newImage("knife.png")												knife.x = 140			knife.y = 100

key1 = display.newImage("key.png")													key1.x = 550			key1.y = 80				key1.rotation = -30
key2 = display.newImage("key.png")													key2.x = -230			key2.y = 400			key2.rotation = -30
key3 = display.newImage("key.png")													key3.x = 280		key3.y = 400			key3.rotation = -30

pausemenu = display.newImage("pause.png")											pausemenu.y = 200		pausemenu.x = 180		pausemenu.height = 250		pausemenu.width = 250
resume = display.newImage("resume.png")												resume.y = 130	resume.x 	= 175	resume.id = "ball5"			resume.height = 100 resume.width = 150
comeback = display.newImage("pausemenu.png")										comeback.y = 257		comeback.x = 170		comeback.id = "ball6"		comeback.height = 80 comeback.width = 150
		
------------inserts----------------------------
		
		--sceneGroup:insert()
sceneGroup:insert(background)
sceneGroup:insert(fenceside)
sceneGroup:insert(fenceside1)
--sceneGroup:insert(stoneground)
sceneGroup:insert(fencetop)
sceneGroup:insert(fencetop1)
sceneGroup:insert(bench)
sceneGroup:insert(bench1)
sceneGroup:insert(bench2)
sceneGroup:insert(bench3)
sceneGroup:insert(bench4)
sceneGroup:insert(binside1)
sceneGroup:insert(binside2)
sceneGroup:insert(bin1)
sceneGroup:insert(bin2)
sceneGroup:insert(benchside)
--sceneGroup:insert(barbell)
sceneGroup:insert(door)
sceneGroup:insert(table1)
sceneGroup:insert(table2)
sceneGroup:insert(prisoner)
sceneGroup:insert(guard1)
sceneGroup:insert(guard2)
sceneGroup:insert(guard3)
sceneGroup:insert(guard4)
sceneGroup:insert(knife)
sceneGroup:insert(key1)
sceneGroup:insert(key2)
sceneGroup:insert(key3)
sceneGroup:insert(pausemenu)
sceneGroup:insert(comeback)
sceneGroup:insert(resume)

pausemenu.isVisible = false
comeback.isVisible = false
resume.isVisible = false

		
---------------------inserts---------------------
		
	
	--PHYSICS
		--CHARACTERS
		function SpawnObjectWithDelay()
			if once == true then
		physics.addBody( prisoner, "dynamic", { density=0.0, friction=0, radius = 25} )
		physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightLeft } , {friction=1, shape = area} )
		physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightLeft } , {friction=1, shape = area} )
		physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightLeft } , {friction=1, shape = area} )
		physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightLeft } , {friction=1, shape = area} )
		
		--WORLD OBJECTS, PUT ALL OBJECTS PHYSICS HERE
		
		--physics.addBody(barbell, 			"static", { friction = .3})					barbell.collType 			= "worldObject"
		physics.addBody(fenceside, 			"static", { friction = .3})					fenceside.collType 			= "worldObject"
		physics.addBody(fenceside1, 			"static", { friction = .3})					fenceside1.collType 			= "worldObject"
		physics.addBody(bin1, 			"static", { friction = .3})					bin1.collType 			= "worldObject"
		physics.addBody(bench1, 		"static", { friction = .3})					bench1.collType 		= "worldObject"
		physics.addBody(bench2, 		"static", { friction = .3})					bench2.collType 		= "worldObject"
		physics.addBody(bench3, 	"static", { friction = .3})					bench3.collType 	= "worldObject"
		physics.addBody(bench4, 	"static", { friction = .3})					bench4.collType 	= "worldObject"
		physics.addBody(table1, 			"static", { friction = .3})					table1.collType 			= "worldObject"
		physics.addBody(table2, 			"static", { friction = .3})					table2.collType 			= "worldObject"
		physics.addBody(bin2, 			"static", { friction = .3})					bin2.collType 			= "worldObject"
		physics.addBody(bench, 			"static", { friction = .3})					bench.collType 			= "worldObject"
		physics.addBody(binside1, 		"static", { friction = .3})					binside1.collType 		= "worldObject"
		physics.addBody(binside2, 		"static", { friction = .3})					binside2.collType 		= "worldObject"
		physics.addBody(benchside, 		"static", { friction = .3})					benchside.collType 		= "worldObject"
		physics.addBody(fencetop, 		"static", { friction = .3})					fencetop.collType 		= "worldObject"
		physics.addBody(fencetop1, 		"static", { friction = .3})					fencetop1.collType 		= "worldObject"
		
		

		
		

		--KEY ITEMS
		physics.addBody(door, 			"static", { friction = .3})					door.collType			= "worldObject"			door.type = "door"
		physics.addBody(knife, 			"static", { friction = .3})					knife.collType			= "worldObject"			knife.type = "knife"
		physics.addBody(key1, 			"static", { friction = .3, radius = 30})	key1.collType 			= "worldObject"  		key1.type = "key"
		physics.addBody(key2, 			"static", { friction = .3, radius = 30})	key2.collType 			= "worldObject"  		key2.type = "key"
		physics.addBody(key3, 			"static", { friction = .3, radius = 30})	key3.collType 			= "worldObject"  		key3.type = "key"
		once = false
			end
		end
		Runtime:addEventListener("enterFrame", SpawnObjectWithDelay )
	------GUARD MOVE PATHS----------------------------------------------------------------------------------------------------------------------------------------------------
	

	local movePath = {}
	movePath[1] = 	{ x=-10, 	y=350, time==800,  	seq = ("walkingleft"), 	sight = 1} 
	movePath[2] = 	{ x=-10,	y=300, time==800,	seq = ("walkingup"), 	sight = 4}
	movePath[3] = 	{ x=-10, 	y=250, time==800,  	seq = ("walkingup"), 	sight = 4}
	movePath[4] = 	{ x=-10, 	y=200, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath[5] = 	{ x=-10, 	y=150, time==800, 	seq = ("walkingup"), 	sight =	4}
	movePath[6] = 	{ x=40, 	y=150, time==800, 	seq = ("walkingright"), sight =	3}
	movePath[7] = 	{ x=40, 	y=200, time==800, 	seq = ("walkingdown"), 	sight = 2}
	movePath[8] = 	{ x=40, 	y=250, time==800,  	seq = ("walkingdown"), 	sight = 2}
	movePath[9] = 	{ x=40, 	y=300, time==800,  	seq = ("walkingdown"),	sight = 2}
	movePath[10] = 	{ x=40, 	y=350, time==800,  	seq = ("walkingdown"),	sight = 2}
	
	local movePath1 = {}
	movePath1[1] = 	{ x=-170, 	y=400, time==800,  	seq = ("walkingright"), 	sight = 3} 
	movePath1[2] = 	{ x=-120,	y=400, time==800,	seq = ("walkingright"), 	sight = 3}
	movePath1[3] = 	{ x=-120, 	y=350, time==800,  	seq = ("walkingup"), 	sight = 4}
	movePath1[4] = 	{ x=-120, 	y=300, time==800, 	seq = ("walkingup"), 	sight = 4}
	movePath1[5] = 	{ x=-170, 	y=300, time==800, 	seq = ("walkingleft"), 	sight =	1}
	movePath1[6] = 	{ x=-220, 	y=300, time==800, 	seq = ("walkingleft"), sight =	1}
	movePath1[7] = 	{ x=-220, 	y=350, time==800, 	seq = ("walkingdown"), sight =	2}
	movePath1[8] = 	{ x=-220, 	y=400, time==800, 	seq = ("walkingdown"), 	sight = 2}
	
	local movePath2 = {}
	movePath2[1] = 	{ x=430, 	y=280, time==800,  	seq = ("walkingleft"), 	sight = 1} 
	movePath2[2] = 	{ x=380,	y=280, time==800,	seq = ("walkingleft"), 	sight = 1}
	movePath2[3] = 	{ x=330, 	y=280, time==800,  	seq = ("walkingleft"), 	sight = 1}
	movePath2[4] = 	{ x=280, 	y=280, time==800, 	seq = ("walkingleft"), sight = 1}
	movePath2[5] = 	{ x=330, 	y=280, time==800, 	seq = ("walkingright"), sight =	3}
	movePath2[6] = 	{ x=380, 	y=280, time==800, 	seq = ("walkingright"), sight =	3}
	movePath2[7] = 	{ x=430, 	y=280, time==800, 	seq = ("walkingright"), sight =	3}
	movePath2[8] = 	{ x=480, 	y=280, time==800, 	seq = ("walkingright"), sight =	3}
	
	local movePath3 = {}
	movePath3[1] = 	{ x=500, 	y=50, time==800,  	seq = ("walkingup"), 	sight = 4} 
	movePath3[2] = 	{ x=450,	y=50, time==800,	seq = ("walkingleft"), 	sight = 1}
	movePath3[3] = 	{ x=400, 	y=50, time==800,  	seq = ("walkingleft"), 	sight = 1}
	movePath3[4] = 	{ x=350, 	y=50, time==800, 	seq = ("walkingleft"), sight = 1}
	movePath3[5] = 	{ x=300, 	y=50, time==800, 	seq = ("walkingleft"), sight =	1}
	movePath3[6] = 	{ x=250, 	y=50, time==800,  	seq = ("walkingleft"), 	sight = 1} 
	movePath3[7] = 	{ x=250,	y=100, time==800,	seq = ("walkingdown"), 	sight = 2}
	movePath3[8] = 	{ x=250, 	y=150, time==800,  	seq = ("walkingdown"), 	sight = 2}
	movePath3[9] = 	{ x=300, 	y=150, time==800, 	seq = ("walkingright"), sight = 3}
	movePath3[10] = 	{ x=350, 	y=150, time==800, 	seq = ("walkingright"), sight =	3}
	movePath3[11] = 	{ x=400, 	y=150, time==800, 	seq = ("walkingright"), sight =	3}
	movePath3[12] = 	{ x=450, 	y=150, time==800, 	seq = ("walkingright"), sight =	3}
	movePath3[13] = 	{ x=500, 	y=150, time==800, 	seq = ("walkingright"), sight =	3}
	movePath3[14] = 	{ x=500, 	y=100, time==800, 	seq = ("walkingup"), sight =	4}
	
	
	
	
	
	

	
	
	
	local function setPath1( guard1, path, seq)
		i = i + 1	if i > 10		then i = 1 end
		-- changes sight for guard1
		if movePath[i].sight == 1 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightLeft }  , {density=1.0, friction=1, shape = area} )		end
		if movePath[i].sight == 2 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightDown } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath[i].sight == 3 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightRight} , {density=1.0, friction=1, shape = area} )			end
		if movePath[i].sight == 4 then	physics.removeBody(guard1) 
								physics.addBody(guard1, "static", { density=1.0, friction=1, shape = sightUp }    , {density=1.0, friction=1, shape = area} ) 		end
													
		transition.to( guard1, { time=800, x=movePath[i].x, 	y=movePath[i].y, 	guard1:setSequence(movePath[i].seq)	} )
		guard1:play()
	end
	
	local function setPath2( guard3, path, seq)
		j = j + 1	if j > 8		then j = 1 end
		-- changes sight for guard1
		if movePath1[j].sight == 1 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightLeft }  , {density=1.0, friction=1, shape = area} )		end
		if movePath1[j].sight == 2 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightDown } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath1[j].sight == 3 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightRight} , {density=1.0, friction=1, shape = area} )			end
		if movePath1[j].sight == 4 then	physics.removeBody(guard3) 
								physics.addBody(guard3, "static", { density=1.0, friction=1, shape = sightUp }    , {density=1.0, friction=1, shape = area} ) 		end
													
		transition.to( guard3, { time=800, x=movePath1[j].x, 	y=movePath1[j].y, 	guard3:setSequence(movePath1[j].seq)	} )
		guard3:play()
	end
	
	local function setPath3( guard4, path, seq)
		k = k + 1	if k > 8		then k = 1 end
		-- changes sight for guard1
		if movePath2[k].sight == 1 then	physics.removeBody(guard4) 
								physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightLeft }  , {density=1.0, friction=1, shape = area} )		end
		if movePath2[k].sight == 2 then	physics.removeBody(guard4) 
								physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightDown } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath2[k].sight == 3 then	physics.removeBody(guard4) 
								physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightRight} , {density=1.0, friction=1, shape = area} )			end
		if movePath2[k].sight == 4 then	physics.removeBody(guard4) 
								physics.addBody(guard4, "static", { density=1.0, friction=1, shape = sightUp }    , {density=1.0, friction=1, shape = area} ) 		end
													
		transition.to( guard4, { time=800, x=movePath2[k].x, 	y=movePath2[k].y, 	guard4:setSequence(movePath2[k].seq)	} )
		guard4:play()
	end
	
	local function setPath4( guard2, path, seq)
		l = l + 1	if l > 14	then l = 1 end
		-- changes sight for guard1
		if movePath3[l].sight == 1 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightLeft }  , {density=1.0, friction=1, shape = area} )		end
		if movePath3[l].sight == 2 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightDown } , {density=1.0, friction=1, shape = area} ) 		end
		if movePath3[l].sight == 3 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightRight} , {density=1.0, friction=1, shape = area} )			end
		if movePath3[l].sight == 4 then	physics.removeBody(guard2) 
								physics.addBody(guard2, "static", { density=1.0, friction=1, shape = sightUp }    , {density=1.0, friction=1, shape = area} ) 		end
													
		transition.to( guard2, { time=800, x=movePath3[l].x, 	y=movePath3[l].y, 	guard2:setSequence(movePath3[l].seq)	} )
		guard2:play()
	end
	
	------------------------------------------------------------------------------GUARD MOVE PATHS----------------------------------------------------------------------------
	local function moving()
			if guard1.exists ~= false then setPath1  ( guard1, path, seq )	end
			if guard3.exists ~= false then setPath2  ( guard3, path, seq )  end
			if guard4.exists ~= false then setPath3 ( guard4, path, seq )  end
			if guard2.exists ~= false then setPath4 (guard2, path, seg)		end 
	end
	---------KEY EVENT--------------------------------------------------------------------------------------------------------------------------------------------------------
				function onKeyEvent(event)
						--print (event.keyName)
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
	if key1.exists ~= false and key2.exists ~= false and key3.exists ~= false then
	
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
		if key1.exists == true then
			key1:removeSelf()
		end
		if key2.exists == true then
			key2:removeSelf()
		end
		if key2.exists == true then
			key2:removeSelf()
		end
		if door.exists ==true then
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
									local death1 = audio.loadSound("death.mp3")
									local death2 = audio.play("death1")
									
								end
							end
			
						--IF THE PLAYER COLLIDES WITH THE KNIFE, "hasKnife" = TRUE
								if event.other.type == "knife" then
									display.remove(knife)
									hasKnife = true
									ExistsKnife = false
								end
			
						--IF THE PLAYER COLLIDES WITH THE KEY, "hasKey" = TRUE
								if event.other.type == "key" then
									print("Got the Key")
									display.remove(event.other)
									a = a + 1
									if a == 3 then hasKey = true 
									else hasKey = false end
								end
						
					
						--IF THE PLAY HAS THE KEY AND HITS THE DOOR
								if event.other.type == "door" then	
										print("VICTORY")
										display.remove(prisoner)
										composer.gotoScene("Credits")
										scene:destroy("")
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







-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
	background:removeSelf()	
 
 fencetop:removeSelf()
 fenceside:removeSelf()  
 fenceside1:removeSelf()  
 table1:removeSelf() 
 table2:removeSelf()
 fencetop:removeSelf()
 door:removeSelf()  
 bench:removeSelf()   
 benchside:removeSelf()
 bin1:removeSelf()
 bin2:removeSelf()
 bench1:removeSelf()
 bench2:removeSelf() 
 bench3:removeSelf()
 bench4:removeSelf()
 if ExistsKnife == true then
	knife:removeSelf()
end
if guard1.exists ~= false then
	guard1:removeSelf() 
end
if guard2.exists ~= false then
	guard2:removeSelf()
end
if guard3.exists ~= false then
	guard3:removeSelf()
end
if guard4.exists ~= false then
	guard4:removeSelf() 
end

    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )

scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene