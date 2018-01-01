spawn_pillar.formname = "pillar_gui"

function spawn_pillar.make_formspec(player, pos)
	local active_pillar = minetest.deserialize(player:get_attribute("spawn_pillar"))

	local fs = "size[10.3,11.3]" ..
	"label[0.5,-0.25;Select a spawn pillar to tune to.]" ..
	"label[0.5,0.05;\\[X\\] Is the currently tuned pillar.]" ..
	"button[8.2,-0.25;2.3,0.8;pbeacon;Go to Party Beacon]" ..
	"button[5.8,-0.25;2.3,0.8;respawn;Respawn]"
	for i = 1, 16 do
		for j = 1, 16 do
			if i == 1 then
				fs = fs .. "\nlabel[" .. (j/1.6 - 0.05) .. ",0.4;" .. j .. "]"
			end
			if j == 1 then
				fs = fs .. "\nlabel[-0.04," .. (i/1.5 + 0.4) .. ";" .. i .. "]"
			end
			local string = " "
			if active_pillar.x == j and active_pillar.y == i then
				string = "\\[X\\]"
			end
			fs = fs .. "\nbutton[" .. (j/1.6 - 0.3) .. "," .. (i/1.5 + 0.4) .. ";0.8,0.5;x = " .. j .. ", y = " .. i .. ";" .. string .. "]"
		end
	end
	return fs
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == spawn_pillar.formname then
		for field,_ in pairs(fields) do
			if field == "pbeacon" then
				teleport_to_beacon(player)
				return
			end
			if field == "respawn" then
				player:set_hp(0)
				return
			end
			if field:sub(1, 1) == "x" then
				player:set_attribute("spawn_pillar", "return {" .. field .. "}")
				minetest.show_formspec(player:get_player_name(), spawn_pillar.formname, spawn_pillar.make_formspec(player, pos))
				return
			end
		end
	end
end)