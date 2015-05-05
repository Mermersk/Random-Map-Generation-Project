--Búa til ský með Billow noise

modules = require("lovenoise.modules")

function skyload()
  
    Testnoise = modules.Billow:new()
	Testnoise:setOctaves(13)--Á milli 2 og 100. Lág tala = smooth eins og pollar, há tala = lýtur meira út eins og lönd á korti
	Testnoise:setSeed(95)
	--Testnoise:setLacunarity(0.5)
	--Testnoise:setPersistence(0.5) --Á milli 0 og 1, mjög lág tala = allt voðalega smooth, mjög há = ekki smooth
	Testnoise:setFrequency(0.007)  --Nýja "zoomið" í gamla var það talan eftir t.d. "fractal", tala, {a, b, c}
	notsky = {}
	sky = {}
	
	
	Noisedata = love.image.newImageData(1201, 801)
	for x = 1, 1200 do
	for y = 1, 800 do
	    info = Testnoise:getValue(x, y)
		Noisedata:setPixel(x, y, 140+127*info, 140+127*info, 140+127*info, 255)
		----------------------
		r, g, b, a = Noisedata:getPixel(x, y)
		if b >= 100 then
		    table.insert(sky, {x = x, y = y})
		end
		if b < 100 then
		    table.insert(notsky, {x = x, y = y})
		end
	end
	end
	
	Noiseimage = love.graphics.newImage(Noisedata)
	
	sky_canvas = love.graphics.newCanvas(1201, 801)
	love.graphics.setCanvas(sky_canvas)
	love.graphics.draw(Noiseimage)
	    for lykill, gildi in pairs(sky) do
	        love.graphics.setColor(255, 255, 255, 255)
		    love.graphics.point(gildi.x, gildi.y)
	        love.graphics.setColor(255, 255, 255, 255)
	    end
		for lykill, gildi in pairs(notsky) do
	        love.graphics.setColor(255, 255, 255, 255)
		    love.graphics.point(gildi.x, gildi.y)
	        love.graphics.setColor(255, 255, 255, 255)
	    end
	love.graphics.setCanvas()
	

end

function skydraw()

    love.graphics.setColor(255, 255, 255, 225)
    love.graphics.draw(sky_canvas)
	love.graphics.setColor(255, 255, 255, 255)

end