
push = require 'push'


Class = require 'class'


require 'StateMachine'

require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'
require 'Animation'
require 'Entity'
require 'Player'
require 'Util'
require 'Car'
require 'Coin'

gTextures = {
    ['player'] = love.graphics.newImage('images/photos/player.png'),
    ['car'] = love.graphics.newImage('images/photos/car.png'),
    ['coin'] = love.graphics.newImage('images/photos/coin.png')
}
gFrames = {
    ['player'] = GenerateQuads(gTextures['player'], 16, 24),
    ['car'] = GenerateQuads(gTextures['car'], 74, 24),
    ['coin'] = GenerateQuads(gTextures['coin'], 16, 16)
}

gSounds = {
    ['hit'] = love.audio.newSource('sounds/hit.mp3', 'static'),
    ['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
    ['coin'] = love.audio.newSource('sounds/coin.mp3', 'static'),
    ['city'] = love.audio.newSource('sounds/city.mp3', 'static'),
    ['slide1'] = love.audio.newSource('sounds/slide.mp3', 'static'),
    ['slide2'] = love.audio.newSource('sounds/slide.mp3', 'static'),
    ['slide3'] = love.audio.newSource('sounds/slide.mp3', 'static'),
    ['slide4'] = love.audio.newSource('sounds/slide.mp3', 'static')
}
-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('images/background.png')
local backgroundScroll = 0

local road = love.graphics.newImage('images/road.png')
local roadScroll = 0

local lamp = love.graphics.newImage('images/lamp.png')
local lampScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local ROAD_SCROLL_SPEED = 90

local BACKGROUND_LOOPING_POINT = 409

function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- seed the RNG
    math.randomseed(os.time())

    -- app window title
    love.window.setTitle('Road Rage')

    smallFont = love.graphics.newFont('fonts/font.ttf', 10)
    mediumFont = love.graphics.newFont('fonts/font.ttf', 20)
    largeFont = love.graphics.newFont('fonts/font.ttf', 40)
    love.graphics.setFont(mediumFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }

    gStateMachine:change('title')
    love.keyboard.keysPressed = {}

    -- initialize mouse input table
    love.mouse.buttonsPressed = {}

    gSounds['music']:setLooping(true)
    gSounds['music']:setVolume(1)
    gSounds['music']:play()

    gSounds['city']:setLooping(true)
    gSounds['city']:play()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

--[[
    LÖVE2D callback fired each time a mouse button is pressed; gives us the
    X and Y of the mouse, as well as the button in question.
]]
function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

--[[
    Custom function to extend LÖVE's input handling; returns whether a given
    key was set to true in our input table this frame.
]]
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

--[[
    Equivalent to our keyboard function from before, but for the mouse buttons.
]]
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.update(dt)
    -- scroll our background and ground, looping back to 0 after a certain amount
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    roadScroll = (roadScroll + ROAD_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
    
    lampScroll = (lampScroll + ROAD_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    gStateMachine:update(dt)
   

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    
    love.graphics.draw(road, -roadScroll, VIRTUAL_HEIGHT-96)
    love.graphics.draw(lamp, 512-lampScroll, VIRTUAL_HEIGHT-125)
    gStateMachine:render()
    push:finish()
end
