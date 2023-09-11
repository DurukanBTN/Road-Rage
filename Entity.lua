Entity = Class{}

function Entity:init(def)
    -- position
    self.x = 0
    self.y = 0

    -- velocity
    self.dx = 0
    self.dy = 0

    -- dimensions
    self.width = 16
    self.height = 24

    self.texture = 'player'
    self.car2 = false

    self.direction = 'right'
end

function Entity:collides(entity)
    return not (self.x > entity.x + entity.width or entity.x > self.x + self.width or
                self.y > entity.y + entity.height or entity.y > self.y + self.height)
end

function Entity:render()
    if self.texture ~= 'car' then
        if self.texture ~= 'coin' then
            love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
                math.floor(self.x-playerscroll2) + 8, math.floor(self.y + playerscroll) + 10, playerrotation, self.direction == 'right' and 1 or -1, 1, 8, 10)
        else 
            love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
                math.floor(self.x) + 8, math.floor(self.y) + 10, 0, self.direction == 'right' and 1 or -1, 1, 8, 10)
        end
    else
        if self.car2 then
            love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
                math.floor(self.x-carscroll2) + 8, math.floor(self.y) + 10, 0, self.direction == 'right' and 1 or -1, 1, 8, 10)
        else
            love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
                math.floor(self.x-carscroll) + 8, math.floor(self.y) + 10, 0, self.direction == 'right' and 1 or -1, 1, 8, 10)
        end
    end
end