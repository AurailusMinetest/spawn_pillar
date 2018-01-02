spawn_pillar.storage = minetest.get_mod_storage()
spawn_pillar.spawn_points = minetest.deserialize(spawn_pillar.storage:get_string("spawn_points")) or {}

function spawn_pillar.get_spawnpoint(xseg, zseg)
	return spawn_pillar.spawn_points[xseg .. "|" .. zseg] or nil
end

function spawn_pillar.set_spawnpoint(xseg, zseg, coords)
	spawn_pillar.spawn_points[xseg .. "|" .. zseg] = coords
	spawn_pillar.storage:set_string("spawn_points", minetest.serialize(spawn_pillar.spawn_points))
end

function spawn_pillar.get_player_pillar(player)
	local spawn = minetest.deserialize(player:get_attribute("spawn_pillar"))
	if not spawn then
		spawn = {x = math.random(16), z = math.random(16)}
		player:set_attribute("spawn_pillar", minetest.serialize(spawn))
	end
	return spawn
end