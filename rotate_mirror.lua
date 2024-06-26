--[[
Rotate Mirroring
Author: memopemo

An Aseprite script that alows the user to draw with the image being rotated into 4 quadrants.
]]--

local sprite = app.sprite

if sprite.width ~= sprite.height then
    print("sprite must be square. exiting.")
    return
end
if(sprite.width % 2 == 1) then
    print("sprite must be even. exiting.")
    return
end
local fullsize = sprite.width
local quadSize = sprite.width/2;

print("~~~Rotate Mirroring~~~")
print("         by memopemo          ")
print("To use, draw in the lower right quadrant of the sprite.")
print("Have fun making beautiful shapes and designs!")
print("Please make sure sprite takes up entire canvas before using. Else you may see white lines appear.")

sprite.events:on('change', function (ev) 

    -- prevent operation on absence of an image.
    if(app.image == nil) then
        return
    end

    clone = app.image:clone()

    -- rotate to bottom left quadrant
    for y = 0, quadSize, 1 do
        for x = 0, quadSize, 1 do
            pixel = clone:getPixel(x - app.cel.position.x + quadSize, y - app.cel.position.y + quadSize)
            clone:drawPixel((quadSize - y) - (app.cel.position.x+1), x - app.cel.position.y + quadSize, pixel)
        end
    end
    
    -- rotate to top left quadrant
    for y = 0, quadSize, 1 do
        for x = 0, quadSize, 1 do
            pixel = clone:getPixel(x - app.cel.position.x + quadSize, y - app.cel.position.y + quadSize)
            clone:drawPixel((quadSize - x) - (app.cel.position.x+1), (quadSize - y) - (app.cel.position.y+1), pixel)
        end
    end
    -- rotate to top right quadrant
    for y = 0, quadSize, 1 do
        for x = 0, quadSize, 1 do
            pixel = clone:getPixel(x - app.cel.position.x + quadSize, y - app.cel.position.y + quadSize)
            clone:drawPixel(y - app.cel.position.x + quadSize, (quadSize - x) - (app.cel.position.y+1), pixel)
        end
    end
    app.cel.image = clone
    app.refresh()
end)




