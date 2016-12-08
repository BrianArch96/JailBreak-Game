local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
physics.setDrawMode("hybrid")
physics.start()
physics.setGravity(0,0)

local physics = require("physics")
physics.setGravity(0,9.8)

local desert = display.newImage("desert.jpg")
desert.x = 100
desert.y = 100
desert.height = 1000
desert.width = 1000


local fencetop = display.newImage("fencetop.png")
fencetop.x = 230
fencetop.y = 30
fencetop.height = 60
fencetop.width = 1000

local fenceside  = display.newImage("fenceside.png")
fenceside.x = -257
fenceside.y = 270
fenceside.height = 420
fenceside.width = 20

local stoneground  = display.newImage("ground.jpe")
stoneground.x = 400
stoneground.y = 300
stoneground.height = 485
stoneground.width = 600

local court = display.newImage("court.jpg")
court.x = 400
court.y = 160
court.height = 200
court.width = 400

local table1 = display.newImage("table.png")
table1.x = 200
table1.y = 370
table1.heigth = 40
table1.width = 130

local table1 = display.newImage("table.png")
table1.x = 400
table1.y = 370
table1.heigth = 40
table1.width = 130

local fencetop = display.newImage("fencetop.png")
fencetop.x = 230
fencetop.y = 455
fencetop.height = 60
fencetop.width = 1000

local door = display.newImage("endwall.png")
door.x = 533
door.y = 455
door.height = 60
door.width = 70

local bench = display.newImage("bench.png")
bench.x = 180
bench.y = 135
bench.height = 155
bench.width = 35

local barbell = display.newImage("barbell.jpg")
barbell.x = -100
barbell.y = 400
barbell.height = 30
barbell.width = 150

local benchside = display.newImage("benchside.png")
benchside.x = 85
benchside.y = 72
benchside.height = 31
benchside.width = 160

local bin = display.newImage("bin.png")
bin.x = 50
bin.y = 400
bin.height = 50
bin.width = 40

local bin = display.newImage("bin.png")
bin.x = 80
bin.y = 400
bin.height = 50
bin.width = 40

local binside = display.newImage("binside.png")
binside.x = -220
binside.y = 227
binside.height = 40
binside.width = 50

local binside = display.newImage("binside.png")
binside.x = -220
binside.y = 180
binside.height = 40
binside.width = 50

local bench = display.newImage("benchside.png")
bench.x = 400
bench.y = 410
bench.height = 30
bench.width = 160

local bench = display.newImage("benchside.png")
bench.x = 200
bench.y = 410
bench.height = 30
bench.width = 160

local bench = display.newImage("benchside.png")
bench.x = 400
bench.y = 330
bench.height = 30
bench.width = 160

local bench = display.newImage("benchside.png")
bench.x = 200
bench.y = 330
bench.height = 30
bench.width = 160
return scene 