splash = {}

local s = {}

function splash:enter()
  s[1] = love.graphics.newImage( 'res/img/splash/splashtri.png' )
  s[2] = love.graphics.newImage( 'res/img/splash/splashcir.png' )
  s[3] = love.graphics.newImage( 'res/img/splash/splashell.png' )
  s[4] = love.graphics.newImage( 'res/img/splash/splashrec.png' )
  s[5] = love.graphics.newImage( 'res/img/splash/splashpol.png' )
  s[6] = love.graphics.newImage( 'res/img/splash/splashrell.png' )
  s[7] = love.graphics.newImage( 'res/img/splash/splashrrec.png' )
  scale:setup(200,200)
end

function splash:draw()
  scale:start()
  love.graphics.draw(s[love.math.random(7)],0,0,0,0.1,0.1)
  scale:finish()
  love.timer.sleep(1/20)
end

function splash:update(dt)
  
end

function splash:keypressed(k)
  if k == 'space' then state.switch(mainmenu)
  elseif k == 'escape' then love.event.quit()
  end
end

return splash