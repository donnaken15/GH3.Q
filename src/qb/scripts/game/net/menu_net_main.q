info_text = [
	"Jump right into a Player Match and rock the house against the first rocker available."
	"Jump right into a Ranked Match and rock the house against the first rocker available."
	"Search for a specific type of online match."
	"Join a private match created by a friend."
	"Create and host your own online match."
	"Setup and make changes to your Quick Match Options."
	"Check out who the best of the best are and see where you rank."
	"Downloads Coming Soon!"
	"Select 'Message Of The Day' to see the latest news in the Guitar Hero universe."
	"Manage your online account."
]
online_main_menu_pos = (470.0, 110.0)
online_info_pane_pos = (890.0, 150.0)

script create_online_main_menu \{ menu_title_xenon = "Online Main Menu" menu_title_ps3 = "Online Main Menu" menu_id = online_main_menu vmenu_id = online_main_vmenu }
	Change \{ winport_block_net_pause = 0 }
	Change \{ gIsInNetGame = 0 }
	Change \{ online_main_menu_pos = (470.0, 110.0) }
	Change \{ online_info_pane_pos = (890.0, 150.0) }
	Change \{ gPrivateMatchId = 0 }
	online_menu_init
	Change \{ rich_presence_context = presence_main_menu }
	spawnscriptnow \{ Menu_Music_On }
	CreateScreenElement \{ Type = ContainerElement PARENT = root_window Id = main_menu_anchor Pos = (0.0, 0.0) }
	CreateScreenElement {
		Type = VScrollingMenu
		PARENT = main_menu_anchor
		Id = <menu_id>
		just = [ center top ]
		dims = (400.0, 480.0)
		Pos = (($online_main_menu_pos)+ (0.0, 75.0))
		z_priority = 1
	}
	CreateScreenElement {
		Type = VMenu
		PARENT = <menu_id>
		Id = <vmenu_id>
		Pos = (47.5, 0.0)
		just = [ Left top ]
		internal_just = [ center top ]
		dims = (400.0, 480.0)
		event_handlers = [
			{ pad_back return_from_online_main_menu }
			{ pad_back generic_menu_pad_back }
			{pad_up generic_menu_up_or_down_sound Params = { Up }}
			{pad_down generic_menu_up_or_down_sound Params = { Down }}
		]
		exclusive_device = ($primary_controller)
	}
	CreateScreenElement \{ Type = ContainerElement PARENT = main_menu_anchor Id = online_main_menu_container Pos = (0.0, 0.0) }
	CreateScreenElement \{ Type = ContainerElement PARENT = online_main_menu_container Id = online_main_menu_text_container Pos = (0.0, 0.0) }
	CreateScreenElement \{ Type = ContainerElement PARENT = main_menu_anchor Id = online_info_pane_container Pos = (0.0, 0.0) }
	CreateScreenElement \{ Type = ContainerElement PARENT = online_info_pane_container Id = online_info_pane_text_container Pos = (0.0, 0.0) }
	create_menu_backdrop \{ texture = Online_Background }
	displaySprite Id = online_frame PARENT = online_main_menu_container tex = Online_Frame_Large Pos = ($online_main_menu_pos)dims = (660.0, 480.0) just = [ center top ] z = 2
	displaySprite Id = Online_Frame_Crown PARENT = online_main_menu_container tex = Online_Frame_Crown Pos = (($online_main_menu_pos)+ (0.0, -62.0))dims = (256.0, 105.0) just = [ center top ] z = 3
	displaySprite Id = motd_top PARENT = online_info_pane_container tex = window_frame_cap rgba = ($online_medium_blue)Pos = ($online_info_pane_pos)dims = (320.0, 64.0) just = [ center top ] z = 5
	displaySprite Id = motd_top_fill PARENT = online_info_pane_container tex = window_fill_cap rgba = [ 0 0 0 200 ] Pos = ($online_info_pane_pos)dims = (320.0, 64.0) just = [ center top ] z = 5
	displaySprite Id = motd_body PARENT = online_info_pane_container tex = window_frame_body_tall rgba = ($online_medium_blue)Pos = (($online_info_pane_pos)+ (0.0, 64.0))dims = (320.0, 256.0) just = [ center top ] z = 5 flip_h
	displaySprite Id = motd_body_fill PARENT = online_info_pane_container tex = window_fill_body_large rgba = [ 0 0 0 200 ] Pos = (($online_info_pane_pos)+ (0.0, 64.0))dims = (320.0, 256.0) just = [ center top ] z = 5 flip_h
	displaySprite Id = motd_end PARENT = online_info_pane_container tex = window_frame_cap rgba = ($online_medium_blue)Pos = (($online_info_pane_pos)+ (0.0, 320.0))dims = (320.0, 64.0) just = [ center top ] z = 5 flip_h
	displaySprite Id = motd_end_fill PARENT = online_info_pane_container tex = window_fill_cap rgba = [ 0 0 0 200 ] Pos = (($online_info_pane_pos)+ (0.0, 320.0))dims = (320.0, 64.0) just = [ center top ] z = 5 flip_h
	displaySprite Id = info_divide PARENT = online_info_pane_text_container tex = store_frame_bottom_bg rgba = ($online_light_blue)Pos = (($online_info_pane_pos)+ (-5.0, 240.0))dims = (320.0, 56.0) just = [ center center ] z = 6
	if IsXenon
		CreateScreenElement {
			Type = TextElement
			PARENT = online_main_menu_text_container
			Id = online_title
			font = fontgrid_title_gh3
			Scale = 0.85
			rgba = ($online_dark_purple)
			Pos = (($online_main_menu_pos)+ (0.0, 35.0))
			text = <menu_title_xenon>
			just = [ center top ]
			z_priority = 4.0
		}
	else
		CreateScreenElement {
			Type = TextElement
			PARENT = online_main_menu_text_container
			Id = online_title
			font = fontgrid_title_gh3
			Scale = 0.85
			rgba = ($online_dark_purple)
			Pos = (($online_main_menu_pos)+ (0.0, 35.0))
			text = <menu_title_ps3>
			just = [ center top ]
			z_priority = 4.0
		}
	endif
	GetScreenElementDims Id = <Id>
	if (<width> > 420)
		SetScreenElementProps {
			Id = <Id>
			Scale = 1.0
		}
		scale_element_to_size {
			Id = <Id>
			target_width = 420
			target_height = <height>
		}
	endif
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "Quick Match"
		info_text_index = 0
		pad_choose_script = online_menu_select_quickmatch_player
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "Browse Matches"
		info_text_index = 2
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = { action = select_custom_match }
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "Join Private Match"
		info_text_index = 3
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = { action = select_join_private }
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "Create Match"
		info_text_index = 4
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = { action = select_create_match }
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "Quick Match Player Options"
		info_text_index = 5
		pad_choose_script = online_menu_select_options
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "Leaderboards"
		info_text_index = 6
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = { action = select_leaderboards }
	}
	if IsXenon
		net_add_item_to_main_menu {
			VMenu = <vmenu_id>
			text = "Downloadable Content"
			info_text_index = 7
			pad_choose_script = null_script
			pad_choose_script2 = SoundEvent
			choose_script_params2 = { Event = ui_sfx_select }
		}
	endif
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "Message Of The Day"
		info_text_index = 8
		pad_choose_script = online_menu_select_motd
		pad_choose_script2 = SoundEvent
		choose_script_params2 = { Event = ui_sfx_select }
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = "Account Management"
		info_text_index = 9
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = { action = select_account_management }
		pad_choose_script2 = SoundEvent
		choose_script_params2 = { Event = ui_sfx_select }
	}
	CreateScreenElement {
		Type = TextBlockElement
		PARENT = online_info_pane_text_container
		Id = help_info_text_block
		font = text_A4
		Scale = (0.75, 0.6500000357627869)
		rgba = ($online_light_blue)
		text = ($info_text [ 0 ])
		just = [ center top ]
		internal_just = [ center top ]
		z_priority = 6.0
		Pos = (($online_info_pane_pos)+ (-4.0, 20.0))
		dims = (320.0, 370.0)
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = online_info_pane_text_container
		Id = motd_info_pane_title
		font = text_A4
		text = "Message of the Day"
		Scale = 0.65
		rgba = ($online_light_blue)
		Pos = (($online_info_pane_pos)+ (0.0, 264.0))
		just = [ center top ]
		z_priority = 6.0
	}
	CreateScreenElement {
		Type = WindowElement
		PARENT = online_info_pane_text_container
		Id = motd_ticker_window
		Pos = (($online_info_pane_pos)+ (0.0, 312.0))
		dims = (248.0, 32.0)
		just = [ center top ]
	}
	CreateScreenElement {
		Type = TextBlockElement
		PARENT = motd_ticker_window
		Id = motd_ticker_text_block
		just = [ Left top ]
		internal_just = [ Left top ]
		Pos = (0.0, 0.0)
		Scale = (0.75, 0.550000011920929)
		text = ""
		font = text_A4
		rgba = ($online_light_blue)
		z_priority = 100
		dims = (670.0, 1500.0)
		line_spacing = 1.0
	}
	spawnscriptnow \{ get_motd_and_start_ticker }
	if NOT IsXenon
		if NOT NetSessionFunc \{ Obj = voice func = voice_allowed }
			CreateScreenElement {
				Type = TextBlockElement
				PARENT = online_info_pane_container
				just = [ center top ]
				internal_just = [ center top ]
				Pos = (640.0, 585.0)
				Scale = (0.550000011920929, 0.550000011920929)
				text = "Chat is disabled on your PLAYSTATION®Network account due to parental control restrictions."
				font = text_A4
				rgba = ($online_light_blue)
				z_priority = 6.0
				dims = (1500.0, 120.0)
			}
		endif
	endif
	set_focus_color rgba = ($online_dark_purple)
	set_unfocus_color rgba = ($online_light_blue)
	create_online_main_menu_helper_buttons
	LaunchEvent Type = Focus Target = <vmenu_id>
endscript

script destroy_online_main_menu
	clean_up_user_control_helpers
	destroy_menu_backdrop
	if ScreenElementExists \{ Id = main_menu_anchor }
		DestroyScreenElement \{ Id = main_menu_anchor }
	endif
	killspawnedscript \{ name = scroll_motd_ticker }
endscript

script create_online_main_menu_helper_buttons
	Change \{user_control_pill_text_color = [ 0 0 0 255 ]}
	Change \{user_control_pill_color = [ 180 180 180 255 ]}
	add_user_control_helper \{ text = "SELECT" button = Green z = 100 }
	add_user_control_helper \{ text = "BACK" button = Red z = 100 }
	add_user_control_helper \{ text = "UP/DOWN" button = strumbar z = 100 }
endscript

script get_motd_and_start_ticker
	if ($retrieved_message_of_the_day = 0)
		NetSessionFunc \{Obj = motd func = get_demonware_motd Params = { callback = motd_callback }}
	else
		motd_ticker_text_block ::SetProps text = ($message_of_the_day)
		spawnscriptnow \{scroll_motd_ticker Params = { Id = motd_ticker_text_block }}
	endif
endscript

script motd_callback
	if GotParam \{ motd_text }
		Change \{ retrieved_message_of_the_day = 1 }
		Change message_of_the_day = <motd_text>
		if ScreenElementExists \{ Id = motd_ticker_text_block }
			motd_ticker_text_block ::SetProps text = ($message_of_the_day)
			spawnscriptnow \{scroll_motd_ticker Params = { Id = motd_ticker_text_block }}
		endif
	endif
endscript

script scroll_motd_ticker \{ scroll_time = 20 }
	<end_pos> = (-1000.0, 0.0)
	<this_ID> = <Id>
	GetScreenElementChildren Id = <this_ID>
	if GotParam \{ children }
		begin
			begin
				wait \{ 2 seconds }
				DoScreenElementMorph Id = <this_ID> Pos = <end_pos> Time = <scroll_time>
				wait \{ 5 seconds }
				GetScreenElementProps Id = <this_ID>
				SetScreenElementProps Id = <this_ID> Pos = <Pos>
				wait \{ 2.0 seconds }
				<this_ID> ::DoMorph Alpha = 0 Time = 0.2
				<this_ID> ::SetProps Pos = (0.0, 0.0)
				wait \{ 0.5 seconds }
				<this_ID> ::DoMorph Alpha = 1 Time = 0.2
				break
			repeat
		repeat
	endif
endscript

script return_from_online_main_menu
	Printf \{ "--- deinitializing network layer" }
	shut_down_net_play
	ui_flow_manager_respond_to_action \{ action = go_back }
endscript

script online_menu_select_quickmatch_player
	Change \{ match_type = Player }
	set_network_preferences
	ui_flow_manager_respond_to_action \{ action = select_quickmatch_player }
endscript

script online_menu_select_quickmatch_ranked
	Change \{ match_type = Ranked }
	set_network_preferences
	ui_flow_manager_respond_to_action \{ action = select_quickmatch_ranked }
endscript

script online_menu_select_options
	ui_flow_manager_respond_to_action \{ action = select_online_options }
endscript

script lobby_connection_lost
	Printf \{ "---lobby_connection_lost performing net cleanup" }
	EndGameNetScriptPump
	if (IsHost)
		isHosting = 1
	else
		isHosting = 0
	endif
	if ($gHandlingWindowClosed = 1 || <isHosting> = 0)
		quit_network_game
		setup_sessionfuncs
		destroy_popup_warning_menu
		ui_flow_manager_respond_to_action \{ action = connection_lost }
	endif
	Change \{ gHandlingWindowClosed = 0 }
endscript

script online_menu_select_website
	create_link_text
	hide_unhide_menu_elements \{ Id = online_info_pane_container Time = 0.2 Hide }
	wait \{ 0.1 seconds }
	hide_unhide_menu_elements \{ Id = online_main_menu_text_container Time = 0.2 Hide }
	hide_unhide_menu_elements \{ Id = online_main_vmenu Time = 0.2 Hide }
	translate_and_scale_online_menu
	wait \{ 0.3 seconds }
	if ScreenElementExists \{ Id = gh_link_container }
		RunScriptOnScreenElement \{Id = gh_link_container DoScreenElementMorph Params = { Id = gh_link_container Alpha = 1.0 Time = 0.2 }}
	endif
	ghlink_vmenu ::SetProps \{ enable_pad_handling }
	LaunchEvent \{ Type = Focus Target = ghlink_vmenu }
endscript

script online_menu_unselect_website
	if ScreenElementExists \{ Id = gh_link_container }
		RunScriptOnScreenElement \{Id = gh_link_container DoScreenElementMorph Params = { Id = gh_link_container Alpha = 0.0 Time = 0.2 }}
	endif
	wait \{ 0.3 seconds }
	if ScreenElementExists \{ Id = gh_link_container }
		DestroyScreenElement \{ Id = gh_link_container }
	endif
	translate_and_scale_online_menu \{ revert }
	hide_unhide_menu_elements \{ Id = online_main_menu_text_container Time = 0.2 }
	hide_unhide_menu_elements \{ Id = online_main_vmenu Time = 0.2 }
	wait \{ 0.1 seconds }
	hide_unhide_menu_elements \{ Id = online_info_pane_container Time = 0.2 }
	wait \{ 0.3 seconds }
	LaunchEvent \{ Type = Focus Target = online_main_vmenu }
endscript

script create_link_text
	CreateScreenElement \{ Type = ContainerElement PARENT = online_main_menu_container Id = gh_link_container Pos = (0.0, 0.0) }
	CreateScreenElement \{Type = VScrollingMenu PARENT = gh_link_container Id = ghlink just = [ center top ] dims = (400.0, 480.0) Pos = (320.0, 200.0) z_priority = 1}
	CreateScreenElement {
		Type = VMenu
		PARENT = ghlink
		Id = ghlink_vmenu
		Pos = (0.0, 0.0)
		just = [ Left top ]
		internal_just = [ center top ]
		dims = (400.0, 480.0)
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_back SoundEvent Params = { Event = Generic_menu_back_SFX }}
			{ pad_back online_menu_unselect_website }
			{ pad_back clean_up_user_control_helpers }
			{ pad_back create_online_main_menu_helper_buttons }
		]
	}
	<Id> ::SetProps disable_pad_handling
	CreateScreenElement {
		Type = TextElement
		PARENT = gh_link_container
		Id = gh_link_title
		font = fontgrid_title_gh3
		Scale = 0.85
		rgba = ($online_dark_purple)
		text = "www.guitarhero.com"
		just = [ center top ]
		Pos = (640.0, 111.0)
		z_priority = 4.0
	}
	CreateScreenElement {
		Type = TextBlockElement
		PARENT = gh_link_container
		font = text_A4
		Scale = (0.75, 0.75)
		rgba = ($online_light_blue)
		text = "Ready to Be A Guitar Hero? \\nHere's how to link your stats to the web community:"
		just = [ center top ]
		internal_just = [ center top ]
		z_priority = 6.0
		Pos = (640.0, 160.0)
		dims = (950.0, 200.0)
	}
	CreateScreenElement {
		Type = TextBlockElement
		PARENT = gh_link_container
		font = text_A4
		Scale = (0.75, 0.75)
		rgba = ($online_light_blue)
		text = "- Go to www.guitarhero.com\\n- Create a New Account or Login\\n- Click 'Link Account'\\n- Enter the following VIP Passcode"
		just = [ center top ]
		internal_just = [ Left top ]
		z_priority = 6.0
		Pos = (640.0, 240.0)
		dims = (1010.0, 600.0)
	}
	NetSessionFunc \{ func = get_agora_token }
	FormatText textname = vip_code "%a" a = <Token>
	CreateScreenElement {
		Type = TextElement
		PARENT = gh_link_container
		font = text_a3
		Scale = 1.25
		rgba = ($online_light_blue)
		text = <vip_code>
		just = [ center top ]
		z_priority = 6.0
		Pos = (640.0, 410.0)
		font_spacing = 5
	}
	CreateScreenElement {
		Type = TextBlockElement
		PARENT = gh_link_container
		font = text_A4
		Scale = (0.75, 0.75)
		rgba = ($online_light_blue)
		text = "On the web you can personalize your profile, browse leaderboards, jam with an online band, collect groupies, and rock out in tournaments!"
		just = [ center top ]
		internal_just = [ Left top ]
		z_priority = 6.0
		Pos = (648.0, 460.0)
		dims = (1010.0, 600.0)
	}
	if ScreenElementExists \{ Id = gh_link_container }
		RunScriptOnScreenElement \{Id = gh_link_container DoScreenElementMorph Params = { Id = gh_link_container Alpha = 0.0 }}
	endif
	clean_up_user_control_helpers
	Change \{user_control_pill_text_color = [ 0 0 0 255 ]}
	Change \{user_control_pill_color = [ 180 180 180 255 ]}
	add_user_control_helper \{ text = "BACK" button = Red z = 100 }
	LaunchEvent \{ Type = unfocus Target = online_main_vmenu }
endscript

script online_menu_select_motd
	create_motd_text
	hide_unhide_menu_elements \{ Id = online_main_menu_container Time = 0.2 Hide }
	hide_unhide_menu_elements \{ Id = online_main_vmenu Time = 0.2 Hide }
	wait \{ 0.1 seconds }
	hide_unhide_menu_elements \{ Id = online_info_pane_text_container Time = 0.2 Hide }
	translate_and_scale_info_pane
	wait \{ 0.3 seconds }
	if ScreenElementExists \{ Id = motd_container }
		RunScriptOnScreenElement \{Id = motd_container DoScreenElementMorph Params = { Id = motd_container Alpha = 1.0 Time = 0.2 }}
	endif
	LaunchEvent \{ Type = Focus Target = motd_vmenu }
	motd_vmenu ::SetProps \{ enable_pad_handling }
endscript

script online_menu_unselect_motd
	if ScreenElementExists \{ Id = motd_container }
		RunScriptOnScreenElement \{Id = motd_container DoScreenElementMorph Params = { Id = motd_container Alpha = 0.0 Time = 0.2 }}
	endif
	wait \{ 0.3 seconds }
	destroy_menu \{ menu_id = motd_scroller }
	if ScreenElementExists \{ Id = motd_container }
		DestroyScreenElement \{ Id = motd_container }
	endif
	translate_and_scale_info_pane \{ revert }
	hide_unhide_menu_elements \{ Id = online_info_pane_text_container Time = 0.2 }
	wait \{ 0.1 seconds }
	hide_unhide_menu_elements \{ Id = online_main_vmenu Time = 0.2 }
	hide_unhide_menu_elements \{ Id = online_main_menu_container Time = 0.2 }
	wait \{ 0.3 seconds }
	LaunchEvent \{ Type = Focus Target = online_main_vmenu }
endscript

script create_motd_text
	CreateScreenElement \{ Type = ContainerElement PARENT = online_info_pane_container Id = motd_container Pos = (0.0, 0.0) }
	CreateScreenElement \{Type = VScrollingMenu PARENT = motd_container Id = motd_scroller just = [ center top ] dims = (400.0, 480.0) Pos = (640.0, 0.0) z_priority = 1}
	CreateScreenElement {
		Type = VMenu
		PARENT = motd_scroller
		Id = motd_vmenu
		Pos = (0.0, 0.0)
		just = [ Left top ]
		internal_just = [ center top ]
		dims = (400.0, 480.0)
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_back SoundEvent Params = { Event = Generic_menu_back_SFX }}
			{ pad_back online_menu_unselect_motd }
			{ pad_back clean_up_user_control_helpers }
			{ pad_back create_online_main_menu_helper_buttons }
		]
	}
	<Id> ::SetProps disable_pad_handling
	CreateScreenElement {
		Type = TextElement
		PARENT = motd_container
		Id = gh_link_title
		font = fontgrid_title_gh3
		Scale = 0.85
		rgba = ($online_light_blue)
		text = "Message Of The Day"
		just = [ center top ]
		Pos = (640.0, 160.0)
		z_priority = 10.0
	}
	CreateScreenElement \{Type = WindowElement PARENT = motd_container Id = motd_info_scroll_window Pos = (633.0, 220.0) dims = (500.0, 300.0) just = [ center top ]}
	CreateScreenElement {
		Type = TextBlockElement
		PARENT = motd_info_scroll_window
		Id = motd_info_text_block
		just = [ Left top ]
		internal_just = [ Left top ]
		Pos = (0.0, 0.0)
		Scale = (0.75, 0.550000011920929)
		text = ($message_of_the_day)
		font = text_A4
		rgba = ($online_light_blue)
		z_priority = 100
		dims = (670.0, 1500.0)
		line_spacing = 1.0
	}
	spawnscriptnow \{scroll_motd_info Params = { Id = motd_info_text_block }}
	if ScreenElementExists \{ Id = motd_container }
		motd_container ::SetProps \{ Alpha = 0.0 }
	endif
	clean_up_user_control_helpers
	Change \{user_control_pill_text_color = [ 0 0 0 255 ]}
	Change \{user_control_pill_color = [ 180 180 180 255 ]}
	add_user_control_helper \{ text = "BACK" button = Red z = 100 }
	LaunchEvent \{ Type = unfocus Target = online_main_vmenu }
endscript

script scroll_motd_info \{ scroll_time = 60 }
	<end_pos> = (0.0, -1000.0)
	<this_ID> = <Id>
	GetScreenElementChildren Id = <this_ID>
	if GotParam \{ children }
		GetArraySize (<children>)
		<line_nums> = <array_Size>
	else
		return
	endif
	if (<line_nums> > 10)
		begin
			begin
				wait \{ 5 seconds }
				DoScreenElementMorph Id = <this_ID> Pos = <end_pos> Time = <scroll_time>
				wait ((<line_nums> - 10)* 1.8)seconds
				GetScreenElementProps Id = <this_ID>
				SetScreenElementProps Id = <this_ID> Pos = <Pos>
				wait \{ 4.0 seconds }
				<this_ID> ::DoMorph Alpha = 0 Time = 0.2
				<this_ID> ::SetProps Pos = (0.0, 0.0)
				wait \{ 0.5 seconds }
				<this_ID> ::DoMorph Alpha = 1 Time = 0.2
				break
			repeat
		repeat
	endif
endscript

script translate_and_scale_online_menu
	if NOT GotParam \{ revert }
		RunScriptOnScreenElement Id = online_frame DoScreenElementMorph Params = {Id = online_frame Pos = (($online_main_menu_pos)+ (170.0, -35.0))Time = 0.2}
		RunScriptOnScreenElement Id = Online_Frame_Crown DoScreenElementMorph Params = {Id = Online_Frame_Crown Pos = (($online_main_menu_pos)+ (180.0, -88.0))Time = 0.2}
		RunScriptOnScreenElement \{Id = online_frame scale_element_to_size Params = { Id = online_frame target_width = 760 target_height = 500 Time = 0.2 }}
	else
		RunScriptOnScreenElement Id = online_frame DoScreenElementMorph Params = {Id = online_frame Pos = ($online_main_menu_pos)Time = 0.2}
		RunScriptOnScreenElement Id = Online_Frame_Crown DoScreenElementMorph Params = {Id = Online_Frame_Crown Pos = (($online_main_menu_pos)+ (0.0, -62.0))Time = 0.2}
		online_frame ::SetProps \{ Scale = 1.0 }
		RunScriptOnScreenElement \{Id = online_frame scale_element_to_size Params = { Id = online_frame target_width = 660 target_height = 480 Time = 0.2 }}
	endif
endscript

script translate_and_scale_info_pane
	if NOT GotParam \{ revert }
		RunScriptOnScreenElement Id = motd_top DoScreenElementMorph Params = {Id = motd_top Pos = (($online_info_pane_pos)+ (-250.0, -32.0))Time = 0.2}
		RunScriptOnScreenElement Id = motd_top_fill DoScreenElementMorph Params = {Id = motd_top_fill Pos = (($online_info_pane_pos)+ (-250.0, -32.0))Time = 0.2}
		RunScriptOnScreenElement Id = motd_body DoScreenElementMorph Params = {Id = motd_body Pos = (($online_info_pane_pos)+ (-250.0, 64.0))Time = 0.2}
		RunScriptOnScreenElement Id = motd_body_fill DoScreenElementMorph Params = {Id = motd_body_fill Pos = (($online_info_pane_pos)+ (-250.0, 64.0))Time = 0.2}
		RunScriptOnScreenElement Id = motd_end DoScreenElementMorph Params = {Id = motd_end Pos = (($online_info_pane_pos)+ (-250.0, 320.0))Time = 0.2}
		RunScriptOnScreenElement Id = motd_end_fill DoScreenElementMorph Params = {Id = motd_end_fill Pos = (($online_info_pane_pos)+ (-250.0, 320.0))Time = 0.2}
		RunScriptOnScreenElement \{Id = motd_top scale_element_to_size Params = { Id = motd_top target_width = 800 target_height = 96 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_top_fill scale_element_to_size Params = { Id = motd_top_fill target_width = 800 target_height = 96 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_body scale_element_to_size Params = { Id = motd_body target_width = 800 target_height = 256 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_body_fill scale_element_to_size Params = { Id = motd_body_fill target_width = 800 target_height = 256 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_end scale_element_to_size Params = { Id = motd_end target_width = 800 target_height = 96 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_end_fill scale_element_to_size Params = { Id = motd_end_fill target_width = 800 target_height = 96 Time = 0.2 }}
	else
		RunScriptOnScreenElement Id = motd_top DoScreenElementMorph Params = {Id = motd_top Pos = ($online_info_pane_pos)Time = 0.2}
		RunScriptOnScreenElement Id = motd_top_fill DoScreenElementMorph Params = {Id = motd_top_fill Pos = ($online_info_pane_pos)Time = 0.2}
		RunScriptOnScreenElement Id = motd_body DoScreenElementMorph Params = {Id = motd_body Pos = (($online_info_pane_pos)+ (0.0, 64.0))Time = 0.2}
		RunScriptOnScreenElement Id = motd_body_fill DoScreenElementMorph Params = {Id = motd_body_fill Pos = (($online_info_pane_pos)+ (0.0, 64.0))Time = 0.2}
		RunScriptOnScreenElement Id = motd_end DoScreenElementMorph Params = {Id = motd_end Pos = (($online_info_pane_pos)+ (0.0, 320.0))Time = 0.2}
		RunScriptOnScreenElement Id = motd_end_fill DoScreenElementMorph Params = {Id = motd_end_fill Pos = (($online_info_pane_pos)+ (0.0, 320.0))Time = 0.2}
		RunScriptOnScreenElement \{Id = motd_top scale_element_to_size Params = { Id = motd_top target_width = 800 target_height = 96 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_top_fill scale_element_to_size Params = { Id = motd_top_fill target_width = 800 target_height = 96 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_body scale_element_to_size Params = { Id = motd_body target_width = 800 target_height = 256 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_body_fill scale_element_to_size Params = { Id = motd_body_fill target_width = 800 target_height = 256 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_end scale_element_to_size Params = { Id = motd_end target_width = 800 target_height = 96 Time = 0.2 }}
		RunScriptOnScreenElement \{Id = motd_end_fill scale_element_to_size Params = { Id = motd_end_fill target_width = 800 target_height = 96 Time = 0.2 }}
	endif
endscript

script hide_unhide_menu_elements \{ Time = 0.0 }
	if ScreenElementExists Id = <Id>
		if GotParam \{ Hide }
			RunScriptOnScreenElement Id = <Id> DoScreenElementMorph Params = {Alpha = 0.0 Time = <Time> Id = <Id>}
		else
			RunScriptOnScreenElement Id = <Id> DoScreenElementMorph Params = {Alpha = 1.0 Time = <Time> Id = <Id>}
		endif
	endif
endscript

script create_net_play_song_menu
endscript

script destroy_net_play_song_menu
endscript

script online_select_downloads
	NetSessionFunc \{ func = ShowMarketPlaceUI }
	wait_for_blade_complete
	SetPakManCurrentBlock \{ map = Zones pak = None block_scripts = 1 }
	destroy_band
	Downloads_UnloadContent
	ui_flow_manager_respond_to_action \{ action = select_downloadable_content }
endscript

script net_add_item_to_main_menu \{ line_spacing = 40 }
	if GotParam \{ info_text_index }
		eventparams = [
			{ Focus net_main_menu_focus }
			{Focus SetScreenElementProps Params = {Id = help_info_text_block text = ($info_text [ <info_text_index> ])}}
			{ unfocus net_main_menu_unfocus }
		]
	else
		eventparams = [
			{ Focus net_main_menu_focus }
			{ unfocus net_main_menu_unfocus }
		]
	endif
	CreateScreenElement {
		Type = ContainerElement
		PARENT = <VMenu>
		dims = ((100.0, 0.0) + (0.0, 1.0) * <line_spacing>)
		event_handlers = <eventparams>
	}
	menu_item_container = <Id>
	if GotParam \{ pad_choose_script }
		if GotParam \{ choose_script_params }
			<menu_item_container> ::SetProps event_handlers = [{pad_choose <pad_choose_script> Params = { <choose_script_params> }}]
		else
			<menu_item_container> ::SetProps event_handlers = [{ pad_choose <pad_choose_script> }]
		endif
	endif
	if GotParam \{ pad_choose_script2 }
		if GotParam \{ choose_script_params2 }
			<menu_item_container> ::SetProps event_handlers = [{pad_choose <pad_choose_script2> Params = { <choose_script_params2> }}]
		else
			<menu_item_container> ::SetProps event_handlers = [{ pad_choose <pad_choose_script2> }]
		endif
	endif
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <menu_item_container>
		local_id = highlightbar
		texture = White
		dims = (450.0, 40.0)
		rgba = ($online_light_blue)
		Pos = (0.0, 7.5)
		just = [ center top ]
		z_priority = 3
		Alpha = 0.0
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <menu_item_container>
		local_id = left_bookend
		texture = character_hub_hilite_bookend
		dims = (50.0, 50.0)
		rgba = ($online_light_blue)
		Pos = (-227.0, 3.0)
		just = [ center top ]
		z_priority = 3
		Alpha = 0.0
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <menu_item_container>
		local_id = right_bookend
		texture = character_hub_hilite_bookend
		dims = (50.0, 50.0)
		rgba = ($online_light_blue)
		Pos = (240.0, 3.0)
		just = [ center top ]
		z_priority = 3
		Alpha = 0.0
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = <menu_item_container>
		local_id = text
		font = text_A4
		Scale = 0.75
		rgba = ($online_light_blue)
		text = <text>
		just = [ center top ]
		z_priority = 4.0
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 420)
		SetScreenElementProps {
			Id = <Id>
			Scale = 1.0
		}
		scale_element_to_size {
			Id = <Id>
			target_width = 420
			target_height = <height>
		}
	endif
	if (<text> = "Quick Match: Ranked Match")
		GetGlobalTags \{ user_options }
		if (<online_game_mode> = 4)
			SetScreenElementProps {
				Id = <menu_item_container>
				not_focusable
			}
			SetScreenElementProps {
				Id = {<menu_item_container> child = text}
				rgba = ($online_grey)
			}
		endif
	endif
endscript

script net_main_menu_focus
	Obj_GetID
	if ScreenElementExists Id = {<ObjID> child = highlightbar}
		SetScreenElementProps {
			Id = {<ObjID> child = highlightbar}
			Alpha = 1.0
		}
	endif
	if ScreenElementExists Id = {<ObjID> child = left_bookend}
		SetScreenElementProps {
			Id = {<ObjID> child = left_bookend}
			Alpha = 1.0
		}
	endif
	if ScreenElementExists Id = {<ObjID> child = right_bookend}
		SetScreenElementProps {
			Id = {<ObjID> child = right_bookend}
			Alpha = 1.0
		}
	endif
	if ScreenElementExists Id = {<ObjID> child = text}
		SetScreenElementProps {
			Id = {<ObjID> child = text}
			rgba = ($online_dark_purple)
		}
	endif
endscript

script net_main_menu_unfocus
	Obj_GetID
	if ScreenElementExists Id = {<ObjID> child = highlightbar}
		SetScreenElementProps {
			Id = {<ObjID> child = highlightbar}
			Alpha = 0.0
		}
	endif
	if ScreenElementExists Id = {<ObjID> child = left_bookend}
		SetScreenElementProps {
			Id = {<ObjID> child = left_bookend}
			Alpha = 0.0
		}
	endif
	if ScreenElementExists Id = {<ObjID> child = right_bookend}
		SetScreenElementProps {
			Id = {<ObjID> child = right_bookend}
			Alpha = 0.0
		}
	endif
	if ScreenElementExists Id = {<ObjID> child = text}
		SetScreenElementProps {
			Id = {<ObjID> child = text}
			rgba = ($online_light_blue)
		}
	endif
endscript
