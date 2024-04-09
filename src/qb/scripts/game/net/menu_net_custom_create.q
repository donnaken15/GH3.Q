
script create_custom_create_menu \{ menu_type = custom_match menu_id = custom_match_menu vmenu_id = custom_match_vmenu }
	match_type_vmenu_id = match_type_selection
	match_type_text_id = match_type_selection_text
	game_mode_vmenu_id = game_mode_selection
	game_mode_text_id = game_mode_selection_text
	difficulty_vmenu_id = difficulty_selection
	difficulty_text_id = difficulty_selection_text
	num_songs_vmenu_id = number_of_songs_selection
	num_songs_text_id = number_of_songs_selection_text
	tie_breaker_vmenu_id = tie_breaker_selection
	tie_breaker_text_id = tie_breaker_selection_text
	CreateScreenElement {
		Type = VScrollingMenu
		PARENT = root_window
		Id = <menu_id>
		just = [ center top ]
		dims = (500.0, 480.0)
		Pos = (640.0, 290.0)
		z_priority = 1
	}
	CreateScreenElement {
		Type = VMenu
		PARENT = <menu_id>
		Id = <vmenu_id>
		Pos = (205.0, 0.0)
		just = [ center top ]
		internal_just = [ Left top ]
		dims = (500.0, 480.0)
		event_handlers = [
			{pad_back ui_flow_manager_respond_to_action Params = { action = go_back }}
			{ pad_back generic_menu_pad_back_sound }
			{pad_up generic_menu_up_or_down_sound Params = { Up }}
			{pad_down generic_menu_up_or_down_sound Params = { Down }}
		]
		exclusive_device = ($primary_controller)
	}
	create_menu_backdrop \{ texture = Online_Background }
	CreateScreenElement \{ Type = ContainerElement PARENT = root_window Id = custom_search_container Pos = (0.0, 0.0) }
	displaySprite \{Id = online_frame PARENT = custom_search_container tex = Online_Frame_Large Pos = (640.0, 100.0) just = [ center top ] z = 2}
	displaySprite \{Id = Online_Frame_Crown PARENT = custom_search_container tex = Online_Frame_Crown Pos = (640.0, 42.0) just = [ center top ] z = 3 dims = (256.0, 105.0)}
	CreateScreenElement {
		Type = TextElement
		PARENT = custom_search_container
		font = fontgrid_title_gh3
		Scale = 0.85
		rgba = ($online_dark_purple)
		text = "BROWSE MATCHES"
		Pos = (640.0, 135.0)
		just = [ center top ]
		z_priority = 100.0
	}
	CreateScreenElement {
		Type = TextElement
		Id = game_mode
		PARENT = <vmenu_id>
		font = fontgrid_title_gh3
		Scale = 0.65
		rgba = ($online_light_blue)
		text = "GAME MODE:"
		just = [ Left top ]
		z_priority = 100.0
		event_handlers = [
			{Focus net_custom_ui_focus Params = {this_ID = game_mode text_id = <game_mode_text_id> VMenu = <vmenu_id>}}
			{unfocus net_custom_ui_unfocus Params = { text_id = <game_mode_text_id> }}
			{pad_choose net_custom_ui_change_focus Params = {this_ID = game_mode text_id = <game_mode_text_id> to = <game_mode_vmenu_id> from = <vmenu_id>}}
			{pad_choose net_copy_intial_params Params = {copy_from = SearchGameModeValue copy_to = CopyOfGlobal}}
		]
	}
	CreateScreenElement {
		Type = VMenu
		Id = <game_mode_vmenu_id>
		PARENT = game_mode
		Pos = (550.0, 0.0)
		just = [ Left top ]
		internal_just = [ Left top ]
		event_handlers = [
			{pad_up animate_helper_arrows Params = { direction = Up }}
			{pad_down animate_helper_arrows Params = { direction = Down }}
			{pad_up net_custom_up_down Params = {text = <game_mode_text_id> Global = CopyOfGlobal Type = mode direction = Up}}
			{pad_down net_custom_up_down Params = {text = <game_mode_text_id> Global = CopyOfGlobal Type = mode direction = Down}}
			{pad_back net_commit_or_reset_params Params = {text = <game_mode_text_id> Global = SearchGameModeValue Type = mode}}
			{pad_back net_custom_ui_change_unfocus Params = {action = back to = <vmenu_id> from = <game_mode_vmenu_id> menu = search}}
			{pad_choose net_commit_or_reset_params Params = {commit copy_from = CopyOfGlobal copy_to = SearchGameModeValue}}
			{pad_choose net_custom_ui_change_unfocus Params = {action = choose to = <vmenu_id> from = <game_mode_vmenu_id> menu = search}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		Id = <game_mode_text_id>
		PARENT = <game_mode_vmenu_id>
		font = fontgrid_title_gh3
		Scale = 1.0
		rgba = ($online_light_blue)
		text = ($FilterTypes.mode.values [ ($SearchGameModeValue) ])
		just = [ Left top ]
		z_priority = 100.0
	}
	fit_text_into_menu_item Id = <Id> max_width = 375
	CreateScreenElement {
		Type = TextElement
		Id = difficulty
		PARENT = <vmenu_id>
		font = fontgrid_title_gh3
		Scale = 0.65
		rgba = ($online_light_blue)
		text = "DIFFICULTY:"
		just = [ Left top ]
		z_priority = 100.0
		event_handlers = [
			{Focus net_custom_ui_focus Params = {this_ID = difficulty text_id = <difficulty_text_id> VMenu = <vmenu_id>}}
			{unfocus net_custom_ui_unfocus Params = { text_id = <difficulty_text_id> }}
			{pad_choose net_custom_ui_change_focus Params = {this_ID = difficulty text_id = <difficulty_text_id> to = <difficulty_vmenu_id> from = <vmenu_id>}}
			{pad_choose net_copy_intial_params Params = {copy_from = SearchDifficultyValue copy_to = CopyOfGlobal}}
		]
	}
	CreateScreenElement {
		Type = VMenu
		Id = <difficulty_vmenu_id>
		PARENT = difficulty
		Pos = (550.0, 0.0)
		just = [ Left top ]
		internal_just = [ Left top ]
		event_handlers = [
			{pad_up animate_helper_arrows Params = { direction = Up }}
			{pad_down animate_helper_arrows Params = { direction = Down }}
			{pad_up net_custom_up_down Params = {text = <difficulty_text_id> Global = CopyOfGlobal Type = diff direction = Up}}
			{pad_down net_custom_up_down Params = {text = <difficulty_text_id> Global = CopyOfGlobal Type = diff direction = Down}}
			{pad_back net_commit_or_reset_params Params = {text = <difficulty_text_id> Global = SearchDifficultyValue Type = diff}}
			{pad_back net_custom_ui_change_unfocus Params = {action = back to = <vmenu_id> from = <difficulty_vmenu_id> menu = search diff_focus}}
			{pad_choose net_commit_or_reset_params Params = {commit copy_from = CopyOfGlobal copy_to = SearchDifficultyValue}}
			{pad_choose net_custom_ui_change_unfocus Params = {action = choose to = <vmenu_id> from = <difficulty_vmenu_id> menu = search diff_focus}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		Id = <difficulty_text_id>
		PARENT = <difficulty_vmenu_id>
		font = fontgrid_title_gh3
		Scale = 1.0
		rgba = ($online_light_blue)
		text = ($FilterTypes.diff.values [ ($SearchDifficultyValue) ])
		just = [ Left top ]
		z_priority = 100.0
	}
	fit_text_into_menu_item Id = <Id> max_width = 375
	CreateScreenElement {
		Type = TextElement
		Id = number_of_songs
		PARENT = <vmenu_id>
		font = fontgrid_title_gh3
		Scale = 0.65
		rgba = ($online_light_blue)
		text = "NUMBER OF SONGS:"
		just = [ Left top ]
		z_priority = 100.0
		event_handlers = [
			{Focus net_custom_ui_focus Params = {this_ID = number_of_songs text_id = <num_songs_text_id> VMenu = <vmenu_id>}}
			{unfocus net_custom_ui_unfocus Params = { text_id = <num_songs_text_id> }}
			{pad_choose net_custom_ui_change_focus Params = {this_ID = number_of_songs text_id = <num_songs_text_id> to = <num_songs_vmenu_id> from = <vmenu_id>}}
			{pad_choose net_copy_intial_params Params = {copy_from = SearchNumSongsValue copy_to = CopyOfGlobal}}
		]
	}
	CreateScreenElement {
		Type = VMenu
		Id = <num_songs_vmenu_id>
		PARENT = number_of_songs
		Pos = (550.0, 0.0)
		just = [ Left top ]
		internal_just = [ Left top ]
		event_handlers = [
			{pad_up animate_helper_arrows Params = { direction = Up }}
			{pad_down animate_helper_arrows Params = { direction = Down }}
			{pad_up net_custom_up_down Params = {text = <num_songs_text_id> Global = CopyOfGlobal Type = num_songs direction = Up}}
			{pad_down net_custom_up_down Params = {text = <num_songs_text_id> Global = CopyOfGlobal Type = num_songs direction = Down}}
			{pad_back net_commit_or_reset_params Params = {text = <num_songs_text_id> Global = SearchNumSongsValue Type = num_songs}}
			{pad_back net_custom_ui_change_unfocus Params = {action = back to = <vmenu_id> from = <num_songs_vmenu_id> menu = search}}
			{pad_choose net_commit_or_reset_params Params = {commit copy_from = CopyOfGlobal copy_to = SearchNumSongsValue}}
			{pad_choose net_custom_ui_change_unfocus Params = {action = choose to = <vmenu_id> from = <num_songs_vmenu_id> menu = search}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		Id = <num_songs_text_id>
		PARENT = <num_songs_vmenu_id>
		font = fontgrid_title_gh3
		Scale = 1.0
		rgba = ($online_light_blue)
		text = ($FilterTypes.num_songs.values [ ($SearchNumSongsValue) ])
		just = [ Left top ]
		z_priority = 100.0
	}
	fit_text_into_menu_item Id = <Id> max_width = 375
	CreateScreenElement {
		Type = TextElement
		Id = submit_selection
		PARENT = <vmenu_id>
		font = fontgrid_title_gh3
		Scale = 0.65
		rgba = ($online_light_blue)
		text = "DONE"
		just = [ Left top ]
		z_priority = 100.0
		event_handlers = [
			{Focus net_custom_ui_focus Params = {this_ID = submit_selection VMenu = <vmenu_id>}}
			{ unfocus net_custom_ui_unfocus }
			{ pad_choose custom_create_select_done }
		]
	}
	<vmenu_id> ::SetTags current_focus = first_time
	block_unblock_difficulty_actions \{ menu = search }
	set_focus_color rgba = ($online_dark_purple)
	set_unfocus_color rgba = ($online_light_blue)
	Change \{user_control_pill_text_color = [ 0 0 0 255 ]}
	Change \{user_control_pill_color = [ 180 180 180 255 ]}
	add_user_control_helper \{ text = "SELECT" button = Green z = 100 }
	add_user_control_helper \{ text = "BACK" button = Red z = 100 }
	add_user_control_helper \{ text = "UP/DOWN" button = strumbar z = 100 }
	LaunchEvent Type = Focus Target = <vmenu_id>
endscript

script destroy_custom_create_menu
	if ScreenElementExists \{ Id = custom_search_container }
		DestroyScreenElement \{ Id = custom_search_container }
	endif
	if ScreenElementExists \{ Id = custom_match_menu }
		DestroyScreenElement \{ Id = custom_match_menu }
	endif
	clean_up_user_control_helpers
	destroy_menu_backdrop
endscript

script custom_create_select_done
	Change match_type = ($FilterTypes.Type.checksum [ ($SearchMatchTypeValue) ])
	set_network_preferences
	ui_flow_manager_respond_to_action \{ action = select_done }
endscript

script net_custom_ui_change_focus
	LaunchEvent Type = unfocus Target = <from>
	SoundEvent \{ Event = ui_sfx_select }
	wait \{ 1 Frame }
	if ScreenElementExists Id = <this_ID>
		<this_ID> ::SetProps rgba = ($online_dark_purple)
		<text_id> ::SetProps rgba = ($online_dark_purple)
	endif
	if ScreenElementExists \{ Id = arrow_down }
		DoScreenElementMorph \{ Id = arrow_down Alpha = 1.0 Time = 0.1 }
	endif
	if ScreenElementExists \{ Id = arrow_up }
		DoScreenElementMorph \{ Id = arrow_up Alpha = 1.0 Time = 0.1 }
	endif
	if ScreenElementExists \{ Id = bookend1_over }
		bookend1_over ::SetProps \{ Alpha = 0.0 }
	endif
	if ScreenElementExists \{ Id = highlight_over }
		highlight_over ::GetProps
		highlight_over ::DoMorph Pos = (<Pos> + (480.0, 0.0))Time = 0.1
	endif
	if ScreenElementExists \{ Id = bookend2_over }
		bookend2_over ::SetProps \{ Alpha = 1.0 }
	endif
	LaunchEvent Type = Focus Target = <to>
endscript

script net_custom_ui_change_unfocus
	LaunchEvent Type = unfocus Target = <from>
	if (<action> = choose)
		SoundEvent \{ Event = ui_sfx_select }
	else
		SoundEvent \{ Event = Generic_menu_back_SFX }
	endif
	if ScreenElementExists \{ Id = arrow_down }
		DoScreenElementMorph \{ Id = arrow_down Alpha = 0.0 Time = 0.1 }
	endif
	if ScreenElementExists \{ Id = arrow_up }
		DoScreenElementMorph \{ Id = arrow_up Alpha = 0.0 Time = 0.1 }
	endif
	if ScreenElementExists \{ Id = bookend2_over }
		bookend2_over ::SetProps \{ Alpha = 0.0 }
	endif
	if ScreenElementExists \{ Id = highlight_over }
		highlight_over ::GetProps
		highlight_over ::DoMorph Pos = (<Pos> + (-480.0, 0.0))Time = 0.1
	endif
	if ScreenElementExists \{ Id = bookend1_over }
		bookend1_over ::SetProps \{ Alpha = 1.0 }
	endif
	block_unblock_difficulty_actions <...>
	LaunchEvent Type = Focus Target = <to>
endscript

script net_custom_ui_focus
	<VMenu> ::GetTags
	if NOT (<current_focus> = <this_ID>)
		destroy_prev_selection_highlight
		if ScreenElementExists Id = <this_ID>
			if (<this_ID> = submit_selection)
				displaySprite Id = highlight_over PARENT = <this_ID> tex = White Pos = (-25.0, -10.0) dims = (480.0, 63.0) rgba = ($online_light_blue)just = [ Left top ] z = 4
				displaySprite Id = bookend1_over PARENT = <this_ID> tex = character_hub_hilite_bookend Pos = (-59.0, 20.0) dims = (60.0, 50.0) rgba = ($online_light_blue)just = [ Left center ] z = 4
				displaySprite Id = bookend2_over PARENT = <this_ID> tex = character_hub_hilite_bookend Pos = (445.0, 20.0) dims = (60.0, 50.0) rgba = ($online_light_blue)just = [ Left center ] z = 4
			else
				displaySprite Id = highlight_under PARENT = <this_ID> tex = White Pos = (-25.0, -10.0) dims = (960.0, 63.0) rgba = ($online_light_purple)just = [ Left top ] z = 3
				displaySprite Id = bookend1_under PARENT = <this_ID> tex = character_hub_hilite_bookend Pos = (-59.0, 20.0) dims = (60.0, 50.0) rgba = ($online_light_purple)just = [ Left center ] z = 3
				displaySprite Id = bookend2_under PARENT = <this_ID> tex = character_hub_hilite_bookend Pos = (923.0, 20.0) dims = (60.0, 50.0) rgba = ($online_light_purple)just = [ Left center ] z = 3
				displaySprite Id = highlight_over PARENT = <this_ID> tex = White Pos = (-25.0, -10.0) dims = (480.0, 63.0) rgba = ($online_light_blue)just = [ Left top ] z = 4
				displaySprite Id = bookend1_over PARENT = <this_ID> tex = character_hub_hilite_bookend Pos = (-59.0, 20.0) dims = (60.0, 50.0) rgba = ($online_light_blue)just = [ Left center ] z = 4
				displaySprite Id = bookend2_over PARENT = <this_ID> tex = character_hub_hilite_bookend Pos = (923.0, 20.0) dims = (60.0, 50.0) rgba = ($online_light_blue)just = [ Left center ] z = 4
				displaySprite Id = arrow_down PARENT = <this_ID> tex = Online_Arrow Pos = (490.0, 40.0) dims = (44.0, 32.0) rgba = ($online_dark_purple)just = [ center center ] z = 5
				displaySprite Id = arrow_up PARENT = <this_ID> tex = Online_Arrow Pos = (490.0, 0.0) dims = (44.0, 32.0) rgba = ($online_dark_purple)just = [ center center ] z = 5 flip_h
				bookend2_over ::SetProps \{ Alpha = 0.0 }
				arrow_down ::SetProps \{ Alpha = 0.0 }
				arrow_up ::SetProps \{ Alpha = 0.0 preserve_flip }
			endif
		endif
		<VMenu> ::SetTags current_focus = <this_ID>
	endif
	retail_menu_focus
	if ScreenElementExists Id = <text_id>
		<text_id> ::SetProps rgba = ($online_dark_purple)
	endif
endscript

script net_custom_ui_unfocus
	retail_menu_unfocus
	if ScreenElementExists Id = <text_id>
		<text_id> ::SetProps rgba = ($online_light_blue)
	endif
endscript

script destroy_prev_selection_highlight
	if ScreenElementExists \{ Id = highlight_under }
		DestroyScreenElement \{ Id = highlight_under }
	endif
	if ScreenElementExists \{ Id = bookend1_under }
		DestroyScreenElement \{ Id = bookend1_under }
	endif
	if ScreenElementExists \{ Id = bookend2_under }
		DestroyScreenElement \{ Id = bookend2_under }
	endif
	if ScreenElementExists \{ Id = highlight_over }
		DestroyScreenElement \{ Id = highlight_over }
	endif
	if ScreenElementExists \{ Id = bookend1_over }
		DestroyScreenElement \{ Id = bookend1_over }
	endif
	if ScreenElementExists \{ Id = bookend2_over }
		DestroyScreenElement \{ Id = bookend2_over }
	endif
	if ScreenElementExists \{ Id = arrow_up }
		DestroyScreenElement \{ Id = arrow_up }
	endif
	if ScreenElementExists \{ Id = arrow_down }
		DestroyScreenElement \{ Id = arrow_down }
	endif
endscript

script animate_helper_arrows
	if (<direction> = Up)
		generic_menu_up_or_down_sound \{ Up }
		if ScreenElementExists \{ Id = arrow_up }
			arrow_up ::DoMorph \{ Scale = (1.7999999523162842, 1.5) Time = 0.1 }
			arrow_up ::DoMorph \{ Scale = (1.375, 1.0) Time = 0.1 }
		endif
	else
		generic_menu_up_or_down_sound \{ Down }
		if ScreenElementExists \{ Id = arrow_down }
			arrow_down ::DoMorph \{ Scale = (1.7999999523162842, 1.5) Time = 0.1 }
			arrow_down ::DoMorph \{ Scale = (1.375, 1.0) Time = 0.1 }
		endif
	endif
endscript
