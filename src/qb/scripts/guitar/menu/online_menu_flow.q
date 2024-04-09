online_signin_fs = {
	Create = create_online_signin_splash
	Destroy = destroy_online_signin_splash
	actions = [
		{ action = online_enabled flow_state = online_menu_fs }
		{ action = go_back flow_state = main_menu_fs }
		{ action = cancel flow_state = main_menu_fs }
	]
}
online_signin_warning_fs = {
	Create = create_online_signin_warning_menu
	Destroy = destroy_online_signin_warning_menu
	actions = [
		{ action = continue flow_state = main_menu_fs }
	]
}
online_menu_fs = {
	Create = create_online_main_menu
	Destroy = destroy_online_main_menu
	actions = [
		{ action = continue flow_state = main_menu_fs }
		{ action = select_quickmatch_player flow_state = quickmatch_search_fs }
		{ action = select_quickmatch_ranked flow_state = quickmatch_search_fs }
		{ action = select_custom_match func = set_rich_presence_searching flow_state = custom_match_fs }
		{ action = select_join_private flow_state = join_private_match_fs }
		{ action = select_create_match flow_state_func = select_create_match_transition }
		{ action = select_online_options func = save_intial_option_values flow_state = online_options_quickmatch_fs }
		{ action = select_leaderboards flow_state = online_leaderboard_groups_fs }
		{ action = select_downloadable_content flow_state = online_downloadable_fs }
		{ action = select_account_management flow_state = account_management_fs }
		{ action = go_back flow_state = main_menu_fs }
	]
}

script select_create_match_transition
	return \{ flow_state = create_match_select_private_match_fs }
endscript
online_downloadable_fs = {
	Create = create_download_scan_menu
	Destroy = destroy_download_scan_menu
	actions = [
		{ action = continue flow_state = online_menu_fs }
	]
}
online_options_fs = {
	Create = create_online_options_menu
	Destroy = destroy_online_options_menu
	actions = [
		{ action = select_quickmatch_pref func = save_intial_option_values flow_state = online_options_quickmatch_fs }
		{ action = select_player_pref func = save_intial_option_values flow_state = online_options_player_prefs_fs }
		{ action = go_back flow_state = online_menu_fs }
	]
}
online_option_changed_dialog_fs = {
	Create = create_online_options_changed_dialog
	Destroy = destroy_online_options_changed_dialog
	popup
	actions = [
		{ action = dialog_response_selected_save flow_state = online_option_autosave_fs }
		{ action = dialog_response_selected_dont_save flow_state = online_menu_fs }
		{ action = go_back use_last_flow_state }
	]
}
online_option_autosave_fs = {
	Create = memcard_sequence_begin_autosave
	Destroy = memcard_sequence_cleanup_generic
	actions = [
		{ action = memcard_sequence_save_success flow_state = online_menu_fs }
		{ action = memcard_sequence_save_failed flow_state = online_menu_fs }
	]
}
online_options_quickmatch_fs = {
	Create = create_online_quickmatch_prefs
	Destroy = destroy_online_quickmatch_prefs
	actions = [
		{ action = save_dialog flow_state = online_option_changed_dialog_fs }
		{ action = dialog_response_selected_save flow_state = online_option_autosave_fs }
		{ action = dialog_response_selected_dont_save flow_state = online_menu_fs }
		{ action = go_back flow_state = online_menu_fs }
	]
}
online_options_player_prefs_fs = {
	Create = create_online_player_prefs
	Destroy = destroy_online_player_prefs
	actions = [
		{ action = save_dialog flow_state = online_option_changed_dialog_fs }
		{ action = go_back flow_state = online_options_fs }
	]
}
online_play_song_fs = {
	Create = create_net_play_song_menu
	Destroy = destroy_net_play_song_menu
	actions = [
		{ action = pause_game flow_state = online_pause_fs }
		{ action = win_song func = kill_gem_scroller flow_state = online_win_song_fs }
		{ action = fail_song func = kill_gem_scroller flow_state = online_fail_song_fs }
		{ action = sudden_death_begin flow_state = online_loading_fs }
		{ action = controller_disconnect flow_state = controller_disconnect_fs }
	]
}
online_win_song_fs = {
	Create = create_newspaper_menu
	Destroy = destroy_newspaper_menu
	actions = [
		{ action = continue_to_next_song flow_state = online_loading_fs }
		{ action = choose_tie_breaker_song flow_state = online_setlist_fs }
		{ action = continue_to_net_stats flow_state = online_match_stats_fs }
	]
}
online_fail_song_fs = {
	Create = create_newspaper_menu
	Destroy = destroy_newspaper_menu
	actions = [
		{ action = continue_to_next_song flow_state = online_loading_fs }
		{ action = choose_tie_breaker_song flow_state = online_setlist_fs }
		{ action = continue_to_net_stats flow_state = online_match_stats_fs }
	]
}
online_match_stats_fs = {
	Create = create_net_detailed_stats_menu
	Destroy = destroy_detailed_stats_menu
	actions = [
		{ action = continue func = quit_network_game flow_state_func = check_if_ranked_game }
	]
}

script check_if_ranked_game
	if IsXenon
		if ($match_type = Ranked)
			return \{ flow_state = online_end_ranked_game_save_fs }
		endif
	else
		return \{ flow_state = online_end_ranked_game_save_fs }
	endif
	return \{ flow_state = online_menu_fs }
endscript
online_end_ranked_game_save_fs = {
	Create = memcard_sequence_begin_autosave
	Destroy = memcard_sequence_cleanup_generic
	actions = [
		{ action = memcard_sequence_save_success flow_state = online_menu_fs }
		{ action = memcard_sequence_save_failed flow_state = online_menu_fs }
	]
}
online_pause_fs = {
	Create = create_pause_menu
	Destroy = destroy_pause_menu
	actions = [
		{ action = select_resume flow_state = online_play_song_fs }
		{ action = select_quit func = select_quit_network_game flow_state = online_menu_fs }
	]
}
online_pause_options_fs = {
	Create = create_pause_menu
	create_params = { for_options = 1 }
	Destroy = destroy_pause_menu
	actions = [
		{ action = select_audio_settings flow_state = online_menu_fs }
		{ action = select_calibrate_lag flow_state = quickplay_calibrate_lag_warning }
		{ action = winport_select_calibrate_lag flow_state = winport_quickplay_calibrate_lag_warning }
		{ action = select_calibrate_whammy_bar flow_state = calibrate_whammy_bar_fs }
		{ action = select_calibrate_star_power_trigger flow_state = calibrate_star_power_trigger_fs }
		{ action = select_lefty_flip flow_state = quickplay_lefty_flip_warning }
		{ action = go_back flow_state = quickplay_pause_fs }
	]
}
online_leaderboard_groups_fs = {
	Create = create_leaderboard_groups_menu
	Destroy = destroy_leaderboard_groups_menu
	actions = [
		{ action = select_leaderboard_group flow_state = online_leaderboard_list_fs }
		{ action = go_back flow_state = online_menu_fs }
	]
}
online_leaderboard_list_fs = {
	Create = create_leaderboard_group_listing_menu
	Destroy = destroy_leaderboard_group_listing_menu
	actions = [
		{ action = select_leaderboard flow_state = view_leaderboard_fs }
		{ action = go_back flow_state = online_leaderboard_groups_fs }
	]
}
view_leaderboard_fs = {
	Create = create_leaderboard_menu
	Destroy = destroy_leaderboard_menu
	actions = [
		{ action = select_leaderboard flow_state = view_leaderboard_fs }
		{ action = next_leaderboard flow_state = view_leaderboard_fs }
		{ action = prev_leaderboard flow_state = view_leaderboard_fs }
		{ action = pull_up_filter_dialog flow_state = leaderboard_filter_fs }
		{ action = go_back flow_state = online_leaderboard_list_fs }
	]
}
leaderboard_filter_fs = {
	Create = create_leaderboard_filter_dialog
	Destroy = destroy_leaderboard_filter_dialog
	popup
	actions = [
		{ action = submit_query flow_state = view_leaderboard_fs }
		{ action = go_back flow_state = view_leaderboard_fs }
	]
}
quickmatch_search_fs = {
	Create = create_online_server_list
	Destroy = destroy_online_server_list
	actions = [
		{ action = select_server flow_state = quick_match_joining_game_fs }
		{ action = response_create_selected flow_state_func = select_create_match_transition }
		{ action = response_cancel_selected flow_state = online_menu_fs }
		{ action = go_back flow_state = online_menu_fs }
	]
}
quick_match_joining_game_fs = {
	Create = create_join_server_menu
	Destroy = destroy_join_server_menu
	actions = [
		{ action = connection_lost flow_state = online_menu_fs }
		{ action = join_server flow_state = online_character_select_fs }
		{ action = go_back flow_state = online_menu_fs }
	]
}
private_match_search_fs = {
	Create = create_online_server_list
	Destroy = destroy_online_server_list
	actions = [
		{ action = select_server flow_state = private_match_joining_game_fs }
		{ action = response_create_selected flow_state_func = select_create_match_transition }
		{ action = response_cancel_selected flow_state = online_menu_fs }
		{ action = go_back flow_state = join_private_match_fs }
	]
}
private_match_joining_game_fs = {
	Create = create_join_server_menu
	Destroy = destroy_join_server_menu
	actions = [
		{ action = connection_lost flow_state = online_menu_fs }
		{ action = join_server flow_state = online_character_select_fs }
		{ action = go_back flow_state = online_menu_fs }
	]
}
invite_joining_game_fs = {
	Create = create_join_server_menu
	Destroy = destroy_join_server_menu
	actions = [
		{ action = connection_lost flow_state = online_menu_fs }
		{ action = join_server flow_state = online_character_select_fs }
		{ action = join_failed flow_state = online_menu_fs }
		{ action = go_back flow_state = online_menu_fs }
	]
}
custom_match_fs = {
	Create = create_custom_create_menu
	Destroy = destroy_custom_create_menu
	actions = [
		{ action = select_done flow_state = online_server_list_fs }
		{ action = go_back flow_state = online_menu_fs }
	]
}
online_server_list_fs = {
	Create = create_online_server_list
	Destroy = destroy_online_server_list
	actions = [
		{ action = select_server flow_state = custom_match_joining_game_fs }
		{ action = response_create_selected flow_state_func = select_create_match_transition }
		{ action = response_cancel_selected flow_state = custom_match_fs }
		{ action = go_back flow_state = custom_match_fs }
	]
}
custom_match_joining_game_fs = {
	Create = create_join_server_menu
	Destroy = destroy_join_server_menu
	actions = [
		{ action = join_server flow_state = online_character_select_fs }
		{ action = go_back flow_state = custom_match_fs }
		{ action = connection_lost flow_state = online_menu_fs }
		{ action = timeout flow_state = custom_match_fs }
	]
}

script setup_and_post_game
	killspawnedscript \{ name = coop_fail_song }
	set_character_hub_dirty
	Change \{ StructureName = player2_status character_id = Axel }
	Change \{ StructureName = player2_status outfit = 1 }
	Change \{ StructureName = player2_status style = 1 }
	Change \{ StructureName = player2_status instrument_id = Instrument_Les_Paul_Black }
	Change \{ character_select_highlighted_character_p2_dirty = 1 }
	Change \{ current_num_players = 2 }
	<rand> = 0
	GetRandomValue \{ name = rand Integer a = 0 b = 1 }
	get_number_of_songs
	if ((<rand> = 0)|| ($game_mode = p2_coop)|| (<num_songs> = 1))
		Change \{ tie_breaker = HOST }
	else
		Change \{ tie_breaker = CLIENT }
	endif
	if IsHost
		ResetHubStates
	endif
	post_network_game
endscript

script transition_from_select_match_type
	if (($match_type)= Ranked)
		return \{ flow_state = create_match_select_game_mode_fs }
	endif
	return \{ flow_state = create_match_select_private_match_fs }
endscript

script transition_from_select_num_songs_back
	if (($game_mode)= p2_pro_faceoff)
		return \{ flow_state = create_match_select_diff_fs }
	endif
	return \{ flow_state = create_match_select_game_mode_fs }
endscript

script transition_from_select_game_mode_forward
	if (($game_mode)= p2_pro_faceoff)
		return \{ flow_state = create_match_select_diff_fs }
	endif
	return \{ flow_state = create_match_select_num_songs_fs }
endscript

script transition_from_select_game_mode_back
	return \{ flow_state = create_match_select_private_match_fs }
endscript
create_match_select_match_type_fs = {
	Create = create_mp_select_match_type_menu
	Destroy = destroy_mp_select_match_type_menu
	actions = [
		{ action = select_match_type flow_state_func = transition_from_select_match_type }
		{ action = go_back flow_state = online_menu_fs }
	]
}
create_match_select_private_match_fs = {
	Create = create_select_private_match_menu
	Destroy = destroy_select_private_match_menu
	actions = [
		{ action = continue flow_state = create_match_select_game_mode_fs }
		{ action = go_back flow_state = online_menu_fs }
	]
}
create_match_select_game_mode_fs = {
	Create = create_mp_select_mode_menu
	Destroy = destroy_mp_select_mode_menu
	actions = [
		{ action = select_game_mode flow_state_func = transition_from_select_game_mode_forward }
		{ action = go_back flow_state_func = transition_from_select_game_mode_back }
	]
}
create_match_select_diff_fs = {
	Create = create_select_difficulty_menu
	Destroy = destroy_select_difficulty_menu
	actions = [
		{ action = continue flow_state = create_match_select_num_songs_fs }
		{ action = go_back flow_state = create_match_select_game_mode_fs }
	]
}
create_match_select_num_songs_fs = {
	Create = create_select_num_songs_menu
	Destroy = destroy_select_num_songs_menu
	actions = [
		{ action = continue flow_state = create_match_select_venue_fs }
		{ action = go_back flow_state_func = transition_from_select_num_songs_back }
	]
}
create_match_select_venue_fs = {
	Create = create_select_venue_menu
	Destroy = destroy_select_venue_menu
	actions = [
		{ action = continue transition_screen = default_joining_screen func = setup_and_post_game flow_state = online_character_select_fs }
		{ action = go_back flow_state = create_match_select_num_songs_fs }
	]
}
default_joining_screen = { Create = create_joining_screen Destroy = destroy_joining_screen }

script transition_from_char_hub
	destroy_gamertags
	if (($game_mode)= p2_coop)
		return \{ flow_state = online_coop_choose_part_fs }
	endif
	if NOT (($game_mode)= p2_pro_faceoff)
		return \{ flow_state = online_select_diff_fs }
	endif
	return \{ flow_state = online_setlist_fs }
endscript

script transition_from_select_diff_back
	if (($game_mode)= p2_coop)
		return \{ flow_state = online_coop_choose_part_fs }
	endif
	set_character_hub_dirty
	return \{ flow_state = online_character_select_fs }
endscript

script transition_from_setlist_back
	if ($game_mode = p2_pro_faceoff)
		set_character_hub_dirty
		return \{ flow_state = online_character_select_fs }
	endif
	return \{ flow_state = online_select_diff_fs }
endscript
online_character_select_fs = {
	Create = create_character_select_menu
	Destroy = destroy_character_select_menu
	actions = [
		{ action = connection_lost flow_state = character_lobby_cleanup_fs }
		{ action = continue flow_state = online_character_hub_fs }
		{ action = go_back func = quit_network_game flow_state = online_menu_fs }
	]
}
online_character_hub_fs = {
	Create = create_character_hub_menu
	Destroy = destroy_character_hub_menu
	actions = [
		{ action = connection_lost flow_state = character_lobby_cleanup_fs }
		{ action = select_ready flow_state_func = transition_from_char_hub }
		{ action = select_change_outfit flow_state = online_select_outfit_fs }
		{ action = select_change_guitar flow_state = online_select_guitar_fs }
		{ action = select_change_bass flow_state = online_select_bass_fs }
		{ action = go_back flow_state = online_character_select_fs }
		{ action = handle_dropped_client flow_state = online_character_select_fs }
	]
}
online_select_outfit_fs = {
	Create = create_select_outfit_menu
	Destroy = destroy_select_outfit_menu
	actions = [
		{ action = connection_lost flow_state = character_lobby_cleanup_fs }
		{ action = select_character_hub flow_state = online_character_hub_fs }
		{ action = select_select_style flow_state = online_select_style_fs }
		{ action = go_back flow_state = online_character_hub_fs }
		{ action = handle_dropped_client flow_state = online_character_select_fs }
	]
}
online_select_style_fs = {
	Create = create_select_style_menu
	Destroy = destroy_select_style_menu
	actions = [
		{ action = connection_lost flow_state = character_lobby_cleanup_fs }
		{ action = select_character_hub flow_state = online_character_hub_fs }
		{ action = select_select_outfit flow_state = online_select_outfit_fs }
		{ action = go_back flow_state = online_select_outfit_fs }
		{ action = handle_dropped_client flow_state = online_character_select_fs }
	]
}
online_select_guitar_fs = {
	Create = create_select_guitar_menu
	Destroy = destroy_select_guitar_menu
	actions = [
		{ action = connection_lost flow_state = character_lobby_cleanup_fs }
		{ action = select_character_hub flow_state = online_character_hub_fs }
		{ action = continue flow_state = online_character_hub_fs }
		{ action = select_guitar_finish flow_state = online_select_guitar_finish_fs }
		{ action = go_back flow_state = online_character_hub_fs }
		{ action = handle_dropped_client flow_state = online_character_select_fs }
	]
}
online_select_guitar_finish_fs = {
	Create = create_select_guitar_finish_menu
	Destroy = destroy_select_guitar_finish_menu
	actions = [
		{ action = connection_lost flow_state = character_lobby_cleanup_fs }
		{ action = continue flow_state = online_select_guitar_fs }
		{ action = select_character_hub flow_state = online_character_hub_fs }
		{ action = go_back flow_state = online_select_guitar_fs }
		{ action = handle_dropped_client flow_state = online_character_select_fs }
	]
}
online_select_bass_fs = {
	Create = create_select_bass_menu
	Destroy = destroy_select_guitar_menu
	actions = [
		{ action = connection_lost flow_state = online_menu_fs }
		{ action = select_character_hub flow_state = online_character_hub_fs }
		{ action = continue flow_state = online_character_hub_fs }
		{ action = select_guitar_finish flow_state = online_select_guitar_finish_fs }
		{ action = go_back flow_state = online_character_hub_fs }
		{ action = handle_dropped_client flow_state = online_character_select_fs }
	]
}
online_coop_choose_part_fs = {
	Create = net_create_choose_part_menu
	Destroy = destroy_choose_part_menu
	actions = [
		{ action = connection_lost flow_state = online_menu_fs }
		{ action = continue flow_state = online_select_diff_fs }
		{ action = go_back func = set_character_hub_dirty flow_state = online_character_select_fs }
		{ action = handle_dropped_client func = set_character_hub_dirty flow_state = online_character_select_fs }
	]
}
online_select_diff_fs = {
	Create = net_create_select_difficulty_menu
	Destroy = destroy_select_difficulty_menu
	actions = [
		{ action = connection_lost flow_state = online_menu_fs }
		{ action = continue flow_state = online_setlist_fs }
		{ action = handle_dropped_client func = set_character_hub_dirty flow_state = online_character_select_fs }
		{ action = go_back flow_state_func = transition_from_select_diff_back }
	]
}
online_setlist_fs = {
	Create = create_setlist_menu
	Destroy = destroy_setlist_menu
	actions = [
		{ action = connection_lost flow_state = online_menu_fs }
		{ action = continue func = start_network_game flow_state = online_loading_fs }
		{ action = continue_to_final_song func = start_final_song flow_state = online_loading_fs }
		{ action = go_back flow_state_func = transition_from_setlist_back }
		{ action = handle_dropped_client flow_state_func = setlist_client_dropped }
	]
}

script setlist_client_dropped
	if ($g_tie_breaker_song = 1)
		return \{ flow_state = online_menu_fs }
	else
		return \{ flow_state = online_character_select_fs func = set_character_hub_dirty }
	endif
endscript
online_loading_fs = {
	Create = create_loading_screen
	Destroy = destroy_loading_screen
	actions = [
		{ action = net_begin_song flow_state = online_play_song_fs }
		{ action = connection_lost func = kill_gem_scroller flow_state = online_menu_fs }
	]
}
character_lobby_cleanup_fs = {
	Create = cleanup_online_lobby_select
	Destroy = empty_script
	actions = [
		{ action = continue flow_state = online_menu_fs }
	]
}
online_winport_start_connection_fs = {
	Create = create_winport_connection_status_screen
	Destroy = destroy_winport_connection_status_screen
	actions = [
		{ action = account_create flow_state = online_winport_start_account_create_fs }
		{ action = goto_online_menu flow_state = online_menu_fs }
		{ action = account_login flow_state = online_winport_start_account_login_fs }
		{ action = back flow_state_func = whats_before_online_menu }
	]
}
online_winport_start_account_create_fs = {
	Create = create_winport_account_create_screen
	Destroy = destroy_winport_account_create_screen
	actions = [
		{ action = executeLogin flow_state = online_winport_start_account_create_status_fs }
		{ action = back flow_state = online_winport_start_connection_fs }
	]
}
online_winport_start_account_login_fs = {
	Create = create_winport_account_login_screen
	Destroy = destroy_winport_account_login_screen
	actions = [
		{ action = account_create flow_state = online_winport_start_account_create_fs }
		{ action = account_change flow_state = online_winport_start_account_change_fs }
		{ action = executeLogin flow_state = online_winport_start_account_login_status_fs }
		{ action = executeOption1 flow_state = online_winport_start_account_change_fs }
		{ action = executeOption2 flow_state = online_winport_start_account_create_fs }
		{ action = back_to_connection_status flow_state = online_winport_start_connection_fs }
		{ action = back_to_main flow_state_func = whats_before_online_menu }
	]
}
online_winport_start_account_change_fs = {
	Create = create_winport_account_change_screen
	Destroy = destroy_winport_account_change_screen
	actions = [
		{ action = account_reset flow_state = online_winport_start_account_reset_fs }
		{ action = executeLogin flow_state = online_winport_start_account_change_status_fs }
		{ action = executeOption1 flow_state = online_winport_start_account_reset_fs }
		{ action = back flow_state = online_winport_start_account_login_fs }
	]
}
online_winport_start_account_reset_fs = {
	Create = create_winport_account_reset_screen
	Destroy = destroy_winport_account_reset_screen
	actions = [
		{ action = account_delete flow_state = online_winport_start_account_delete_fs }
		{ action = executeLogin flow_state = online_winport_start_account_reset_status_fs }
		{ action = executeOption1 flow_state = online_winport_start_account_delete_fs }
		{ action = back flow_state = online_winport_start_account_change_fs }
	]
}
online_winport_start_account_delete_fs = {
	Create = create_winport_account_delete_screen
	Destroy = destroy_winport_account_delete_screen
	actions = [
		{ action = executeLogin flow_state = online_winport_start_account_delete_status_fs }
		{ action = back flow_state = online_winport_start_account_reset_fs }
	]
}
online_winport_start_account_create_status_fs = {
	Create = create_winport_account_create_status_screen
	Destroy = destroy_winport_account_create_status_screen
	actions = [
		{ action = successAction flow_state_func = whats_after_login_complete }
		{ action = errorAction flow_state = online_winport_start_account_create_fs }
		{ action = back flow_state = online_winport_start_account_create_fs }
	]
}
online_winport_start_account_login_status_fs = {
	Create = create_winport_account_login_status_screen
	Destroy = destroy_winport_account_login_status_screen
	actions = [
		{ action = successAction flow_state_func = whats_after_login_complete }
		{ action = errorAction flow_state = online_winport_start_account_login_fs }
		{ action = back flow_state = online_winport_start_account_login_fs }
	]
}
online_winport_start_account_change_status_fs = {
	Create = create_winport_account_change_status_screen
	Destroy = destroy_winport_account_change_status_screen
	actions = [
		{ action = successAction flow_state_func = whats_after_login_complete }
		{ action = errorAction flow_state = online_winport_start_account_change_fs }
		{ action = back flow_state = online_winport_start_account_change_fs }
	]
}
online_winport_start_account_reset_status_fs = {
	Create = create_winport_account_reset_status_screen
	Destroy = destroy_winport_account_reset_status_screen
	actions = [
		{ action = successAction flow_state_func = whats_after_login_complete }
		{ action = errorAction flow_state = online_winport_start_account_reset_fs }
		{ action = back flow_state = online_winport_start_account_reset_fs }
	]
}
online_winport_start_account_delete_status_fs = {
	Create = create_winport_account_delete_status_screen
	Destroy = destroy_winport_account_delete_status_screen
	actions = [
		{ action = successAction flow_state = online_winport_start_account_create_fs }
		{ action = errorAction flow_state = online_winport_start_account_delete_fs }
		{ action = back flow_state = online_winport_start_account_delete_fs }
	]
}
join_private_match_fs = {
	Create = create_join_private_menu
	Destroy = destroy_join_private_menu
	actions = [
		{ action = attempt_join flow_state = private_match_search_fs }
		{ action = back flow_state = online_menu_fs }
	]
}
account_management_fs = {
	Create = create_account_submenu
	Destroy = destroy_account_submenu
	actions = [
		{ action = execute_logout flow_state = account_logout_fs }
		{ action = execute_change_password flow_state = account_change_password_fs }
		{ action = execute_delete_account flow_state = account_delete_fs }
		{ action = back flow_state = online_menu_fs }
	]
}
account_logout_fs = {
	Create = create_logout_submenu
	Destroy = destroy_logout_submenu
	actions = [
		{ action = back flow_state = account_management_fs }
	]
}
account_change_password_fs = {
	Create = create_change_password_submenu
	Destroy = destroy_change_password_submenu
	actions = [
		{ action = executeLogin flow_state = online_start_account_change_submenu_status_fs }
		{ action = back flow_state = account_management_fs }
	]
}
online_start_account_change_submenu_status_fs = {
	Create = create_account_change_submenu_status_screen
	Destroy = destroy_account_change_submenu_status_screen
	actions = [
		{ action = successAction flow_state = account_management_fs }
		{ action = errorAction flow_state = account_change_password_fs }
	]
}
account_delete_fs = {
	Create = create_account_delete_submenu
	Destroy = destroy_account_delete_submenu
	actions = [
		{ action = executeLogin flow_state = online_start_account_delete_submenu_status_fs }
		{ action = back flow_state = account_management_fs }
	]
}
online_start_account_delete_submenu_status_fs = {
	Create = create_account_delete_submenu_status_screen
	Destroy = destroy_account_delete_submenu_status_screen
	actions = [
		{ action = successAction flow_state = online_return_to_main_menu_fs }
		{ action = errorAction flow_state = account_delete_fs }
	]
}
online_return_to_main_menu_fs = { Create = processAccountDeleteSuccess Destroy = null_script }

script processAccountDeleteSuccess
	destroy_account_delete_submenu_status_screen
	NetSessionFunc \{ func = ResetNetwork }
	start_flow_manager \{ flow_state = main_menu_fs }
endscript

script whats_before_online_menu
	if ($main_menu_created = 0)
		process_signin_complete
		return flow_state = <flow_state>
	endif
	return \{ flow_state = main_menu_fs }
endscript

script whats_after_login_complete
	if ($main_menu_created = 0)
		NetSessionFunc \{ func = GetAutoLoginSetting }
		if (<autoLoginSetting> = autoLoginUnknown)
			return \{ flow_state = bootup_autologin_save_fs }
		endif
		process_signin_complete
		return flow_state = <flow_state>
	endif
	return \{ flow_state = online_menu_fs }
endscript
