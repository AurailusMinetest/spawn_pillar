spawn_pillar = {}

local path = minetest.get_modpath("spawn_pillar")
dofile(path .. "/modstorage.lua")
dofile(path .. "/formspec.lua")
dofile(path .. "/nodes.lua")
dofile(path .. "/gen.lua")
dofile(path .. "/respawn.lua")

minetest.register_on_newplayer(function(player)
	player:set_attribute("spawn_pillar", minetest.serialize({x = math.random(16), z = math.random(16)}))
	player:setpos(vector.add(spawn_pillar.get_player_spawn_coords(player), {x = 1, y = 0, z = 0}))
end)