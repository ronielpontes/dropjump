local background = display.newImage("background.jpg")
display.setStatusBar (display.HiddenStatusBar)


local w = display.contentWidth/2
local h = display.contentHeight/2

local sheetData =  { width=45, height=63, numFrames=12 }

local player = display.newRect(0, 0, 40, 40)
player.x = w * .5
player.y = h * .5

local buttons = {}

buttons[1] = display.newImage("button.jpg")
buttons[1].x = 250
buttons[1].y = 380


buttons[2] = display.newImage("button.jpg")
buttons[2].x = 250
buttons[2].y = 440


buttons[3] = display.newImage("button.jpg")
buttons[3].x = 210
buttons[3].y = 410


buttons[4] = display.newImage("button.jpg")
buttons[4].x = 290
buttons[4].y = 410




