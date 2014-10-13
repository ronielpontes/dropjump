display.setStatusBar(display.HiddenStatusBar)

local physics = require("physics")
physics.start()
group = display.newGroup()

_W = display.contentWidth;
_H = display.contentHeight;
Scrollspeed = 2;
motionx = 0
speed = 3

local pulo = audio.loadSound ("/sons/Jump.mp3")

--Adicionando fundo de tela -> 1
local bg1 = display.newImage( "/imagens/bg3.jpg")
bg1.x = _W/2; bg1.y = _H/2;

----------------------------------------------------------------------------------------

-- --Adicionando fundo de tela -> 3
-- local bg4 = display.newImage( "/imagens/bg3.jpg")
-- bg4.x = _W/2; bg4.y = -480;

-- local function move()

-- bg1.y = bg1.y + Scrollspeed
-- bg2.y = bg2.y + Scrollspeed
-- bg4.y = bg4.y + Scrollspeed

-- if (bg1.y + bg1.contentHeight) < 0 then
-- 	bg1:translate(0, 480*3)
-- end
-- if (bg2.y + bg2.contentHeight) < 0 then
-- 	bg2: translate(0, 480*3)
-- end

-- if (bg4.y + bg4.contentHeight) < 0 then
-- 	bg4:translate(0, 480*3)
-- end
--end

--Runtime:addEventListener("enterFrame", move)
--tm = timer.performWithDelay (1, move, 0)

-- local function andaPorra()
-- 	local function recria()
-- 		display.remove (bg1)
-- 		local bg1 = display.newImage( "/imagens/bg3.jpg")
-- 		bg1.x = _W/2; bg1.y = 160;
-- 	end

-- 	local function recria2()
-- 		display.remove(bg2)
-- 		local bg2 = display.newImage( "/imagens/bg3.jpg")
-- 		bg2.x = _W/2; bg2.y = -320;
-- 	end
-- 	transition.to (bg1, {x = 0, y = 480, time = 2000, onComplete = recria})
-- 	--transition.to (bg2, {x = 0, y = 480, time = 2000, onComplete = recria2})
-- end

-- tm = timer.performWithDelay (1000, andaPorra, 0)

------------------------------------------------------------------------------------------------------------


local medidasFolha = {width = 64, height = 79, numFrames = 10}

local folha = graphics.newImageSheet ("/imagens/sheetdrop.png", medidasFolha)

local sequenciaSprites = 
{
	{name = "paradoDireita", start = 6, count = 1, time = 0, loopCount = 1},
	{name = "paradoEsquerda", start = 1, count = 1, time = 0, loopCount =1},
	{name = "puloDireita", start = 6, count = 4, time = 500, loopCount = 1, loopDirection = "bounce"},
	{name = "puloEsquerda", start = 1, count = 4, time = 500, loopCount = 1, loopDirection ="bounce"},
		
}

local drop = display.newSprite (folha, sequenciaSprites)
drop.y = _H/2
drop.x = _W/2
physics.addBody(drop, "dynamic", { density=0.6, friction=0, bounce=0.3 })
drop:setSequence ("puloEsquerda")
drop.name = "drop"
drop.isFixedRotation = true


--Adicionando plataforma
local plataforma = display.newImage("/imagens/platformPeq.png", true)
plataforma.x = 400; plataforma.y = 230;
physics.addBody( plataforma, "static", { friction=0.5, bounce=0 } )
plataforma.name = "plataforma"

--Adicionando plataforma
local plataforma = display.newImage("/imagens/platformPeq.png", true)
plataforma.x = 230; plataforma.y = 150;
physics.addBody( plataforma, "static", { friction=0.5, bounce=0 } )
plataforma.name = "plataforma"

--Adicionando o chão
local chao = display.newImage( "/imagens/grass.png", true )
chao.x = _W/2; chao.y = _H-20;
--grass_bottom:setReferencePoint(display.BottomLeftReferencePoint);
physics.addBody( chao, "static", { friction=0.3, bounce=0 } )
chao.name = "chao"
-- Adicionando o personagem
-- drop = display.newImage("/imagens/drop.png")
-- physics.addBody(drop, "dynamic", { density=1.0, friction=0.3, bounce=0.3 })
-- drop.x = _W/2
-- drop.isFixedRotation = true
-- drop.name = "drop"

--Adicionando botão esquerdo
local left = display.newImage ("/imagens/botao.png")
left.x = 47; left.y = 300;
left.rotation = 180;
left.myName = "left"

--Adicionando botão direito
local right = display.newImage ("/imagens/botao.png")
right.x = 433; right.y = 300;
right.myName = "right"

--Adicionando paredes
local lefWall = display.newRect( 0, display.contentHeight/2, 1, display.contentHeight)
local rightWall = display.newRect(display.contentWidth, display.contentHeight/2, 1, display.contentHeight)

physics.addBody(lefWall, "static", {bounce = 0.1 })
physics.addBody(rightWall, "static", {bounce = 0.1 })

--Função de pulo.
function playerJump()
		drop:setLinearVelocity( 0, 0 )
		drop:applyLinearImpulse(0,80, drop.x, drop.y)
		if ((drop.sequence == "paradoEsquerda") or (drop.sequence == "puloEsquerda")) then
			drop:setSequence("puloEsquerda")
			drop:play()
		elseif ((drop.sequence == "paradoDireita") or (drop.sequence == "puloDireita")) then
			drop:setSequence ("puloDireita")
			drop:play()
		end
end			

--Chama infinitamente a função de pulo.
local tm = timer.performWithDelay (3000, playerJump, 0)	

--Para o movimento apos soltar as setas.
local function stop (event)
	if event.phase =="ended" then
		motionx = 0;
	end		
end


--Mover o Personagem
local function movedrop (event)
	drop.x = drop.x + motionx;
end



--Função para remover o chão após tocar em uma das setas.
function removeChao()
	function apagar()
		display.remove (chao)
	end
	transition.to(chao, {x = chao.x, y = display.contentHeight+25, time = 3000, onComplete = apagar})
end

-- Função de toque no botão esquerdo
function left:touch()
	removeChao ()
	drop:setSequence ("paradoEsquerda")
	motionx = -speed;
end


--Função de toque no botão
function right:touch()
	removeChao ()
	drop:setSequence ("paradoDireita")
	motionx = speed;
end

local function onCollision(event)
	if ((event.object1.name == "drop" and event.object2.name == "plataforma") or (event.object1.name == "drop" and event.object2.name == "chao")) then
		audio.play (pulo)
	end	
end

--Cria os Listeners.
Runtime:addEventListener ("collision", onCollision)
Runtime:addEventListener("touch", stop )
Runtime:addEventListener("enterFrame", movedrop)
left:addEventListener("touch",left)
right:addEventListener("touch",right)
