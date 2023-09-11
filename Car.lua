

Car = Class{__includes = Entity}

function Car:init(def)
    Entity.init(self, def)
    self.x = math.floor(math.random(600,1000))
    self.y = VIRTUAL_HEIGHT -60
    self.width = 74
    self.height = 24
    self.texture = 'car'
    
end



function Car:render()
    Entity.render(self)
end

