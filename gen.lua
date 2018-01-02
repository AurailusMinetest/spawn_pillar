--Place spawn pillars
local spawn_positions = {}
local xseg = 1
local zseg = 1
for i = -8, 8 do
	for j = -8, 8 do
		if not spawn_pillar.get_spawnpoint(xseg, zseg) then
			table.insert(spawn_positions, {x = j*2000, z = i*2000, xseg = xseg, zseg = zseg})
		end
		xseg = xseg + 1
	end
	xseg = 1
	zseg = zseg + 1
end

-- print("[Spawn Pillar] There are " .. #spawn_positions .. "spawn positions.")

local function create_pillar(pos, segment)
	for i = -2, 2 do
		for j = -2, 2 do
			for k = -1, 3 do
				local pos = vector.new(pos.x + i, pos.y + k, pos.z + j)
				if k == -1 then
					minetest.set_node(pos, {name = "spawn_pillar:spawn_tile"})
				else
					minetest.set_node(pos, {name = "air"})
				end
			end
		end
	end

	minetest.set_node(pos, {name = "spawn_pillar:pillar_bottom"})

	minetest.set_node(vector.add(pos, vector.new(1, 0, 0)), {name = "default:torch", param2 = 1})
	minetest.set_node(vector.add(pos, vector.new(-1, 0, 0)), {name = "default:torch", param2 = 1})
	minetest.set_node(vector.add(pos, vector.new(0, 0, 1)), {name = "default:torch", param2 = 1})
	minetest.set_node(vector.add(pos, vector.new(0, 0, -1)), {name = "default:torch", param2 = 1})

	for _,player in ipairs(minetest.get_connected_players()) do
		local sc = minetest.deserialize(player:get_attribute("spawn_pillar"))
		if sc.x == segment.x and sc.z == segment.z then
			player:set_pos(vector.add(spawn_pillar.get_spawnpoint(segment.x, segment.z), {x = 1, y = 0, z = 0}))
		end
	end
end

minetest.register_on_generated(function(minp, maxp)
	for ind,spos in pairs(spawn_positions) do
		if minp.x < spos.x and spos.x < maxp.x and
			 minp.z < spos.z and spos.z < maxp.z and
			 maxp.y > 0 then

			if not spawn_pillar.get_spawnpoint(spos.xseg, spos.zseg) then
				for j = maxp.y, math.max(minp.y, 0), -1 do
					local node = vector.new(spos.x, j, spos.z)
					local below = vector.new(spos.x, j-1, spos.z)

					if (minetest.get_node(node).name  == "air" and
							minetest.get_node(below).name ~= "air" and 
							minetest.get_node(below).name ~= "ignore") then

						spawn_pillar.set_spawnpoint(spos.xseg, spos.zseg, vector.new(spos.x, j, spos.z))
						create_pillar(vector.new(spos.x, j, spos.z), {x = spos.xseg, z = spos.zseg})
						table.remove(spawn_positions, ind)
						return

					end
				end
			end

		end
	end
end)