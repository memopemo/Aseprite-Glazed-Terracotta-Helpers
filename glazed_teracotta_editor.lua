--[[
Glazed Terracotta Editor
Author: memopemo

An Aseprite script that alows the user to draw with an 45 degree mirroring. 
It also will copy the result and rotates it into the other 4 quadrants to previewview it in context.

you may also copy/paste the upper right quadrant into the lower right quadrant to view the alternate rotation of the block.
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

print("~~~Glazed Terracotta Editor~~~")
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


    -- 45 degree flip from upper wedge of bottom right quadrant to lower wedge
    for x = 0, quadSize, 1 do
        for y = 0, x, 1 do
            pixel = clone:getPixel(x - app.cel.position.x + quadSize, y - app.cel.position.y + quadSize)
            clone:drawPixel(y - (app.cel.position.x) + quadSize, x - (app.cel.position.y) + quadSize, pixel)
        end
    end
    
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




