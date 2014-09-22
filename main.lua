display.setStatusBar(display.HiddenStatusBar)

local background = display.newImage ("background.png")

local physics = require("physics")
physics.start()

_W = display.contentWidth;
_H = display.contentHeight;
motionx = 0;
speed = 3;


--Adicionando fundo de tela
local background = display.newImage( "background.png", true )
background.x = _W/2; background.y = 160;

--Adicionando plataforma
local plataforma = display.newImage("block.png", true)
plataforma.x = 200; plataforma.y = 300;
physics.addBody( plataforma, "static", { friction=0.5, bounce=0 } )


--Adicionando o chão
local chao = display.newImage( "chao.png", true )
chao.x = _W/2; chao.y = _H-35;
--grass_bottom:setReferencePoint(display.BottomLeftReferencePoint);
physics.addBody( chao, "static", { friction=0.3, bounce=0 } )


--Adicionando o topo da grama
local gramatopo = display.newImage( "gramatopo.png", true)
gramatopo.x = _W/2; gramatopo.y = _H-95;


--Adicionando o personagem
drop = display.newImage("drop.png")
physics.addBody(drop, "dynamic", { density=1.0, friction=0.3, bounce=0.3 })
drop.x = math.random(10,_W-10)
drop.isFixedRotation = true

local function jump( event )
	if(event.numTaps == 1) then

		drop:applyForce(-350, -1000, drop.x, drop.y)
	end
end 

drop:addEventListener("tap", jump)


--Adicionando botão esquerdo
local left = display.newImage ("botao.png")
left.x = 45; left.y = 430;
left.rotation = 180;


--Adicionando botão direito
local right = display.newImage ("botao.png")
right.x = 265; right.y = 433;


--Adicionando paredes
local lefWall = display.newRect( 0, 0, 1, display.contentHeight)
local rightWall = display.newRect(display.contentWidth,0,1, display.contentHeight)

physics.addBody(lefWall, "static", {bounce = 0.1 })
physics.addBody(rightWall, "static", {bounce = 0.1 })




-- Mover o Personagem
--local function movedrop (event)
--	drop.x = drop.x + motionx;
--end
--Runtime:addEventListener("enterFrame", movedrop)

-- Função de toque no botão esquerdo
function left:touch()
	motionx = -speed;
end
left:addEventListener("touch",left)

--Função de toque no botão
function right:touch()
	motionx = speed;
end
right:addEventListener("touch",right)