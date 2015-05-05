
function createmap()  --Fyrsta skref, búa til "desert land"

    tuncoords = {{x = 200, y = 200}}  -- frystu hnitin er til að testa
	snowcoords = {}
	snjovatncoords = {}
	sandcoords = {}
	sjocoords = {}
	rtrecoords = {}
	fjallcoords = {}
	shallowscoords = {}
    
	
    Mapnoise = lovenoise.newNoise({"fractal", 440, {11, 0.5, 2}})  --{number of octaves, amplitude scaling factor, frequency scaling factor}
    Mapnoise:setnormalized(true)               --440, {11, 0.5, 2}
	seed_tala = love.math.random(1, 3000)
	Mapnoise:setseed(seed_tala)  --refresher landlsag og býr til nýtt
	
	Mapdata = love.image.newImageData(1201, 801) --einn pixel stærri, annars er kvartað um "out of range pixel"
	
	for x = 1, 1200 do
	for y = 1, 800 do
	    info = Mapnoise:eval(x, y)
        Mapdata:setPixel(x, y, 255*info, 100*info, 45*info, 255)
		-----------
		r, g, b, a = Mapdata:getPixel(x, y)
	    if b >= 2 and b < 21 then  --Setja x og y coords innni töflu sem geymir x og y-hnitinn
	        table.insert(tuncoords, {x = x, y = y}) --Hér set ég inn í töfluna treecords x og y hnitin á pixlum þar sem bláliturinn er á milli 5 og 20 úr x (frá 1 til 1200) og y(frá 1 til 800)
	    end
		if b > 23 and b < 50 then
		    table.insert(snowcoords, {x = x, y = y}) --Ná í hnitinn fyrir hver pixel snjór, set hnitinn í töflu
		end
		if b == 23 then --I krínkum jökla-fjallstoppa vatn-leysingjavatn
		    table.insert(snjovatncoords, {x = x, y = y}) 
		end
		if b > -1 and b <= 1 then
		    table.insert(sandcoords, {x = x, y = y}) --Ná í hnitinn fyrir ströndina!
		end
		if b > 200 then
		    table.insert(sjocoords, {x = x, y = y}) --Ná í hnitinn fyrir sjó!
		end
		if b > 5 and b < 19 then
		    table.insert(rtrecoords, {x = x, y = y}) --Ná í hnit fyrir alvöru tré, nema uppi er tré...eða gras?
		end
		if b >= 21 and b <= 23 then
		    table.insert(fjallcoords, {x = x, y = y}) --Fjöllin
		end
		if b >= 249 and b <= 255 then
		    table.insert(shallowscoords, {x = x, y = y}) --Shallow sjór við strönd
		end
		
	end
	end
	
	Map = love.graphics.newImage(Mapdata)

	return Map  --Skilar tilbaka Mynd sem heitir Map, eins og .png eða eitthvað
end

function skogify()  --function til að setja stuff á góðu noise mappið okkar, eins og snjó og tré.....

    Mapready = love.graphics.newCanvas(1201, 801)
	love.graphics.setCanvas(Mapready)
	    love.graphics.draw(Map)
		
		for lykill, gildi in pairs(tuncoords) do
			love.graphics.setColor(34, 139, 34, 175)  --Grænn litur, fyrir skóg  --0, 30, 0
			love.graphics.point(gildi.x, gildi.y)
			love.graphics.setColor(255, 255, 255, 255)
		end
		
		for lykill, gildi in pairs(snowcoords) do
		    love.graphics.setColor(255, 255, 255)  --Snjórinn
			love.graphics.point(gildi.x, gildi.y)
			love.graphics.setColor(255, 255, 255)
		end
		for lykill, gildi in pairs(snjovatncoords) do
		    love.graphics.setColor(0, 250, 250)  --Snjóleysingjavatn
			love.graphics.point(gildi.x, gildi.y)
			love.graphics.setColor(255, 255, 255)
		end
		for lykill, gildi in pairs(sandcoords) do
		    love.graphics.setColor(244, 164, 96)  --Ströndin
			love.graphics.point(gildi.x, gildi.y)
			love.graphics.setColor(255, 255, 255)
		end
		for lykill, gildi in pairs(sjocoords) do  
		    love.graphics.setColor(0, 139, 139, 255)  --Sjórinn
			love.graphics.point(gildi.x, gildi.y)
			love.graphics.setColor(255, 255, 255, 255)
		end
		for lykill, gildi in pairs(rtrecoords) do
		    love.graphics.setColor(0, 35, 0)  --alvörutré
			love.graphics.point(gildi.x, gildi.y)
			love.graphics.setColor(255, 255, 255)
		end
		for lykill, gildi in pairs(fjallcoords) do
		    love.graphics.setColor(119, 136, 153)  --Fjallstoppur
			love.graphics.point(gildi.x, gildi.y)
			love.graphics.setColor(255, 255, 255)
		end
		for lykill, gildi in pairs(shallowscoords) do
		    love.graphics.setColor(32, 178, 170, 255)  --Sea-shallows  32, 178, 170, 255
			love.graphics.point(gildi.x, gildi.y)
			love.graphics.setColor(255, 255, 255, 255)
		end
	
	--fljot()
    love.graphics.setCanvas()

	return Mapready
end

function fljot()

    fjoldi_fljota = {}
    for f = 1, 10 do	
	    fjoldi_fljota[f] = {snjor = love.math.random(1, #snjovatncoords), sjor = love.math.random(1, #sandcoords)} --Handahófskenndar tölur
	end
		
	kurva_punktar = {}
	for lykill, gildi in pairs(fjoldi_fljota) do
		table.insert(kurva_punktar, {f_snjo_x = snjovatncoords[gildi.snjor].x, f_snjo_y = snjovatncoords[gildi.snjor].y, middle_x = love.math.random(580, 620), middle_y = love.math.random(380, 420), f_sjo_x = sandcoords[gildi.sjor].x, f_sjo_y = sandcoords[gildi.sjor].y})
	end
    
	for lykill, gildi in pairs(kurva_punktar) do
	    love.graphics.setColor(0, 0, 210, 255)
		kurva = love.math.newBezierCurve(gildi.f_snjo_x, gildi.f_snjo_y, gildi.middle_x, gildi.middle_y, gildi.f_sjo_x, gildi.f_sjo_y)
	    kurva_ready = kurva:render(10)
	    love.graphics.line(kurva_ready)
		love.graphics.setColor(255, 255, 255, 255)
    end
	
end


function cleanse() --not working

    
	x, y = kurva:evaluate(t)
	love.graphics.circle("fill", x, y, 12, 36)
	if love.keyboard.isDown("up") then
	    t = t + 0.01 
	end
	if love.keyboard.isDown("down") then
	    t = t - 0.01 
	end
	love.graphics.print(x, 500, 100)
	love.graphics.print(y, 600, 200)
	
	if x == sjocoords.x then
	    love.graphics.setColor(255, 255, 255, 0)
		
		
	end

end

function pyth(x1, x2, y1, y2)  --Pýþagóras functionið, get þá gert hvar sem er pyth(x-hnit hlutars 1, x-hnit hlutars 2, y-hnit hlutars 1, y-hnit hlutars 2) og fengið út lengdina á mili þeirra!
    return math.sqrt((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2))
end

