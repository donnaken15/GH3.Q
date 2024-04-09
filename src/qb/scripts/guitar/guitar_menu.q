gh3_button_font = buttonsxenon
bunny_flame_index = 1
g_anim_flame = 1
default_event_handlers = [
	{
		pad_up
		generic_menu_up_or_down_sound
		Params = { Up }
	}
	{
		pad_down
		generic_menu_up_or_down_sound
		Params = { Down }
	}
	{
		pad_back
		generic_menu_pad_back
		Params = { callback = menu_flow_go_back }
	}
]
menu_text_color = [ 215 160 110 255 ]

script menu_flow_go_back \{Player = 1 create_params = {}destroy_params = {}}
	ui_flow_manager_respond_to_action action = go_back Player = <Player> create_params = <create_params> destroy_params = <destroy_params>
endscript

script new_menu \{menu_pos = $menu_pos event_handlers = $default_event_handlers use_backdrop = 0 z = 1 dims = (400.0, 480.0) font = text_a1 font_size = 0.75 default_colors = 1 just = [ Left top ] no_focus = 0 internal_just = [ center top ]}
	if ScreenElementExists Id = <scrollid>
		Printf "script new_menu - %s Already exists." s = <scrollid>
		return
	endif
	if ScreenElementExists Id = <vmenuid>
		Printf "script new_menu - %s Already exists." s = <vmenuid>
		return
	endif
	CreateScreenElement {
		Type = VScrollingMenu
		PARENT = root_window
		Id = <scrollid>
		just = <just>
		dims = <dims>
		Pos = <menu_pos>
		z_priority = <z>
	}
	if (<use_backdrop>)
		create_generic_backdrop
	endif
	if GotParam \{ name }
		CreateScreenElement {
			Type = TextElement
			PARENT = <scrollid>
			font = <font>
			Pos = (0.0, -45.0)
			Scale = <font_size>
			rgba = [ 210 210 210 250 ]
			text = <name>
			just = <just>
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [ 0 0 0 255 ]
		}
	endif
	CreateScreenElement {
		Type = VMenu
		PARENT = <scrollid>
		Id = <vmenuid>
		Pos = (0.0, 0.0)
		just = <just>
		internal_just = <internal_just>
		event_handlers = <event_handlers>
	}
	if GotParam \{ rot_angle }
		SetScreenElementProps Id = <vmenuid> rot_angle = <rot_angle>
	endif
	if GotParam \{ no_wrap }
		SetScreenElementProps Id = <vmenuid> dont_allow_wrap
	endif
	if GotParam \{ spacing }
		SetScreenElementProps Id = <vmenuid> spacing_between = <spacing>
	endif
	if GotParam \{ text_left }
		SetScreenElementProps Id = <vmenuid> internal_just = [ Left top ]
	endif
	if GotParam \{ text_right }
		SetScreenElementProps Id = <vmenuid> internal_just = [ Right top ]
	endif
	if NOT GotParam \{ exclusive_device }
		exclusive_device = ($primary_controller)
	endif
	if NOT (<exclusive_device> = None)
		SetScreenElementProps {
			Id = <scrollid>
			exclusive_device = <exclusive_device>
		}
		SetScreenElementProps {
			Id = <vmenuid>
			exclusive_device = <exclusive_device>
		}
	endif
	if GotParam \{ tierlist }
		Tier = 0
		begin
			<Tier> = (<Tier> + 1)
			setlist_prefix = ($<tierlist>.prefix)
			FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = (<Tier>)
			FormatText ChecksumName = tier_checksum 'tier%s' s = (<Tier>)
			<unlocked> = 1
			GetGlobalTags <tiername> param = unlocked
			if ((<unlocked> = 1)|| ($is_network_game))
				GetArraySize ($<tierlist>.<tier_checksum>.songs)
				song_count = 0
				if (<array_Size> > 0)
					begin
						FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1)s = (<Tier>)AddToStringLookup = TRUE
						for_bonus = 0
						if ($current_tab = tab_bonus)
							<for_bonus> = 1
						endif
						if IsSongAvailable song_checksum = <song_checksum> song = ($g_gh3_setlist.<tier_checksum>.songs [ <song_count> ])for_bonus = <for_bonus>
							get_song_title song = ($<tierlist>.<tier_checksum>.songs [ <song_count> ])
							CreateScreenElement {
								Type = TextElement
								PARENT = <vmenuid>
								font = <font>
								Scale = <font_size>
								rgba = [ 210 210 210 250 ]
								text = <song_title>
								just = [ Left top ]
								event_handlers = [
									{ Focus menu_focus }
									{ unfocus menu_unfocus }
									{pad_choose <on_choose> Params = {Tier = <Tier> song_count = <song_count>}}
									{pad_left <on_left> Params = {Tier = <Tier> song_count = <song_count>}}
									{pad_right <on_right> Params = {Tier = <Tier> song_count = <song_count>}}
									{pad_L3 <on_l3> Params = {Tier = <Tier> song_count = <song_count>}}
								]
							}
						endif
						song_count = (<song_count> + 1)
					repeat <array_Size>
				endif
			endif
		repeat ($<tierlist>.num_tiers)
	endif
	if (<default_colors>)
		set_focus_color rgba = ($default_menu_focus_color)
		set_unfocus_color rgba = ($default_menu_unfocus_color)
	endif
	if (<no_focus> = 0)
		LaunchEvent Type = Focus Target = <vmenuid>
	endif
endscript

script destroy_menu
	if GotParam \{ menu_id }
		if ScreenElementExists Id = <menu_id>
			DestroyScreenElement Id = <menu_id>
		endif
		destroy_generic_backdrop
	endif
endscript

script create_main_menu_backdrop
	Change \{ coop_dlc_active = 0 }
	create_menu_backdrop \{ texture = GH3_Main_Menu_BG }
	base_menu_pos = (730.0, 90.0)
	CreateScreenElement {
		Type = ContainerElement
		Id = main_menu_text_container
		PARENT = root_window
		Pos = (<base_menu_pos>)
		just = [ Left top ]
		z_priority = 3
		Scale = 0.8
	}
	CreateScreenElement \{Type = ContainerElement Id = main_menu_bg_container PARENT = root_window Pos = (0.0, 0.0) z_priority = 3}
	WinPortGetAppFullVersion
	FormatText textname = version_string_display "VERSION %s" s = <version_string>
	main_menu_font = fontgrid_title_gh3
	CreateScreenElement {
		Type = TextElement
		Id = version_text
		PARENT = main_menu_bg_container
		text = <version_string_display>
		font = <main_menu_font>
		Pos = (130.0, 600.0)
		Scale = (0.5, 0.5)
		rgba = ($menu_text_color)
		just = [ Left top ]
		font_spacing = 0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [ 0 0 0 255 ]
		z_priority = 60
	}
	CreateScreenElement \{Type = SpriteElement Id = #"0xe8054a04" PARENT = main_menu_bg_container texture = #"0xe8054a04" Pos = (335.0, 0.0) dims = (720.0, 720.0) just = [ Left top ] z_priority = 1}
	RunScriptOnScreenElement Id = #"0xe8054a04" glow_menu_element Params = {Time = 1 Id = <Id>}
	CreateScreenElement \{Type = SpriteElement PARENT = main_menu_bg_container texture = #"0xf4e50517" Pos = (0.0, 0.0) dims = (1280.0, 720.0) just = [ Left top ] z_priority = 2}
	CreateScreenElement \{Type = SpriteElement Id = eyes_BL PARENT = main_menu_bg_container texture = #"0xac82272b" Pos = (93.0, 676.0) dims = (128.0, 64.0) just = [ center center ] z_priority = 3}
	RunScriptOnScreenElement Id = eyes_BL glow_menu_element Params = {Time = 1.0 Id = <Id>}
	CreateScreenElement \{Type = SpriteElement Id = eyes_BR PARENT = main_menu_bg_container texture = #"0x568d1a48" Pos = (1176.0, 659.0) dims = (128.0, 64.0) just = [ center center ] z_priority = 3}
	RunScriptOnScreenElement Id = eyes_BR glow_menu_element Params = {Time = 1.0 Id = <Id>}
	CreateScreenElement \{Type = SpriteElement Id = eyes_C PARENT = main_menu_bg_container texture = #"0x49d95bd1" Pos = (406.0, 398.0) dims = (128.0, 64.0) just = [ center center ] z_priority = 3}
	RunScriptOnScreenElement Id = eyes_C glow_menu_element Params = {Time = 1.5 Id = <Id>}
	CreateScreenElement \{Type = SpriteElement Id = eyes_TL PARENT = main_menu_bg_container texture = #"0xb01a92fc" Pos = (271.0, 215.0) dims = (128.0, 64.0) just = [ center center ] z_priority = 3}
	RunScriptOnScreenElement Id = eyes_TL glow_menu_element Params = {Time = 1.7 Id = <Id>}
	CreateScreenElement \{Type = SpriteElement Id = eyes_TR PARENT = main_menu_bg_container texture = #"0x4a15af9f" Pos = (995.0, 71.0) dims = (128.0, 64.0) just = [ center center ] z_priority = 3}
	RunScriptOnScreenElement Id = eyes_TR glow_menu_element Params = {Time = 1.0 Id = <Id>}
endscript

script WinPortCreateLaptopUi
	z = 1000000
	CreateScreenElement {
		Type = SpriteElement
		Id = batteryElem
		PARENT = root_window
		texture = #"0x013e3f9b"
		Pos = (65.0, 721.0)
		Scale = (0.6600000262260437, 0.6600000262260437)
		just = [ Left bottom ]
		z_priority = <z>
		Hide
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = batteryLevelElem
		PARENT = root_window
		texture = #"0xb701b78f"
		Pos = (65.0, 721.0)
		Scale = (0.6600000262260437, 0.6600000262260437)
		just = [ Left bottom ]
		z_priority = (<z> - 1)
		Hide
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = wirelessElem
		PARENT = root_window
		texture = #"0xdca434cd"
		Pos = (1201.0, 716.0)
		Scale = (0.6600000262260437, 0.6600000262260437)
		just = [ Right bottom ]
		z_priority = <z>
		Hide
	}
	spawnscriptnow \{ WinPortUpdateLaptopUi }
endscript

script WinPortUpdateLaptopUi
	begin
		WinPortGetLaptopInfo
		if (<batteryPercent> > -1)
			if (<batteryCharging> = 1)
				SetScreenElementProps \{ Id = batteryElem Unhide texture = #"0x013e3f9b" }
			else
				SetScreenElementProps \{ Id = batteryElem Unhide texture = #"0x2fd10b51" }
			endif
			MathFloor ((<batteryPercent> + 1)/ 12.5)
			FormatText ChecksumName = batteryLevelImage 'battery_level%a' a = <floor>
			SetScreenElementProps Id = batteryLevelElem Unhide texture = <batteryLevelImage>
		else
			SetScreenElementProps \{ Id = batteryElem Hide }
			SetScreenElementProps \{ Id = batteryLevelElem Hide }
		endif
		if (<wirelessPercent> > -1)
			MathFloor ((<wirelessPercent> + 1)/ 20)
			FormatText ChecksumName = wirelessImage 'wifi_bar%a' a = <floor>
			SetScreenElementProps Id = wirelessElem Unhide texture = <wirelessImage>
		else
			SetScreenElementProps \{ Id = wirelessElem Hide }
		endif
		wait \{ 5 seconds }
	repeat
endscript
main_menu_movie_first_time = 1
main_menu_created = 0

script create_main_menu
	if IsWinPort
		shut_down_net_play
		if ($main_menu_created = 0)
			if WinPortSioIsKeyboard \{ deviceNum = $primary_controller }
				SetGlobalTags \{user_options Params = { lefty_flip_p1 = 1 }}
			else
				guitarCount = 0
				if IsGuitarController \{ controller = 0 }
					guitarCount = (<guitarCount> + 1)
				endif
				if IsGuitarController \{ controller = 1 }
					guitarCount = (<guitarCount> + 1)
				endif
				if IsGuitarController \{ controller = 2 }
					guitarCount = (<guitarCount> + 1)
				endif
				if (<guitarCount> < 2)
					SetGlobalTags \{user_options Params = { lefty_flip_p2 = 1 }}
				endif
			endif
			WinPortCreateLaptopUi
		endif
	endif
	Change \{ winport_is_in_online_menu_system = 0 }
	Change \{ main_menu_created = 1 }
	GetGlobalTags \{ user_options }
	menu_audio_settings_update_guitar_volume vol = <guitar_volume>
	menu_audio_settings_update_band_volume vol = <band_volume>
	menu_audio_settings_update_sfx_volume vol = <sfx_volume>
	SetSoundBussParams {Crowd = {vol = ($Default_BussSet.Crowd.vol)}}
	if ($main_menu_movie_first_time = 0)
		fadetoblack \{ ON Time = 0 Alpha = 1.0 z_priority = 900 }
	endif
	create_main_menu_backdrop
	if ($main_menu_movie_first_time = 0 & $invite_controller = -1)
		PlayMovieAndWait \{ movie = 'GH3_Intro' noblack noletterbox }
		Change \{ main_menu_movie_first_time = 1 }
		fadetoblack \{ OFF Time = 0 }
	endif
	SetMenuAutoRepeatTimes \{ (0.30000001192092896, 0.05000000074505806) }
	kill_start_key_binding
	UnPauseGame
	Change \{ current_num_players = 1 }
	Change StructureName = player1_status controller = ($primary_controller)
	Change \{ player_controls_valid = 0 }
	disable_pause
	spawnscriptnow \{ Menu_Music_On }
	if ($is_demo_mode = 1)
		demo_mode_disable = {rgba = [ 128 128 128 255 ] not_focusable}
	else
		demo_mode_disable = {}
	endif
	DeRegisterAtoms
	RegisterAtoms \{ name = achievement $Achievement_Atoms }
	Change \{ setlist_previous_tier = 1 }
	Change \{ setlist_previous_song = 0 }
	Change \{ setlist_previous_tab = tab_setlist }
	Change \{ current_song = welcometothejungle }
	Change \{ end_credits = 0 }
	Change \{ battle_sudden_death = 0 }
	Change \{ StructureName = player1_status character_id = Axel }
	Change \{ StructureName = player2_status character_id = Axel }
	Change \{default_menu_focus_color = [ 125 0 0 255 ]}
	Change \{ default_menu_unfocus_color = $menu_text_color }
	safe_create_gh3_pause_menu
	base_menu_pos = (730.0, 90.0)
	main_menu_font = fontgrid_title_gh3
	new_menu scrollid = main_menu_scrolling_menu vmenuid = vmenu_main_menu use_backdrop = (0)menu_pos = (<base_menu_pos>)
	Change \{ rich_presence_context = presence_main_menu }
	career_text_off = (-30.0, 0.0)
	career_text_scale = (1.5499999523162842, 1.4499999284744263)
	coop_career_text_off = (<career_text_off> + (30.0, 63.0))
	coop_career_text_scale = (0.800000011920929, 0.8999999761581421)
	quickplay_text_off = (<coop_career_text_off> + (-35.0, 40.0))
	quickplay_text_scale = (1.649999976158142, 1.5499999523162842)
	multiplayer_text_off = (<quickplay_text_off> + (-40.0, 65.0))
	multiplayer_text_scale = (1.2000000476837158, 1.100000023841858)
	training_text_off = (<multiplayer_text_off> + (60.0, 47.0))
	training_text_scale = (1.5, 1.5)
	options_text_off = (<training_text_off> + (-20.0, 63.0))
	options_text_scale = (1.2000000476837158, 1.100000023841858)
	leaderboards_text_off = (<options_text_off> + (20.0, 48.0))
	leaderboards_text_scale = (1.100000023841858, 1.0)
	exit_text_off = (<leaderboards_text_off> + (-20.0, 65.0))
	exit_text_scale = (1.100000023841858, 1.0)
	debug_menu_text_off = (<exit_text_off> + (0.0, 160.0))
	debug_menu_text_scale = 0.8
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_career_text
		PARENT = main_menu_text_container
		text = "CAREER"
		font = <main_menu_font>
		Pos = {(<career_text_off>)relative}
		Scale = (<career_text_scale>)
		rgba = ($menu_text_color)
		just = [ Left top ]
		font_spacing = 0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [ 0 0 0 255 ]
		z_priority = 60
		<demo_mode_disable>
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 420)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> dims = ((420.0, 0.0) + <height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_coop_career_text
		PARENT = main_menu_text_container
		text = "CO-OP CAREER"
		font = <main_menu_font>
		Pos = {(<coop_career_text_off>)relative}
		Scale = (<coop_career_text_scale>)
		rgba = ($menu_text_color)
		just = [ Left top ]
		font_spacing = 0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [ 0 0 0 255 ]
		z_priority = 60
		<demo_mode_disable>
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 400)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> dims = ((400.0, 0.0) + <height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_quickplay_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		text = "QUICKPLAY"
		font_spacing = 0
		Pos = {(<quickplay_text_off>)relative}
		Scale = (<quickplay_text_scale>)
		rgba = ($menu_text_color)
		just = [ Left top ]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [ 0 0 0 255 ]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 400)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> dims = ((400.0, 0.0) + <height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_multiplayer_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		text = "MULTIPLAYER"
		font_spacing = 1
		Pos = {(<multiplayer_text_off>)relative}
		Scale = (<multiplayer_text_scale>)
		rgba = ($menu_text_color)
		just = [ Left top ]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [ 0 0 0 255 ]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 460)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> dims = ((460.0, 0.0) + <height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_training_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		text = "TRAINING"
		font_spacing = 0
		Pos = {(<training_text_off>)relative}
		Scale = (<training_text_scale>)
		rgba = ($menu_text_color)
		just = [ Left top ]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [ 0 0 0 255 ]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 345)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> dims = ((345.0, 0.0) + <height> * (0.0, 1.0))
	endif
	GetScreenElementDims \{ Id = main_menu_training_text }
	old_height = <height>
	fit_text_in_rectangle Id = main_menu_training_text dims = (350.0, 100.0) Pos = {(<training_text_off>)relative}start_x_scale = (<training_text_scale>.(1.0, 0.0))start_y_scale = (<training_text_scale>.(0.0, 1.0))only_if_larger_x = 1 keep_ar = 1
	GetScreenElementDims \{ Id = main_menu_training_text }
	offset = ((<old_height> * ((<old_height> -24.0)/ <old_height>))- (<height> * ((<height> - (24.0 * ((1.0 * <height>)/ <old_height>)))/ <height>)))
	leaderboards_text_off = (<leaderboards_text_off> - <offset> * (0.0, 1.0))
	options_text_off = (<options_text_off> - <offset> * (0.0, 1.0))
	if IsXenon
		CreateScreenElement {
			Type = TextElement
			Id = main_menu_leaderboards_text
			PARENT = main_menu_text_container
			font = <main_menu_font>
			text = "ONLINE"
			font_spacing = 0
			Pos = {(<leaderboards_text_off>)relative}
			Scale = (<leaderboards_text_scale>)
			rgba = ($menu_text_color)
			just = [ Left top ]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [ 0 0 0 255 ]
			z_priority = 60
			<demo_mode_disable>
		}
		GetScreenElementDims Id = <Id>
		if (<width> > 360)
			SetScreenElementProps Id = <Id> Scale = 1
			fit_text_in_rectangle Id = <Id> dims = ((360.0, 0.0) + <height> * (0.0, 1.0))
		endif
	else
		CreateScreenElement {
			Type = TextElement
			Id = main_menu_leaderboards_text
			PARENT = main_menu_text_container
			font = <main_menu_font>
			text = "ONLINE"
			font_spacing = 0
			Pos = {(<leaderboards_text_off>)relative}
			Scale = (<leaderboards_text_scale>)
			rgba = ($menu_text_color)
			just = [ Left top ]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [ 0 0 0 255 ]
			z_priority = 60
			<demo_mode_disable>
		}
		GetScreenElementDims Id = <Id>
		if (<width> > 360)
			SetScreenElementProps Id = <Id> Scale = 1
			fit_text_in_rectangle Id = <Id> dims = ((360.0, 0.0) + <height> * (0.0, 1.0))
		endif
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_options_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		text = "OPTIONS"
		font_spacing = 0
		Pos = {(<options_text_off>)relative}
		Scale = (<options_text_scale>)
		rgba = ($menu_text_color)
		just = [ Left top ]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [ 0 0 0 255 ]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 420)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> dims = ((420.0, 0.0) + <height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_exit_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		text = "EXIT"
		font_spacing = 0
		Pos = {(<exit_text_off>)relative}
		Scale = (<exit_text_scale>)
		rgba = ($menu_text_color)
		just = [ Left top ]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [ 0 0 0 255 ]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 420)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> dims = ((420.0, 0.0) + <height> * (0.0, 1.0))
	endif
	if ($enable_button_cheats = 1)
		CreateScreenElement {
			Type = TextElement
			Id = main_menu_debug_menu_text
			PARENT = main_menu_text_container
			font = <main_menu_font>
			text = "DEBUG MENU"
			Pos = {(<debug_menu_text_off>)relative}
			Scale = (<debug_menu_text_scale>)
			rgba = ($menu_text_color)
			just = [ Left top ]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [ 0 0 0 255 ]
			z_priority = 60
		}
	endif
	offWhite = [ 255 255 205 255 ]
	hilite_off = (5.0, 0.0)
	gm_hlInfoList = [
		{
			posL = (<career_text_off> + <hilite_off> + (-40.0, 9.0))
			posR = (<career_text_off> + <hilite_off> + (218.0, 9.0))
			beDims = (40.0, 40.0)
			posH = (<career_text_off> + <hilite_off> + (-14.0, -2.0))
			hDims = (240.0, 57.0)
		},
		{
			posL = (<coop_career_text_off> + <hilite_off> + (-33.0, 3.0))
			posR = (<coop_career_text_off> + <hilite_off> + (281.0, 3.0))
			beDims = (32.0, 32.0)
			posH = (<coop_career_text_off> + <hilite_off> + (-14.0, -1.0))
			hDims = (300.0, 37.0)
		},
		{
			posL = (<quickplay_text_off> + <hilite_off> + (-34.0, 4.0))
			posR = (<quickplay_text_off> + <hilite_off> + (251.0, 4.0))
			beDims = (40.0, 40.0)
			posH = (<quickplay_text_off> + <hilite_off> + (-14.0, -2.0))
			hDims = (267.0, 47.0)
		},
		{
			posL = (<multiplayer_text_off> + <hilite_off> + (-37.0, 4.0))
			posR = (<multiplayer_text_off> + <hilite_off> + (301.0, 4.0))
			beDims = (38.0, 38.0)
			posH = (<multiplayer_text_off> + <hilite_off> + (-14.0, -1.0))
			hDims = (320.0, 43.0)
		},
		{
			posL = (<training_text_off> + <hilite_off> + (-31.0, 9.0))
			posR = (<training_text_off> + <hilite_off> + (282.0, 9.0))
			beDims = (42.0, 42.0)
			posH = (<training_text_off> + <hilite_off> + (-13.0, -2.0))
			hDims = (295.0, 61.0)
		},
		{
			posL = (<leaderboards_text_off> + <hilite_off> + (-33.0, 3.0))
			posR = (<leaderboards_text_off> + <hilite_off> + (213.0, 3.0))
			beDims = (34.0, 34.0)
			posH = (<leaderboards_text_off> + <hilite_off> + (-13.0, -2.0))
			hDims = (232.0, 40.0)
		},
		{
			posL = (<options_text_off> + <hilite_off> + (-36.0, 5.0))
			posR = (<options_text_off> + <hilite_off> + (183.0, 5.0))
			beDims = (36.0, 36.0)
			posH = (<options_text_off> + <hilite_off> + (-14.0, 0.0))
			hDims = (205.0, 43.0)
		},
		{
			posL = (<exit_text_off> + <hilite_off> + (-36.0, 5.0))
			posR = (<exit_text_off> + <hilite_off> + (183.0, 5.0))
			beDims = (36.0, 36.0)
			posH = (<exit_text_off> + <hilite_off> + (-12.0, 0.0))
			hDims = (205.0, 43.0)
		}
	]
	<gm_hlIndex> = 0
	displaySprite {
		PARENT = main_menu_text_container
		tex = character_hub_hilite_bookend
		Pos = ((<gm_hlInfoList> [ <gm_hlIndex> ]).posL)
		dims = ((<gm_hlInfoList> [ <gm_hlIndex> ]).beDims)
		rgba = <offWhite>
		z = 2
	}
	<bookEnd1ID> = <Id>
	displaySprite {
		PARENT = main_menu_text_container
		tex = character_hub_hilite_bookend
		Pos = ((<gm_hlInfoList> [ <gm_hlIndex> ]).posR)
		dims = ((<gm_hlInfoList> [ <gm_hlIndex> ]).beDims)
		rgba = <offWhite>
		z = 2
	}
	<bookEnd2ID> = <Id>
	displaySprite {
		PARENT = main_menu_text_container
		tex = White
		rgba = <offWhite>
		Pos = ((<gm_hlInfoList> [ <gm_hlIndex> ]).posH)
		dims = ((<gm_hlInfoList> [ <gm_hlIndex> ]).hDims)
		z = 2
	}
	<whiteTexHighlightID> = <Id>
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = { Id = main_menu_career_text }}
			{Focus SetScreenElementProps Params = { Id = main_menu_career_text no_shadow }}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 0
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_career_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_career_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [ 0 0 0 255 ]}}
			{unfocus retail_menu_unfocus Params = { Id = main_menu_career_text }}
			{ pad_choose main_menu_select_career }
		]
		z_priority = -1
		<demo_mode_disable>
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = { Id = main_menu_coop_career_text }}
			{Focus SetScreenElementProps Params = { Id = main_menu_coop_career_text no_shadow }}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 1
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_coop_career_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_coop_career_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [ 0 0 0 255 ]}}
			{unfocus retail_menu_unfocus Params = { Id = main_menu_coop_career_text }}
			{ pad_choose main_menu_select_coop_career }
		]
		z_priority = -1
		<demo_mode_disable>
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = { Id = main_menu_quickplay_text }}
			{Focus SetScreenElementProps Params = { Id = main_menu_quickplay_text no_shadow }}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 2
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_quickplay_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_quickplay_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [ 0 0 0 255 ]}}
			{unfocus retail_menu_unfocus Params = { Id = main_menu_quickplay_text }}
			{ pad_choose main_menu_select_quickplay }
		]
		z_priority = -1
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = { Id = main_menu_multiplayer_text }}
			{Focus SetScreenElementProps Params = { Id = main_menu_multiplayer_text no_shadow }}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 3
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_multiplayer_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_multiplayer_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [ 0 0 0 255 ]}}
			{unfocus retail_menu_unfocus Params = { Id = main_menu_multiplayer_text }}
			{ pad_choose main_menu_select_multiplayer }
		]
		z_priority = -1
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = { Id = main_menu_training_text }}
			{Focus SetScreenElementProps Params = { Id = main_menu_training_text no_shadow }}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 4
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_training_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_training_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [ 0 0 0 255 ]}}
			{unfocus retail_menu_unfocus Params = { Id = main_menu_training_text }}
			{ pad_choose main_menu_select_training }
		]
		z_priority = -1
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = { Id = main_menu_options_text }}
			{Focus SetScreenElementProps Params = { Id = main_menu_options_text no_shadow }}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 6
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_options_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_options_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [ 0 0 0 255 ]}}
			{unfocus retail_menu_unfocus Params = { Id = main_menu_options_text }}
			{ pad_choose main_menu_select_options }
		]
		z_priority = -1
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = { Id = main_menu_leaderboards_text }}
			{Focus SetScreenElementProps Params = { Id = main_menu_leaderboards_text no_shadow }}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 5
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_leaderboards_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_leaderboards_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [ 0 0 0 255 ]}}
			{unfocus retail_menu_unfocus Params = { Id = main_menu_leaderboards_text }}
			{ pad_choose main_menu_select_winport_online }
		]
		z_priority = -1
		<demo_mode_disable>
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		text = "Exit placeholder"
		event_handlers = [
			{Focus retail_menu_focus Params = { Id = main_menu_exit_text }}
			{Focus SetScreenElementProps Params = { Id = main_menu_exit_text no_shadow }}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 7
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_exit_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_exit_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [ 0 0 0 255 ]}}
			{unfocus retail_menu_unfocus Params = { Id = main_menu_exit_text }}
			{ pad_choose main_menu_select_exit }
		]
		z_priority = -1
	}
	if ($enable_button_cheats = 1)
		CreateScreenElement {
			Type = TextElement
			PARENT = vmenu_main_menu
			font = <main_menu_font>
			text = ""
			event_handlers = [
				{Focus retail_menu_focus Params = { Id = main_menu_debug_menu_text }}
				{Focus guitar_menu_highlighter Params = {
						zPri = -2
						hlIndex = 0
						hlInfoList = <gm_hlInfoList>
						be1ID = <bookEnd1ID>
						be2ID = <bookEnd2ID>
						wthlID = <whiteTexHighlightID>
					}
				}
				{unfocus retail_menu_unfocus Params = { Id = main_menu_debug_menu_text }}
				{pad_choose ui_flow_manager_respond_to_action Params = { action = select_debug_menu }}
			]
			z_priority = -1
		}
	endif
	if ($new_message_of_the_day = 1)
		spawnscriptnow \{ pop_in_new_downloads_notifier }
	endif
	Change \{user_control_pill_text_color = [ 0 0 0 255 ]}
	Change \{user_control_pill_color = [ 180 180 180 255 ]}
	add_user_control_helper \{ text = "SELECT" button = Green z = 100 }
	add_user_control_helper \{ text = "UP/DOWN" button = strumbar z = 100 }
	if NOT ($invite_controller = -1)
		Change \{ invite_controller = -1 }
		ui_flow_manager_respond_to_action \{ action = select_xbox_live }
		fadetoblack \{ OFF Time = 0 }
	else
		LaunchEvent \{ Type = Focus Target = vmenu_main_menu }
	endif
endscript

script guitar_menu_highlighter \{ zPri = 50 }
	if GotParam \{ text_id }
		GetScreenElementDims Id = <text_id>
		hilite_dims = (<width> * (1.0, 0.0) + <height> * (0.0, 0.699999988079071) + (20.0, -1.0))
		bookend_dims = (<height> * (0.5, 0.5))
		hilite_pos = ((<hlInfoList> [ <hlIndex> ]).posH - (5.0, 0.0))
		SetScreenElementProps {
			Id = <wthlID>
			Pos = <hilite_pos>
			dims = <hilite_dims>
			z_priority = <zPri>
		}
		SetScreenElementProps {
			Id = <be1ID>
			Pos = (<hilite_pos> - <bookend_dims>.(1.0, 0.0) * (0.6000000238418579, 0.0) + <height> * (0.0, 0.10000000149011612))
			dims = <bookend_dims>
			z_priority = <zPri>
		}
		SetScreenElementProps {
			Id = <be2ID>
			Pos = (<hilite_pos> + (<hilite_dims>.(1.0, 0.0) * (1.0, 0.0))+ <height> * (0.0, 0.10000000149011612) - (<bookend_dims>.(1.0, 0.0) * (0.10000000149011612, 0.0)))
			dims = <bookend_dims>
			z_priority = <zPri>
			flip_h
		}
	else
		SetScreenElementProps {
			Id = <be1ID>
			Pos = ((<hlInfoList> [ <hlIndex> ]).posL)
			dims = ((<hlInfoList> [ <hlIndex> ]).beDims)
			z_priority = <zPri>
		}
		SetScreenElementProps {
			Id = <be2ID>
			Pos = ((<hlInfoList> [ <hlIndex> ]).posR)
			dims = ((<hlInfoList> [ <hlIndex> ]).beDims)
			z_priority = <zPri>
		}
		SetScreenElementProps {
			Id = <wthlID>
			Pos = ((<hlInfoList> [ <hlIndex> ]).posH)
			dims = ((<hlInfoList> [ <hlIndex> ]).hDims)
			z_priority = <zPri>
		}
	endif
endscript

script glow_new_downloads_text
	begin
		if ScreenElementExists \{ Id = new_downloads_text_glow }
			new_downloads_text_glow ::DoMorph Alpha = 0 Time = <Time>
		endif
		if ScreenElementExists \{ Id = new_downloads_text_glow }
			new_downloads_text_glow ::DoMorph Alpha = 1 Time = <Time>
		endif
	repeat
endscript

script pop_in_new_downloads_notifier \{ Time = 0.5 }
	wait \{ 0.5 Second }
	if NOT ScreenElementExists \{ Id = main_menu_text_container }
		return
	endif
	Pos = (100.0, 390.0)
	text = "NEW	 DOWNLOADABLE  CONTENT!"
	CreateScreenElement {
		Type = TextElement
		PARENT = main_menu_text_container
		text = <text>
		Scale = 0.5
		rgba = [ 255 255 205 255 ]
		just = [ center center ]
		font_spacing = 5
		font = text_a3
		Pos = <Pos>
		z_priority = 5
		Alpha = 0
	}
	GetScreenElementDims Id = <Id>
	if (<width> >= 500)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> only_if_larger_x = 1 dims = ((500.0, 0.0) + <height> * (0.0, 1.0))keep_ar = 1
	endif
	DoScreenElementMorph Id = <Id> Alpha = 1 Time = <Time>
	CreateScreenElement {
		Type = TextElement
		PARENT = main_menu_text_container
		Id = new_downloads_text_glow
		text = <text>
		Scale = 0.5
		rgba = [ 255 255 255 255 ]
		font = text_a3
		just = [ center center ]
		font_spacing = 5
		Pos = <Pos>
		z_priority = 6
		Alpha = 0
	}
	GetScreenElementDims Id = <Id>
	if (<width> >= 500)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> only_if_larger_x = 1 dims = ((500.0, 0.0) + <height> * (0.0, 1.0))keep_ar = 1
	endif
	DoScreenElementMorph Id = <Id> Alpha = 1 Time = <Time>
	displaySprite {
		PARENT = main_menu_text_container
		tex = White
		Pos = (<Pos>)
		just = [ center center ]
		rgba = [ 170 90 35 255 ]
		z = 4
		dims = ((<width> + 20)* (1.0, 0.0) + (0.0, 1.0) * (<height> + 10))
		Alpha = 0
	}
	DoScreenElementMorph Id = <Id> Alpha = 1 Time = <Time>
	displaySprite {
		PARENT = main_menu_text_container
		tex = character_hub_hilite_bookend
		just = [ Right center ]
		rgba = [ 170 90 35 255 ]
		z = 4
		Pos = ((<Pos>)- <width> * (0.5, 0.0) - (6.0, 1.0))
		dims = (<height> * (1.0, 1.0))
		flip_v
		Alpha = 0
	}
	DoScreenElementMorph Id = <Id> Alpha = 1 Time = <Time>
	displaySprite {
		PARENT = main_menu_text_container
		tex = character_hub_hilite_bookend
		just = [ Left center ]
		rgba = [ 170 90 35 255 ]
		z = 4
		Pos = ((<Pos>)+ <width> * (0.5, 0.0) + (6.0, 1.0))
		dims = (<height> * (1.0, 1.0))
		Alpha = 0
	}
	DoScreenElementMorph Id = <Id> Alpha = 1 Time = <Time>
	spawnscriptnow \{glow_new_downloads_text Params = { Time = 0.75 }}
endscript

script glow_menu_element \{ Time = 1 }
	if NOT ScreenElementExists Id = <Id>
		return
	endif
	wait randomrange (0.0, 2.0) seconds
	begin
		<Id> ::DoMorph Alpha = 1 Time = <Time> Motion = smooth
		<Id> ::DoMorph Alpha = 0 Time = <Time> Motion = smooth
	repeat
endscript

script destroy_main_menu
	killspawnedscript \{ name = pop_in_new_downloads_notifier }
	killspawnedscript \{ name = glow_new_downloads_text }
	clean_up_user_control_helpers
	Change \{default_menu_focus_color = [ 210 210 210 250 ]}
	Change \{default_menu_unfocus_color = [ 210 130 0 250 ]}
	PrintStruct X = ($ui_flow_manager_state)
	destroy_menu \{ menu_id = main_menu_scrolling_menu }
	destroy_menu \{ menu_id = main_menu_text_container }
	destroy_menu_backdrop
	DestroyScreenElement \{ Id = main_menu_bg_container }
endscript

script main_menu_select_career
	Change \{ game_mode = p1_career }
	Change \{ current_num_players = 1 }
	Change \{ StructureName = player1_status part = guitar }
	Change \{ StructureName = player2_status part = guitar }
	ui_flow_manager_respond_to_action \{ action = select_career }
endscript

script main_menu_select_coop_career
	Change \{ game_mode = p2_career }
	Change \{ current_num_players = 2 }
	ui_flow_manager_respond_to_action \{ action = select_coop_career }
endscript

script main_menu_select_quickplay
	Change \{ game_mode = p1_quickplay }
	Change \{ current_num_players = 1 }
	Change \{ StructureName = player1_status part = guitar }
	Change \{ StructureName = player2_status part = guitar }
	ui_flow_manager_respond_to_action \{ action = select_quickplay }
endscript

script main_menu_select_multiplayer
	Change \{ game_mode = p2_faceoff }
	Change \{ current_num_players = 2 }
	Change \{ StructureName = player1_status part = guitar }
	Change \{ StructureName = player2_status part = guitar }
	ui_flow_manager_respond_to_action \{ action = select_multiplayer }
endscript

script main_menu_select_training
	Change \{ game_mode = training }
	Change \{ current_num_players = 1 }
	Change \{ came_to_practice_from = main_menu }
	Change \{ StructureName = player1_status part = guitar }
	Change \{ StructureName = player2_status part = guitar }
	ui_flow_manager_respond_to_action \{ action = select_training }
endscript

script main_menu_select_xbox_live
	ui_flow_manager_respond_to_action \{ action = select_xbox_live }
endscript
winport_is_in_online_menu_system = 0

script main_menu_select_winport_online
	Change \{ winport_is_in_online_menu_system = 1 }
	ui_flow_manager_respond_to_action \{ action = select_winport_online }
endscript

script main_menu_select_exit
	ui_flow_manager_respond_to_action \{ action = select_winport_exit }
endscript

script main_menu_select_options
	ui_flow_manager_respond_to_action \{ action = select_options }
endscript

script create_play_song_menu
endscript

script destroy_play_song_menu
endscript

script isSinglePlayerGame
	if ($game_mode = p1_career || $game_mode = p1_quickplay || $game_mode = training)
		return \{ TRUE }
	else
		return \{ FALSE }
	endif
endscript
winport_in_top_pause_menu = 0

script create_pause_menu \{ Player = 1 for_options = 0 for_practice = 0 }
	player_device = ($last_start_pressed_device)
	if ($player1_device = <player_device>)
		<Player> = 1
	else
		<Player> = 2
	endif
	Change \{user_control_pill_text_color = [ 0 0 0 255 ]}
	Change \{user_control_pill_color = [ 180 180 180 255 ]}
	if (<for_options> = 0)
		if ($view_mode)
			return
		endif
		enable_pause
		safe_create_gh3_pause_menu
	else
		kill_start_key_binding
		flame_handlers = [
			{pad_back ui_flow_manager_respond_to_action Params = { action = go_back }}
		]
	endif
	if IsWinPort
		Change \{ winport_in_top_pause_menu = 1 }
	endif
	Change \{ bunny_flame_index = 1 }
	pause_z = 10000
	spacing = -65
	if (<for_options> = 0)
		menu_pos = (730.0, 220.0)
		if (<for_practice> = 1)
			<menu_pos> = (640.0, 190.0)
			<spacing> = -65
		endif
	else
		<spacing> = -65
		if IsGuitarController controller = <player_device>
			if WinPortSioIsKeyboard deviceNum = <player_device>
				menu_pos = (640.0, 260.0)
			else
				menu_pos = (640.0, 225.0)
			endif
		else
			menu_pos = (640.0, 260.0)
		endif
	endif
	new_menu {
		scrollid = scrolling_pause
		vmenuid = vmenu_pause
		menu_pos = <menu_pos>
		rot_angle = 2
		event_handlers = <flame_handlers>
		spacing = <spacing>
		use_backdrop = (0)
		exclusive_device = <player_device>
	}
	create_pause_menu_frame z = (<pause_z> - 10)
	if ($is_network_game = 0)
		CreateScreenElement {
			Type = SpriteElement
			PARENT = pause_menu_frame_container
			texture = menu_pause_frame_banner
			Pos = (640.0, 540.0)
			just = [ center center ]
			z_priority = (<pause_z> + 100)
		}
		if GotParam \{ banner_text }
			pause_player_text = <banner_text>
			if GotParam \{ banner_scale }
				pause_player_scale = <banner_scale>
			else
				pause_player_scale = (1.0, 1.0)
			endif
		else
			if (<for_options> = 0)
				if (<for_practice> = 1)
					<pause_player_text> = "PAUSED"
				else
					if NOT isSinglePlayerGame
						FormatText textname = pause_player_text "P%d PAUSED" d = <Player>
					else
						<pause_player_text> = "PAUSED"
					endif
				endif
				pause_player_scale = (0.6000000238418579, 0.75)
			else
				pause_player_text = "OPTIONS"
				pause_player_scale = (0.75, 0.75)
			endif
		endif
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = <Id>
		text = <pause_player_text>
		font = text_a6
		Pos = (125.0, 53.0)
		Scale = <pause_player_scale>
		rgba = [ 170 90 30 255 ]
		Scale = 0.8
	}
	text_scale = (0.8999999761581421, 0.8999999761581421)
	if (<for_options> = 0 & <for_practice> = 0)
		CreateScreenElement {
			Type = ContainerElement
			PARENT = pause_menu_frame_container
			Id = bunny_container
			Pos = (380.0, 170.0)
			just = [ Left top ]
			z_priority = <pause_z>
		}
		i = 1
		begin
			FormatText ChecksumName = bunny_id 'pause_bunny_flame_%d' d = <i>
			FormatText ChecksumName = bunny_tex 'GH3_Pause_Bunny_Flame%d' d = <i>
			CreateScreenElement {
				Type = SpriteElement
				Id = <bunny_id>
				PARENT = bunny_container
				Pos = (160.0, 170.0)
				texture = <bunny_tex>
				rgba = [ 255 255 255 255 ]
				dims = (300.0, 300.0)
				just = [ Right bottom ]
				z_priority = (<pause_z> + 3)
				rot_angle = 5
			}
			if (<i> > 1)
				DoScreenElementMorph Id = <bunny_id> Alpha = 0
			endif
			<i> = (<i> + 1)
		repeat 7
		CreateScreenElement {
			Type = SpriteElement
			Id = pause_bunny_shadow
			PARENT = bunny_container
			texture = GH3_Pause_Bunny
			rgba = [ 0 0 0 128 ]
			Pos = (20.0, -110.0)
			dims = (550.0, 550.0)
			just = [ center top ]
			z_priority = (<pause_z> + 4)
		}
		CreateScreenElement {
			Type = SpriteElement
			Id = pause_bunny
			PARENT = bunny_container
			texture = GH3_Pause_Bunny
			rgba = [ 255 255 255 255 ]
			Pos = (0.0, -130.0)
			dims = (550.0, 550.0)
			just = [ center top ]
			z_priority = (<pause_z> + 5)
		}
		RunScriptOnScreenElement \{Id = bunny_container bunny_hover Params = { hover_origin = (380.0, 170.0) }}
	endif
	container_params = {Type = ContainerElement PARENT = vmenu_pause dims = (0.0, 100.0)}
	if (<for_options> = 0)
		if (<for_practice> = 1)
			if English
			else
				text_scale = (0.7199999690055847, 0.7199999690055847)
			endif
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = { Id = pause_resume }}
					{unfocus retail_menu_unfocus Params = { Id = pause_resume }}
					{ pad_choose gh3_start_pressed }
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = [ 210 130 0 250 ]
				Id = pause_resume
				text = "RESUME"
				just = [ center top ]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [ 0 0 0 255 ]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = { Id = pause_restart }}
					{unfocus retail_menu_unfocus Params = { Id = pause_restart }}
					{pad_choose ui_flow_manager_respond_to_action Params = { action = select_restart }}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = [ 210 130 0 250 ]
				text = "RESTART"
				Id = pause_restart
				just = [ center top ]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [ 0 0 0 255 ]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = { Id = pause_options }}
					{unfocus retail_menu_unfocus Params = { Id = pause_options }}
					{pad_choose ui_flow_manager_respond_to_action Params = {action = select_options create_params = { player_device = <player_device> }}}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = [ 210 130 0 250 ]
				text = "OPTIONS"
				Id = pause_options
				just = [ center top ]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [ 0 0 0 255 ]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = { Id = pause_change_speed }}
					{unfocus retail_menu_unfocus Params = { Id = pause_change_speed }}
					{pad_choose ui_flow_manager_respond_to_action Params = { action = select_change_speed }}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = [ 210 130 0 250 ]
				text = "CHANGE SPEED"
				Id = pause_change_speed
				just = [ center top ]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [ 0 0 0 255 ]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = { Id = pause_change_section }}
					{unfocus retail_menu_unfocus Params = { Id = pause_change_section }}
					{pad_choose ui_flow_manager_respond_to_action Params = { action = select_change_section }}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = [ 210 130 0 250 ]
				text = "CHANGE SECTION"
				Id = pause_change_section
				just = [ center top ]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [ 0 0 0 255 ]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			if ($came_to_practice_from = main_menu)
				CreateScreenElement {
					<container_params>
					event_handlers = [
						{Focus retail_menu_focus Params = { Id = pause_new_song }}
						{unfocus retail_menu_unfocus Params = { Id = pause_new_song }}
						{pad_choose ui_flow_manager_respond_to_action Params = { action = select_new_song }}
					]
				}
				CreateScreenElement {
					Type = TextElement
					PARENT = <Id>
					font = fontgrid_title_gh3
					Scale = <text_scale>
					rgba = [ 210 130 0 250 ]
					text = "NEW SONG"
					Id = pause_new_song
					just = [ center top ]
					Shadow
					shadow_offs = (3.0, 3.0)
					shadow_rgba [ 0 0 0 255 ]
					z_priority = <pause_z>
					exclusive_device = <player_device>
				}
				GetScreenElementDims Id = <Id>
				fit_text_in_rectangle Id = <Id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			endif
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = { Id = pause_quit }}
					{unfocus retail_menu_unfocus Params = { Id = pause_quit }}
					{pad_choose ui_flow_manager_respond_to_action Params = { action = select_quit }}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = [ 210 130 0 250 ]
				text = "QUIT"
				Id = pause_quit
				just = [ center top ]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [ 0 0 0 255 ]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			add_user_control_helper \{ text = "SELECT" button = Green z = 100000 }
			add_user_control_helper \{ text = "UP/DOWN" button = strumbar z = 100000 }
		else
			if English
			else
				container_params = {Type = ContainerElement PARENT = vmenu_pause dims = (0.0, 105.0)}
				text_scale = (0.800000011920929, 0.800000011920929)
			endif
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = { Id = pause_resume }}
					{unfocus retail_menu_unfocus Params = { Id = pause_resume }}
					{ pad_choose gh3_start_pressed }
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = [ 210 130 0 250 ]
				text = "RESUME"
				Id = pause_resume
				just = [ center top ]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [ 0 0 0 255 ]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> dims = ((250.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			if ($is_network_game = 0)
				if NOT ($end_credits = 1)
					CreateScreenElement {
						<container_params>
						event_handlers = [
							{Focus retail_menu_focus Params = { Id = pause_restart }}
							{unfocus retail_menu_unfocus Params = { Id = pause_restart }}
							{pad_choose ui_flow_manager_respond_to_action Params = { action = select_restart }}
						]
					}
					CreateScreenElement {
						Type = TextElement
						PARENT = <Id>
						font = fontgrid_title_gh3
						Scale = <text_scale>
						rgba = [ 210 130 0 250 ]
						text = "RESTART"
						Id = pause_restart
						just = [ center top ]
						Shadow
						shadow_offs = (3.0, 3.0)
						shadow_rgba [ 0 0 0 255 ]
						z_priority = <pause_z>
						exclusive_device = <player_device>
					}
					GetScreenElementDims Id = <Id>
					fit_text_in_rectangle Id = <Id> dims = ((250.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
					if ($is_demo_mode = 1)
						demo_mode_disable = {rgba = [ 80 80 80 255 ] not_focusable}
					else
						demo_mode_disable = {}
					endif
					if (($game_mode = p1_career & $boss_battle = 0)|| ($game_mode = p1_quickplay))
						CreateScreenElement {
							<container_params>
							event_handlers = [
								{Focus retail_menu_focus Params = { Id = pause_practice }}
								{unfocus retail_menu_unfocus Params = { Id = pause_practice }}
								{pad_choose ui_flow_manager_respond_to_action Params = { action = select_practice }}
							]
						}
						CreateScreenElement {
							Type = TextElement
							PARENT = <Id>
							font = fontgrid_title_gh3
							Scale = <text_scale>
							rgba = [ 210 130 0 250 ]
							text = "PRACTICE"
							Id = pause_practice
							just = [ center top ]
							Shadow
							shadow_offs = (3.0, 3.0)
							shadow_rgba [ 0 0 0 255 ]
							z_priority = <pause_z>
							exclusive_device = <player_device>
						}
						GetScreenElementDims Id = <Id>
						fit_text_in_rectangle Id = <Id> dims = ((260.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
					endif
					CreateScreenElement {
						<container_params>
						event_handlers = [
							{Focus retail_menu_focus Params = { Id = pause_options }}
							{unfocus retail_menu_unfocus Params = { Id = pause_options }}
							{pad_choose ui_flow_manager_respond_to_action Params = {action = select_options create_params = { player_device = <player_device> }}}
						]
					}
					CreateScreenElement {
						Type = TextElement
						PARENT = <Id>
						font = fontgrid_title_gh3
						Scale = <text_scale>
						rgba = [ 210 130 0 250 ]
						text = "OPTIONS"
						Id = pause_options
						just = [ center top ]
						Shadow
						shadow_offs = (3.0, 3.0)
						shadow_rgba [ 0 0 0 255 ]
						z_priority = <pause_z>
						exclusive_device = <player_device>
					}
					GetScreenElementDims Id = <Id>
					fit_text_in_rectangle Id = <Id> dims = ((260.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
				endif
			endif
			quit_script = ui_flow_manager_respond_to_action
			quit_script_params = {action = select_quit create_params = { Player = <Player> }}
			if ($is_network_game)
				quit_script = create_leaving_lobby_dialog
				quit_script_params = {
					create_pause_menu
					pad_back_script = return_to_pause_menu_from_net_warning
					pad_choose_script = pause_menu_really_quit_net_game
					z = 300
				}
			endif
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = { Id = pause_quit }}
					{unfocus retail_menu_unfocus Params = { Id = pause_quit }}
					{pad_choose <quit_script> Params = <quit_script_params>}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = [ 210 130 0 250 ]
				text = "QUIT"
				Id = pause_quit
				just = [ center top ]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [ 0 0 0 255 ]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> dims = ((270.0, 0.0) + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			if ($enable_button_cheats = 1)
				CreateScreenElement {
					<container_params>
					event_handlers = [
						{Focus retail_menu_focus Params = { Id = pause_debug_menu }}
						{unfocus retail_menu_unfocus Params = { Id = pause_debug_menu }}
						{pad_choose ui_flow_manager_respond_to_action Params = { action = select_debug_menu }}
					]
				}
				CreateScreenElement {
					Type = TextElement
					PARENT = <Id>
					font = fontgrid_title_gh3
					Scale = <text_scale>
					rgba = [ 210 130 0 250 ]
					text = "DEBUG MENU"
					Id = pause_debug_menu
					just = [ center top ]
					Shadow
					shadow_offs = (3.0, 3.0)
					shadow_rgba [ 0 0 0 255 ]
					z_priority = <pause_z>
					exclusive_device = <player_device>
				}
			endif
			add_user_control_helper \{ text = "SELECT" button = Green z = 100000 }
			add_user_control_helper \{ text = "UP/DOWN" button = strumbar z = 100000 }
		endif
	else
		<fit_dims> = (400.0, 0.0)
		CreateScreenElement {
			Type = ContainerElement
			PARENT = vmenu_pause
			dims = (0.0, 100.0)
			event_handlers = [
				{Focus retail_menu_focus Params = { Id = options_audio }}
				{ Focus generic_menu_up_or_down_sound }
				{unfocus retail_menu_unfocus Params = { Id = options_audio }}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = select_audio_settings create_params = { Player = <Player> }}}
			]
		}
		CreateScreenElement {
			Type = TextElement
			PARENT = <Id>
			font = fontgrid_title_gh3
			Scale = <text_scale>
			rgba = [ 210 130 0 250 ]
			text = "SET AUDIO"
			Id = options_audio
			just = [ center center ]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [ 0 0 0 255 ]
			z_priority = <pause_z>
			exclusive_device = <player_device>
		}
		GetScreenElementDims Id = <Id>
		fit_text_in_rectangle Id = <Id> dims = (<fit_dims> + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
		CreateScreenElement {
			Type = ContainerElement
			PARENT = vmenu_pause
			dims = (0.0, 100.0)
			event_handlers = [
				{Focus retail_menu_focus Params = { Id = options_calibrate_lag }}
				{ Focus generic_menu_up_or_down_sound }
				{unfocus retail_menu_unfocus Params = { Id = options_calibrate_lag }}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = select_calibrate_lag create_params = { Player = <Player> }}}
			]
		}
		CreateScreenElement {
			Type = TextElement
			PARENT = <Id>
			font = fontgrid_title_gh3
			Scale = <text_scale>
			rgba = [ 210 130 0 250 ]
			text = "CALIBRATE VIDEO LAG"
			Id = options_calibrate_lag
			just = [ center center ]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [ 0 0 0 255 ]
			z_priority = <pause_z>
			exclusive_device = <player_device>
		}
		GetScreenElementDims Id = <Id>
		fit_text_in_rectangle Id = <Id> dims = (<fit_dims> + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
		CreateScreenElement {
			Type = ContainerElement
			PARENT = vmenu_pause
			dims = (0.0, 100.0)
			event_handlers = [
				{Focus retail_menu_focus Params = { Id = winport_options_calibrate_lag }}
				{ Focus generic_menu_up_or_down_sound }
				{unfocus retail_menu_unfocus Params = { Id = winport_options_calibrate_lag }}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = winport_select_calibrate_lag create_params = { Player = <Player> }}}
			]
		}
		CreateScreenElement {
			Type = TextElement
			PARENT = <Id>
			font = fontgrid_title_gh3
			Scale = <text_scale>
			rgba = [ 210 130 0 250 ]
			text = "CALIBRATE AUDIO LAG"
			Id = winport_options_calibrate_lag
			just = [ center center ]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [ 0 0 0 255 ]
			z_priority = <pause_z>
			exclusive_device = <player_device>
		}
		GetScreenElementDims Id = <Id>
		fit_text_in_rectangle Id = <Id> dims = (<fit_dims> + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
		if IsGuitarController controller = <player_device>
			if NOT WinPortSioIsKeyboard deviceNum = <player_device>
				CreateScreenElement {
					Type = ContainerElement
					PARENT = vmenu_pause
					dims = (0.0, 100.0)
					event_handlers = [
						{Focus retail_menu_focus Params = { Id = options_calibrate_whammy }}
						{ Focus generic_menu_up_or_down_sound }
						{unfocus retail_menu_unfocus Params = { Id = options_calibrate_whammy }}
						{pad_choose ui_flow_manager_respond_to_action Params = {action = select_calibrate_whammy_bar create_params = {Player = <Player> popup = 1}}}
					]
				}
				CreateScreenElement {
					Type = TextElement
					PARENT = <Id>
					font = fontgrid_title_gh3
					Scale = <text_scale>
					rgba = [ 210 130 0 250 ]
					text = "CALIBRATE WHAMMY"
					Id = options_calibrate_whammy
					just = [ center center ]
					Shadow
					shadow_offs = (3.0, 3.0)
					shadow_rgba [ 0 0 0 255 ]
					z_priority = <pause_z>
					exclusive_device = <player_device>
				}
				GetScreenElementDims Id = <Id>
				fit_text_in_rectangle Id = <Id> dims = (<fit_dims> + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
			endif
		endif
		if isSinglePlayerGame
			lefty_flip_text = "LEFTY FLIP:"
		else
			if (<Player> = 1)
				lefty_flip_text = "P1 LEFTY FLIP:"
			else
				lefty_flip_text = "P2 LEFTY FLIP:"
			endif
		endif
		CreateScreenElement {
			Type = ContainerElement
			PARENT = vmenu_pause
			dims = (0.0, 100.0)
			event_handlers = [
				{Focus retail_menu_focus Params = { Id = pause_options_lefty }}
				{ Focus generic_menu_up_or_down_sound }
				{unfocus retail_menu_unfocus Params = { Id = pause_options_lefty }}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = select_lefty_flip create_params = { Player = <Player> }}}
			]
		}
		<lefty_container> = <Id>
		CreateScreenElement {
			Type = TextElement
			PARENT = <lefty_container>
			Id = pause_options_lefty
			font = fontgrid_title_gh3
			Scale = <text_scale>
			rgba = [ 210 130 0 250 ]
			text = <lefty_flip_text>
			just = [ center center ]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [ 0 0 0 255 ]
			z_priority = <pause_z>
			exclusive_device = <player_device>
		}
		GetScreenElementDims Id = <Id>
		fit_text_in_rectangle Id = <Id> dims = (<fit_dims> + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
		CreateScreenElement \{Type = ContainerElement PARENT = vmenu_pause dims = (0.0, 100.0) event_handlers = [{Focus retail_menu_focus Params = { Id = options_exit }}{ Focus generic_menu_up_or_down_sound }{unfocus retail_menu_unfocus Params = { Id = options_exit }}{pad_choose ui_flow_manager_respond_to_action Params = { action = go_back }}]}
		CreateScreenElement {
			Type = TextElement
			PARENT = <Id>
			font = fontgrid_title_gh3
			Scale = <text_scale>
			rgba = [ 210 130 0 250 ]
			text = "EXIT"
			Id = options_exit
			just = [ center center ]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [ 0 0 0 255 ]
			z_priority = <pause_z>
			exclusive_device = <player_device>
		}
		GetScreenElementDims Id = <Id>
		fit_text_in_rectangle Id = <Id> dims = (<fit_dims> + <height> * (0.0, 1.0))only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0))start_y_scale = (<text_scale>.(0.0, 1.0))
		GetGlobalTags \{ user_options }
		if (<Player> = 1)
			if (<lefty_flip_p1> = 1)
				lefty_tex = Options_Controller_Check
			else
				lefty_tex = Options_Controller_X
			endif
		else
			if (<lefty_flip_p2> = 1)
				lefty_tex = Options_Controller_Check
			else
				lefty_tex = Options_Controller_X
			endif
		endif
		displaySprite {
			PARENT = <lefty_container>
			tex = <lefty_tex>
			just = [ center center ]
			z = (<pause_z> + 10)
		}
		GetScreenElementDims \{ Id = pause_options_lefty }
		<Id> ::SetProps Pos = (<width> * (0.5, 0.0) + (22.0, 0.0))
		add_user_control_helper \{ text = "SELECT" button = Green z = 100000 }
		add_user_control_helper \{ text = "BACK" button = Red z = 100000 }
		add_user_control_helper \{ text = "UP/DOWN" button = strumbar z = 100000 }
	endif
	if ($is_network_game = 0)
		if NOT isSinglePlayerGame
			if (<for_practice> = 0)
				FormatText textname = player_paused_text "PLAYER %d PAUSED. ONLY PLAYER %d OPTIONS ARE AVAILABLE." d = <Player>
				displaySprite {
					PARENT = pause_menu_frame_container
					Id = pause_helper_text_bg
					tex = Control_pill_body
					Pos = (640.0, 600.0)
					just = [ center center ]
					rgba = [ 96 0 0 255 ]
					z = (<pause_z> + 10)
				}
				displayText {
					PARENT = pause_menu_frame_container
					Pos = (640.0, 604.0)
					just = [ center center ]
					text = <player_paused_text>
					rgba = [ 186 105 0 255 ]
					Scale = (0.45000001788139343, 0.6000000238418579)
					z = (<pause_z> + 11)
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
					z = (<pause_z> + 10)
				}
				displaySprite {
					PARENT = pause_menu_frame_container
					tex = Control_pill_end
					Pos = ((640.0, 601.0) + <width> * (0.5, 0.0))
					rgba = [ 96 0 0 255 ]
					just = [ Left center ]
					z = (<pause_z> + 10)
				}
			endif
		endif
	endif
	Change \{ menu_choose_practice_destroy_previous_menu = 1 }
	if (<for_options> = 0 & <for_practice> = 0)
		spawnscriptnow \{ animate_bunny_flame }
	endif
endscript

script animate_bunny_flame
	begin
		swap_bunny_flame
		wait \{ 0.1 Second }
	repeat
endscript

script bunny_hover
	if NOT ScreenElementExists \{ Id = bunny_container }
		return
	endif
	i = 1
	begin
		FormatText ChecksumName = bunnyid 'pause_bunny_flame_%d' d = <i>
		if NOT ScreenElementExists Id = <bunnyid>
			return
		else
			SetScreenElementProps Id = <bunnyid> Pos = <flame_origin>
		endif
		<i> = (<i> + 1)
	repeat 7
	begin
		bunny_container ::DoMorph \{Pos = (360.0, 130.0) Time = 1 rot_angle = -25 Scale = 1.05 Motion = ease_out}
		bunny_container ::DoMorph \{Pos = (390.0, 170.0) Time = 1 rot_angle = -20 Scale = 0.95 Motion = ease_in}
		bunny_container ::DoMorph \{Pos = (360.0, 130.0) Time = 1 rot_angle = -15 Scale = 1.05 Motion = ease_out}
		bunny_container ::DoMorph \{Pos = (390.0, 170.0) Time = 1 rot_angle = -20 Scale = 0.95 Motion = ease_in}
	repeat
endscript

script destroy_pause_menu
	restore_start_key_binding
	clean_up_user_control_helpers
	destroy_pause_menu_frame
	destroy_menu \{ menu_id = scrolling_pause }
	destroy_menu \{ menu_id = pause_menu_frame_container }
	killspawnedscript \{ name = animate_bunny_flame }
	if ScreenElementExists \{ Id = warning_message_container }
		DestroyScreenElement \{ Id = warning_message_container }
	endif
	if ScreenElementExists \{ Id = leaving_lobby_dialog_menu }
		DestroyScreenElement \{ Id = leaving_lobby_dialog_menu }
	endif
	destroy_pause_menu_frame \{ container_id = net_quit_warning }
	if IsWinPort
		Change \{ winport_in_top_pause_menu = 0 }
	endif
endscript

script swap_bunny_flame
	if GotParam \{ Up }
		generic_menu_up_or_down_sound \{ Up }
		Change \{ g_anim_flame = -1 }
	elseif GotParam \{ Down }
		generic_menu_up_or_down_sound \{ Down }
		Change \{ g_anim_flame = 1 }
	endif
	Change bunny_flame_index = ($bunny_flame_index + $g_anim_flame)
	if ($bunny_flame_index > 7)
		Change \{ bunny_flame_index = 1 }
	endif
	if ($bunny_flame_index < 1)
		Change \{ bunny_flame_index = 7 }
	endif
	reset_bunny_alpha
	FormatText \{ ChecksumName = bunnyid 'pause_bunny_flame_%d' d = $bunny_flame_index }
	if ScreenElementExists Id = <bunnyid>
		DoScreenElementMorph Id = <bunnyid> Alpha = 1
	endif
endscript

script reset_bunny_alpha
	i = 1
	begin
		FormatText ChecksumName = bunnyid 'pause_bunny_flame_%d' d = <i>
		if ScreenElementExists Id = <bunnyid>
			DoScreenElementMorph Id = <bunnyid> Alpha = 0
		endif
		<i> = (<i> + 1)
	repeat 7
endscript

script create_menu_backdrop \{texture = Venue_BG rgba = [ 255 255 255 255 ]}
	if ScreenElementExists \{ Id = menu_backdrop_container }
		DestroyScreenElement \{ Id = menu_backdrop_container }
	endif
	CreateScreenElement \{Type = ContainerElement PARENT = root_window Id = menu_backdrop_container Pos = (0.0, 0.0) just = [ Left top ]}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = menu_backdrop_container
		Id = menu_backdrop
		texture = <texture>
		rgba = <rgba>
		Pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [ center center ]
		z_priority = 0
	}
endscript

script destroy_menu_backdrop
	if ScreenElementExists \{ Id = menu_backdrop_container }
		DestroyScreenElement \{ Id = menu_backdrop_container }
	endif
endscript

script create_pause_menu_frame \{x_scale = 1 y_scale = 1 tile_sprite = 1 container_id = pause_menu_frame_container z = 0 gradient = 1 PARENT = root_window}
	CreateScreenElement {
		Type = ContainerElement
		PARENT = <PARENT>
		Id = <container_id>
		Pos = (0.0, 0.0)
		just = [ Left top ]
		z_priority = <z>
	}
	<center_pos> = (640.0, 360.0)
	pos_scale_2 = ((0.0, -5.0) * <y_scale>)
	scale_1 = ((1.5, 0.0) * <x_scale> + (0.0, 1.399999976158142) * <y_scale>)
	scale_2 = ((1.399999976158142, 0.0) * <x_scale> + (0.0, 1.399999976158142) * <y_scale>)
	scale_3 = ((1.399999976158142, 0.0) * <x_scale> + (0.0, 1.3499999046325684) * <y_scale>)
	scale_4 = ((1.5750000476837158, 0.0) * <x_scale> + (0.0, 1.5) * <y_scale>)
	scale_5 = ((1.5, 0.0) * <x_scale> + (0.0, 1.399999976158142) * <y_scale>)
	if (<gradient> = 1)
		CreateScreenElement {
			Type = SpriteElement
			PARENT = <container_id>
			texture = gradient_128
			rgba = [ 0 0 0 180 ]
			Pos = (0.0, 0.0)
			dims = (1280.0, 720.0)
			just = [ Left top ]
			z_priority = (<z> + 1)
		}
	endif
	if (<tile_sprite> = 1)
		CreateScreenElement {
			Type = WindowElement
			PARENT = <container_id>
			Pos = (642.0, 360.0)
			dims = ((508.0, 0.0) * <x_scale> + (0.0, 340.0) * <y_scale>)
			just = [ center center ]
			z_priority = (<z> - 1)
		}
		pause_menu_scrolling_bg_01 = <Id>
		TileSprite PARENT = <pause_menu_scrolling_bg_01> tile_dims = (980.0, 910.0) Pos = (0.0, 0.0) texture = GH3_Pause_bg_tile
		RunScriptOnScreenElement TileSpriteLoop Id = <Id> Params = {move_x = -2 move_y = -2}
	else
		CreateScreenElement {
			Type = SpriteElement
			Id = frame_background
			PARENT = <container_id>
			rgba = [ 0 0 0 255 ]
			Pos = (640.0, 360.0)
			just = [ center center ]
			dims = ((520.0, 0.0) * <x_scale> + (0.0, 340.0) * <y_scale>)
			z_priority = (<z> - 1)
		}
	endif
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_02
		rgba = [ 255 255 255 255 ]
		Pos = (<center_pos>)
		Scale = <scale_3>
		just = [ bottom Right ]
		z_priority = (<z> + 2)
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_02
		rgba = [ 255 255 255 255 ]
		Pos = (<center_pos>)
		Scale = <scale_3>
		just = [ top Right ]
		z_priority = (<z> + 2)
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_02
		rgba = [ 255 255 255 255 ]
		Pos = (<center_pos>)
		Scale = <scale_3>
		just = [ top Left ]
		z_priority = (<z> + 2)
		flip_v
		flip_h
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_02
		rgba = [ 255 255 255 255 ]
		Pos = (<center_pos>)
		Scale = <scale_3>
		just = [ bottom Left ]
		z_priority = (<z> + 2)
		flip_h
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [ 255 255 255 255 ]
		Pos = (<center_pos>)
		Scale = <scale_4>
		just = [ bottom Right ]
		z_priority = (<z> + 2)
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [ 255 255 255 255 ]
		Pos = (<center_pos>)
		Scale = <scale_4>
		just = [ top Right ]
		z_priority = (<z> + 2)
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [ 255 255 255 255 ]
		Pos = (<center_pos>)
		Scale = <scale_4>
		just = [ top Left ]
		z_priority = (<z> + 2)
		flip_v
		flip_h
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [ 255 255 255 255 ]
		Pos = (<center_pos>)
		Scale = <scale_4>
		just = [ bottom Left ]
		z_priority = (<z> + 2)
		flip_h
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [ 0 0 0 255 ]
		Pos = (<center_pos>)
		Scale = <scale_5>
		just = [ bottom Right ]
		z_priority = (<z> + 2)
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [ 0 0 0 255 ]
		Pos = (<center_pos>)
		Scale = <scale_5>
		just = [ top Right ]
		z_priority = (<z> + 2)
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [ 0 0 0 255 ]
		Pos = (<center_pos>)
		Scale = <scale_5>
		just = [ top Left ]
		z_priority = (<z> + 2)
		flip_v
		flip_h
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [ 0 0 0 255 ]
		Pos = (<center_pos>)
		Scale = <scale_5>
		just = [ bottom Left ]
		z_priority = (<z> + 2)
		flip_h
	}
endscript

script destroy_pause_menu_frame \{ container_id = pause_menu_frame_container }
	destroy_menu menu_id = <container_id>
endscript
default_menu_focus_color = [ 210 210 210 250 ]
default_menu_unfocus_color = [ 210 130 0 250 ]
menu_focus_color = [ 210 210 210 250 ]
menu_unfocus_color = [ 210 130 0 250 ]

script set_focus_color \{rgba = [ 210 210 210 250 ]}
	Change menu_focus_color = <rgba>
endscript

script set_unfocus_color \{rgba = [ 210 130 0 250 ]}
	Change menu_unfocus_color = <rgba>
endscript

script retail_menu_focus
	if GotParam \{ Id }
		if ScreenElementExists Id = <Id>
			SetScreenElementProps Id = <Id> rgba = ($menu_focus_color)
		endif
	else
		GetTags
		PrintStruct <...>
		SetScreenElementProps Id = <Id> rgba = ($menu_focus_color)
	endif
endscript

script retail_menu_unfocus
	if GotParam \{ Id }
		if ScreenElementExists Id = <Id>
			SetScreenElementProps Id = <Id> rgba = ($menu_unfocus_color)
		endif
	else
		GetTags
		SetScreenElementProps Id = <Id> rgba = ($menu_unfocus_color)
	endif
endscript

script fit_text_in_rectangle \{dims = (100.0, 100.0) just = center keep_ar = 0 only_if_larger_x = 0 only_if_larger_y = 0 start_x_scale = 1.0 start_y_scale = 1.0}
	if NOT GotParam \{ Id }
		ScriptAssert \{ "No id passed to fit_text_in_rectangle!" }
	endif
	GetScreenElementDims Id = <Id>
	x_dim = (<dims>.(1.0, 0.0))
	y_dim = (<dims>.(0.0, 1.0))
	x_scale = (<x_dim> / <width>)
	if (<keep_ar> = 1)
		y_scale = <x_scale>
	else
		y_scale = (<y_dim> / <height>)
	endif
	if GotParam \{ debug_me }
		PrintStruct <...>
	endif
	if (<only_if_larger_x> = 1)
		if (<x_scale> > 1)
			return
		endif
	elseif (<only_if_larger_y> = 1)
		if (<y_scale> > 1)
			return
		endif
	endif
	if (<just> = center)
		if GotParam \{ Pos }
		endif
	endif
	scale_pair = ((1.0, 0.0) * <x_scale> * <start_x_scale> + (0.0, 1.0) * <y_scale> * <start_y_scale>)
	SetScreenElementProps {
		Id = <Id>
		Scale = <scale_pair>
	}
	if GotParam \{ Pos }
		SetScreenElementProps Id = <Id> Pos = <Pos>
	endif
endscript
num_user_control_helpers = 0
user_control_text_font = fontgrid_title_gh3
user_control_pill_color = [ 20 20 20 155 ]
user_control_pill_text_color = [ 180 180 180 255 ]
user_control_auto_center = 1
user_control_super_pill = 0
user_control_pill_y_position = 650
user_control_pill_scale = 0.4
user_control_pill_end_width = 50
user_control_pill_gap = 150
user_control_super_pill_gap = 0.4
pill_helper_max_width = 100

script clean_up_user_control_helpers
	if ScreenElementExists \{ Id = user_control_container }
		DestroyScreenElement \{ Id = user_control_container }
	endif
	Change \{ user_control_pill_gap = 150 }
	Change \{ pill_helper_max_width = 100 }
	Change \{ num_user_control_helpers = 0 }
	Change \{user_control_pill_color = [ 20 20 20 155 ]}
	Change \{user_control_pill_text_color = [ 180 180 180 255 ]}
	Change \{ user_control_auto_center = 1 }
	Change \{ user_control_super_pill = 0 }
	Change \{ user_control_pill_y_position = 650 }
	Change \{ user_control_pill_scale = 0.4 }
endscript

script add_user_control_helper \{ z = 10 pill = 1 fit_to_rectangle = 1 }
	Scale = ($user_control_pill_scale)
	Pos = ((0.0, 1.0) * ($user_control_pill_y_position))
	buttonoff = (0.0, 0.0)
	if NOT ScreenElementExists \{ Id = user_control_container }
		CreateScreenElement \{ Id = user_control_container Type = ContainerElement PARENT = root_window Pos = (0.0, 0.0) }
	endif
	if GotParam \{ button }
		switch (<button>)
			case Green
				buttonchar = "\\m0"
			case Red
				buttonchar = "\\m1"
			case Yellow
				buttonchar = "\\b6"
			case Blue
				buttonchar = "\\b7"
			case Orange
				buttonchar = "\\b8"
			case strumbar
				buttonchar = "\\bb"
				offset_for_strumbar = 1
			case Start
				buttonchar = "\\ba"
				offset_for_strumbar = 1
		endswitch
	else
		buttonchar = ""
	endif
	if (<pill> = 0)
		CreateScreenElement {
			Type = TextElement
			PARENT = user_control_container
			text = <buttonchar>
			Pos = (<Pos> + (-10.0, 8.0) * <Scale> + <buttonoff>)
			Scale = (1 * <Scale>)
			rgba = [ 255 255 255 255 ]
			font = ($gh3_button_font)
			just = [ Left top ]
			z_priority = (<z> + 0.1)
		}
		CreateScreenElement {
			Type = TextElement
			PARENT = user_control_container
			text = <text>
			rgba = $user_control_pill_text_color
			Scale = (1.1 * <Scale>)
			Pos = (<Pos> + (50.0, 0.0) * <Scale> + (0.0, 20.0) * <Scale>)
			font = ($user_control_text_font)
			z_priority = (<z> + 0.1)
			just = [ Left top ]
		}
		if (<fit_to_rectangle> = 1)
			SetScreenElementProps Id = <Id> Scale = (1.1 * <Scale>)
			GetScreenElementDims Id = <Id>
			if (<width> > $pill_helper_max_width)
				fit_text_in_rectangle Id = <Id> dims = ($pill_helper_max_width * (0.5, 0.0) + <height> * (0.0, 1.0) * $user_control_pill_scale)
			endif
		endif
	else
		if (($user_control_super_pill = 0)& ($user_control_auto_center = 0))
			CreateScreenElement {
				Type = TextElement
				PARENT = user_control_container
				text = <text>
				Id = <textid>
				rgba = $user_control_pill_text_color
				Scale = (1.1 * <Scale>)
				Pos = (<Pos> + (50.0, 0.0) * <Scale> + (0.0, 20.0) * <Scale>)
				font = ($user_control_text_font)
				z_priority = (<z> + 0.1)
				just = [ Left top ]
			}
			textid = <Id>
			if (<fit_to_rectangle> = 1)
				SetScreenElementProps Id = <Id> Scale = (1.1 * <Scale>)
				GetScreenElementDims Id = <Id>
				if (<width> > $pill_helper_max_width)
					fit_text_in_rectangle Id = <Id> dims = ($pill_helper_max_width * (0.5, 0.0) + <height> * (0.0, 1.0) * $user_control_pill_scale)
				endif
			endif
			CreateScreenElement {
				Type = TextElement
				PARENT = user_control_container
				Id = <buttonid>
				text = <buttonchar>
				Pos = (<Pos> + (-10.0, 8.0) * <Scale> + <buttonoff>)
				Scale = (1 * <Scale>)
				rgba = [ 255 255 255 255 ]
				font = ($gh3_button_font)
				just = [ Left top ]
				z_priority = (<z> + 0.1)
			}
			buttonid = <Id>
			if GotParam \{ offset_for_strumbar }
				<textid> ::SetTags is_strumbar = 1
				fastscreenelementpos Id = <textid> absolute
				SetScreenElementProps Id = <textid> Pos = (<ScreenElementPos> + (50.0, 0.0) * <Scale>)
			else
			endif
			fastscreenelementpos Id = <buttonid> absolute
			top_left = <ScreenElementPos>
			fastscreenelementpos Id = <textid> absolute
			bottom_right = <ScreenElementPos>
			GetScreenElementDims Id = <textid>
			bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
			pill_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
			pill_height = ((0.0, 1.0).<bottom_right> - (0.0, 1.0).<top_left>)
			pill_y_offset = (<pill_height> * 0.2)
			pill_height = (<pill_height> + <pill_y_offset>)
			<Pos> = (<Pos> + (0.0, 1.0) * (<Scale> * 3))
			CreateScreenElement {
				Type = SpriteElement
				PARENT = user_control_container
				texture = Control_pill_body
				dims = ((1.0, 0.0) * <pill_width> + (0.0, 1.0) * <pill_height>)
				Pos = (<Pos> + (0.0, -0.5) * <pill_y_offset>)
				rgba = ($user_control_pill_color)
				just = [ Left top ]
				z_priority = <z>
			}
			CreateScreenElement {
				Type = SpriteElement
				PARENT = user_control_container
				texture = Control_pill_end
				dims = ((1.0, 0.0) * (<Scale> * $user_control_pill_end_width)+ (0.0, 1.0) * <pill_height>)
				Pos = (<Pos> + (0.0, -0.5) * <pill_y_offset>)
				rgba = ($user_control_pill_color)
				just = [ Right top ]
				z_priority = <z>
				flip_v
			}
			CreateScreenElement {
				Type = SpriteElement
				PARENT = user_control_container
				texture = Control_pill_end
				dims = ((1.0, 0.0) * (<Scale> * $user_control_pill_end_width)+ (0.0, 1.0) * <pill_height>)
				Pos = (<Pos> + (0.0, -0.5) * <pill_y_offset> + (1.0, 0.0) * <pill_width>)
				rgba = ($user_control_pill_color)
				just = [ Left top ]
				z_priority = <z>
			}
		else
			FormatText ChecksumName = textid 'uc_text_%d' d = ($num_user_control_helpers)
			CreateScreenElement {
				Type = TextElement
				PARENT = user_control_container
				text = <text>
				Id = <textid>
				rgba = $user_control_pill_text_color
				Scale = (1.1 * <Scale>)
				Pos = (<Pos> + (50.0, 0.0) * <Scale> + (0.0, 20.0) * <Scale>)
				font = ($user_control_text_font)
				z_priority = (<z> + 0.1)
				just = [ Left top ]
			}
			if (<fit_to_rectangle> = 1)
				SetScreenElementProps Id = <Id> Scale = (1.1 * <Scale>)
				GetScreenElementDims Id = <Id>
				if (<width> > $pill_helper_max_width)
					fit_text_in_rectangle Id = <Id> dims = ($pill_helper_max_width * (0.5, 0.0) + <height> * (0.0, 1.0) * $user_control_pill_scale)
				endif
			endif
			FormatText ChecksumName = buttonid 'uc_button_%d' d = ($num_user_control_helpers)
			CreateScreenElement {
				Type = TextElement
				PARENT = user_control_container
				Id = <buttonid>
				text = <buttonchar>
				Pos = (<Pos> + (-10.0, 8.0) * <Scale> + <buttonoff>)
				Scale = (1.2 * <Scale>)
				rgba = [ 255 255 255 255 ]
				font = ($gh3_button_font)
				just = [ Left top ]
				z_priority = (<z> + 0.1)
			}
			if GotParam \{ offset_for_strumbar }
				<textid> ::SetTags is_strumbar = 1
				fastscreenelementpos Id = <textid> absolute
				SetScreenElementProps Id = <textid> Pos = (<ScreenElementPos> + (50.0, 0.0) * <Scale>)
			endif
			Change num_user_control_helpers = ($num_user_control_helpers + 1)
		endif
	endif
	if ($user_control_super_pill = 1)
		user_control_build_super_pill z = <z>
	elseif ($user_control_auto_center = 1)
		user_control_build_pills z = <z>
	endif
endscript

script user_control_cleanup_pills
	destroy_menu \{ menu_id = user_control_super_pill_object_main }
	destroy_menu \{ menu_id = user_control_super_pill_object_l }
	destroy_menu \{ menu_id = user_control_super_pill_object_r }
	Index = 0
	if NOT ($num_user_control_helpers = 0)
		begin
			FormatText ChecksumName = pill_id 'uc_pill_%d' d = <Index>
			if ScreenElementExists Id = <pill_id>
				DestroyScreenElement Id = <pill_id>
			endif
			FormatText ChecksumName = pill_l_id 'uc_pill_l_%d' d = <Index>
			if ScreenElementExists Id = <pill_l_id>
				DestroyScreenElement Id = <pill_l_id>
			endif
			FormatText ChecksumName = pill_r_id 'uc_pill_r_%d' d = <Index>
			if ScreenElementExists Id = <pill_r_id>
				DestroyScreenElement Id = <pill_r_id>
			endif
			<Index> = (<Index> + 1)
		repeat ($num_user_control_helpers)
	endif
endscript
action_safe_width_for_helpers = 925

script user_control_build_pills
	user_control_cleanup_pills
	Scale = ($user_control_pill_scale)
	Index = 0
	max_pill_width = 0
	if NOT ($num_user_control_helpers = 0)
		begin
			FormatText ChecksumName = textid 'uc_text_%d' d = <Index>
			FormatText ChecksumName = buttonid 'uc_button_%d' d = <Index>
			fastscreenelementpos Id = <buttonid> absolute
			top_left = <ScreenElementPos>
			fastscreenelementpos Id = <textid> absolute
			bottom_right = <ScreenElementPos>
			GetScreenElementDims Id = <textid>
			bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
			pill_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
			if (<pill_width> > <max_pill_width>)
				<max_pill_width> = (<pill_width>)
			endif
			<Index> = (<Index> + 1)
		repeat ($num_user_control_helpers)
	endif
	<total_width> = (((<max_pill_width> + (<Scale> * $user_control_pill_end_width * 2))* ($num_user_control_helpers))+ (($user_control_pill_gap * <Scale>)* ($num_user_control_helpers - 1)))
	if (<total_width> > $action_safe_width_for_helpers)
		<max_pill_width> = ((($action_safe_width_for_helpers - (($user_control_pill_gap * <Scale>)* ($num_user_control_helpers - 1)))/ ($num_user_control_helpers))- (<Scale> * $user_control_pill_end_width * 2))
	endif
	Index = 0
	initial_pill_x = (640 + -1 * (($num_user_control_helpers / 2.0)* <max_pill_width>)- ((0.5 * $user_control_pill_gap * <Scale>)* ($num_user_control_helpers -1)))
	Pos = ((1.0, 0.0) * <initial_pill_x> + (0.0, 1.0) * ($user_control_pill_y_position)+ (0.0, 0.800000011920929) * (<Scale>))
	if NOT ($num_user_control_helpers = 0)
		begin
			FormatText ChecksumName = pill_id 'uc_pill_%d' d = <Index>
			FormatText ChecksumName = pill_l_id 'uc_pill_l_%d' d = <Index>
			FormatText ChecksumName = pill_r_id 'uc_pill_r_%d' d = <Index>
			FormatText ChecksumName = textid 'uc_text_%d' d = <Index>
			FormatText ChecksumName = buttonid 'uc_button_%d' d = <Index>
			fastscreenelementpos Id = <buttonid> absolute
			top_left = <ScreenElementPos>
			fastscreenelementpos Id = <textid> absolute
			bottom_right = <ScreenElementPos>
			GetScreenElementDims Id = <textid>
			bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
			pill_width = (<max_pill_width>)
			pill_height = ((0.0, 1.0).<bottom_right> - (0.0, 1.0).<top_left>)
			pill_y_offset = (<pill_height> * 0.2)
			pill_height = (<pill_height> + <pill_y_offset>)
			CreateScreenElement {
				Type = SpriteElement
				PARENT = user_control_container
				Id = <pill_id>
				texture = Control_pill_body
				dims = ((1.0, 0.0) * <pill_width> + (0.0, 1.0) * <pill_height>)
				Pos = (<Pos> + (0.0, -0.5) * <pill_y_offset>)
				rgba = ($user_control_pill_color)
				just = [ Left top ]
				z_priority = <z>
			}
			CreateScreenElement {
				Type = SpriteElement
				PARENT = user_control_container
				Id = <pill_l_id>
				texture = Control_pill_end
				dims = ((1.0, 0.0) * (<Scale> * $user_control_pill_end_width)+ (0.0, 1.0) * <pill_height>)
				Pos = (<Pos> + (0.0, -0.5) * <pill_y_offset>)
				rgba = ($user_control_pill_color)
				just = [ Right top ]
				z_priority = <z>
				flip_v
			}
			CreateScreenElement {
				Type = SpriteElement
				PARENT = user_control_container
				Id = <pill_r_id>
				texture = Control_pill_end
				dims = ((1.0, 0.0) * (<Scale> * $user_control_pill_end_width)+ (0.0, 1.0) * <pill_height>)
				Pos = (<Pos> + (0.0, -0.5) * <pill_y_offset> + (1.0, 0.0) * <max_pill_width>)
				rgba = ($user_control_pill_color)
				just = [ Left top ]
				z_priority = <z>
			}
			<Index> = (<Index> + 1)
			Pos = (<Pos> + (1.0, 0.0) * ($user_control_pill_gap * <Scale> + <max_pill_width>))
		repeat ($num_user_control_helpers)
	endif
	Index = 0
	if NOT ($num_user_control_helpers = 0)
		begin
			align_user_control_with_pill pill_index = <Index>
			<Index> = (<Index> + 1)
		repeat ($num_user_control_helpers)
	endif
endscript

script align_user_control_with_pill
	FormatText ChecksumName = pill_id 'uc_pill_%d' d = <pill_index>
	fastscreenelementpos Id = <pill_id> absolute
	GetScreenElementDims Id = <pill_id>
	pill_midpoint_x = (<ScreenElementPos>.(1.0, 0.0) + 0.5 * <width>)
	align_user_control_with_x X = <pill_midpoint_x> pill_index = <pill_index>
endscript

script align_user_control_with_x
	FormatText ChecksumName = textid 'uc_text_%d' d = <pill_index>
	FormatText ChecksumName = buttonid 'uc_button_%d' d = <pill_index>
	fastscreenelementpos Id = <buttonid> absolute
	top_left = <ScreenElementPos>
	button_pos = <ScreenElementPos>
	fastscreenelementpos Id = <textid> absolute
	bottom_right = <ScreenElementPos>
	text_pos = <ScreenElementPos>
	GetScreenElementDims Id = <textid>
	bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
	pill_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
	text_button_midpoint = (<top_left>.(1.0, 0.0) + 0.5 * <pill_width>)
	midpoint_diff = (<text_button_midpoint> - <X>)
	new_button_pos = (<button_pos> - (1.0, 0.0) * <midpoint_diff>)
	new_text_pos = (<text_pos> - (1.0, 0.0) * <midpoint_diff>)
	SetScreenElementProps Id = <textid> Pos = <new_text_pos>
	SetScreenElementProps Id = <buttonid> Pos = <new_button_pos>
endscript

script user_control_build_super_pill
	user_control_cleanup_pills
	Scale = ($user_control_pill_scale)
	Index = 0
	Pos = ((0.0, 1.0) * $user_control_pill_y_position)
	leftmost = 9999.0
	rightmost = -9999.0
	if NOT ($num_user_control_helpers = 0)
		begin
			FormatText ChecksumName = textid 'uc_text_%d' d = <Index>
			FormatText ChecksumName = buttonid 'uc_button_%d' d = <Index>
			fastscreenelementpos Id = <buttonid> absolute
			top_left = <ScreenElementPos>
			fastscreenelementpos Id = <textid> absolute
			bottom_right = <ScreenElementPos>
			GetScreenElementDims Id = <textid>
			bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
			button_text_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
			left_x = ((1.0, 0.0).<Pos>)
			right_x = ((1.0, 0.0).<Pos> + <button_text_width>)
			if (<left_x> < <leftmost>)
				<leftmost> = (<left_x>)
			endif
			if (<right_x> > <rightmost>)
				<rightmost> = (<right_x>)
			endif
			pill_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
			<buttonid> ::SetTags calc_width = <pill_width>
			<buttonid> ::SetTags calc_pos = <Pos>
			Pos = (<Pos> + (1.0, 0.0) * ($user_control_pill_gap * <Scale> * $user_control_super_pill_gap + <pill_width>))
			<Index> = (<Index> + 1)
		repeat ($num_user_control_helpers)
	endif
	whole_pill_width = (<rightmost> - <leftmost>)
	holy_midpoint_batman = (<leftmost> + 0.5 * <whole_pill_width>)
	midpoint_diff = (<holy_midpoint_batman> - 640)
	Index = 0
	if NOT ($num_user_control_helpers = 0)
		begin
			FormatText ChecksumName = textid 'uc_text_%d' d = <Index>
			FormatText ChecksumName = buttonid 'uc_button_%d' d = <Index>
			<buttonid> ::GetTags
			<calc_pos> = (<calc_pos> - (1.0, 0.0) * <midpoint_diff>)
			SetScreenElementProps Id = <buttonid> Pos = (<calc_pos>)
			istextstrumbar Id = <textid>
			if (<is_strumbar> = 0)
				SetScreenElementProps Id = <textid> Pos = (<calc_pos> + (50.0, 7.0) * <Scale>)
			else
				SetScreenElementProps Id = <textid> Pos = (<calc_pos> + (100.0, 7.0) * <Scale>)
			endif
			<Index> = (<Index> + 1)
		repeat ($num_user_control_helpers)
	endif
	pill_height = ((0.0, 1.0).<bottom_right> - (0.0, 1.0).<top_left>)
	pill_y_offset = (<pill_height> * 0.2)
	pill_height = (<pill_height> + <pill_y_offset>)
	Pos = ((1.0, 0.0) * (<leftmost> - <midpoint_diff>)+ (0.0, 1.0) * $user_control_pill_y_position)
	CreateScreenElement {
		Type = SpriteElement
		PARENT = user_control_container
		Id = user_control_super_pill_object_main
		texture = Control_pill_body
		dims = ((1.0, 0.0) * <whole_pill_width> + (0.0, 1.0) * <pill_height>)
		Pos = (<Pos> + (0.0, -0.5) * <pill_y_offset>)
		rgba = ($user_control_pill_color)
		just = [ Left top ]
		z_priority = <z>
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = user_control_container
		Id = user_control_super_pill_object_l
		texture = Control_pill_end
		dims = ((1.0, 0.0) * (<Scale> * $user_control_pill_end_width)+ (0.0, 1.0) * <pill_height>)
		Pos = (<Pos> + (0.0, -0.5) * <pill_y_offset>)
		rgba = ($user_control_pill_color)
		just = [ Right top ]
		z_priority = <z>
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = user_control_container
		Id = user_control_super_pill_object_r
		texture = Control_pill_end
		dims = ((1.0, 0.0) * (<Scale> * $user_control_pill_end_width)+ (0.0, 1.0) * <pill_height>)
		Pos = (<Pos> + (0.0, -0.5) * <pill_y_offset> + (1.0, 0.0) * <whole_pill_width>)
		rgba = ($user_control_pill_color)
		just = [ Left top ]
		z_priority = <z>
	}
endscript

script fastscreenelementpos
	GetScreenElementProps Id = <Id>
	return ScreenElementPos = <Pos>
endscript

script istextstrumbar
	<Id> ::GetTags
	if GotParam \{ is_strumbar }
		return \{ is_strumbar = 1 }
	else
		return \{ is_strumbar = 0 }
	endif
endscript

script get_diff_completion_text \{ for_p2_career = 0 }
	pop_progression = 0
	if ($progression_pop_count = 1)
		progression_push_current
		pop_progression = 1
	endif
	diff_completion_text = [ "" "" "" "" ]
	get_progression_globals game_mode = ($game_mode)
	Change g_gh3_setlist = <tier_global>
	difficulty_array = [ easy medium hard expert ]
	stored_difficulty = ($current_difficulty)
	if ($game_mode = p2_career)
		stored_difficulty2 = ($current_difficulty2)
		Change \{ current_difficulty2 = expert }
	endif
	num_tiers = ($g_gh3_setlist.num_tiers)
	diff_index = 0
	begin
		diff_num_songs = 0
		diff_songs_completed = 0
		Change current_difficulty = (<difficulty_array> [ <diff_index> ])
		progression_pop_current \{ UpdateAtoms = 0 }
		tier_index = 1
		begin
			setlist_prefix = ($g_gh3_setlist.prefix)
			FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <tier_index>
			FormatText ChecksumName = tier_checksum 'tier%s' s = <tier_index>
			GetArraySize ($g_gh3_setlist.<tier_checksum>.songs)
			num_songs = <array_Size>
			diff_num_songs = (<diff_num_songs> + <num_songs>)
			song_count = 0
			begin
				FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1)s = <tier_index> AddToStringLookup = TRUE
				GetGlobalTags <song_checksum> Params = { stars score }
				if NOT (<stars> = 0)
					<diff_songs_completed> = (<diff_songs_completed> + 1)
				endif
				song_count = (<song_count> + 1)
			repeat <num_songs>
			<tier_index> = (<tier_index> + 1)
		repeat <num_tiers>
		if NOT (<for_p2_career>)
			FormatText textname = diff_completion_string "%a OF %b SONGS" a = <diff_songs_completed> b = <diff_num_songs>
			SetArrayElement ArrayName = diff_completion_text Index = (<diff_index>)NewValue = (<diff_completion_string>)
		else
			FormatText textname = diff_completion_string "%a of %b songs completed" a = <diff_songs_completed> b = <diff_num_songs>
			SetArrayElement ArrayName = diff_completion_text Index = (<diff_index>)NewValue = (<diff_completion_string>)
		endif
		progression_push_current
		<diff_index> = (<diff_index> + 1)
	repeat 4
	Change current_difficulty = <stored_difficulty>
	if ($game_mode = p2_career)
		Change current_difficulty2 = <stored_difficulty2>
	endif
	if (<pop_progression> = 1)
		progression_pop_current \{ UpdateAtoms = 0 }
	endif
	return diff_completion_text = <diff_completion_text>
endscript

script get_diff_completion_percentage \{ for_p2_career = 0 }
	pop_progression = 0
	if ($progression_pop_count = 1)
		progression_push_current
		pop_progression = 1
	endif
	diff_completion_percentage = [ 0 0 0 0 ]
	diff_completion_score = [ 0 0 0 0 ]
	get_progression_globals game_mode = ($game_mode)
	Change g_gh3_setlist = <tier_global>
	difficulty_array = [ easy medium hard expert ]
	stored_difficulty = ($current_difficulty)
	if ($game_mode = p2_career)
		stored_difficulty2 = ($current_difficulty2)
		Change \{ current_difficulty2 = expert }
	endif
	num_tiers = ($g_gh3_setlist.num_tiers)
	percentage_complete = 0
	diff_index = 0
	begin
		diff_num_songs = 0
		diff_songs_completed = 0
		diff_songs_score = 0
		Change current_difficulty = (<difficulty_array> [ <diff_index> ])
		progression_pop_current \{ UpdateAtoms = 0 }
		tier_index = 1
		begin
			setlist_prefix = ($g_gh3_setlist.prefix)
			FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <tier_index>
			FormatText ChecksumName = tier_checksum 'tier%s' s = <tier_index>
			GetArraySize ($g_gh3_setlist.<tier_checksum>.songs)
			num_songs = <array_Size>
			diff_num_songs = (<diff_num_songs> + <num_songs>)
			song_count = 0
			begin
				FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1)s = <tier_index> AddToStringLookup = TRUE
				GetGlobalTags <song_checksum> Params = { stars score }
				if NOT (<stars> = 0)
					<diff_songs_completed> = (<diff_songs_completed> + 1)
					<diff_songs_score> = (<diff_songs_score> + <score>)
				endif
				song_count = (<song_count> + 1)
			repeat <num_songs>
			<tier_index> = (<tier_index> + 1)
		repeat <num_tiers>
		percentage_complete = (<percentage_complete> + (100 * <diff_songs_completed>)/ <diff_num_songs>)
		SetArrayElement ArrayName = diff_completion_percentage Index = (<diff_index>)NewValue = ((100 * <diff_songs_completed>)/ <diff_num_songs>)
		SetArrayElement ArrayName = diff_completion_score Index = (<diff_index>)NewValue = <diff_songs_score>
		progression_push_current
		<diff_index> = (<diff_index> + 1)
	repeat 4
	Change current_difficulty = <stored_difficulty>
	if ($game_mode = p2_career)
		Change current_difficulty2 = <stored_difficulty2>
	endif
	if (<pop_progression> = 1)
		progression_pop_current \{ UpdateAtoms = 0 }
	endif
	return diff_completion_percentage = <diff_completion_percentage> total_percentage_complete = (<percentage_complete> / 4)diff_completion_score = <diff_completion_score>
endscript
winport_confirm_exit_msg = "Are you sure you want to exit?"

script winport_create_confirm_exit_popup
	create_popup_warning_menu \{textblock = { text = $winport_confirm_exit_msg }menu_pos = (640.0, 490.0) dialog_dims = (288.0, 64.0) options = [{func = {ui_flow_manager_respond_to_action Params = { action = continue }}text = "Yes" Scale = (1.0, 1.0)}{func = {ui_flow_manager_respond_to_action Params = { action = go_back }}text = "No" Scale = (1.0, 1.0)}]}
endscript

script winport_destroy_confirm_exit_popup
	destroy_popup_warning_menu
endscript
