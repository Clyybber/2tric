test = {}

--require 'code/experiments/generator'

local ecs = {components = {},main_list={}}

local px, py = 10, 10

local bineapple = require 'code/systems/bineapple'

local bspt


function image_to_raw(image) --img provided as imageData
  local image_width, image_height = image:getDimensions()
  local raw = {}
  for x=1, image_width do
    raw[x] = {}
    for y=1, image_height do
      raw[x][y] = { image:getPixel(x-1,y-1) }
    end
  end
  return raw
end

local function basic_draw(self)
  love.graphics.setColor(self.r,self.g,self.b)
  love.graphics.rectangle('fill',self.back_ref['bspt'].lx,self.back_ref['bspt'].uy,self.back_ref['bspt'].rx-self.back_ref['bspt'].lx,self.back_ref['bspt'].dy-self.back_ref['bspt'].uy)
end

function test:enter()
  love.graphics.setDefaultFilter('nearest','nearest')
  scale:setup(100,100 )
  ecs.components.bspt = bineapple.new(100,100,3)
  ecs.components.render = {}
--bineapple.insert(bspt,lx,uy,rx,dy,back_ref)
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(49,49,51,51,'mittemitte')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(49,16,51,19,'obenmitte')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(49,90,51,91,'untenmitte')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(80,49,81,51,'rechtsmitte')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(19,49,21,51,'linksmitte')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(10,10,11,11,'links oben')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(19,79,21,81,'links unten')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(80,19,81,23,'rechts oben')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(80,87,81,91,'rechts unten')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(10,10,11,11,'links oben2')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(19,79,21,81,'links unten2')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(80,19,81,23,'rechts oben2')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  ecs.main_list[#ecs.main_list+1] = {}
  ecs.main_list[#ecs.main_list]['bspt'] = ecs.components.bspt:insert(80,87,81,91,'rechts unten2')
  ecs.components.render[#ecs.components.render+1] = {back_ref=ecs.main_list[#ecs.main_list],basic_draw = basic_draw}
  ecs.components.render[#ecs.components.render].r = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].g = love.math.random(20,255)
  ecs.components.render[#ecs.components.render].b = love.math.random(20,255)
  ecs.main_list[#ecs.main_list]['render'] = ecs.components.render[#ecs.components.render]
  local foo1 = {[0]=true,[1]=true,[2]=true,[3]=true,[4]=true}
  local foo2 = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true}
  local img = love.image.newImageData('res/img/test.png')
  do
    local lol = "ha"
    print(lol)
  end
  print(lol)
  if true then
    local ha = "lol"
    print(ha)
  end
  print(ha)
end

function test:draw()
  scale:start()
  for i = 1, #ecs.main_list do
    ecs.main_list[i]['render']:basic_draw()
  end
  scale:finish()
end

function test:update(dt)
  
end

return test