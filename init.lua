spawn_pillar = {}

spawn_pillar.storage = minetest.get_mod_storage()
spawn_pillar.spawn_points = minetest.deserialize(spawn_pillar.storage:get_string("spawn_points")) or {}

function spawn_pillar.get_spawnpoint(xseg, zseg)
	return spawn_pillar.spawn_points[xseg .. "|" .. zseg] or nil
end

function spawn_pillar.set_spawnpoint(xseg, zseg, coords)
	spawn_pillar.spawn_points[xseg .. "|" .. zseg] = coords
	spawn_pillar.storage:set_string("spawn_points", minetest.serialize(spawn_pillar.spawn_points))
	-- print(dump(spawn_pillar.spawn_points))
	print("adding spawnpoint")
end

local path = minetest.get_modpath("spawn_pillar")
dofile(path .. "/formspec.lua")
dofile(path .. "/nodes.lua")
dofile(path .. "/gen.lua")
dofile(path .. "/respawn.lua")

minetest.register_on_newplayer(function(player)
	player:set_attribute("spawn_pillar", minetest.serialize({x = math.random(16), y = math.random(16)}))
end)