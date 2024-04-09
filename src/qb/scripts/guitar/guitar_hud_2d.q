g_flash_red_going_p1 = 0
g_flash_red_going_p2 = 0
g_hud_2d_struct_used = career_hud_2d_elements

script create_2d_hud_elements \{ player_text = 'p1' }
	Change \{ g_flash_red_going_p1 = 0 }
	Change \{ g_flash_red_going_p2 = 0 }
	Change \{ old_animate_bulbs_star_power_p1 = 0.0 }
	Change \{ old_animate_bulbs_star_power_p2 = 0.0 }
	GetArraySize (($g_hud_2d_struct_used).elements)
	parent_scale = (($g_hud_2d_struct_used).Scale)
	old_parent = <PARENT>
	parent_z = (($g_hud_2d_struct_used).z)
	i = 0
	begin
		just = [ Left top ]
		myscale = 1.0
		zoff = 0.0
		rot = 0.0
		Alpha = 1
		pos_off = (0.0, 0.0)
		AddParams (($g_hud_2d_struct_used).elements [ <i> ])
		element_struct = (($g_hud_2d_struct_used).elements [ <i> ])
		if StructureContains Structure = <element_struct> parent_container
			if StructureContains Structure = <element_struct> element_parent
				ExtendCRC <element_parent> <player_text> out = container_parent
				if NOT ScreenElementExists Id = <container_parent>
					ExtendCRC <element_parent> 'p1' out = container_parent
				endif
			else
				container_parent = <old_parent>
			endif
			container_pos = (0.0, 0.0)
			if StructureContains Structure = <element_struct> pos_type
				<container_pos> = (($g_hud_2d_struct_used).<pos_type>)
				if (<player_text> = 'p2')
					ExtendCRC <pos_type> '_p2' out = new_pos_type
					<container_pos> = (($g_hud_2d_struct_used).<new_pos_type>)
				else
					if ($current_num_players = 2)
						ExtendCRC <pos_type> '_p1' out = new_pos_type
						<container_pos> = (($g_hud_2d_struct_used).<new_pos_type>)
					endif
				endif
			endif
			if StructureContains Structure = <element_struct> note_streak_bar
				if StructureContains Structure = ($g_hud_2d_struct_used)offscreen_note_streak_bar_off
					<container_pos> = (<container_pos> + (($g_hud_2d_struct_used).offscreen_note_streak_bar_off))
				else
					if (<player_text> = 'p1')
						<container_pos> = (<container_pos> + (($g_hud_2d_struct_used).offscreen_note_streak_bar_off_p1))
					else
						<container_pos> = (<container_pos> + (($g_hud_2d_struct_used).offscreen_note_streak_bar_off_p2))
					endif
				endif
			endif
			<container_pos> = (<container_pos> + <pos_off>)
			ExtendCRC <element_id> <player_text> out = new_id
			<create_it> = 1
			if StructureContains Structure = <element_struct> create_once
				ExtendCRC <element_id> 'p1' out = p1_id
				if ScreenElementExists Id = <p1_id>
					<create_it> = 0
				endif
			endif
			if ((StructureContains Structure = <element_struct> rot_p2)& (<player_text> = 'p2'))
				<rot> = <rot_p2>
			endif
			if (<create_it>)
				CreateScreenElement {
					Type = ContainerElement
					PARENT = <container_parent>
					Id = <new_id>
					Pos = <container_pos>
					rot_angle = <rot>
					z_priority = <z_off>
				}
			endif
			PARENT = <new_id>
		endif
		if StructureContains Structure = <element_struct> container
			if NOT StructureContains Structure = <element_struct> parent_container
				ExtendCRC <element_id> <player_text> out = new_id
				ExtendCRC <element_parent> <player_text> out = myParent
				if StructureContains Structure = <element_struct> small_bulb
					scaled_dims = (<element_dims> * (($g_hud_2d_struct_used).small_bulb_scale))
				else
					scaled_dims = (<element_dims> * (($g_hud_2d_struct_used).big_bulb_scale))
				endif
				if ((StructureContains Structure = <element_struct> pos_off_p2)& (<player_text> = 'p2'))
					<pos_off> = <pos_off_p2>
				endif
				<create_it> = 1
				if StructureContains Structure = <element_struct> create_once
					ExtendCRC <element_id> 'p1' out = p1_id
					if ScreenElementExists Id = <p1_id>
						<create_it> = 0
					endif
				endif
				if (<create_it>)
					CreateScreenElement {
						Type = SpriteElement
						PARENT = <myParent>
						Id = <new_id>
						texture = <texture>
						Pos = <pos_off>
						just = <just>
						rgba = [ 255 255 255 255 ]
						rot_angle = <rot>
						z_priority = <zoff>
						Alpha = <Alpha>
						dims = <scaled_dims>
					}
					<new_id> ::SetTags morph = 0
					<new_id> ::SetTags Index = <i>
					<PARENT> = <Id>
					<rot> = 0.0
					<Pos> = (0.0, 0.0)
					if StructureContains Structure = <element_struct> initial_pos
						if ((StructureContains Structure = <element_struct> initial_pos_p2)& (<player_text> = 'p2'))
							SetScreenElementProps Id = <new_id> Pos = <initial_pos_p2>
							<new_id> ::SetTags final_pos = <pos_off_p2>
							<new_id> ::SetTags initial_pos = <initial_pos_p2>
							<new_id> ::SetTags morph = 1
						else
							SetScreenElementProps Id = <new_id> Pos = <initial_pos>
							<new_id> ::SetTags final_pos = <pos_off>
							<new_id> ::SetTags initial_pos = <initial_pos>
							<new_id> ::SetTags morph = 1
						endif
					endif
				endif
			endif
		else
			if NOT StructureContains Structure = <element_struct> parent_container
				ExtendCRC <element_id> <player_text> out = new_id
				if StructureContains Structure = <element_struct> initial_pos
					<pos_off> = <initial_pos>
				endif
				if StructureContains Structure = <element_struct> battle_pos
					if (<player_text> = 'p2')
						<container_pos> = (($g_hud_2d_struct_used).rock_pos_p2)
						ExtendCRC <pos_type> '_p2' out = new_pos_type
						<pos_off> = ((($g_hud_2d_struct_used).<new_pos_type>))
					else
						<container_pos> = (($g_hud_2d_struct_used).rock_pos_p1)
						ExtendCRC <pos_type> '_p1' out = new_pos_type
						<pos_off> = ((($g_hud_2d_struct_used).<new_pos_type>))
					endif
				endif
				ExtendCRC <element_parent> <player_text> out = myParent
				flags = {}
				if StructureContains Structure = <element_struct> flags
					if StructureContains Structure = (<element_struct>.flags)flip_v
						if StructureContains Structure = (<element_struct>.flags)p1
							if (<player_text> = 'p1')
								<flags> = flip_v
							endif
						endif
					endif
					if StructureContains Structure = (<element_struct>.flags)flip_h
						if StructureContains Structure = (<element_struct>.flags)p1
							if (<player_text> = 'p1')
								<flags> = flip_h
							endif
						endif
						if StructureContains Structure = (<element_struct>.flags)p2
							if (<player_text> = 'p2')
								<flags> = flip_h
							endif
						endif
					endif
				endif
				mydims = {}
				if StructureContains Structure = <element_struct> dims
					<mydims> = <dims>
				endif
				<create_it> = 1
				if StructureContains Structure = <element_struct> create_once
					ExtendCRC <element_id> 'p1' out = p1_id
					if ScreenElementExists Id = <p1_id>
						<create_it> = 0
					endif
				endif
				if ((StructureContains Structure = <element_struct> initial_pos_p2)& (<player_text> = 'p2'))
					<pos_off> = <initial_pos_p2>
				elseif ((StructureContains Structure = <element_struct> pos_off_p2)& (<player_text> = 'p2'))
					<pos_off> = <pos_off_p2>
				endif
				my_rgba = [ 255 255 255 255 ]
				if (StructureContains Structure = <element_struct> rgba)
					<my_rgba> = <rgba>
				endif
				if (<create_it>)
					CreateScreenElement {
						Type = SpriteElement
						PARENT = <myParent>
						Id = <new_id>
						texture = <texture>
						Pos = <pos_off>
						rgba = <my_rgba>
						just = <just>
						z_priority = <zoff>
						Alpha = <Alpha>
						<flags>
						rot_angle = <rot>
						dims = <mydims>
					}
				endif
				if StructureContains Structure = <element_struct> Scale
					if (<create_it>)
						GetScreenElementDims Id = <new_id>
						new_width = (<width> * <Scale>)
						new_height = (<height> * <Scale>)
						SetScreenElementProps Id = <new_id> dims = (((1.0, 0.0) * <new_width>)+ ((0.0, 1.0) * <new_height>))
					endif
				endif
			endif
		endif
		if StructureContains Structure = <element_struct> tube
			ExtendCRC <new_id> 'tube' out = new_child_id
			<zoff> = (<tube>.zoff)
			<Alpha> = (<tube>.Alpha)
			ExtendCRC <element_parent> <player_text> out = myParent
			if StructureContains Structure = <element_struct> small_bulb
				scaled_dims = (<tube>.element_dims * (($g_hud_2d_struct_used).small_bulb_scale))
			else
				scaled_dims = (<tube>.element_dims * (($g_hud_2d_struct_used).big_bulb_scale))
			endif
			if ScreenElementExists Id = <myParent>
				CreateScreenElement {
					Type = SpriteElement
					PARENT = <myParent>
					Id = <new_child_id>
					texture = (<tube>.texture)
					Pos = (<pos_off> + (<tube>.pos_off))
					rgba = [ 255 255 255 255 ]
					dims = <scaled_dims>
					just = [ center bottom ]
					z_priority = <zoff>
					Alpha = <Alpha>
				}
				<PARENT> = <Id>
				<new_child_id> ::SetTags morph = 0
				<new_child_id> ::SetTags old_dims = <element_dims>
				if StructureContains Structure = <element_struct> initial_pos
					SetScreenElementProps Id = <new_child_id> Pos = (<initial_pos> + (<tube>.pos_off))
					<new_child_id> ::SetTags {
						final_pos = (<pos_off> + (<tube>.pos_off))
						initial_pos = (<initial_pos> + (<tube>.pos_off))
						morph = 1
					}
				endif
			endif
		endif
		if StructureContains Structure = <element_struct> full
			ExtendCRC <new_id> 'full' out = new_child_id
			<zoff> = (<full>.zoff)
			<Alpha> = (<full>.Alpha)
			ExtendCRC <element_parent> <player_text> out = myParent
			if StructureContains Structure = <element_struct> small_bulb
				scaled_dims = (<element_dims> * (($g_hud_2d_struct_used).small_bulb_scale))
			else
				scaled_dims = (<element_dims> * (($g_hud_2d_struct_used).big_bulb_scale))
			endif
			if ScreenElementExists Id = <myParent>
				CreateScreenElement {
					Type = SpriteElement
					PARENT = <myParent>
					Id = <new_child_id>
					texture = (<full>.texture)
					Pos = <pos_off>
					rgba = [ 255 255 255 255 ]
					dims = <scaled_dims>
					just = <just>
					z_priority = <zoff>
					Alpha = <Alpha>
				}
				<new_child_id> ::SetTags morph = 0
				if StructureContains Structure = <element_struct> initial_pos
					SetScreenElementProps Id = <new_child_id> Pos = <initial_pos>
					<new_child_id> ::SetTags final_pos = <pos_off>
					<new_child_id> ::SetTags initial_pos = <initial_pos>
					<new_child_id> ::SetTags morph = 1
				endif
			endif
		endif
		<i> = (<i> + 1)
	repeat <array_Size>
	if NOT ($game_mode = p2_battle || $boss_battle = 1)
		ExtendCRC HUD2D_Score_Text <player_text> out = new_id
		ExtendCRC HUD2D_score_container <player_text> out = new_score_container
		score_text_pos = (222.0, 70.0)
		if ($game_mode = p2_career || $game_mode = p2_coop)
			<score_text_pos> = (226.0, 85.0)
		endif
		if ScreenElementExists Id = <new_score_container>
			displayText {
				PARENT = <new_score_container>
				Id = <new_id>
				font = num_a9
				Pos = <score_text_pos>
				z = 20
				Scale = (1.100000023841858, 1.100000023841858)
				just = [ Right Right ]
				rgba = [ 255 255 255 255 ]
			}
			SetScreenElementProps Id = <Id> font_spacing = 5
		endif
		i = 1
		begin
			FormatText ChecksumName = note_streak_text_id 'HUD2D_Note_Streak_Text_%d' d = <i>
			ExtendCRC <note_streak_text_id> <player_text> out = new_id
			ExtendCRC HUD2D_note_container <player_text> out = new_note_container
			if ScreenElementExists Id = <new_note_container>
				if (<i> = 1)
					rgba = [ 15 15 70 200 ]
				else
					rgba = [ 230 230 230 200 ]
				endif
				displayText {
					PARENT = <new_note_container>
					Id = <new_id>
					font = num_a7
					text = "0"
					Pos = ((222.0, 78.0) + (<i> * (-37.0, 0.0)))
					z = 25
					just = [ center center ]
					rgba = <rgba>
					noshadow
				}
				<Id> ::SetTags intial_pos = ((222.0, 78.0) + (<i> * (-37.0, 0.0)))
			endif
			<i> = (<i> + 1)
		repeat 4
	endif
endscript

script rock_meter_star_power_on
	if ($game_mode = p2_career)
		<player_status> = player1_status
	endif
	FormatText textname = player_text 'p%d' d = ($<player_status>.Player)
	spawnscriptnow rock_back_and_forth_star_meter Params = {player_status = <player_status> player_text = <player_text>}
	FormatText ChecksumName = player_spawned_scriptid 'player_spawned_scriptid_p%d' d = ($<player_status>.Player)
	spawnscriptnow {
		pulsate_all_star_power_bulbs Params = {Player = ($<player_status>.Player)player_status = <player_status> player_text = <player_text>}
		Id = <player_spawned_scriptid>
	}
	i = 1
	begin
		FormatText ChecksumName = Id 'HUD2D_rock_tube_%d' d = <i>
		ExtendCRC <Id> <player_text> out = parent_id
		if ScreenElementExists Id = <parent_id>
			<parent_id> ::GetTags
			if (<morph> = 1)
				DoScreenElementMorph Id = <parent_id> Pos = <final_pos> Time = 0.4
			endif
			ExtendCRC <parent_id> 'tube' out = child_id
			<child_id> ::GetTags
			SetScreenElementProps Id = <child_id> texture = (($g_hud_2d_struct_used).elements [ <Index> ].tube.star_texture)
			if (<morph> = 1)
				DoScreenElementMorph Id = <child_id> Pos = <final_pos> Time = 0.4
			endif
			ExtendCRC <parent_id> 'full' out = child_id
			<child_id> ::GetTags
			SetScreenElementProps Id = <child_id> texture = (($g_hud_2d_struct_used).elements [ <Index> ].full.star_texture)
			if (<morph> = 1)
				DoScreenElementMorph Id = <child_id> Pos = <final_pos> Time = 0.4
				wait \{ 0.2 seconds }
			endif
		endif
		<i> = (<i> + 1)
	repeat 6
endscript

script kill_pulsate_star_power_bulbs
	FormatText ChecksumName = player_spawned_scriptid 'player_spawned_scriptid_p%d' d = <Player>
	killspawnedscript Id = <player_spawned_scriptid>
	KillPulsateStarPowerBulbs Player = <Player>
endscript

script pulsate_star_power_bulb
	begin
		alpha_time = Random (@ 0.1 @*2 0.5)
		if ScreenElementExists Id = <bulb_checksum>
			ExtendCRC <bulb_checksum> 'tube' out = child_id
			DoScreenElementMorph Id = <child_id> Alpha = 0.3 Time = <alpha_time> Motion = ease_in
			ExtendCRC <bulb_checksum> 'full' out = child_id
			DoScreenElementMorph Id = <child_id> Alpha = 0.3 Time = <alpha_time> Motion = ease_in
		endif
		wait <alpha_time> seconds
		alpha_time = Random (@ 0.1 @*2 0.5)
		if ScreenElementExists Id = <bulb_checksum>
			ExtendCRC <bulb_checksum> 'tube' out = child_id
			<child_id> ::GetTags
			DoScreenElementMorph Id = <child_id> Alpha = <old_alpha> Time = <alpha_time> Motion = ease_out
			ExtendCRC <bulb_checksum> 'full' out = child_id
			<child_id> ::GetTags
			DoScreenElementMorph Id = <child_id> Alpha = <old_alpha> Time = <alpha_time> Motion = ease_out
		endif
		wait <alpha_time> seconds
	repeat
endscript

script pulsate_big_glow
	ExtendCRC HUD2D_rock_glow <player_text> out = parent_id
	if NOT ScreenElementExists Id = <parent_id>
		return
	endif
	begin
		if NOT ScreenElementExists Id = <parent_id>
			return
		endif
		<parent_id> ::DoMorph Alpha = 0 rgba = [ 95 205 255 255 ] Time = 1 Motion = ease_in
		if NOT ScreenElementExists Id = <parent_id>
			return
		endif
		<parent_id> ::DoMorph Alpha = 1 rgba = [ 255 255 255 255 ] Time = 1 Motion = ease_out
	repeat
endscript

script pulsate_all_star_power_bulbs
	<i> = 1
	begin
		FormatText ChecksumName = Id 'HUD2D_rock_tube_%d' d = <i>
		ExtendCRC <Id> <player_text> out = parent_id
		if ScreenElementExists Id = <parent_id>
			FormatText ChecksumName = player_spawned_scriptid 'player_spawned_scriptid_p%d' d = <Player>
			spawnscriptnow {
				pulsate_star_power_bulb Params = { bulb_checksum = <parent_id> }
				Id = <player_spawned_scriptid>
			}
		endif
		<i> = (<i> + 1)
	repeat 6
	ExtendCRC HUD2D_rock_glow <player_text> out = parent_id
	if ScreenElementExists Id = <parent_id>
		FormatText ChecksumName = player_spawned_scriptid 'player_spawned_scriptid_p%d' d = <Player>
		spawnscriptnow {
			pulsate_big_glow Params = { <...>  }
			Id = <player_spawned_scriptid>
		}
	endif
endscript

script rock_back_and_forth_star_meter
	move_up_and_down = 1
	if ($game_mode = p1_career || $game_mode = p1_quickplay || $game_mode = p2_career || $game_mode = p2_coop)
		ExtendCRC HUD2D_rock_container <player_text> out = shake_container
	elseif ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff)
		ExtendCRC HUD2D_score_container <player_text> out = shake_container
		<move_up_and_down> = 0
	endif
	if ScreenElementExists Id = <shake_container>
		GetScreenElementProps Id = <shake_container>
		time_to_shake = 0.15
		if (<move_up_and_down> = 1)
			if ScreenElementExists Id = <shake_container>
				DoScreenElementMorph Id = <shake_container> Pos = (<Pos> - (0.0, 50.0))Scale = 1.5 rot_angle = 10 Time = <time_to_shake> Motion = ease_in
				wait <time_to_shake> seconds
			endif
			if ScreenElementExists Id = <shake_container>
				DoScreenElementMorph Id = <shake_container> Pos = (<Pos> + (0.0, 75.0))Scale = 0.5 rot_angle = -15 Time = <time_to_shake> Motion = ease_in
				wait <time_to_shake> seconds
			endif
			if ScreenElementExists Id = <shake_container>
				DoScreenElementMorph Id = <shake_container> Pos = (<Pos>)Scale = 1.0 rot_angle = 0 Time = <time_to_shake>
			endif
		else
			if ScreenElementExists Id = <shake_container>
				DoScreenElementMorph Id = <shake_container> Pos = (<Pos> - (50.0, 0.0))Scale = 1.5 rot_angle = 10 Time = <time_to_shake> Motion = ease_in
				wait <time_to_shake> seconds
			endif
			if ScreenElementExists Id = <shake_container>
				DoScreenElementMorph Id = <shake_container> Pos = (<Pos> + (75.0, 0.0))Scale = 0.5 rot_angle = -15 Time = <time_to_shake> Motion = ease_in
				wait <time_to_shake> seconds
			endif
			if ScreenElementExists Id = <shake_container>
				DoScreenElementMorph Id = <shake_container> Pos = (<Pos>)Scale = 1.0 rot_angle = 0 Time = <time_to_shake> Motion = ease_out
			endif
		endif
	endif
endscript

script rock_meter_star_power_off \{ player_text = 'p1' }
	if ($game_mode = p2_battle || $boss_battle = 1)
		return
	endif
	j = 6
	begin
		FormatText ChecksumName = Id 'HUD2D_rock_tube_%d' d = <j>
		ExtendCRC <Id> <player_text> out = parent_id
		if ScreenElementExists Id = <parent_id>
			<parent_id> ::GetTags
			if (<morph> = 1)
				if ScreenElementExists Id = <parent_id>
					DoScreenElementMorph Id = <parent_id> Pos = (<final_pos> + <final_pos> * 0.1)Time = 0.1
				endif
				wait \{ 0.1 seconds }
				if ScreenElementExists Id = <parent_id>
					DoScreenElementMorph Id = <parent_id> Pos = <initial_pos> Time = 0.4
				endif
				wait \{ 0.1 seconds }
			endif
			ExtendCRC <parent_id> 'tube' out = child_id
			if ScreenElementExists Id = <child_id>
				<child_id> ::GetTags
				SetScreenElementProps Id = <child_id> texture = (($g_hud_2d_struct_used).elements [ <Index> ].tube.texture)
				if (<morph>)
					SetScreenElementProps Id = <child_id> Pos = <initial_pos>
				endif
			endif
			ExtendCRC <parent_id> 'full' out = child_id
			if ScreenElementExists Id = <child_id>
				<child_id> ::GetTags
				SetScreenElementProps Id = <child_id> texture = (($g_hud_2d_struct_used).elements [ <Index> ].full.texture)
				if (<morph>)
					SetScreenElementProps Id = <child_id> Pos = <initial_pos>
				endif
			endif
		endif
		<j> = (<j> -1)
	repeat 6
endscript

script hud_activated_star_power \{ Player = 1 Time = 0.2 }
	spawnscriptnow hud_activated_star_power_spawned Params = { <...>  }
endscript

script hud_activated_star_power_spawned
	wait \{ 1 GameFrame }
	if (<Player> = 1)
		player_text = 'p1'
	elseif (<Player> = 2)
		player_text = 'p2'
	else
		return
	endif
	spawnscriptnow kill_pulsate_star_power_bulbs Params = { Player = <Player> }
	ExtendCRC HUD2D_score_flash <player_text> out = new_flash
	if ScreenElementExists Id = <new_flash>
		DoScreenElementMorph Id = <new_flash> Alpha = 1 Scale = 5 Time = <Time>
		wait <Time> seconds
		if ScreenElementExists Id = <new_flash>
			DoScreenElementMorph Id = <new_flash> Alpha = 0 Scale = 1 Time = (<Time> / 2.0)
		endif
		UpdateNixie Player = <Player>
	endif
endscript

script hud_move_note_scorebar \{ Player = 1 Time = 0.5 in = 1 }
	if ($game_mode = p2_battle || $boss_battle = 1 || $end_credits = 1 || $Cheat_PerformanceMode = 1)
		return
	endif
	if (($game_mode = p2_career || $game_mode = p2_coop)& (<Player> = 2))
		return
	endif
	if NOT StructureContains Structure = ($g_hud_2d_struct_used)offscreen_note_streak_bar_off
		if NOT StructureContains Structure = ($g_hud_2d_struct_used)offscreen_note_streak_bar_off_p1
			return
		endif
	endif
	morph_miss_off = (0.0, 60.0)
	ease_off = (0.0, 10.0)
	count_off = offscreen_note_streak_bar_off
	if (<Player> = 1)
		player_text = 'p1'
		if ($game_mode = p2_career || $game_mode = p2_coop)
			count_pos = counter_pos
		else
			if ($current_num_players = 2)
				count_pos = counter_pos_p1
				morph_miss_off = (60.0, 0.0)
				ease_off = (10.0, 0.0)
				count_off = offscreen_note_streak_bar_off_p1
			else
				count_pos = counter_pos
			endif
		endif
	elseif (<Player> = 2)
		player_text = 'p2'
		count_pos = counter_pos_p2
		morph_miss_off = (-60.0, 0.0)
		ease_off = (-10.0, 0.0)
		count_off = offscreen_note_streak_bar_off_p2
	else
		return
	endif
	if (<in> = 1)
		ExtendCRC HUD2D_note_container <player_text> out = new_container
		if ScreenElementExists Id = <new_container>
			DoScreenElementMorph Id = <new_container> Pos = ((($g_hud_2d_struct_used).<count_pos>)- <morph_miss_off>)Time = <Time> Motion = ease_out
			wait <Time> seconds
			if ScreenElementExists Id = <new_container>
				DoScreenElementMorph Id = <new_container> Pos = (($g_hud_2d_struct_used).<count_pos>)Time = (<Time> / 3)Motion = ease_in
				<new_container> ::DoMorph Pos = { <ease_off> relative }Time = 0.1 Motion = ease_out
				<new_container> ::DoMorph Pos = {(<ease_off> * -1)relative}Time = 0.1 Motion = ease_in
			endif
		endif
	else
		ExtendCRC HUD2D_note_container <player_text> out = new_container
		if ScreenElementExists Id = <new_container>
			if ($game_mode = p1_career || $game_mode = p2_career || $game_mode = p1_quickplay || $game_mode = p2_coop)
				DoScreenElementMorph Id = <new_container> Pos = ((($g_hud_2d_struct_used).<count_pos>)- <morph_miss_off>)Time = (<Time> / 2.0)Motion = ease_out
			else
				DoScreenElementMorph Id = <new_container> Pos = ((($g_hud_2d_struct_used).<count_pos>)+ <morph_miss_off>)Time = (<Time> / 2.0)Motion = ease_in
			endif
			wait <Time> seconds
			if ScreenElementExists Id = <new_container>
				DoScreenElementMorph Id = <new_container> Pos = ((($g_hud_2d_struct_used).<count_pos>)+ (($g_hud_2d_struct_used).<count_off>))Time = <Time>
			endif
		endif
	endif
endscript
old_animate_bulbs_star_power_p1 = 0.0
old_animate_bulbs_star_power_p2 = 0.0

script hud_flash_red_bg_p1 \{ Time = 0.2 }
	if ($g_flash_red_going_p1 = 1)
		return
	else
		Change \{ g_flash_red_going_p1 = 1 }
	endif
	if ($game_mode = p2_career || $game_mode = p2_coop)
		ExtendCRC \{ HUD2D_rock_lights_red 'p1' out = new_bg }
		<Time> = 0.15
	else
		ExtendCRC \{ HUD2D_rock_BG_red 'p1' out = new_bg }
	endif
	begin
		if ($game_mode = p2_career || $game_mode = p2_coop)
			if ScreenElementExists Id = <new_bg>
				DoScreenElementMorph Id = <new_bg> rgba = [ 0 0 0 255 ] Time = <Time>
				wait <Time> seconds
			endif
			if ScreenElementExists Id = <new_bg>
				DoScreenElementMorph Id = <new_bg> rgba = [ 225 225 225 255 ] Time = <Time>
			endif
			wait <Time> seconds
		else
			if ScreenElementExists Id = <new_bg>
				DoScreenElementMorph Id = <new_bg> rgba = [ 0 0 0 255 ] Time = <Time>
				wait <Time> seconds
			endif
			if ScreenElementExists Id = <new_bg>
				DoScreenElementMorph Id = <new_bg> rgba = [ 225 225 225 255 ] Time = <Time>
				wait <Time> seconds
			endif
			if ScreenElementExists Id = <new_bg>
				DoScreenElementMorph Id = <new_bg> rgba = [ 0 0 0 255 ] Time = <Time>
				wait <Time> seconds
			endif
			if ScreenElementExists Id = <new_bg>
				DoScreenElementMorph Id = <new_bg> rgba = [ 225 225 225 255 ] Time = <Time>
			endif
			wait (<Time> * 2.5)seconds
		endif
	repeat
endscript

script hud_flash_red_bg_p2 \{ Time = 0.2 }
	if ($g_flash_red_going_p2 = 1)
		return
	else
		Change \{ g_flash_red_going_p2 = 1 }
	endif
	ExtendCRC \{ HUD2D_rock_BG_red 'p2' out = new_bg }
	begin
		if ScreenElementExists Id = <new_bg>
			DoScreenElementMorph Id = <new_bg> rgba = [ 0 0 0 255 ] Time = <Time>
			wait <Time> seconds
		endif
		if ScreenElementExists Id = <new_bg>
			DoScreenElementMorph Id = <new_bg> rgba = [ 225 225 225 255 ] Time = <Time>
			wait <Time> seconds
		endif
		if ScreenElementExists Id = <new_bg>
			DoScreenElementMorph Id = <new_bg> rgba = [ 0 0 0 255 ] Time = <Time>
			wait <Time> seconds
		endif
		if ScreenElementExists Id = <new_bg>
			DoScreenElementMorph Id = <new_bg> rgba = [ 225 225 225 255 ] Time = <Time>
		endif
		wait (<Time> * 2.5)seconds
	repeat
endscript

script hud_flash_red_bg_kill \{ Player = 1 }
	if (<Player> = 1)
		if ($g_flash_red_going_p1 = 0)
			return
		endif
		player_text = 'p1'
	elseif (<Player> = 2)
		if ($g_flash_red_going_p2 = 0)
			return
		endif
		player_text = 'p2'
	else
		return
	endif
	ExtendCRC HUD2D_rock_BG_red <player_text> out = new_bg
	if ScreenElementExists Id = <new_bg>
		SetScreenElementProps Id = <new_bg> rgba = [ 225 225 225 255 ]
		if (<Player> = 1)
			killspawnedscript \{ name = hud_flash_red_bg_p1 }
		else
			killspawnedscript \{ name = hud_flash_red_bg_p2 }
		endif
	endif
	if (<Player> = 1)
		Change \{ g_flash_red_going_p1 = 0 }
	else
		Change \{ g_flash_red_going_p2 = 0 }
	endif
endscript

script two_message_test
	spawnscriptnow \{hud_show_note_streak_combo Params = { Player = 1 }}
	spawnscriptnow \{show_star_power_ready Params = { player_status = player1_status }}
	spawnscriptnow \{hud_show_note_streak_combo Params = { Player = 2 }}
	spawnscriptnow \{show_star_power_ready Params = { player_status = player2_status }}
endscript

script hud_show_note_streak_combo \{ Player = 1 combo = 0 }
	if ($end_credits = 1 || $Cheat_PerformanceMode = 1)
		return
	endif
	if ($game_mode = p2_career || $game_mode = p2_coop)
		<Player> = 1
	endif
	begin
		if (<Player> = 1)
			if ($star_power_ready_on_p1 = 0)
				break
			endif
		else
			if ($star_power_ready_on_p2 = 0)
				break
			endif
		endif
		wait \{ 1 GameFrame }
	repeat
	FormatText ChecksumName = player_container 'HUD_Note_Streak_Combo%d' d = <Player>
	if ScreenElementExists Id = <player_container>
		return
	endif
	if (<Player> = 1)
		player_status = player1_status
	else
		player_status = player2_status
	endif
	ExtendCRC hud_destroygroup_window ($<player_status>.text)out = hud_destroygroup
	CreateScreenElement {
		Type = ContainerElement
		PARENT = <hud_destroygroup>
		Id = <player_container>
	}
	base_scale = 0.8
	s = 0.8
	if (<Player> = 1)
		if isSinglePlayerGame
			Pos = (640.0, 211.0)
			<base_scale> = 1.0
			spawnscriptnow GH_SFX_Note_Streak_SinglePlayer Params = { combo = <combo> }
		elseif ($game_mode = p2_career)
			Pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow GH_SFX_Note_Streak_P1 Params = { combo = <combo> }
		elseif ($is_network_game & $game_mode = p2_coop)
			Pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow GH_SFX_Note_Streak_P1 Params = { combo = <combo> }
		else
			<s> = 0.35
			Pos = (415.0, 170.0)
			spawnscriptnow GH_SFX_Note_Streak_P1 Params = { combo = <combo> }
		endif
	else
		if ($game_mode = p2_career)
			Pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow GH_SFX_Note_Streak_P2 Params = { combo = <combo> }
		elseif ($is_network_game & $game_mode = p2_coop)
			Pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow GH_SFX_Note_Streak_P2 Params = { combo = <combo> }
		else
			<s> = 0.35
			Pos = (865.0, 170.0)
			spawnscriptnow GH_SFX_Note_Streak_P2 Params = { combo = <combo> }
		endif
	endif
	FormatText textname = text "%d Note Streak!" d = <combo>
	FormatText ChecksumName = note_streak_alert 'note_streak_alert_%d' d = <Player>
	CreateScreenElement {
		Type = TextElement
		Id = <note_streak_alert>
		PARENT = <player_container>
		font = text_a6
		text = <text>
		rgba = [ 223 223 223 255 ]
		Pos = <Pos>
		Scale = (<base_scale> * 3)
		just = [ center top ]
		z_priority = 50
		Alpha = 0
		Shadow
		shadow_offs = (2.0, 2.0)
		shadow_rgba = [ 0 0 0 255 ]
	}
	<Id> ::DoMorph Scale = <base_scale> Time = 0.2 Alpha = 1 Motion = ease_in
	if NOT ScreenElementExists Id = <Id>
		destroy_menu menu_id = <player_container>
		return
	endif
	spawnscriptnow hud_glowburst_alert Params = { player_status = <player_status> }
	color0 = [ 245 255 120 255 ]
	color1 = [ 245 255 160 255 ]
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph Scale = (<base_scale> + <s>)Time = 0.4 rgba = <color1> rot_angle = 3 Motion = ease_out
	endif
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph Scale = <base_scale> Time = 0.4 rgba = <color0> rot_angle = 2 Motion = ease_in
	endif
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph Scale = (<base_scale> + (<s> / 1.5))Time = 0.3 rgba = <color1> rot_angle = -2 Motion = ease_out
	endif
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph Scale = <base_scale> Time = 0.3 rgba = <color0> rot_angle = -1 Motion = ease_in
	endif
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph Scale = (<base_scale> + (<s> / 2.0))Time = 0.2 rgba = <color1> rot_angle = 2 Motion = ease_out
	endif
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph Scale = <base_scale> Time = 0.2 rgba = <color0> rot_angle = 1 Motion = ease_in
	endif
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph Scale = (<base_scale> + (<s> / 2.5))Time = 0.1 rgba = <color1> rot_angle = -1 Motion = ease_out
	endif
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph Scale = <base_scale> Time = 0.1 rgba = <color0> rot_angle = 1 Motion = ease_in
	endif
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph rot_angle = 0 Scale = <base_scale> Motion = gentle
	endif
	if ScreenElementExists Id = <Id>
		<Id> ::DoMorph Pos = (<Pos> - (0.0, 230.0))Scale = (<base_scale> * 0.8)Time = 0.35 Motion = ease_in
	endif
	destroy_menu menu_id = <player_container>
endscript

script hud_lightning_alert
	if NOT ScreenElementExists Id = <alert_id>
		return
	endif
	FormatText ChecksumName = #"0xb0e43a20" 'HUD_lightning_01_%d' d = <Player>
	FormatText ChecksumName = #"0x5eea5b0c" 'HUD_lightning_03_%d' d = <Player>
	FormatText ChecksumName = #"0xb789fe39" 'HUD_lightning_05_%d' d = <Player>
	FormatText ChecksumName = #"0x59879f15" 'HUD_lightning_07_%d' d = <Player>
	GetScreenElementProps Id = <alert_id>
	lightning_pos = (<Pos> - (0.0, 20.0))
	lightning_dims = (800.0, 100.0)
	lightning_time = 0.2
	if ScreenElementExists Id = <#"0xb0e43a20">
		DestroyScreenElement Id = <#"0xb0e43a20">
	endif
	CreateScreenElement {
		Type = SpriteElement
		Id = <#"0xb0e43a20">
		texture = #"0xb0e43a20"
		PARENT = <player_container>
		Pos = <lightning_pos>
		dims = <lightning_dims>
		just = [ center top ]
		z_priority = 45
		Alpha = 0
	}
	if ScreenElementExists Id = <#"0x5eea5b0c">
		DestroyScreenElement Id = <#"0x5eea5b0c">
	endif
	CreateScreenElement {
		Type = SpriteElement
		Id = <#"0x5eea5b0c">
		texture = #"0x5eea5b0c"
		PARENT = <player_container>
		Pos = <lightning_pos>
		dims = <lightning_dims>
		just = [ center top ]
		z_priority = 45
		Alpha = 0
	}
	if ScreenElementExists Id = <#"0xb789fe39">
		DestroyScreenElement Id = <#"0xb789fe39">
	endif
	CreateScreenElement {
		Type = SpriteElement
		Id = <#"0xb789fe39">
		texture = #"0xb789fe39"
		PARENT = <player_container>
		Pos = <lightning_pos>
		dims = <lightning_dims>
		just = [ center top ]
		z_priority = 45
		Alpha = 0
	}
	if ScreenElementExists Id = <#"0x59879f15">
		DestroyScreenElement Id = <#"0x59879f15">
	endif
	CreateScreenElement {
		Type = SpriteElement
		Id = <#"0x59879f15">
		texture = #"0x59879f15"
		PARENT = <player_container>
		Pos = <lightning_pos>
		dims = <lightning_dims>
		just = [ center top ]
		z_priority = 45
		Alpha = 0
	}
	if ScreenElementExists Id = <#"0xb0e43a20">
		DoScreenElementMorph Id = <#"0xb0e43a20"> Alpha = 1 Time = <lightning_time>
		wait <lightning_time> seconds
	endif
	if ScreenElementExists Id = <#"0xb0e43a20">
		DoScreenElementMorph Id = <#"0xb0e43a20"> Alpha = 0 Time = <lightning_time>
		if ScreenElementExists Id = <#"0x5eea5b0c">
			DoScreenElementMorph Id = <#"0x5eea5b0c"> Alpha = 1 Time = <lightning_time>
		endif
		wait <lightning_time> seconds
	endif
	if ScreenElementExists Id = <#"0x5eea5b0c">
		DoScreenElementMorph Id = <#"0x5eea5b0c"> Alpha = 0 Time = <lightning_time>
		if ScreenElementExists Id = <#"0xb789fe39">
			DoScreenElementMorph Id = <#"0xb789fe39"> Alpha = 1 Time = <lightning_time>
		endif
		wait <lightning_time> seconds
	endif
	if ScreenElementExists Id = <#"0xb789fe39">
		DoScreenElementMorph Id = <#"0xb789fe39"> Alpha = 0 Time = <lightning_time>
		if ScreenElementExists Id = <#"0x59879f15">
			DoScreenElementMorph Id = <#"0x59879f15"> Alpha = 1 Time = <lightning_time>
		endif
		wait <lightning_time> seconds
	endif
	if ScreenElementExists Id = <#"0x59879f15">
		DoScreenElementMorph Id = <#"0x59879f15"> Alpha = 0 Time = <lightning_time>
		wait <lightning_time> seconds
	endif
	if ScreenElementExists Id = <#"0xb0e43a20">
		DestroyScreenElement Id = <#"0xb0e43a20">
	endif
	if ScreenElementExists Id = <#"0x5eea5b0c">
		DestroyScreenElement Id = <#"0x5eea5b0c">
	endif
	if ScreenElementExists Id = <#"0xb789fe39">
		DestroyScreenElement Id = <#"0xb789fe39">
	endif
	if ScreenElementExists Id = <#"0x59879f15">
		DestroyScreenElement Id = <#"0x59879f15">
	endif
endscript

script hud_glowburst_alert \{ player_status = player1_status }
	FormatText ChecksumName = star_power_ready_glow 'star_power_ready_glow_%d' d = ($<player_status>.Player)
	ExtendCRC hud_destroygroup_window ($<player_status>.text)out = hud_destroygroup
	if ScreenElementExists Id = <star_power_ready_glow>
		DestroyScreenElement Id = <star_power_ready_glow>
	endif
	if (($game_mode = p2_faceoff)|| ($game_mode = p2_pro_faceoff))
		if (($<player_status>.Player)= 1)
			original_pos = (($hud_screen_elements [ 0 ].Pos)- (225.0, 37.0))
		else
			original_pos = (($hud_screen_elements [ 0 ].Pos)+ (225.0, -37.0))
		endif
		base_scale = (7.5, 0.5)
		scale2 = (10.0, 2.5)
		scale3 = (7.5, 0.25)
		scale4 = (40.0, 0.0)
	else
		if ($game_mode = p2_career || $game_mode = p2_coop)
			original_pos = (($hud_screen_elements [ 0 ].Pos)- (0.0, 36.0))
		else
			original_pos = (($hud_screen_elements [ 0 ].Pos)+ (0.0, 7.0))
		endif
		base_scale = (15.0, 1.0)
		scale2 = (20.0, 5.0)
		scale3 = (15.0, 0.5)
		scale4 = (80.0, 0.0)
	endif
	if ScreenElementExists Id = <hud_destroygroup>
		CreateScreenElement {
			Type = SpriteElement
			Id = <star_power_ready_glow>
			PARENT = <hud_destroygroup>
			texture = Char_Select_Hilite1
			just = [ center center ]
			Pos = <original_pos>
			rgba = [ 245 255 200 255 ]
			Scale = <base_scale>
			Alpha = 1
			z_priority = 50
		}
	endif
	if ScreenElementExists Id = <star_power_ready_glow>
		<star_power_ready_glow> ::DoMorph Scale = <scale2> Alpha = 0.5 Motion = ease_out Time = 0.1
	endif
	if ScreenElementExists Id = <star_power_ready_glow>
		<star_power_ready_glow> ::DoMorph Scale = <scale3> Alpha = 0.5 rgba = [ 245 255 160 255 ] Motion = ease_out Time = 0.1
	endif
	if ScreenElementExists Id = <star_power_ready_glow>
		<star_power_ready_glow> ::DoMorph Scale = <scale4> Alpha = 0 Motion = ease_in Time = 0.8
	endif
	if ScreenElementExists Id = <star_power_ready_glow>
		DestroyScreenElement Id = <star_power_ready_glow>
	endif
endscript

script hud_flip_note_streak_num
	FormatText ChecksumName = Id 'HUD2D_Note_Streak_Text_%dp%i' d = <dial_num> i = <Player>
	if NOT ScreenElementExists Id = <Id>
		return
	endif
	<Id> ::GetTags
	GetScreenElementProps Id = <Id>
	basePos = <Pos>
	DoScreenElementMorph Id = <Id> Pos = (<basePos> + (0.0, 10.0))Alpha = 0
	DoScreenElementMorph Id = <Id> Pos = <intial_pos> Alpha = 1 Time = 0.1
endscript
