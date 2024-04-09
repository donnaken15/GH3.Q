career_choose_band_fs = {
	Create = create_choose_band_menu
	Destroy = destroy_choose_band_menu
	actions = [
		{ action = select_existing_band flow_state = career_select_difficulty_fs transition_right }
		{ action = select_new_band flow_state = career_enter_band_name_fs transition_right }
		{ action = go_back flow_state = main_menu_fs transition_left }
	]
}
career_enter_band_name_fs = {
	Create = create_enter_band_name_menu
	Destroy = destroy_enter_band_name_menu
	remove_focus = enter_band_name_remove_focus
	refocus = enter_band_name_refocus
	actions = [
		{ action = enter_band_name flow_state = career_select_difficulty_fs transition_right }
		{ action = enter_no_band flow_state = career_no_band_fs transition_right }
		{ action = go_back flow_state_func = career_enter_band_name_flow_state_func transition_left }
	]
}

script career_enter_band_name_flow_state_func
	get_current_first_play
	if (<first_play>)
		return \{ flow_state = main_menu_fs }
	else
		return \{ flow_state = career_choose_band_fs }
	endif
endscript

script get_current_first_play
	get_band_game_mode_name
	FormatText ChecksumName = bandname_id 'band%i_info_%g' i = ($current_band)g = <game_mode_name>
	GetGlobalTags <bandname_id>
	return first_play = <first_play>
endscript
career_no_band_fs = {
	Create = create_no_band_menu
	Destroy = destroy_no_band_menu
	popup
	actions = [
		{ action = continue flow_state = career_enter_band_name_fs transition_left }
		{ action = go_back flow_state = career_enter_band_name_fs transition_left }
	]
}
career_select_difficulty_fs = {
	Create = create_select_difficulty_menu
	Destroy = destroy_select_difficulty_menu
	actions = [
		{ action = continue flow_state_func = career_select_difficulty_flow_state_func }
		{ action = go_back flow_state = career_choose_band_fs transition_left }
	]
}

script career_select_difficulty_flow_state_func
	progression_pop_current
	if ($game_mode = p1_career)
		Index = ($difficulty_list_props.($current_difficulty).Index)
		SetProgressionDifficulty difficulty = <Index>
		DeRegisterAtoms
		get_progression_globals game_mode = ($game_mode)
		if NOT (<progression_global> = None)
			RegisterAtoms name = Progression $<progression_global>
			RegisterAtoms \{ name = achievement $Achievement_Atoms }
			UpdateAtoms \{ name = Progression }
		endif
	endif
	get_current_first_play
	if (<first_play>)
		set_character_hub_dirty
		return \{ flow_state = career_select_character_fs }
	else
		set_character_hub_dirty
		return \{ flow_state = career_character_hub_fs }
	endif
endscript
career_select_character_fs = {
	Create = create_character_select_menu
	Destroy = destroy_character_select_menu
	actions = [
		{ action = continue flow_state = career_character_hub_fs }
		{ action = go_back func = progression_push_current flow_state = career_select_difficulty_fs transition_left }
	]
}
career_character_hub_fs = {
	Create = create_character_hub_menu
	Destroy = destroy_character_hub_menu
	actions = [
		{ action = select_play_show flow_state = career_select_venue_fs }
		{ action = select_the_store func = set_store_came_from_p1_career flow_state = store_fs }
		{ action = select_change_outfit flow_state = career_select_outfit_fs }
		{ action = select_change_guitar flow_state = career_select_guitar_fs }
		{ action = go_back flow_state = career_select_character_fs }
	]
}

script set_store_came_from_p1_career
	Change \{ store_came_from = p1_career }
endscript
career_select_outfit_fs = {
	Create = create_select_outfit_menu
	Destroy = destroy_select_outfit_menu
	actions = [
		{ action = select_character_hub flow_state = career_character_hub_fs }
		{ action = select_select_style flow_state = career_select_style_fs }
		{ action = go_back flow_state = career_character_hub_fs }
	]
}
career_select_style_fs = {
	Create = create_select_style_menu
	Destroy = destroy_select_style_menu
	actions = [
		{ action = select_character_hub flow_state = career_character_hub_fs }
		{ action = select_select_outfit flow_state = career_select_outfit_fs }
		{ action = go_back flow_state = career_select_outfit_fs }
	]
}
career_select_guitar_fs = {
	Create = create_select_guitar_menu
	Destroy = destroy_select_guitar_menu
	actions = [
		{ action = select_character_hub flow_state = career_character_hub_fs }
		{ action = select_guitar_finish flow_state = career_select_guitar_finish_fs }
		{ action = go_back flow_state = career_character_hub_fs }
	]
}
career_select_guitar_finish_fs = {
	Create = create_select_guitar_finish_menu
	Destroy = destroy_select_guitar_finish_menu
	actions = [
		{ action = select_character_hub flow_state = career_character_hub_fs }
		{ action = select_select_guitar flow_state = career_select_guitar_fs }
		{ action = go_back flow_state = career_select_guitar_fs }
	]
}
career_select_venue_fs = {
	Create = create_select_venue_menu
	Destroy = destroy_select_venue_menu
	actions = [
		{ action = continue flow_state = career_setlist_fs transition_right }
		{ action = go_back func = set_character_hub_dirty flow_state = career_character_hub_fs }
	]
}
career_play_song_fs = {
	Create = create_play_song_menu
	Destroy = destroy_play_song_menu
	actions = [
		{ action = pause_game flow_state = career_pause_fs }
		{ action = preboss_win_song func = start_boss flow_state = career_play_song_fs }
		{ action = battle_mode_helper flow_state = career_autosave_boss_confirmation_fs }
		{ action = preencore_win_song flow_state = career_encore_confirmation_fs }
		{ action = unlocktier_win_song flow_state = career_select_venue_fs }
		{ action = win_song func = kill_gem_scroller flow_state_func = career_check_for_beat_game }
		{ action = fail_song flow_state_func = career_fail_song_fs_decider }
		{ action = controller_disconnect flow_state = controller_disconnect_fs }
	]
}
career_boss_wuss_out_fs = {
	Create = create_wuss_out_menu
	Destroy = destroy_wuss_out_menu
	actions = [
		{ action = continue flow_state = career_fail_song_fs }
		{ action = WUSS_OUT func = wuss_out_transition flow_state = career_encore_confirmation_fs }
	]
}

script wuss_out_transition
	Change \{ StructureName = player1_status score = 1 }
	Progression_SongWon
	end_song
	UnPauseGame
	Change \{ current_transition = None }
	PauseGame
endscript

script career_fail_song_fs_decider
	if ($current_song = bosstom || $current_song = bossslash)
		Change boss_wuss_out = ($boss_wuss_out + 2)
		Printf \{ channel = trchen "Boss Wuss Out %s" s = $boss_wuss_out }
		if ($current_song = bosstom)
			FormatText \{ ChecksumName = song_checksum 'career_song6_tier2' AddToStringLookup = TRUE }
		elseif ($current_song = bossslash)
			FormatText \{ ChecksumName = song_checksum 'career_song6_tier5' AddToStringLookup = TRUE }
		endif
		GetGlobalTags <song_checksum> param = score
		if ($boss_wuss_out > 6)
			if NOT (<score> > 0)
				Printf \{ channel = trchen "SHOW WUSS OUT" }
				return \{ flow_state = career_boss_wuss_out_fs }
			endif
		else
			return \{ flow_state = career_fail_song_fs }
		endif
	endif
	return \{ flow_state = career_fail_song_fs }
endscript

script career_check_for_beat_game
	if ($progression_beat_game_last_song = 1)
		return \{ flow_state = career_beat_game_fs }
	else
		return \{ flow_state = career_newspaper_fs }
	endif
endscript
career_beat_game_fs = {
	Create = create_beat_game_menu
	Destroy = destroy_beat_game_menu
	actions = [
		{ action = continue flow_state = career_newspaper_fs transition_right }
	]
}
career_pause_fs = {
	Create = create_pause_menu
	Destroy = destroy_pause_menu
	actions = [
		{ action = select_resume flow_state = career_play_song_fs }
		{ action = select_restart flow_state = career_restart_warning_fs }
		{ action = select_practice flow_state = career_practice_warning_fs }
		{ action = select_options flow_state = career_pause_options_fs }
		{ action = select_quit flow_state_func = end_credits_quit_fs_decider }
		{ action = select_debug_menu flow_state = debug_menu_fs }
	]
}
career_pause_options_fs = {
	Create = create_pause_menu
	create_params = { for_options = 1 }
	Destroy = destroy_pause_menu
	actions = [
		{ action = select_audio_settings flow_state = career_audio_settings_fs }
		{ action = select_calibrate_lag flow_state = career_calibrate_lag_warning }
		{ action = winport_select_calibrate_lag flow_state = winport_career_calibrate_lag_warning }
		{ action = select_calibrate_whammy_bar flow_state = calibrate_whammy_bar_fs }
		{ action = select_calibrate_star_power_trigger flow_state = calibrate_star_power_trigger_fs }
		{ action = select_lefty_flip flow_state = career_lefty_flip_warning }
		{ action = go_back flow_state = career_pause_fs }
	]
}

script end_credits_quit_fs_decider
	if ($end_credits = 1)
		Change \{ end_credits = 0 }
		Progression_EndCredits_Done
		career_song_ended_select_quit
		spawnscriptnow \{ Menu_Music_On }
		return \{ flow_state = main_menu_fs }
	endif
	return \{ flow_state = career_quit_warning_fs }
endscript
career_credits_autosave_fs = {
	Create = memcard_sequence_begin_autosave
	Destroy = memcard_sequence_cleanup_generic
	actions = [
		{ action = memcard_sequence_save_success flow_state = main_menu_fs }
		{ action = memcard_sequence_save_failed flow_state = main_menu_fs }
	]
}
career_controller_settings_fs = {
	Create = create_controller_settings_menu
	create_params = { popup = 1 }
	Destroy = destroy_controller_settings_menu
	actions = [
		{ action = select_lefty_flip flow_state = career_lefty_flip_warning }
		{ action = select_calibrate_whammy_bar flow_state = calibrate_whammy_bar_fs }
		{ action = select_calibrate_star_power_trigger flow_state = calibrate_star_power_trigger_fs }
		{ action = go_back flow_state = career_pause_fs }
	]
}
career_audio_settings_fs = {
	Create = create_audio_settings_menu
	create_params = { popup = 1 }
	Destroy = destroy_audio_settings_menu
	actions = [
		{ action = continue flow_state = career_pause_fs }
		{ action = go_back use_last_flow_state }
	]
}
career_video_settings_fs = {
	Create = create_video_settings_menu
	create_params = { popup = 1 }
	Destroy = destroy_video_settings_menu
	actions = [
		{ action = select_calibrate_lag flow_state = career_calibrate_lag_warning }
		{ action = go_back use_last_flow_state }
	]
}
career_lefty_flip_warning = {
	Create = create_lefty_flip_warning_menu
	Destroy = destroy_lefty_flip_warning_menu
	actions = [
		{ action = continue func = lefty_flip_func flow_state = career_play_song_fs }
		{ action = go_back use_last_flow_state }
	]
}

script lefty_flip_func
	GetGlobalTags \{ user_options }
	Change StructureName = player1_status lefthanded_gems = <lefty_flip_p1>
	Change StructureName = player1_status lefthanded_button_ups = <lefty_flip_p1>
	if (<lefty_flip_p1>)
		Change \{ pad_event_up_inversion = TRUE }
	else
		Change \{ pad_event_up_inversion = FALSE }
	endif
	Change StructureName = player2_status lefthanded_gems = <lefty_flip_p2>
	Change StructureName = player2_status lefthanded_button_ups = <lefty_flip_p2>
	career_restart_song
endscript

script career_restart_song
	killspawnedscript \{ name = GuitarEvent_SongWon_Spawned }
	destroy_menu \{ menu_id = yourock_text }
	destroy_menu \{ menu_id = yourock_text_2 }
	destroy_menu \{ menu_id = yourock_text_legend }
	restart_song
endscript
career_calibrate_lag_warning = {
	Create = create_calibrate_lag_warning_menu
	Destroy = destroy_calibrate_lag_warning_menu
	actions = [
		{ action = continue flow_state = career_calibrate_lag_fs }
		{ action = go_back use_last_flow_state }
	]
}
winport_career_calibrate_lag_warning = {
	Create = winport_create_calibrate_lag_warning_menu
	Destroy = winport_destroy_calibrate_lag_warning_menu
	actions = [
		{ action = continue flow_state = winport_career_calibrate_lag_fs }
		{ action = go_back use_last_flow_state }
	]
}
career_controller_settings_calibrate_lag_warning = {
	Create = create_calibrate_lag_warning_menu
	Destroy = destroy_calibrate_lag_warning_menu
	actions = [
		{ action = continue flow_state = career_calibrate_lag_fs }
		{ action = go_back use_last_flow_state }
	]
}
career_calibrate_autosave_fs = {
	Create = memcard_sequence_begin_autosave
	Destroy = memcard_sequence_cleanup_generic
	actions = [
		{ action = memcard_sequence_save_success func = restart_song flow_state = career_play_song_fs }
		{ action = memcard_sequence_save_failed func = restart_song flow_state = career_play_song_fs }
	]
}
career_calibrate_lag_fs = {
	Create = create_calibrate_lag_menu
	Destroy = destroy_calibrate_lag_menu
	actions = [
		{ action = continue flow_state = career_calibrate_autosave_fs }
		{ action = go_back func = career_restart_song flow_state = career_play_song_fs }
	]
}
winport_career_calibrate_lag_fs = {
	Create = winport_create_calibrate_lag_menu
	Destroy = winport_destroy_calibrate_lag_menu
	actions = [
		{ action = go_back func = career_restart_song flow_state = career_play_song_fs }
	]
}
career_fail_song_fs = {
	Create = create_fail_song_menu
	Destroy = destroy_fail_song_menu
	actions = [
		{ action = select_practice flow_state = career_practice_warning_fs }
		{ action = select_retry flow_state = career_play_song_fs }
		{ action = select_new_song flow_state_func = career_autosave_or_setlist }
		{ action = select_tutorial flow_state = career_practice_warning_fs }
		{ action = select_quit func = career_fail_song_select_quit flow_state = main_menu_fs }
	]
}

script career_fail_song_select_quit
	Change \{ StructureName = player1_status new_cash = 0 }
	progression_push_current
	GH3_SFX_fail_song_stop_sounds
	kill_gem_scroller
endscript
career_song_ended_fs = {
	Create = create_song_ended_menu
	Destroy = destroy_song_ended_menu
	actions = [
		{ action = select_retry flow_state = career_play_song_fs }
		{ action = select_new_song flow_state_func = career_autosave_or_setlist }
		{ action = select_quit func = career_song_ended_select_quit flow_state = main_menu_fs }
	]
}

script career_end_credits_quit
	if ($end_credits = 1)
		progression_push_current
		kill_gem_scroller
	endif
endscript

script career_song_ended_select_quit
	if ($debug_playcredits_active = 1)
		progression_push_current \{ Force = 1 }
		Change \{ debug_playcredits_active = 0 }
	else
		progression_push_current
	endif
	kill_gem_scroller
endscript
career_restart_warning_fs = {
	Create = create_restart_warning_menu
	Destroy = destroy_restart_warning_menu
	actions = [
		{ action = continue func = career_restart_song transition_screen = default_loading_screen flow_state = career_play_song_fs }
		{ action = go_back flow_state = career_pause_fs }
	]
}
career_quit_warning_fs = {
	Create = create_quit_warning_menu
	Destroy = destroy_quit_warning_menu
	actions = [
		{ action = continue func = xenon_singleplayer_session_complete_uninit spawned_func flow_state = career_song_ended_fs }
		{ action = go_back flow_state = career_pause_fs }
	]
}
career_practice_warning_fs = {
	Create = create_practice_warning_menu
	Destroy = destroy_practice_warning_menu
	actions = [
		{ action = continue func = career_go_to_practice_setup flow_state = practice_select_song_section_fs }
		{ action = continue_tutorial func = career_go_to_tutorial_setup flow_state = practice_tutorial_select_fs }
		{ action = go_back use_last_flow_state }
	]
}

script career_go_to_practice_setup
	progression_push_current
	Change \{ came_to_practice_from = career }
	Change came_to_practice_difficulty = ($current_difficulty)
	kill_gem_scroller
	Change \{ game_mode = training }
endscript
select_battle_tutorial = 0

script career_go_to_tutorial_setup
	progression_push_current
	Change \{ came_to_practice_from = career }
	Change came_to_practice_difficulty = ($current_difficulty)
	kill_gem_scroller
	spawnscriptnow \{ Menu_Music_On }
	Change \{ select_battle_tutorial = 1 }
	Change \{ game_mode = tutorial }
endscript
career_newspaper_fs = {
	Create = create_newspaper_menu
	Destroy = destroy_newspaper_menu
	actions = [
		{ action = continue flow_state_func = career_find_newspaper_successor }
		{ action = try_again func = restart_song transition_screen = default_loading_screen flow_state = career_play_song_fs }
		{ action = select_detailed_stats flow_state = career_detailed_stats_fs transition_right }
		{ action = quit func = progression_push_current flow_state = main_menu_fs }
	]
}

script career_find_newspaper_successor
	unlock_guitar = ($progression_unlocked_guitar)
	sponsored = ($progression_got_sponsored_last_song)
	if ($player1_status.new_cash = 0)
		got_cash = 0
	else
		got_cash = 1
	endif
	if ($is_network_game)
		return \{ flow_state = online_menu_fs }
	elseif NOT (<unlock_guitar> = -1)
		return \{ flow_state = career_unlock_1_fs }
	elseif (<sponsored>)
		return \{ flow_state = career_sponsored_fs }
	elseif (<got_cash>)
		return \{ flow_state = career_cash_reward_fs }
	else
		GetGlobalTags \{ user_options }
		if (<autosave> = 1)
			return \{ flow_state = career_autosave_fs }
		else
			return \{ flow_state = career_setlist_fs }
		endif
	endif
endscript
career_cash_reward_fs = {
	Create = create_cash_reward_menu
	Destroy = destroy_cash_reward_menu
	actions = [
		{ action = continue flow_state_func = career_autosave_or_setlist }
	]
}

script career_autosave_or_setlist
	kill_gem_scroller
	destroy_song_ended_menu
	destroy_fail_song_menu
	kill_start_key_binding
	destroy_sponsored_menu
	if ($progression_play_completion_movie = 1)
		get_progression_globals game_mode = ($game_mode)
		FormatText ChecksumName = tiername 'tier%i' i = ($progression_completion_tier)
		if StructureContains Structure = ($<tier_global>.<tiername>)completion_movie
			Menu_Music_Off
			PlayMovieAndWait movie = ($<tier_global>.<tiername>.completion_movie)
			get_movie_id_by_name movie = ($<tier_global>.<tiername>.completion_movie)
			SetGlobalTags <Id> Params = { unlocked = 1 }
		endif
		Change \{ progression_play_completion_movie = 0 }
	endif
	GetGlobalTags \{ user_options }
	if (<autosave> = 1)
		return \{ flow_state = career_autosave_fs }
	else
		if ($progression_unlock_tier_last_song = 1)
			return \{ flow_state = career_select_venue_fs }
			Change \{ progression_unlock_tier_last_song = 0 }
		else
			return \{ flow_state = career_setlist_fs }
		endif
	endif
endscript
career_autosave_fs = {
	Create = memcard_sequence_begin_autosave
	Destroy = memcard_sequence_cleanup_generic
	actions = [
		{ action = memcard_sequence_save_success flow_state_func = career_autosave_venue_select }
		{ action = memcard_sequence_save_failed flow_state_func = career_autosave_venue_select }
	]
}

script career_autosave_venue_select
	if ($progression_unlock_tier_last_song = 1)
		Change \{ progression_unlock_tier_last_song = 0 }
		return \{ flow_state = career_select_venue_fs }
	else
		return \{ flow_state = career_setlist_fs }
	endif
endscript
career_detailed_stats_fs = {
	Create = create_detailed_stats_menu
	Destroy = destroy_detailed_stats_menu
	actions = [
		{ action = go_back flow_state = career_newspaper_fs transition_left }
		{ action = continue flow_state_func = career_find_newspaper_successor }
	]
}
career_sponsored_fs = {
	Create = create_sponsored_menu
	Destroy = destroy_sponsored_menu
	actions = [
		{ action = continue flow_state_func = career_autosave_or_setlist }
	]
}
career_unlock_1_fs = {
	Create = create_unlock_menu
	create_params = { num_guitars_unlocked = 1 }
	Destroy = destroy_unlock_menu
	actions = [
		{ action = continue flow_state_func = find_career_unlock_successor transition_right }
	]
}
career_unlock_2_fs = {
	Create = create_unlock_menu
	create_params = { num_guitars_unlocked = 2 }
	Destroy = destroy_unlock_menu
	actions = [
		{ action = continue flow_state_func = find_career_unlock_successor transition_right }
	]
}

script find_career_unlock_successor
	unlock_guitar = ($progression_unlocked_guitar)
	sponsored = ($progression_got_sponsored_last_song)
	if ($player1_status.new_cash = 0)
		got_cash = 0
	else
		got_cash = 1
	endif
	if NOT (<unlock_guitar> = -1)
		return \{ flow_state = career_unlock_2_fs }
	elseif (<sponsored> = 1)
		return \{ flow_state = career_sponsored_fs }
	elseif (<got_cash>)
		return \{ flow_state = career_cash_reward_fs }
	else
		GetGlobalTags \{ user_options }
		if (<autosave> = 1)
			return \{ flow_state = career_autosave_fs }
		else
			return \{ flow_state = career_setlist_fs }
		endif
	endif
endscript
career_encore_confirmation_fs = {
	Create = create_encore_confirmation_menu
	Destroy = destroy_encore_confirmation_menu
	actions = [
		{ action = continue func = start_encore flow_state = career_play_song_fs }
		{ action = quit func = kill_gem_scroller flow_state = career_newspaper_fs }
	]
}
career_setlist_fs = {
	Create = create_setlist_menu
	Destroy = destroy_setlist_menu
	actions = [
		{ action = continue transition_screen = default_loading_screen func = start_song flow_state = career_play_song_fs }
		{ action = show_help flow_state = career_battle_help_fs transition_right }
		{ action = go_back flow_state = career_select_venue_fs transition_left }
	]
}
career_battle_help_fs = {
	Create = create_battle_helper_menu
	Destroy = destroy_battle_helper_menu
	actions = [
		{ action = continue func = start_song transition_screen = default_loading_screen flow_state = career_play_song_fs }
		{ action = go_back flow_state = career_setlist_fs transition_left }
	]
}

script start_encore
	kill_start_key_binding
	create_loading_screen \{ mode = play_encore }
	if ($is_network_game = 0)
		xenon_singleplayer_session_init
	endif
	Change \{ current_transition = ENCORE }
	GetGlobalTags \{ Progression Params = encore_song }
	SetGlobalTags Progression Params = { current_tier = <next_tier> }
	SetGlobalTags Progression Params = { current_song_count = <next_song_count> }
	prepare_bassist_for_encore song = <encore_song>
	restart_gem_scroller song_name = <encore_song> difficulty = ($current_difficulty)difficulty2 = ($current_difficulty2)starttime = ($current_starttime)device_num = ($player1_status.controller)
endscript

script prepare_bassist_for_encore
	if NOT ($game_mode = p2_coop || $game_mode = p2_career)
		return
	endif
	if ($player1_status.band_Member = BASSIST)
		player_status = player1_status
	else
		player_status = player2_status
	endif
	if NOT find_profile_by_id Id = ($<player_status>.character_id)
		return
	endif
	get_musician_profile_struct Index = <Index>
	FormatText ChecksumName = default_characterguitartag1 'character_%c_player_%p_guitar_tags' c = (<profile_struct>.name)p = ($<player_status>.Player)
	if GetGlobalTags <default_characterguitartag1> noassert = 1
		current_guitar = <current_selected_guitar>
		current_bass = <current_selected_bass>
	else
		return
	endif
	get_song_rhythm_track song = <song>
	if (<rhythm_track> = 1)
		Change StructureName = <player_status> instrument_id = <current_guitar>
		SetGlobalTags <default_characterguitartag1> Params = { current_instrument = guitar }
	else
		Change StructureName = <player_status> instrument_id = <current_bass>
		SetGlobalTags <default_characterguitartag1> Params = { current_instrument = bass }
	endif
endscript
default_loading_screen = { Create = create_loading_screen Destroy = destroy_loading_screen }
career_autosave_boss_confirmation_fs = {
	Create = memcard_sequence_begin_autosave
	Destroy = memcard_sequence_cleanup_generic
	actions = [
		{ action = memcard_sequence_save_success flow_state = career_battle_help_boss_confirmation_fs }
		{ action = memcard_sequence_save_failed flow_state = career_battle_help_boss_confirmation_fs }
	]
}
career_battle_help_boss_confirmation_fs = {
	Create = create_battle_helper_menu
	create_params = { popup = 1 }
	Destroy = destroy_battle_helper_menu
	actions = [
		{ action = continue func = start_boss flow_state = career_play_song_fs }
		{ action = go_back func = kill_gem_scroller flow_state = career_setlist_fs transition_left }
	]
}

script should_play_boss_intro
	if NOT GotParam \{ song }
		song = ($current_song)
	endif
	return_val = FALSE
	GetPakManCurrent \{ map = Zones }
	switch <pak>
		case Z_Dive
			if (<song> = bosstom)
				return_val = TRUE
			endif
		case Z_Prison
			if (<song> = bossslash)
				return_val = TRUE
			endif
		case Z_Hell
			if (<song> = bossdevil)
				return_val = TRUE
			endif
	endswitch
	return <return_val>
endscript

script start_boss
	kill_start_key_binding
	destroy_loading_screen
	create_loading_screen \{ mode = play_boss }
	GetGlobalTags \{ Progression Params = boss_song }
	SetGlobalTags Progression Params = { current_tier = <next_tier> }
	SetGlobalTags Progression Params = { current_song_count = <next_song_count> }
	if ($show_boss_helper_screen = 1)
		Change \{ current_transition = boss }
	else
		Change \{ current_transition = fastintro }
	endif
	Change \{ boss_battle = 1 }
	Change \{ current_num_players = 2 }
	spawnscriptnow restart_gem_scroller Params = {song_name = <boss_song> difficulty = ($current_difficulty)difficulty2 = ($current_difficulty2)starttime = ($current_starttime)device_num = ($player1_status.controller)}
endscript

script get_current_battle_first_play
	get_band_game_mode_name
	FormatText ChecksumName = bandname_id 'band%i_info_%g' i = ($current_band)g = <game_mode_name>
	GetGlobalTags <bandname_id>
	return first_battle_play = <first_battle_play>
endscript

script set_current_battle_first_play \{ first_play = 0 }
	get_band_game_mode_name
	FormatText ChecksumName = bandname_id 'band%i_info_%g' i = ($current_band)g = <game_mode_name>
	SetGlobalTags <bandname_id> Params = { first_battle_play = <first_play> }
	GetGlobalTags <bandname_id>
endscript
