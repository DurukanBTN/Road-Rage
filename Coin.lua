

Coin = Class{__includes = Entity}

function Coin:init(def)
    Entity.init(self, def)
    self.x = math.floor(math.random(600,1000))
    self.y = (VIRTUAL_HEIGHT - math.random(3) * 32) + 8
    self.width = 16
    self.height = 16
    self.texture = 'coin'
    
end



function Coin:render()
    Entity.render(self)
end

