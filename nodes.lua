minetest.register_node("spawn_pillar:spawn_tile", {
	tiles = {
		"spawn_pillar_tile.png"
	},
	groups = {immortal = 1},
	description = "Spawn Tile"
})

minetest.register_node("spawn_pillar:pillar_bottom", {
	tiles = {
		"spawn_pillar_pillar_bottom.png",
		"spawn_pillar_pillar_crystal.png",
		"spawn_pillar_pillar_crystal_bottom.png",
		"spawn_pillar_pillar_crystal_bottom.png",
		"spawn_pillar_pillar_crystal_bottom.png",
		"spawn_pillar_pillar_crystal_bottom.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5}, -- NodeBox1
			{-0.125, -0.1875, -0.125, 0.125, 0.0625, 0.125}, -- NodeBox2
			{-0.1875, 0.0625, -0.1875, 0.1875, 0.3125, 0.1875}, -- NodeBox3
			{-0.25, 0.3125, -0.25, 0.25, 0.5, 0.25}, -- NodeBox4
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 1.3, 0.5}
		}
	},
	light_source = 14,
	collisionbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 1, 0.5}
		}
	},
	groups = {not_in_creative_inventory = 1, immortal = 1},
	on_construct = function(pos)
		minetest.set_node(vector.add(pos, vector.new(0, 1, 0)), {name = "spawn_pillar:pillar_top"})
	end,
	on_destruct = function(pos)
		minetest.set_node(vector.add(pos, vector.new(0, 1, 0)), {name = "air"})
	end,
	on_rightclick = function(pos, node, player)
		minetest.show_formspec(player:get_player_name(), spawn_pillar.formname, spawn_pillar.make_formspec(player, pos))
	end
})

minetest.register_node("spawn_pillar:pillar_top", {
	tiles = {
		"spawn_pillar_pillar_crystal.png",
		"spawn_pillar_pillar_crystal.png",
		"spawn_pillar_pillar_crystal.png",
		"spawn_pillar_pillar_crystal.png",
		"spawn_pillar_pillar_crystal.png",
		"spawn_pillar_pillar_crystal.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25}, -- NodeBox1
			{-0.3125, -0.4375, -0.3125, 0.3125, -0.1875, 0.3125}, -- NodeBox2
			{-0.375, -0.1875, -0.375, 0.375, -0.0625, 0.375}, -- NodeBox3
			{-0.3125, -0.0625, -0.3125, 0.3125, 0.0625, 0.3125}, -- NodeBox4
			{-0.25, 0.0625, -0.25, 0.25, 0.125, 0.25}, -- NodeBox5
			{-0.1875, 0.125, -0.1875, 0.1875, 0.1875, 0.1875}, -- NodeBox6
			{-0.125, 0.1875, -0.125, 0.125, 0.25, 0.125}, -- NodeBox8
			{-0.0625, 0.25, -0.0625, 0.0625, 0.3125, 0.0625}, -- NodeBox9
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
		}
	},
	light_source = 14,
	collisionbox = {
		type = "fixed",
		fixed = {
		}
	},
	groups = {not_in_creative_inventory = 1, immortal = 1}
})