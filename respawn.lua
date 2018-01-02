function spawn_pillar.get_player_spawn_coords(player)
	local seg = minetest.deserialize(player:get_attribute("spawn_pillar"))
	-- print(dump(spawn_pillar.get_spawnpoint(seg.x, seg.z) or {x = (seg.x-9)*2000, y = 20, z = (seg.z-9)*2000}))
	return spawn_pillar.get_spawnpoint(seg.x, seg.z) or {x = (seg.x-9)*2000, y = 20, z = (seg.z-9)*2000}
end 

minetest.register_on_respawnplayer(function(player)
	player:setpos(vector.add(spawn_pillar.get_player_spawn_coords(player), {x = 1, y = 0, z = 0}))
	return true
end)