--Tilraunir við mappagerð, eða gera eitthvað við það sem kemur út úr noise!
--Note Lovenoise eftir substitue á forumið.

require("Mapgen")
require("sky")
require("skip")
require("conf")
lovenoise = require("lovenoise")
modules = require("lovenoise.modules")


function love.load()
    
	generated = false
	timer_go = false
	load_timer = 0
	
	ekki_generated = "Press Enter to generate new land!"
	is_generating = "Generating..."
	beginning_info = ekki_generated
	
	t = 0.1
	
end

function love.update(dt)
    
	if timer_go == true then
	    load_timer = load_timer + 1*dt
	end
	
	 if load_timer > 1 then  --ýti á enter til að setja timarann load_timer af stað þegann hann er kominn í 1 þá generateast mappið
	    seed_tala = love.math.random(0, 3000)
		love.load(  --vissi ekki að þetta væri hægt, virkar eins og love.load alveg lengst uppi!
		createmap(),
	    skogify(),
		skyload(),
	    skipload()
		) 
		load_timer = 0
		generated = true
		
	end
	
	if generated == false then
	    return
	end
    
    mx, my = love.mouse.getPosition()
    mr, mg, mb, ma = Mapdata:getPixel(mx, my)  --Músarchekkið, skoða litinn á mappinu þegar BARA noiseið er komið á.
	skipupdate(dt)
	
end

function love.draw()
    
	loading_screen()
	
	if load_timer > 0.1 and load_timer < 0.9 then
	    generated = false
	end
	
	if generated == false then
	    return
	end
	
	love.graphics.draw(Mapready, -1, -1)
	love.graphics.rectangle("fill", 0, 0, 35, 30)
	love.graphics.setColor(0, 0, 0)
    love.graphics.print(mb, 10, 10)  --.. er til að bara skrifa í næstu bail en ekki yfir hvort annað
    love.graphics.setColor(255, 255, 255)
	
	love.graphics.print("Tréhnit " .. #tuncoords, 1000, 5)  --Ná í hve mörg pör af {x = ?, y = ?} pörum við erum með
	love.graphics.print("Snjóhnit " .. #snowcoords, 1000, 20)
    love.graphics.print("Snjóvatnhnit " .. #snjovatncoords , 1000, 35)  
	love.graphics.print("Sandhnit " .. #snowcoords, 1000, 50)
	--love.graphics.print("ENTER to Generate new map", 40, 5)
	--love.graphics.print(kurva_punktar[1].f_sjo_x, 1000, 70)
	--love.graphics.print(kurva_punktar[2].f_sjo_x, 1000, 90)
    --skydraw()
	skipdraw()
	
	
end

function love.keypressed(key)

    if key == "return" then
	    beginning_info = is_generating
		timer_go = true
	end
	
	if key == "h" then
	    cleanse()
	end

end

function loading_screen()

	love.graphics.setBackgroundColor(45, 70, 100)
	love.graphics.print(beginning_info, 500, 400)
	
end

--Loading logic: ekkert er hlaðið in og love.draw-love.update eru ekki keyrðar þar sem að generated = false. Eina sem sést er blár bakgrunnur og strengurinn "Press enter to generate new land..".
--Notandi ýtir á enter, þá breytist strengurinn í "Generating..." og load_timer fer af stað. þegar load_timer er á milli 0.1 og 0.9 þá breyti ég generated í false svo að allt hverfi(gildir bara þegar generatea á map ekki í 1 sinn) og þegar load_timer er kominn yfir 1 þá generate ég glænýtt mapp og segi að generated = true i endann og þá teiknar programið allt. Stilli lika load_timer aftur á 0.


--skref 1: Bý til noise og er með ákveðna liti á það, set það á imagedata og fer siðan yfir það til að finna hvar skógur á að fara með þvi að skoða blá litinn, value frá 5 til 20 þar er skógur. Það undanskilur þá strendur og há fjöll
--skref 2: Bý til canvas þar sem ég lita punktanna sem ég fann og setti í töflu græna. skógur!! og örugglega margt fleira


 
