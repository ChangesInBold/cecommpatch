printl("SETTING TEMPERATE BIOME")
local biomeName = "temperate"
send("gameSession", "setSessionString", "biome", biomeName)
send("gameSession", "setSessionBool", "biomeCold", false)
send("gameSession", "setSessionBool", "biomeTemperate", true)
send("gameSession", "setSessionBool", "biomeTropical", false)
send("gameSession", "setSessionBool", "biomeDesert", false)
send("gameSession", "setSessionInt", "colonyPopulation", 0)
send("gameSession", "setSessionInt", "militaryCount", 0)

send("rendCommandManager", "odinRendererSetLighting",165,140,125,30,40,90) -- Temperate Lighting
--send("rendCommandManager", "odinRendererSetLighting",118,79,75,38,27,53) -- Desert Lighting
--send("rendCommandManager", "odinRendererSetLighting",126,132,183,33,37,82) -- Tropical Lighting
--send("rendCommandManager", "odinRendererSetLighting",111,90,59,93,83,69) -- Arctic Lighting

-- set up agriculture for this biome
-- (these will be read by farm.go to set allowed crops)
local cropTable = EntityDB.WorldStats.climateInfoPerBiome[ biomeName ].cropTable
for cropName, stats in pairs( cropTable ) do
     send("gameSession", "setSessionBool", "cropUnlocked=" .. cropName, cropTable[cropName].unlocked )
	send("gameSession", "setSessionInt", "cropGrowthModifier=" .. cropName, cropTable.growthModifier)
end

function spawnGameobject( x, y, objectType, objectTable )
	if x > 235 then x = 235 end
	if x < 20 then x = 20 end
	
	if y > 235 then y = 235 end
	if y < 20 then y = 20 end
	
	local createResults = query( "scriptManager", "scriptCreateGameObjectRequest", objectType, objectTable )
	local handle = createResults[1]
	if handle ~= nil then
		send(handle, "GameObjectPlace", x, y )
	end
end

-- need some accessible hunting at game start
local animals_to_spawn = { [1] = {["legacyString"]="Aurochs"}, [2] = {["legacyString"]="Dodo"} }
--spawnGameobject( 250, 210, "herd", animals_to_spawn[rand(1,#animals_to_spawn)])
--spawnGameobject( 250, 300, "herd", animals_to_spawn[rand(1,#animals_to_spawn)])
spawnGameobject( rand(20,235), rand(20,235), "herd", animals_to_spawn[rand(1,#animals_to_spawn)])
spawnGameobject( rand(20,235), rand(20,235), "herd", animals_to_spawn[rand(1,#animals_to_spawn)])
send("gameSession", "setSessionBool", "maize_technology_unlocked", true) --gotta manually unlock it!