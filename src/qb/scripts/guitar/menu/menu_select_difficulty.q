menu_select_difficulty_p1_difficulty_index = 0
menu_select_difficulty_p2_difficulty_index = 0
menu_select_difficulty_first_time = 1
sd_highlight_time = 0.05

script create_select_difficulty_menu
	disable_pause
	if ($current_num_players = 2)
		if NOT ($game_mode = p2_pro_faceoff)
			create_mp_select_difficulty_menu
			return
		endif
	endif
	spawnscriptnow \{ Menu_Music_On }
	base_menu_pos = (280.0, 235.0)
	main_menu_font = fontgrid_title_gh3
	menu_vspacing = 20
	completion_scale = 0.5
	menu_font = text_a6
	if (($player1_status.bot_play = 1)|| ($is_network_game))
		exclusive_device = ($primary_controller)
	else
		if ($game_mode = p2_pro_faceoff)
			exclusive_mp_controllers = [ 0 , 0 ]
			SetArrayElement ArrayName = exclusive_mp_controllers Index = 0 NewValue = ($player1_device)
			SetArrayElement ArrayName = exclusive_mp_controllers Index = 1 NewValue = ($player2_device)
			exclusive_device = <exclusive_mp_controllers>
		else
			exclusive_device = ($primary_controller)
		endif
	endif
	Change \{ rich_presence_context = presence_song_list }
	new_menu {
		scrollid = scrolling_select_difficulty
		vmenuid = vmenu_select_difficulty
		menu_pos = <base_menu_pos>
		use_backdrop = 0
		spacing = <menu_vspacing>
		exclusive_device = <exclusive_device>
	}
	if ($game_mode = p1_career || $game_mode = $p2_career)
	else
		if GotParam \{ song }
			Change current_song = <song>
		endif
	endif
	set_focus_color \{rgba = [ 175 0 0 250 ]}
	set_unfocus_color \{rgba = [ 210 210 210 250 ]}
	SetScreenElementProps \{Id = vmenu_select_difficulty internal_just = [ Left top ]}
	CreateScreenElement \{ Type = ContainerElement PARENT = root_window Id = sd_container Pos = (0.0, 0.0) }
	create_menu_backdrop \{ texture = Venue_BG }
	displaySprite \{PARENT = sd_container tex = Difficulty_1p_BG Pos = (640.0, 0.0) just = [ center top ] dims = (920.0, 720.0) z = 1}
	p1_diff_index = 8
	displaySprite Id = sd_white_p1 PARENT = sd_container tex = White Pos = ($g_sd_hilite_props [ <p1_diff_index> ].Pos)dims = (300.0, 37.0) rgba = [ 225 120 60 255 ]
	displaySprite \{PARENT = sd_container tex = Toprockers_Tape_1 Pos = (1150.0, 0.0) dims = (212.0, 128.0) z = 50 rot_angle = 90}
	displaySprite \{PARENT = sd_container tex = Toprockers_Tape_1 Pos = (1155.0, 3.0) dims = (212.0, 128.0) rgba = [ 0 0 0 100 ] z = 49 rot_angle = 90}
	displaySprite \{PARENT = sd_container tex = Toprockers_Tape_2 Pos = (260.0, 550.0) z = 50 rot_angle = 90 dims = (212.0, 128.0)}
	displaySprite \{PARENT = sd_container tex = Toprockers_Tape_2 Pos = (264.0, 555.0) rgba = [ 0 0 0 100 ] z = 49 rot_angle = 90 dims = (212.0, 128.0)}
	if (($game_mode = p1_career)|| ($game_mode = p2_career))
		get_diff_completion_text
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty
		Id = easy_title_text
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "EASY"
		just = [ Left top ]
		font_spacing = 0
		event_handlers = [
			{Focus sd_highlight_menuitem Params = {Player = 1 Index = 8 difficulty_index = 0}}
			{pad_choose selected_difficulty Params = { diff = easy }}
		]
	}
	fit_text_in_rectangle Id = <Id> dims = (210.0, 50.0)
	completion_pos = (490.0, 290.0)
	if (($game_mode = p1_career)|| ($game_mode = p2_career))
		CreateScreenElement {
			Type = TextElement
			PARENT = sd_container
			font = <main_menu_font>
			Scale = <completion_scale>
			just = [ Right center ]
			Pos = <completion_pos>
			text = (<diff_completion_text> [ 0 ])
			rgba = [ 175 100 55 255 ]
			z_priority = 100
		}
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty
		Id = medium_title_text
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "MEDIUM"
		just = [ Left top ]
		font_spacing = 0
		event_handlers = [
			{Focus sd_highlight_menuitem Params = {Player = 1 Index = 9 difficulty_index = 1}}
			{pad_choose selected_difficulty Params = { diff = medium }}
		]
	}
	fit_text_in_rectangle Id = <Id> dims = (210.0, 50.0)
	<completion_pos> = (490.0, 360.0)
	if (($game_mode = p1_career)|| ($game_mode = p2_career))
		CreateScreenElement {
			Type = TextElement
			PARENT = sd_container
			font = <main_menu_font>
			Scale = <completion_scale>
			just = [ Right center ]
			Pos = <completion_pos>
			text = (<diff_completion_text> [ 1 ])
			rgba = [ 175 100 55 255 ]
			z_priority = 100
		}
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty
		Id = hard_title_text
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "HARD"
		just = [ Left top ]
		font_spacing = 0
		event_handlers = [
			{Focus sd_highlight_menuitem Params = {Player = 1 Index = 10 difficulty_index = 2}}
			{pad_choose selected_difficulty Params = { diff = hard }}
		]
	}
	fit_text_in_rectangle Id = <Id> dims = (210.0, 50.0)
	<completion_pos> = (490.0, 430.0)
	if (($game_mode = p1_career)|| ($game_mode = p2_career))
		CreateScreenElement {
			Type = TextElement
			PARENT = sd_container
			font = <main_menu_font>
			Scale = <completion_scale>
			just = [ Right center ]
			Pos = <completion_pos>
			text = (<diff_completion_text> [ 2 ])
			rgba = [ 175 100 55 255 ]
			z_priority = 100
		}
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty
		Id = expert_title_text
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "EXPERT"
		just = [ Left top ]
		font_spacing = 0
		event_handlers = [
			{Focus sd_highlight_menuitem Params = {Player = 1 Index = 11 difficulty_index = 3}}
			{pad_choose selected_difficulty Params = { diff = expert }}
		]
	}
	fit_text_in_rectangle Id = <Id> dims = (210.0, 50.0)
	<completion_pos> = (490.0, 500.0)
	if (($game_mode = p1_career)|| ($game_mode = p2_career))
		CreateScreenElement {
			Type = TextElement
			PARENT = sd_container
			font = <main_menu_font>
			Scale = <completion_scale>
			just = [ Right center ]
			Pos = <completion_pos>
			text = (<diff_completion_text> [ 3 ])
			rgba = [ 175 100 55 255 ]
			z_priority = 100
		}
	endif
	Change \{ disable_menu_sounds = 1 }
	Change \{ sd_highlight_time = 0.0 }
	Change \{ sd_highlight_menuitem_morph = 0 }
	if ($menu_select_difficulty_first_time = 1)
		if IsXenon
			if GetGameProfileSetting \{ gsid = 1 }
				begin
					if (<game_setting> < 3)
						break
					endif
					LaunchEvent \{ Type = pad_down Target = vmenu_select_difficulty }
					<game_setting> = (<game_setting> - 1)
				repeat
			endif
		endif
		Change \{ menu_select_difficulty_first_time = 0 }
	else
		launch_num = 0
		switch ($current_difficulty)
			case medium
				<launch_num> = 1
			case hard
				<launch_num> = 2
			case expert
				<launch_num> = 3
		endswitch
		if (<launch_num>)
			begin
				LaunchEvent \{ Type = pad_down Target = vmenu_select_difficulty }
			repeat <launch_num>
		endif
	endif
	Change \{ sd_highlight_menuitem_morph = 1 }
	Change \{ disable_menu_sounds = 0 }
	Change \{ sd_highlight_time = 0.05 }
	if English
		select_diff_tex = #"0x82389cb4"
	elseif French
		select_diff_tex = #"0xbd149338"
	elseif Spanish
		select_diff_tex = #"0x64af1400"
	elseif German
		select_diff_tex = #"0x0cf1747d"
	elseif Italian
		select_diff_tex = #"0xd3ef2ac2"
	elseif #"0x6eaa363c"
		select_diff_tex = #"0x82389cb4"
	endif
	CreateScreenElement {
		Type = SpriteElement
		PARENT = sd_container
		texture = <select_diff_tex>
		Pos = (757.0, 491.0)
		dims = (192.0, 192.0)
		rgba = [ 255 255 255 255 ]
		just = [ center center ]
		z_priority = 80
	}
	displaySprite \{PARENT = sd_container tex = Instrument_2p_Overlay Pos = (0.0, 0.0) dims = (1280.0, 720.0) z = 50 rgba = [ 105 56 7 160 ]}
	add_user_control_helper \{ text = "SELECT" button = Green z = 100 }
	add_user_control_helper \{ text = "BACK" button = Red z = 100 }
	add_user_control_helper \{ text = "UP/DOWN" button = strumbar z = 100 }
endscript

script destroy_select_difficulty_menu
	destroy_gamertags
	destroy_ready_icons
	Change \{ g_sd_p1_ready = 0 }
	Change \{ g_sd_p2_ready = 0 }
	clean_up_user_control_helpers
	destroy_menu \{ menu_id = scrolling_select_difficulty }
	destroy_menu \{ menu_id = scrolling_select_difficulty2 }
	destroy_menu \{ menu_id = sd_container }
	destroy_menu_backdrop
endscript

script selected_difficulty
	if ($transitions_locked = 0)
		LaunchEvent \{ Type = unfocus Target = vmenu_select_difficulty }
	endif
	Change current_difficulty = <diff>
	Change current_difficulty2 = <diff>
	if ($coop_dlc_active = 1)
		ui_flow_manager_respond_to_action \{ action = continue_coop }
	else
		ui_flow_manager_respond_to_action \{ action = continue }
	endif
endscript
player_selecting_difficulty = 1
g_sd_hilite_props = [
	{ Pos = (224.0, 275.0) }
	{ Pos = (224.0, 325.0) }
	{ Pos = (224.0, 375.0) }
	{ Pos = (224.0, 425.0) }
	{ Pos = (830.0, 275.0) }
	{ Pos = (830.0, 325.0) }
	{ Pos = (830.0, 375.0) }
	{ Pos = (830.0, 425.0) }
	{ Pos = (216.0, 235.0) }
	{ Pos = (216.0, 305.0) }
	{ Pos = (216.0, 375.0) }
	{ Pos = (216.0, 445.0) }
]
g_sd_p1_ready = 0
g_sd_p2_ready = 0

script create_mp_select_difficulty_menu
	Printf ($net_can_send_approval = 1)
	if (($is_network_game = 1)& ($net_can_send_approval = 1))
		net_lobby_state_message {
			current_state = ($net_current_flow_state)
			action = request
			request_state = difficulty
		}
	endif
	spawnscriptnow \{ Menu_Music_On }
	Printf \{ "--- create_mp_select_difficulty_menu" }
	if ($game_mode = p2_career)
		Change \{ rich_presence_context = presence_main_menu }
	endif
	create_menu_backdrop \{ texture = Venue_BG }
	menu_pos_p1 = (240.0, 280.0)
	menu_pos_p2 = (850.0, 280.0)
	menu_font = text_a6
	if ($is_network_game = 1)
		event_handlers_p1 = [
			{pad_up select_difficulty_generic_sound Params = { Player = 1 Up }}
			{pad_down select_difficulty_generic_sound Params = { Player = 1 Down }}
			{pad_back net_difficulty_go_back Params = {Player = 1 Index = menu_select_difficulty_p1_difficulty_index}}
			{ pad_start menu_show_gamercard }
		]
	else
		event_handlers_p1 = [
			{pad_up select_difficulty_generic_sound Params = { Player = 1 Up }}
			{pad_down select_difficulty_generic_sound Params = { Player = 1 Down }}
			{pad_back menu_sd_back_up Params = { Player = 1 }}
		]
	endif
	event_handlers_p2 = [
		{pad_up select_difficulty_generic_sound Params = { Player = 2 Up }}
		{pad_down select_difficulty_generic_sound Params = { Player = 2 Down }}
		{pad_back menu_sd_back_up Params = { Player = 2 }}
	]
	if ($is_network_game = 1)
		<exclusive_dev> = $player1_device
	else
		<exclusive_dev> = $player2_device
	endif
	if ($is_network_game = 1)
		no_focus_value = 1
	else
		no_focus_value = 0
	endif
	new_menu {
		scrollid = scrolling_select_difficulty
		vmenuid = vmenu_select_difficulty
		menu_pos = <menu_pos_p1>
		use_backdrop = (0)
		font = <menu_font>
		font_size = 1.0
		event_handlers = <event_handlers_p1>
		exclusive_device = $player1_device
		no_focus = <no_focus_value>
	}
	new_menu {
		scrollid = scrolling_select_difficulty2
		vmenuid = vmenu_select_difficulty2
		menu_pos = <menu_pos_p2>
		use_backdrop = (0)
		font = <menu_font>
		font_size = 1.0
		event_handlers = <event_handlers_p2>
		exclusive_device = <exclusive_dev>
		no_focus = <no_focus_value>
	}
	CreateScreenElement \{ Type = ContainerElement PARENT = root_window Id = sd_container Pos = (0.0, 0.0) }
	displaySprite \{PARENT = sd_container tex = Difficulty_2p_BG Pos = (640.0, 0.0) just = [ center top ] dims = (915.0, 720.0) z = 1}
	p1_diff_index = 0
	p2_diff_index = 4
	if ($is_network_game = 1)
		ui_print_gamertags \{pos1 = (380.0, 200.0) pos2 = (930.0, 200.0) dims = (350.0, 43.0) just1 = [ center top ] just2 = [ center top ]}
	else
		displayText PARENT = sd_container text = "player" font = <menu_font> Pos = (260.0, 160.0) Scale = 1 rgba = [ 205 105 50 255 ] noshadow
		GetScreenElementDims Id = <Id>
		if (<width> > 150)
			SetScreenElementProps Id = <Id> Scale = 1
			fit_text_in_rectangle Id = <Id> dims = ((150.0, 0.0) + ((0.0, 1.0) * <height>))Pos = (260.0, 160.0)
		endif
		displayText PARENT = sd_container text = "player" font = <menu_font> Pos = (860.0, 160.0) Scale = 1 rgba = [ 205 105 50 255 ] noshadow
		GetScreenElementDims Id = <Id>
		if (<width> > 150)
			SetScreenElementProps Id = <Id> Scale = 1
			fit_text_in_rectangle Id = <Id> dims = ((150.0, 0.0) + ((0.0, 1.0) * <height>))Pos = (860.0, 160.0)
		endif
		displayText \{PARENT = sd_container text = "1" font = text_A11_Large Pos = (320.0, 180.0) Scale = 1 rgba = [ 205 105 50 255 ] noshadow}
		displayText \{PARENT = sd_container text = "2" font = text_A11_Large Pos = (920.0, 180.0) Scale = 1 rgba = [ 205 105 50 255 ] noshadow}
	endif
	displaySprite Id = sd_white_p1 PARENT = sd_container tex = White Pos = ($g_sd_hilite_props [ <p1_diff_index> ].Pos)dims = (228.0, 48.0) rgba = [ 225 120 60 255 ]
	displaySprite Id = sd_white_p2 PARENT = sd_container tex = White Pos = ($g_sd_hilite_props [ <p2_diff_index> ].Pos)dims = (228.0, 48.0) rgba = [ 225 120 60 255 ]
	displaySprite \{PARENT = sd_container tex = Toprockers_Tape_1 Pos = (1150.0, 0.0) dims = (212.0, 128.0) z = 50 rot_angle = 90}
	displaySprite \{PARENT = sd_container tex = Toprockers_Tape_1 Pos = (1155.0, 3.0) dims = (212.0, 128.0) rgba = [ 0 0 0 100 ] z = 49 rot_angle = 90}
	displaySprite \{PARENT = sd_container tex = Toprockers_Tape_2 Pos = (230.0, 550.0) z = 50 rot_angle = 90 dims = (212.0, 128.0)}
	displaySprite \{PARENT = sd_container tex = Toprockers_Tape_2 Pos = (235.0, 553.0) rgba = [ 0 0 0 100 ] z = 49 rot_angle = 90 dims = (212.0, 128.0)}
	if ($game_mode = p2_career)
		get_diff_completion_text \{ for_p2_career = 1 }
		initial_pos = (635.0, 592.0)
		rot = 0
		displayText {
			Id = sd_songs_completed_p1
			PARENT = sd_container
			Pos = <initial_pos>
			Scale = 0.75
			font = text_a6
			rgba = [ 240 220 175 255 ]
			rot = <rot>
			just = [ center center ]
			noshadow
			z = 15
		}
		displaySprite {
			PARENT = sd_container
			Id = diff_select_completed_bg
			tex = Control_pill_body
			Pos = (<initial_pos> + (0.0, -3.0))
			just = [ center center ]
			rgba = [ 225 120 60 255 ]
			z = 10
		}
		sd_songs_completed_p1 ::SetTags diff_completion_text = <diff_completion_text>
		<width> = 500
		completed_dims = (<width> * (1.0, 0.0) + (20.0, 32.0))
		diff_select_completed_bg ::SetProps dims = <completed_dims>
		displaySprite {
			PARENT = sd_container
			tex = Control_pill_end
			Pos = ((625.0, 589.0) - <width> * (0.5, 0.0))
			rgba = [ 225 120 60 255 ]
			just = [ Right center ]
			flip_v
			z = 10
		}
		displaySprite {
			PARENT = sd_container
			tex = Control_pill_end
			Pos = ((645.0, 589.5) + <width> * (0.5, 0.0))
			rgba = [ 225 120 60 255 ]
			just = [ Left center ]
			z = 10
		}
		displayText \{PARENT = sd_container Id = sd_combined_diff_text Pos = (640.0, 500.0) just = [ center center ] font = text_a6 rgba = [ 225 120 60 255 ] Scale = 1.25 noshadow z = 15}
	endif
	if ($is_network_game = 1)
		<choose_script> = net_request_difficulty
		<highlight_script> = net_sd_highlight_menuitem
	else
		<choose_script> = temp_selected_difficulty
		<highlight_script> = sd_highlight_menuitem
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "EASY"
		just = [ Left top ]
		event_handlers = [
			{Focus <highlight_script> Params = {Player = 1 Index = 0 difficulty_index = 0}}
			{pad_choose <choose_script> Params = {Player = 1 diff = easy}}
		]
		exclusive_device = $player1_device
	}
	fit_text_in_rectangle Id = <Id> dims = (180.0, 50.0)
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "MEDIUM"
		just = [ Left top ]
		event_handlers = [
			{Focus <highlight_script> Params = {Player = 1 Index = 1 difficulty_index = 1}}
			{pad_choose <choose_script> Params = {Player = 1 diff = medium}}
		]
		exclusive_device = $player1_device
	}
	fit_text_in_rectangle Id = <Id> dims = (180.0, 50.0)
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "HARD"
		just = [ Left top ]
		event_handlers = [
			{Focus <highlight_script> Params = {Player = 1 Index = 2 difficulty_index = 2}}
			{pad_choose <choose_script> Params = {Player = 1 diff = hard}}
		]
		exclusive_device = $player1_device
	}
	fit_text_in_rectangle Id = <Id> dims = (180.0, 50.0)
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "EXPERT"
		just = [ Left top ]
		event_handlers = [
			{Focus <highlight_script> Params = {Player = 1 Index = 3 difficulty_index = 3}}
			{pad_choose <choose_script> Params = {Player = 1 diff = expert}}
		]
		exclusive_device = $player1_device
	}
	fit_text_in_rectangle Id = <Id> dims = (180.0, 50.0)
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty2
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "EASY"
		just = [ Left top ]
		event_handlers = [
			{Focus sd_highlight_menuitem Params = {Player = 2 Index = 4 difficulty_index = 0}}
			{pad_choose temp_selected_difficulty Params = {Player = 2 diff = easy}}
		]
		exclusive_device = $player2_device
	}
	fit_text_in_rectangle Id = <Id> dims = (180.0, 50.0)
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty2
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "MEDIUM"
		just = [ Left top ]
		event_handlers = [
			{Focus sd_highlight_menuitem Params = {Player = 2 Index = 5 difficulty_index = 1}}
			{pad_choose temp_selected_difficulty Params = {Player = 2 diff = medium}}
		]
		exclusive_device = $player2_device
	}
	fit_text_in_rectangle Id = <Id> dims = (180.0, 50.0)
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty2
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "HARD"
		just = [ Left top ]
		event_handlers = [
			{Focus sd_highlight_menuitem Params = {Player = 2 Index = 6 difficulty_index = 2}}
			{pad_choose temp_selected_difficulty Params = {Player = 2 diff = hard}}
		]
		exclusive_device = $player2_device
	}
	fit_text_in_rectangle Id = <Id> dims = (180.0, 50.0)
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_select_difficulty2
		Id = elxpert_title_text
		font = <menu_font>
		rgba = [ 60 35 20 255 ]
		text = "EXPERT"
		just = [ Left top ]
		event_handlers = [
			{Focus sd_highlight_menuitem Params = {Player = 2 Index = 7 difficulty_index = 3}}
			{pad_choose temp_selected_difficulty Params = {Player = 2 diff = expert}}
		]
		exclusive_device = $player2_device
	}
	fit_text_in_rectangle Id = <Id> dims = (180.0, 50.0)
	displaySprite \{PARENT = sd_container tex = Instrument_2p_Overlay Pos = (0.0, 0.0) dims = (1280.0, 720.0) z = 50 rgba = [ 105 56 7 160 ]}
	if ($is_network_game = 1)
		create_ready_icons \{ pos1 = (260.0, 150.0) pos2 = (880.0, 130.0) }
	else
		create_ready_icons \{ pos1 = (260.0, 200.0) pos2 = (880.0, 180.0) }
	endif
	if ($game_mode = p2_career)
		displaySprite \{PARENT = sd_container Id = diff_select_helper tex = White Pos = (640.0, 620.0) just = [ center center ] rgba = [ 240 215 175 255 ] z = 10}
		displayText \{PARENT = sd_container Pos = (640.0, 622.0) just = [ center center ] text = "Don't wimp out! Lowest difficulty determines cash and unlocks!" rgba = [ 225 120 60 255 ] Scale = (0.5, 0.6000000238418579) z = 11 font = text_a6 noshadow}
		GetScreenElementDims Id = <Id>
		if (<width> > 400)
			SetScreenElementProps Id = <Id> Scale = (0.5, 0.6000000238418579)
			fit_text_in_rectangle Id = <Id> dims = ((400.0, 0.0) + <height> * (0.0, 0.6000000238418579))
		endif
		GetScreenElementDims Id = <Id>
		bg_dims = (<width> * (1.0, 0.0) + (0.0, 32.0))
		diff_select_helper ::SetProps dims = <bg_dims>
	endif
	Change \{ disable_menu_sounds = 1 }
	Change \{ sd_highlight_menuitem_morph = 0 }
	if ($is_network_game = 0)
		launch_num = 0
		switch ($current_difficulty)
			case medium
				<launch_num> = 1
			case hard
				<launch_num> = 2
			case expert
				<launch_num> = 3
		endswitch
		if (<launch_num>)
			begin
				LaunchEvent \{ Type = pad_down Target = vmenu_select_difficulty }
			repeat <launch_num>
		endif
		<launch_num> = 0
		switch ($current_difficulty2)
			case medium
				<launch_num> = 1
			case hard
				<launch_num> = 2
			case expert
				<launch_num> = 3
		endswitch
		if (<launch_num>)
			begin
				LaunchEvent \{ Type = pad_down Target = vmenu_select_difficulty2 }
			repeat <launch_num>
		endif
	endif
	if NOT ($game_mode = p2_career)
		if English
			select_diff_tex = #"0x82389cb4"
		elseif French
			select_diff_tex = #"0xbd149338"
		elseif Spanish
			select_diff_tex = #"0x64af1400"
		elseif German
			select_diff_tex = #"0x0cf1747d"
		elseif Italian
			select_diff_tex = #"0xd3ef2ac2"
		elseif #"0x6eaa363c"
			select_diff_tex = #"0x82389cb4"
		endif
		CreateScreenElement {
			Type = SpriteElement
			PARENT = sd_container
			texture = <select_diff_tex>
			Pos = (640.0, 491.0)
			dims = (160.0, 160.0)
			rgba = [ 255 255 255 255 ]
			just = [ center center ]
			z_priority = 80
		}
	endif
	Change \{ sd_highlight_menuitem_morph = 1 }
	Change \{ disable_menu_sounds = 0 }
	add_user_control_helper \{ text = "SELECT" button = Green z = 100 }
	add_user_control_helper \{ text = "BACK" button = Red z = 100 }
	add_user_control_helper \{ text = "UP/DOWN" button = strumbar z = 100 }
	if (($is_network_game = 1)& ($net_can_send_approval = 1))
		net_lobby_state_message \{ current_state = difficulty action = approval }
		Change \{ net_can_send_approval = 0 }
	endif
endscript
sd_highlight_menuitem_morph = 0

script sd_highlight_menuitem \{ Player = 1 Index = 0 Time = 0.05 }
	Time = ($sd_highlight_time)
	if (<Player> = 1)
		Change menu_select_difficulty_p1_difficulty_index = <difficulty_index>
	else
		Change menu_select_difficulty_p2_difficulty_index = <difficulty_index>
	endif
	min = ($menu_select_difficulty_p1_difficulty_index)
	MathMin a = ($menu_select_difficulty_p1_difficulty_index)b = ($menu_select_difficulty_p2_difficulty_index)
	casttointeger \{ min }
	difficulty_index = <min>
	if (<Player> = 1)
		if (g_sd_p1_ready = 1)
			return
		endif
		if ScreenElementExists \{ Id = sd_white_p1 }
			RunScriptOnScreenElement Id = sd_white_p1 menu_sd_move_highlight Params = {Player = <Player> Time = <Time> Pos = ($g_sd_hilite_props [ <Index> ].Pos)}
		endif
	else
		if (g_sd_p2_ready = 1)
			return
		endif
		if ScreenElementExists \{ Id = sd_white_p2 }
			RunScriptOnScreenElement Id = sd_white_p2 menu_sd_move_highlight Params = {Player = <Player> Time = <Time> Pos = ($g_sd_hilite_props [ <Index> ].Pos)}
		endif
	endif
	if ($game_mode = p2_career)
		if ScreenElementExists \{ Id = sd_songs_completed_p1 }
			sd_songs_completed_p1 ::GetTags
		endif
		if ScreenElementExists \{ Id = sd_combined_diff_text }
			my_diff = ($difficulty_list [ <difficulty_index> ])
			get_difficulty_text difficulty = <my_diff>
			if English
				<difficulty_text> = (<difficulty_text> + "!")
			endif
			SetScreenElementProps Id = sd_combined_diff_text text = <difficulty_text> Scale = 1
			fit_text_in_rectangle \{ Id = sd_combined_diff_text dims = (165.0, 50.0) keep_ar = 1 }
			sd_songs_completed_p1 ::GetTags
			SetScreenElementProps Id = sd_songs_completed_p1 text = (<diff_completion_text> [ <difficulty_index> ])
			GetScreenElementDims \{ Id = sd_songs_completed_p1 }
			if (<width> > 350)
				SetScreenElementProps \{ Id = sd_songs_completed_p1 Scale = 0.75 }
				fit_text_in_rectangle Id = sd_songs_completed_p1 dims = ((350.0, 0.0) + <height> * (0.0, 0.75))
			endif
		endif
	endif
endscript

script select_difficulty_generic_sound
	if (<Player> = 1)
		if ($g_sd_p1_ready = 0)
			generic_menu_up_or_down_sound <...>
		endif
	else
		if ($g_sd_p2_ready = 0)
			generic_menu_up_or_down_sound <...>
		endif
	endif
endscript

script temp_selected_difficulty \{ Player = 1 }
	if (<Player> = 1)
		if ($g_sd_p1_ready = 0)
			Change current_difficulty = <diff>
			Change \{ g_sd_p1_ready = 1 }
			FormatText ChecksumName = ready_container 'ready_container_p%d' d = <Player>
			if ScreenElementExists Id = <ready_container>
				RunScriptOnScreenElement Id = <ready_container> drop_in_ready_sign Params = { Player = <Player> }
			endif
			SetScreenElementProps \{ Id = vmenu_select_difficulty disable_pad_handling }
		endif
	else
		if ($g_sd_p2_ready = 0)
			Change current_difficulty2 = <diff>
			Change \{ g_sd_p2_ready = 1 }
			FormatText ChecksumName = ready_container 'ready_container_p%d' d = <Player>
			if ScreenElementExists Id = <ready_container>
				RunScriptOnScreenElement Id = <ready_container> drop_in_ready_sign Params = { Player = <Player> }
			endif
			SetScreenElementProps \{ Id = vmenu_select_difficulty2 disable_pad_handling }
		endif
	endif
	if (($g_sd_p1_ready)& ($g_sd_p2_ready))
		Change \{ menu_flow_locked = 1 }
		wait \{ 0.5 seconds }
		Change \{ menu_flow_locked = 0 }
		if ($coop_dlc_active = 1)
			ui_flow_manager_respond_to_action \{action = continue_coop create_params = { Player = 2 }}
		else
			ui_flow_manager_respond_to_action \{action = continue create_params = { Player = 2 }}
		endif
	endif
endscript

script menu_sd_back_up \{ Player = 1 }
	if ($menu_flow_locked = 1)
		return
	endif
	if (<Player> = 1)
		if ($g_sd_p1_ready = 1)
			Change \{ g_sd_p1_ready = 0 }
			FormatText ChecksumName = ready_container 'ready_container_p%d' d = <Player>
			if ScreenElementExists Id = <ready_container>
				RunScriptOnScreenElement Id = <ready_container> drop_out_ready_sign Params = { Player = <Player> }
			endif
			SetScreenElementProps \{ Id = vmenu_select_difficulty enable_pad_handling }
		else
			menu_flow_go_back
		endif
	else
		if ($g_sd_p2_ready = 1)
			Change \{ g_sd_p2_ready = 0 }
			FormatText ChecksumName = ready_container 'ready_container_p%d' d = <Player>
			if ScreenElementExists Id = <ready_container>
				RunScriptOnScreenElement Id = <ready_container> drop_out_ready_sign Params = { Player = <Player> }
			endif
			SetScreenElementProps \{ Id = vmenu_select_difficulty2 enable_pad_handling }
		else
			menu_flow_go_back
		endif
	endif
endscript

script menu_sd_move_highlight
	FormatText ChecksumName = hilight_container 'sd_white_p%d' d = <Player>
	if ($sd_highlight_menuitem_morph = 1)
		DoScreenElementMorph Id = <hilight_container> Pos = <Pos> Time = <Time>
	else
		DoScreenElementMorph Id = <hilight_container> Pos = <Pos>
	endif
endscript
