

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.x = 100
    self.y = VIRTUAL_HEIGHT-60
    self.width = 16
    self.height = 24
    
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
end

