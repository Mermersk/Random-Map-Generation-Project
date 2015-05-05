--Skip

function skipload()

    skip = love.graphics.newImage("skip2.png")
	location_skip = love.math.random(1, #sjocoords)
	skip_x = sjocoords[location_skip].x  --Næ í random value frá sjóhnitatöflunni til að setja skipið mitt á!
	skip_y = sjocoords[location_skip].y
	skip_hradi = 0
	skip_radius = 0
	p_radius = 0
	p_hradi = 0.5


end

function skipupdate(dt)


    skip_x = skip_x + math.cos(skip_radius) * skip_hradi*dt  --staðsetning hlutar + áttin á x-ás * hraði í áttina = 360 movement
	skip_y = skip_y + math.sin(skip_radius) * skip_hradi*dt
	if love.keyboard.isDown("left") then
	    skip_radius = skip_radius - 3 *dt  --breyta um átt
	end
	if love.keyboard.isDown("right") then
	    skip_radius = skip_radius + 3 *dt
	end
    if love.keyboard.isDown("up") then
	    skip_hradi = skip_hradi + 11 *dt
	else if skip_hradi > 0 then
	   skip_hradi = skip_hradi - 10 *dt
	end
	end
	
	punkt_x = (skip_x + 50) + math.cos(p_radius) *p_hradi *dt
	punkt_y = (skip_y + 50) + math.sin(p_radius) *p_hradi*dt
	p_radius = p_radius + p_hradi*dt
    
	sr, sg, sb, sa = Mapready:getPixel(skip_x, skip_y)  --skip collision check á Landamappi s = skip
    if sb < 100 then
	    skip_x = 200
	end
	
	--circlecollision2(skip_x, skip_y, )
end

function skipdraw()
    love.graphics.draw(skip, skip_x, skip_y, skip_radius, 0.1, 0.1, 195, 170)
	love.graphics.line(skip_x, skip_y, punkt_x, punkt_y)
end

--math.sqrt(math.abs(x-coords a - x-coords b)^2 + math.abs(y-coords a - y-coords b)^2) < radius a + radius b  radius er í raun = width/2.
function circlecollision2(xa, ya, xb, yb, rada, radb)
    if math.sqrt(math.abs(xa-xb)^2 + math.abs(ya-yb)^2) < rada + radb then
	    collision = true
	else
	    collision = false
	end
	
	return collision
end