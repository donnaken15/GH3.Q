audio_settings_menu_font = fontgrid_title_gh3
audio_settings_editing = Band
aom_menu_pos = (480.0, 100.0)
as_pointer_pos = [ (264.0, 160.0) (264.0, 330.0) (264.0, 500.0) ]
as_pointer_index = 0
as_pointer_scale = 1
as_is_popup = 0
as_ping_index = 0
audio_settings_locked = 0

script create_audio_settings_menu \{ popup = 0 }
	exclusive_params = {}
	CreateScreenElement \{ Type = ContainerElement PARENT = root_window Id = aom_container Pos = (0.0, 0.0) }
	if (<popup> = 1)
		kill_start_key_binding
		z = 100
		Change \{ as_is_popup = 1 }
		new_menu {
			scrollid = as_scroll
			vmenuid = as_vmenu
			menu_pos = (420.0, 280.0)
			exclusive_device = ($last_start_pressed_device)
			text_right
			spacing = 40
		}
		create_pause_menu_frame z = (<z> - 10)
		Change \{menu_focus_color = [ 254 204 55 255 ]}
		Change \{menu_unfocus_color = [ 182 182 182 255 ]}
		text_params = {
			PARENT = as_vmenu
			Type = TextElement
			font = text_a6
			rgba = ($menu_unfocus_color)
			z_priority = <z>
			Scale = 0.7
			Shadow
			shadow_offs = (2.0, 2.0)
			shadow_rgba = [ 0 0 0 255 ]
		}
		CreateScreenElement {
			Type = SpriteElement
			PARENT = aom_container
			texture = menu_pause_frame_banner
			Pos = (640.0, 540.0)
			just = [ center center ]
			z_priority = (<z> + 100)
		}
		CreateScreenElement {
			Type = TextElement
			PARENT = <Id>
			text = "AUDIO"
			font = text_a6
			Pos = (125.0, 53.0)
			rgba = [ 170 90 30 255 ]
			Scale = 0.8
		}
		if NOT isSinglePlayerGame
			FormatText textname = player_paused_text "PLAYER %d PAUSED. ONLY PLAYER %d OPTIONS ARE AVAILABLE." d = (($last_start_pressed_device)+ 1)
			displaySprite {
				PARENT = pause_menu_frame_container
				Id = pause_helper_text_bg
				tex = Control_pill_body
				Pos = (640.0, 600.0)
				just = [ center center ]
				rgba = [ 96 0 0 255 ]
				z = (<z> + 10)
			}
			displayText {
				PARENT = pause_menu_frame_container
				Pos = (640.0, 604.0)
				just = [ center center ]
				text = <player_paused_text>
				rgba = [ 186 105 0 255 ]
				Scale = (0.45000001788139343, 0.6000000238418579)
				z = (<z> + 11)
				font = text_a6
			}
			GetScreenElementDims Id = <Id>
			bg_dims = (<width> * (1.0, 0.0) + (0.0, 32.0))
			pause_helper_text_bg ::SetProps dims = <bg_dims>
			displaySprite {
				PARENT = pause_menu_frame_container
				tex = Control_pill_end
				Pos = ((640.0, 600.0) - <width> * (0.5, 0.0))
				rgba = [ 96 0 0 255 ]
				just = [ Right center ]
				flip_v
				z = (<z> + 10)
			}
			displaySprite {
				PARENT = pause_menu_frame_container
				tex = Control_pill_end
				Pos = ((640.0, 600.0) + <width> * (0.5, 0.0))
				rgba = [ 96 0 0 255 ]
				just = [ Left center ]
				z = (<z> + 10)
			}
		endif
		displaySprite \{PARENT = aom_container tex = Options_Audio_Knob Pos = (725.0, 295.0) just = [ center center ] dims = (96.0, 96.0) rgba = [ 150 150 150 255 ] z = 150}
		displaySprite \{PARENT = aom_container tex = Options_Audio_Knob Pos = (825.0, 365.0) just = [ center center ] dims = (96.0, 96.0) rgba = [ 150 150 150 255 ] z = 150}
		displaySprite \{PARENT = aom_container tex = Options_Audio_Knob Pos = (725.0, 440.0) just = [ center center ] dims = (96.0, 96.0) rgba = [ 150 150 150 255 ] z = 150}
		displaySprite \{PARENT = aom_container Id = aom_knob_line_1 tex = Options_Audio_Knob_Line Pos = (725.0, 295.0) dims = (48.0, 12.0) z = 151 rgba = [ 230 190 70 255 ] just = [ 1.0 0.0 ]}
		displaySprite \{PARENT = aom_container Id = aom_knob_line_2 tex = Options_Audio_Knob_Line Pos = (825.0, 365.0) dims = (48.0, 12.0) z = 151 rgba = [ 230 190 70 255 ] just = [ 1.0 0.0 ]}
		displaySprite \{PARENT = aom_container Id = aom_knob_line_3 tex = Options_Audio_Knob_Line Pos = (725.0, 440.0) dims = (48.0, 12.0) z = 151 rgba = [ 230 190 70 255 ] just = [ 1.0 0.0 ]}
	else
		Change \{ as_is_popup = 0 }
		spacing = 105
		new_menu scrollid = as_scroll vmenuid = as_vmenu spacing = <spacing> menu_pos = $aom_menu_pos exclusive_device = ($primary_controller)
		create_menu_backdrop \{ texture = Venue_BG }
		CreateScreenElement \{Type = SpriteElement PARENT = aom_container Id = as_light_overlay texture = Venue_Overlay Pos = (640.0, 360.0) dims = (1280.0, 720.0) just = [ center center ] z_priority = 99}
		set_focus_color \{rgba = [ 230 190 70 255 ]}
		set_unfocus_color \{rgba = [ 150 150 150 255 ]}
		displaySprite \{ PARENT = aom_container tex = Options_Audio_Poster Pos = (340.0, 40.0) dims = (672.0, 672.0) }
		displaySprite \{PARENT = aom_container tex = Tape_H_01 Pos = (360.0, 40.0) dims = (192.0, 96.0) z = 10 rot_angle = -20}
		displaySprite \{PARENT = aom_container tex = Tape_H_01 rgba = [ 0 0 0 128 ] Pos = (360.0, 48.0) dims = (192.0, 96.0) z = 10 rot_angle = -20}
		displaySprite \{PARENT = aom_container tex = Tape_V_01 Pos = (870.0, 550.0) dims = (96.0, 192.0) z = 10 rot_angle = 16}
		displaySprite \{PARENT = aom_container tex = Tape_V_01 rgba = [ 0 0 0 128 ] Pos = (875.0, 551.0) dims = (96.0, 192.0) z = 10 rot_angle = 16}
		displaySprite PARENT = aom_container tex = Options_Audio_Knob Pos = ($aom_menu_pos + (15.0, 50.0))dims = (96.0, 96.0) rgba = [ 150 150 150 255 ] z = 9
		displaySprite PARENT = aom_container tex = Options_Audio_Knob Pos = ($aom_menu_pos + (15.0, 219.0))dims = (96.0, 96.0) rgba = [ 150 150 150 255 ] z = 9
		displaySprite PARENT = aom_container tex = Options_Audio_Knob Pos = ($aom_menu_pos + (15.0, 386.0))dims = (96.0, 96.0) rgba = [ 150 150 150 255 ] z = 9
		displaySprite \{PARENT = aom_container Id = aom_belly_strings tex = Options_Audio_BellyStrings Pos = (744.0, 146.0) dims = (74.0, 318.0) z = 10}
		displaySprite PARENT = aom_container Id = aom_pointer tex = Options_Audio_Pointer_V2 Pos = ($as_pointer_pos [ 0 ])dims = (256.0, 128.0) relative_scale z = 10
		displaySprite PARENT = aom_container Id = aom_knob_line_1 tex = Options_Audio_Knob_Line Pos = ($aom_menu_pos + (63.0, 94.0))dims = (48.0, 12.0) z = 10 rgba = [ 230 190 70 255 ] just = [ 1.0 0.0 ]
		displaySprite PARENT = aom_container Id = aom_knob_line_2 tex = Options_Audio_Knob_Line Pos = ($aom_menu_pos + (63.0, 263.0))dims = (48.0, 12.0) z = 10 rgba = [ 230 190 70 255 ] just = [ 1.0 0.0 ]
		displaySprite PARENT = aom_container Id = aom_knob_line_3 tex = Options_Audio_Knob_Line Pos = ($aom_menu_pos + (63.0, 430.0))dims = (48.0, 12.0) z = 10 rgba = [ 230 190 70 255 ] just = [ 1.0 0.0 ]
		GetScreenElementProps Id = <Id>
		text_params = {PARENT = as_vmenu Type = TextElement font = ($audio_settings_menu_font)rgba = ($menu_unfocus_color)}
	endif
	i = 0
	begin
		FormatText ChecksumName = ping_id 'aom_ping_%d' d = <i>
		displaySprite PARENT = aom_container Id = <ping_id> tex = Options_Audio_Ping Alpha = 0 Scale = 1 z = 180 just = [ center center ]
		<i> = (<i> + 1)
	repeat 11
	GetGlobalTags \{ user_options }
	FormatText textname = band_volume_text "%d" d = <band_volume>
	if (<popup>)
		FormatText textname = text "BAND: %d" d = <band_volume>
		<exclusive_params> = {exclusive_device = ($last_start_pressed_device)}
		displaySprite \{PARENT = pause_menu_frame_container tex = Newspaper_Circle rgba = [ 0 0 0 255 ] Pos = (615.0, 295.0) dims = (58.0, 58.0) just = [ center center ] z = 200}
		displaySprite \{PARENT = pause_menu_frame_container Id = band_yeller tex = Newspaper_Circle rgba = [ 0 0 0 255 ] Pos = (615.0, 295.0) dims = (44.0, 44.0) just = [ center center ] z = 201}
		displayText {
			PARENT = pause_menu_frame_container
			Id = band_volume_text_id
			Pos = (613.0, 298.0)
			just = [ center center ]
			rgba = ($menu_unfocus_color)
			z = 202
			Scale = 0.8
			font = text_a6
			text = <band_volume_text>
			noshadow
		}
	else
		text = "BAND"
		displayText PARENT = aom_container Id = band_volume_id text = <band_volume_text> Pos = ($aom_menu_pos + (130.0, 75.0))z = 9
		<exclusive_params> = {exclusive_device = ($primary_controller)}
	endif
	SetScreenElementProps Id = aom_knob_line_1 rot_angle = ((<band_volume> / 11.0)* 180.0)
	CreateScreenElement {
		<text_params>
		text = "BAND"
		Id = as_band
		Pos = (600.0, 32.0)
		event_handlers = [
			{Focus menu_audio_settings_focus Params = { editing = Band }}
			{unfocus menu_audio_settings_unfocus Params = { editing = Band }}
			{ pad_choose menu_audio_settings_lock_selection }
			{ pad_back menu_audio_settings_press_back }
			{ pad_left menu_audio_settings_lower_selection_volume }
			{ pad_right menu_audio_settings_increase_selection_volume }
		]
		<exclusive_params>
	}
	FormatText textname = guitar_volume_text "%d" d = <guitar_volume>
	if (<popup>)
		FormatText textname = text "GUITAR: %d" d = <guitar_volume>
		<exclusive_params> = {exclusive_device = ($last_start_pressed_device)}
		displaySprite \{PARENT = pause_menu_frame_container tex = HUD_score_nixie_2a rgba = [ 0 0 0 255 ] Pos = (615.0, 365.0) dims = (58.0, 58.0) just = [ center center ] z = 200}
		displaySprite \{PARENT = pause_menu_frame_container Id = guitar_yeller tex = Newspaper_Circle rgba = [ 0 0 0 255 ] Pos = (615.0, 365.0) dims = (44.0, 44.0) just = [ center center ] z = 201}
		displayText {
			PARENT = pause_menu_frame_container
			Id = guitar_volume_text_id
			Pos = (613.0, 368.0)
			just = [ center center ]
			rgba = ($menu_unfocus_color)
			z = 202
			Scale = 0.8
			font = text_a6
			noshadow
			text = <guitar_volume_text>
		}
	else
		displayText PARENT = aom_container Id = guitar_volume_id text = <guitar_volume_text> Pos = ($aom_menu_pos + (130.0, 243.0))z = 9
		<exclusive_params> = {exclusive_device = ($primary_controller)}
	endif
	SetScreenElementProps Id = aom_knob_line_2 rot_angle = ((<guitar_volume> / 11.0)* 180.0)
	CreateScreenElement {
		<text_params>
		text = "GUITAR"
		Id = as_guitar
		event_handlers = [
			{Focus menu_audio_settings_focus Params = { editing = guitar }}
			{unfocus menu_audio_settings_unfocus Params = { editing = guitar }}
			{ pad_choose menu_audio_settings_lock_selection }
			{ pad_back menu_audio_settings_press_back }
			{ pad_left menu_audio_settings_lower_selection_volume }
			{ pad_right menu_audio_settings_increase_selection_volume }
		]
		<exclusive_params>
	}
	FormatText textname = sfx_volume_text "%d" d = <sfx_volume>
	if (<popup>)
		FormatText textname = text "FX: %d" d = <sfx_volume>
		<exclusive_params> = {exclusive_device = ($last_start_pressed_device)}
		displaySprite \{PARENT = pause_menu_frame_container tex = HUD_score_nixie_2a rgba = [ 0 0 0 255 ] Pos = (615.0, 440.0) dims = (58.0, 58.0) just = [ center center ] z = 200}
		displaySprite \{PARENT = pause_menu_frame_container Id = fx_yeller tex = Newspaper_Circle rgba = [ 0 0 0 255 ] Pos = (615.0, 440.0) dims = (44.0, 44.0) just = [ center center ] z = 201}
		displayText {
			PARENT = pause_menu_frame_container
			Id = fx_volume_text_id
			Pos = (613.0, 443.0)
			just = [ center center ]
			rgba = ($menu_unfocus_color)
			z = 202
			Scale = 0.8
			font = text_a6
			text = <sfx_volume_text>
			noshadow
		}
	else
		displayText PARENT = aom_container Id = sfx_volume_id text = <sfx_volume_text> Pos = ($aom_menu_pos + (130.0, 409.0))z = 9
		<exclusive_params> = {exclusive_device = ($primary_controller)}
	endif
	SetScreenElementProps Id = aom_knob_line_3 rot_angle = ((<sfx_volume> / 11.0)* 180.0)
	CreateScreenElement {
		<text_params>
		text = "FX"
		Id = as_sfx
		event_handlers = [
			{Focus menu_audio_settings_focus Params = { editing = SFX }}
			{unfocus menu_audio_settings_unfocus Params = { editing = SFX }}
			{ pad_choose menu_audio_settings_lock_selection }
			{ pad_back menu_audio_settings_press_back }
			{ pad_left menu_audio_settings_lower_selection_volume }
			{ pad_right menu_audio_settings_increase_selection_volume }
		]
		<exclusive_params>
	}
	if (<popup>)
		GetScreenElementDims \{ Id = as_band }
		fit_text_in_rectangle Id = as_band only_if_larger_x = 1 dims = ((160.0, 0.0) + <height> * (0.0, 1.0))start_x_scale = 0.7 start_y_scale = 0.7
		GetScreenElementDims \{ Id = as_guitar }
		fit_text_in_rectangle Id = as_guitar only_if_larger_x = 1 dims = ((160.0, 0.0) + <height> * (0.0, 1.0))start_x_scale = 0.7 start_y_scale = 0.7
		GetScreenElementDims \{ Id = as_sfx }
		fit_text_in_rectangle Id = as_sfx only_if_larger_x = 1 dims = ((160.0, 0.0) + <height> * (0.0, 1.0))start_x_scale = 0.7 start_y_scale = 0.7
	endif
	Change \{user_control_pill_text_color = [ 0 0 0 255 ]}
	Change \{user_control_pill_color = [ 180 180 180 255 ]}
	add_user_control_helper \{ text = "SELECT" button = Green z = 100 }
	add_user_control_helper \{ text = "BACK" button = Red z = 100 }
	add_user_control_helper \{ text = "UP/DOWN" button = strumbar z = 100 }
endscript

script destroy_audio_settings_menu
	clean_up_user_control_helpers
	Change \{ audio_settings_locked = 0 }
	Change \{ as_pointer_index = 0 }
	destroy_menu \{ menu_id = aom_container }
	destroy_menu \{ menu_id = as_scroll }
	destroy_menu \{ menu_id = as_highlight_sprite }
	destroy_menu_backdrop
	destroy_pause_menu_frame
endscript

script menu_audio_settings_focus
	retail_menu_focus
	Change audio_settings_editing = <editing>
	last_index = $as_pointer_index
	switch (<editing>)
		case Band
			Change \{ as_pointer_index = 0 }
			if ($as_is_popup)
				SetScreenElementProps Id = band_yeller rgba = ($menu_focus_color)
				SetScreenElementProps \{Id = band_volume_text_id rgba = [ 0 0 0 255 ]}
			endif
		case guitar
			Change \{ as_pointer_index = 1 }
			if ($as_is_popup)
				SetScreenElementProps Id = guitar_yeller rgba = ($menu_focus_color)
				SetScreenElementProps \{Id = guitar_volume_text_id rgba = [ 0 0 0 255 ]}
			endif
		case SFX
			Change \{ as_pointer_index = 2 }
			if ($as_is_popup)
				SetScreenElementProps Id = fx_yeller rgba = ($menu_focus_color)
				SetScreenElementProps \{Id = fx_volume_text_id rgba = [ 0 0 0 255 ]}
			endif
	endswitch
	aom_hilite_knob
	if NOT ($as_is_popup)
		aom_move_pointer last_index = <last_index>
	endif
endscript

script menu_audio_settings_unfocus
	retail_menu_unfocus
	if ($as_is_popup)
		switch (<editing>)
			case Band
				SetScreenElementProps \{Id = band_yeller rgba = [ 0 0 0 255 ]}
				SetScreenElementProps Id = band_volume_text_id rgba = ($menu_unfocus_color)
			case guitar
				SetScreenElementProps \{Id = guitar_yeller rgba = [ 0 0 0 255 ]}
				SetScreenElementProps Id = guitar_volume_text_id rgba = ($menu_unfocus_color)
			case SFX
				SetScreenElementProps \{Id = fx_yeller rgba = [ 0 0 0 255 ]}
				SetScreenElementProps Id = fx_volume_text_id rgba = ($menu_unfocus_color)
		endswitch
	endif
endscript

script menu_audio_settings_lock_selection
	if NOT ($audio_settings_locked)
		SoundEvent \{ Event = ui_sfx_select }
	endif
	GetTags
	LaunchEvent \{ Type = unfocus Target = as_vmenu }
	wait \{ 1 GameFrame }
	LaunchEvent Type = Focus Target = <Id>
	SetScreenElementProps {
		Id = <Id>
		event_handlers = [
			{ pad_up menu_audio_settings_increase_volume_guitar_check }
			{ pad_down menu_audio_settings_lower_volume_guitar_check }
		]
		Replace_Handlers
	}
	menu_audio_settings_highlight_item
	Change \{ audio_settings_locked = 1 }
endscript

script menu_audio_settings_press_back
	SoundEvent \{ Event = Generic_menu_back_SFX }
	GetTags
	LaunchEvent Type = unfocus Target = <Id>
	wait \{ 1 GameFrame }
	LaunchEvent \{ Type = Focus Target = as_vmenu }
	SetScreenElementProps {
		Id = <Id>
		event_handlers = [
			{ pad_up null_script }
			{ pad_down null_script }
		]
		Replace_Handlers
	}
	menu_audio_settings_remove_highlight
	Change \{ audio_settings_locked = 0 }
endscript

script ChangeSpinalTapVolume \{ spinal_tap_volume_max = 11 }
	<spinal_tap_volume> = (<spinal_tap_volume> + <Change>)
	if (<spinal_tap_volume> < 0)
		<spinal_tap_volume> = 0
	elseif (<spinal_tap_volume> > <spinal_tap_volume_max>)
		<spinal_tap_volume> = <spinal_tap_volume_max>
	endif
	return Volume = <spinal_tap_volume>
endscript

script menu_audio_settings_lower_selection_volume
	GetGlobalTags \{ user_options }
	switch ($audio_settings_editing)
		case Band
			ChangeSpinalTapVolume spinal_tap_volume = <band_volume> Change = -1
			SetGlobalTags user_options Params = { band_volume = <Volume> }
			if ($as_is_popup)
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = band_volume_text_id text = <text>
			else
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = band_volume_id text = <text>
			endif
			SetScreenElementProps Id = aom_knob_line_1 rot_angle = ((<Volume> / 11.0)* 180.0)
			menu_audio_settings_update_band_volume vol = <Volume>
			if NOT (<band_volume> = <Volume>)
				do_ping = 1
				menu_audio_settings_band_volume_sound
			else
				do_ping = 0
			endif
		case guitar
			ChangeSpinalTapVolume spinal_tap_volume = <guitar_volume> Change = -1
			SetGlobalTags user_options Params = { guitar_volume = <Volume> }
			if ($as_is_popup)
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = guitar_volume_text_id text = <text>
			else
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = guitar_volume_id text = <text>
			endif
			SetScreenElementProps Id = aom_knob_line_2 rot_angle = ((<Volume> / 11.0)* 180.0)
			menu_audio_settings_update_guitar_volume vol = <Volume>
			if NOT (<guitar_volume> = <Volume>)
				do_ping = 1
				menu_audio_settings_guitar_volume_sound
			else
				do_ping = 0
			endif
		case SFX
			ChangeSpinalTapVolume spinal_tap_volume = <sfx_volume> Change = -1
			SetGlobalTags user_options Params = { sfx_volume = <Volume> }
			if ($as_is_popup)
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = fx_volume_text_id text = <text>
			else
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = sfx_volume_id text = <text>
			endif
			SetScreenElementProps Id = aom_knob_line_3 rot_angle = ((<Volume> / 11.0)* 180.0)
			menu_audio_settings_update_sfx_volume vol = <Volume>
			if NOT (<sfx_volume> = <Volume>)
				do_ping = 1
				menu_audio_settings_fx_volume_sound
			else
				do_ping = 0
			endif
	endswitch
	if (<do_ping>)
		FormatText \{ ChecksumName = ping_id 'aom_ping_%d' d = $as_ping_index }
		Change as_ping_index = ($as_ping_index + 1)
		if ($as_ping_index > 10)
			Change \{ as_ping_index = 0 }
		endif
		RunScriptOnScreenElement Id = <ping_id> aom_spawn_ping
	endif
endscript

script menu_audio_settings_increase_selection_volume
	GetGlobalTags \{ user_options }
	switch ($audio_settings_editing)
		case Band
			ChangeSpinalTapVolume spinal_tap_volume = <band_volume> Change = 1
			SetGlobalTags user_options Params = { band_volume = <Volume> }
			if ($as_is_popup)
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = band_volume_text_id text = <text>
			else
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = band_volume_id text = <text>
			endif
			SetScreenElementProps Id = aom_knob_line_1 rot_angle = ((<Volume> / 11.0)* 180.0)
			menu_audio_settings_update_band_volume vol = <Volume>
			if NOT (<band_volume> = <Volume>)
				do_ping = 1
				menu_audio_settings_band_volume_sound
			else
				do_ping = 0
			endif
		case guitar
			ChangeSpinalTapVolume spinal_tap_volume = <guitar_volume> Change = 1
			SetGlobalTags user_options Params = { guitar_volume = <Volume> }
			if ($as_is_popup)
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = guitar_volume_text_id text = <text>
			else
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = guitar_volume_id text = <text>
			endif
			SetScreenElementProps Id = aom_knob_line_2 rot_angle = ((<Volume> / 11.0)* 180.0)
			menu_audio_settings_update_guitar_volume vol = <Volume>
			if NOT (<guitar_volume> = <Volume>)
				do_ping = 1
				menu_audio_settings_guitar_volume_sound
			else
				do_ping = 0
			endif
		case SFX
			ChangeSpinalTapVolume spinal_tap_volume = <sfx_volume> Change = 1
			SetGlobalTags user_options Params = { sfx_volume = <Volume> }
			if ($as_is_popup)
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = fx_volume_text_id text = <text>
			else
				FormatText textname = text "%d" d = <Volume>
				SetScreenElementProps Id = sfx_volume_id text = <text>
			endif
			SetScreenElementProps Id = aom_knob_line_3 rot_angle = ((<Volume> / 11.0)* 180.0)
			menu_audio_settings_update_sfx_volume vol = <Volume>
			if NOT (<sfx_volume> = <Volume>)
				do_ping = 1
				menu_audio_settings_fx_volume_sound
			else
				do_ping = 0
			endif
	endswitch
	if (<do_ping>)
		FormatText \{ ChecksumName = ping_id 'aom_ping_%d' d = $as_ping_index }
		Change as_ping_index = ($as_ping_index + 1)
		if ($as_ping_index > 10)
			Change \{ as_ping_index = 0 }
		endif
		RunScriptOnScreenElement Id = <ping_id> aom_spawn_ping
	endif
endscript

script menu_audio_settings_increase_volume_guitar_check
	if IsGuitarController controller = <device_num>
		menu_audio_settings_lower_selection_volume
	else
		menu_audio_settings_increase_selection_volume
	endif
endscript

script menu_audio_settings_lower_volume_guitar_check
	if IsGuitarController controller = <device_num>
		menu_audio_settings_increase_selection_volume
	else
		menu_audio_settings_lower_selection_volume
	endif
endscript

script menu_audio_settings_highlight_item
	if NOT ScreenElementExists \{ Id = as_highlight_sprite }
		GetTags
		GetScreenElementDims Id = <Id>
		GetScreenElementPosition Id = <Id> absolute
		if ($as_is_popup = 0)
			<highlight_pos> = (<ScreenElementPos> + (-0.05000000074505806, 0.0) * <width> + (0.0, -0.05000000074505806) * <height>)
			<highlight_dims> = ((1.100000023841858, 0.0) * <width> + (0.0, 0.800000011920929) * <height>)
		else
			<highlight_pos> = (<ScreenElementPos> + (-5.0, -3.0))
			<highlight_dims> = ((1.0, 0.0) * <width> + (0.0, 1.0) * <height> + (12.0, 0.0))
		endif
		CreateScreenElement {
			Type = SpriteElement
			PARENT = root_window
			Id = as_highlight_sprite
			Pos = <highlight_pos>
			dims = <highlight_dims>
			rgba = [ 210 130 0 125 ]
			just = [ Left top ]
			z_priority = 99
		}
	endif
endscript

script menu_audio_settings_remove_highlight
	if ScreenElementExists \{ Id = as_highlight_sprite }
		DestroyScreenElement \{ Id = as_highlight_sprite }
	endif
endscript

script menu_audio_settings_get_buss_volume
	switch <Volume>
		case 11
			<vol> = 0
		case 10
			<vol> = -1.2
		case 9
			<vol> = -2.4
		case 8
			<vol> = -3.7
		case 7
			<vol> = -4.9
		case 6
			<vol> = -6.2
		case 5
			<vol> = -8
		case 4
			<vol> = -10
		case 3
			<vol> = -13
		case 2
			<vol> = -17
		case 1
			<vol> = -21
		case 0
			<vol> = -100
	endswitch
	return vol = <vol>
endscript

script menu_audio_settings_update_guitar_volume \{ vol = 11 }
	menu_audio_settings_get_buss_volume Volume = <vol>
	SoundBussUnlock \{ User_Guitar }
	SetSoundBussParams {User_Guitar = { vol = <vol> }}
	SoundBussLock \{ User_Guitar }
endscript

script menu_audio_settings_update_band_volume \{ vol = 11 }
	menu_audio_settings_get_buss_volume Volume = <vol>
	SoundBussUnlock \{ User_Band }
	SetSoundBussParams {User_Band = { vol = <vol> }}
	SoundBussLock \{ User_Band }
endscript

script menu_audio_settings_update_sfx_volume \{ vol = 11 }
	Printf "Got vol = %v" v = <vol>
	menu_audio_settings_get_buss_volume Volume = <vol>
	Printf "Got vol-post = %v" v = <vol>
	SoundBussUnlock \{ User_SFX }
	Printf channel = SFX "setting user_sfx to %s " s = <vol>
	SetSoundBussParams {User_SFX = { vol = <vol> }}
	SoundBussLock \{ User_SFX }
endscript

script aom_move_pointer
	if NOT ($as_pointer_index = <last_index>)
		if (<last_index> < $as_pointer_index)
			middle_pos = (($as_pointer_pos [ $as_pointer_index ])+ (-80.0, 85.0))
		else
			middle_pos = (($as_pointer_pos [ $as_pointer_index ])+ (-80.0, -85.0))
		endif
		DoScreenElementMorph Id = aom_pointer Pos = <middle_pos> Scale = ($as_pointer_scale / 2.0)Time = 0.1 relative_scale
		wait \{ 0.1 seconds }
		DoScreenElementMorph Id = aom_pointer Pos = ($as_pointer_pos [ $as_pointer_index ])Scale = $as_pointer_scale Time = 0.1 relative_scale
		wait \{ 0.1 seconds }
		<last_index> = $as_pointer_index
	endif
endscript

script aom_hilite_knob
	switch ($as_pointer_index)
		case 0
			SetScreenElementProps \{Id = aom_knob_line_1 rgba = [ 230 190 70 255 ]}
			if NOT ($as_is_popup)
				SetScreenElementProps \{Id = band_volume_id rgba = [ 230 190 70 255 ]}
			endif
			SetScreenElementProps \{Id = aom_knob_line_2 rgba = [ 150 150 150 255 ]}
			SetScreenElementProps \{Id = aom_knob_line_3 rgba = [ 150 150 150 255 ]}
			if NOT ($as_is_popup)
				SetScreenElementProps \{Id = guitar_volume_id rgba = [ 150 150 150 255 ]}
				SetScreenElementProps \{Id = sfx_volume_id rgba = [ 150 150 150 255 ]}
			endif
		case 1
			SetScreenElementProps \{Id = aom_knob_line_2 rgba = [ 230 190 70 255 ]}
			if NOT ($as_is_popup)
				SetScreenElementProps \{Id = guitar_volume_id rgba = [ 230 190 70 255 ]}
			endif
			SetScreenElementProps \{Id = aom_knob_line_1 rgba = [ 150 150 150 255 ]}
			SetScreenElementProps \{Id = aom_knob_line_3 rgba = [ 150 150 150 255 ]}
			if NOT ($as_is_popup)
				SetScreenElementProps \{Id = band_volume_id rgba = [ 150 150 150 255 ]}
				SetScreenElementProps \{Id = sfx_volume_id rgba = [ 150 150 150 255 ]}
			endif
		case 2
			SetScreenElementProps \{Id = aom_knob_line_3 rgba = [ 230 190 70 255 ]}
			if NOT ($as_is_popup)
				SetScreenElementProps \{Id = sfx_volume_id rgba = [ 230 190 70 255 ]}
			endif
			SetScreenElementProps \{Id = aom_knob_line_1 rgba = [ 150 150 150 255 ]}
			SetScreenElementProps \{Id = aom_knob_line_2 rgba = [ 150 150 150 255 ]}
			if NOT ($as_is_popup)
				SetScreenElementProps \{Id = band_volume_id rgba = [ 150 150 150 255 ]}
				SetScreenElementProps \{Id = guitar_volume_id rgba = [ 150 150 150 255 ]}
			endif
	endswitch
endscript

script aom_spawn_ping \{ Time = 0.25 }
	GetTags
	if NOT ($as_is_popup)
		switch ($audio_settings_editing)
			case Band
				Pos = ($aom_menu_pos + (145.0, 96.0))
			case guitar
				Pos = ($aom_menu_pos + (145.0, 266.0))
			case SFX
				Pos = ($aom_menu_pos + (145.0, 436.0))
		endswitch
	else
		switch ($audio_settings_editing)
			case Band
				Pos = (725.0, 295.0)
			case guitar
				Pos = (825.0, 365.0)
			case SFX
				Pos = (725.0, 440.0)
		endswitch
	endif
	<Id> ::DoMorph Scale = 1 Pos = <Pos> Alpha = 1
	<Id> ::DoMorph Scale = 5 Alpha = 0 Time = <Time>
	if NOT ($as_is_popup)
		<center_belly_pos> = (744.0, 146.0)
		<left_belly_pos> = (724.0, 146.0)
		<right_belly_pos> = (764.0, 146.0)
		<jiggle_time> = 0.05
		begin
			DoScreenElementMorph Id = aom_belly_strings Pos = <left_belly_pos> Time = <jiggle_time>
			wait <jiggle_time> seconds
			DoScreenElementMorph Id = aom_belly_strings Pos = <center_belly_pos> Time = <jiggle_time>
			wait <jiggle_time> seconds
			DoScreenElementMorph Id = aom_belly_strings Pos = <right_belly_pos> Time = <jiggle_time>
			wait <jiggle_time> seconds
			DoScreenElementMorph Id = aom_belly_strings Pos = <center_belly_pos> Time = <jiggle_time>
			<left_belly_pos> = (<left_belly_pos> + (3.3299999237060547, 0.0))
			<right_belly_pos> = (<right_belly_pos> + (-3.3299999237060547, 0.0))
		repeat 6
	endif
endscript
