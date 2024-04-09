guitar_events = [
	{ Event = missed_note Scr = GuitarEvent_MissedNote }
	{ Event = unnecessary_note Scr = GuitarEvent_UnnecessaryNote }
	{ Event = hit_notes Scr = GuitarEvent_HitNotes }
	{ Event = hit_note Scr = GuitarEvent_HitNote }
	{ Event = star_power_on Scr = GuitarEvent_StarPowerOn }
	{ Event = star_power_off Scr = GuitarEvent_StarPowerOff }
	{ Event = song_failed Scr = GuitarEvent_SongFailed }
	{ Event = song_won Scr = GuitarEvent_SongWon }
	{ Event = star_hit_note Scr = GuitarEvent_StarHitNote }
	{ Event = star_sequence_bonus Scr = GuitarEvent_StarSequenceBonus }
	{ Event = star_miss_note Scr = GuitarEvent_StarMissNote }
	{ Event = whammy_on Scr = GuitarEvent_WhammyOn }
	{ Event = whammy_off Scr = GuitarEvent_WhammyOff }
	{ Event = star_whammy_on Scr = GuitarEvent_StarWhammyOn }
	{ Event = star_whammy_off Scr = GuitarEvent_StarWhammyOff }
	{ Event = note_window_open Scr = GuitarEvent_Note_Window_Open }
	{ Event = note_window_close Scr = GuitarEvent_Note_Window_Close }
	{ Event = crowd_poor_medium Scr = GuitarEvent_crowd_poor_medium }
	{ Event = crowd_medium_good Scr = GuitarEvent_crowd_medium_good }
	{ Event = crowd_medium_poor Scr = GuitarEvent_crowd_medium_poor }
	{ Event = crowd_good_medium Scr = GuitarEvent_crowd_good_medium }
	{ Event = first_gem Scr = GuitarEvent_CreateFirstGem }
	{ Event = firstnote_window_open Scr = GuitarEvent_FirstNote_Window_Open }
]

script create_guitar_events
	Printf "create_guitar_events %a .........." a = <player_text>
	GetArraySize \{ $guitar_events }
	array_entry = 0
	begin
		Printf \{ "adding..." }
		Event = ($guitar_events [ <array_entry> ].Event)
		ExtendCRC <Event> <player_text> out = Event
		SetEventHandler response = call_script Event = <Event> Scr = event_spawner Params = { event_spawned = <array_entry> }
		array_entry = (<array_entry> + 1)
	repeat <array_Size>
	if IsWinPort
		WinPortGetConfigNumber \{ name = "Sound.ClapDelay" defaultValue = 0 }
		Change winport_clap_delay = <value>
	endif
	Block
endscript

script event_spawner
	spawnscriptnow ($guitar_events [ <event_spawned> ].Scr)Params = { <...>	 }Id = song_event_scripts
endscript

script event_iterator
	Printf "Event Iterator started with time %d" d = <time_offset>
	get_song_prefix song = <song_name>
	FormatText ChecksumName = song '%s_%e' s = <song_prefix> e = <event_string> AddToStringLookup
	array_entry = 0
	GetArraySize $<song>
	if (<array_Size> = 0)
		return
	endif
	GetSongTimeMS time_offset = <time_offset>
	begin
		if ((<Time> - <skipleadin>)< (($<song> [ <array_entry> ]).Time))
			break
		endif
		<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
	array_Size = (<array_Size> - <array_entry>)
	if (<array_Size> = 0)
		return
	endif
	begin
		TimeMarkerReached_SetParams time_offset = <time_offset> array = <song> array_entry = <array_entry> ArrayOfStructures
		begin
			if TimeMarkerReached
				GetSongTimeMS time_offset = <time_offset>
				break
			endif
			wait \{ 1 GameFrame }
		repeat
		TimeMarkerReached_ClearParams
		ScriptName = ($<song> [ <array_entry> ].Scr)
		if ScriptExists <ScriptName>
			spawnscriptnow <ScriptName> Params = {Time = <Time> ($<song> [ <array_entry> ].Params)}Id = song_event_scripts
		elseif SymbolIsCFunc <ScriptName>
			<ScriptName> {Time = <Time> ($<song> [ <array_entry> ].Params)}
		endif
		<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
endscript

script GuitarEvent_MissedNote
	if (<bum_note> = 1)
		Guitar_Wrong_Note_Sound_Logic <...>
	endif
	if ($is_network_game & ($<player_status>.Player = 2))
		if (<silent_miss> = 1)
			spawnscriptnow highway_pulse_black Params = {player_text = ($<player_status>.text)}
		endif
	else
		if NOT ($<player_status>.guitar_volume = 0)
			if (<silent_miss> = 1)
				spawnscriptnow highway_pulse_black Params = {player_text = ($<player_status>.text)}
			else
				Change StructureName = <player_status> guitar_volume = 0
				UpdateGuitarVolume
			endif
		endif
	endif
	CrowdDecrease player_status = <player_status>
	if ($always_strum = FALSE)
		if ($disable_band = 0)
			if CompositeObjectExists name = (<player_status>.band_Member)
				LaunchEvent Type = Anim_MissedNote Target = (<player_status>.band_Member)
			endif
		endif
	endif
	note_time = ($<song> [ <array_entry> ] [ 0 ])
	if ($show_play_log = 1)
		output_log_text "Missed Note (%t)" t = <note_time> Color = Orange
	endif
endscript

script highway_pulse_black
	<half_time> = ($highway_pulse_time / 2.0)
	FormatText ChecksumName = highway 'Highway_2D%p' p = <player_text> AddToStringLookup = TRUE
	DoScreenElementMorph Id = <highway> rgba = ($highway_pulse)Time = <half_time>
	wait <half_time> seconds
	DoScreenElementMorph Id = <highway> rgba = ($highway_normal)Time = <half_time>
endscript

script Guitar_Wrong_Note_Sound_Logic
	if ($current_num_players = 1)
		get_song_rhythm_track song = ($current_song)
		if ($<player_status>.part = rhythm)
			if (<rhythm_track> = 1)
				SoundEvent \{ Event = Single_Player_Bad_Note_Guitar }
			else
				SoundEvent \{ Event = Single_Player_Bad_Note_Bass }
			endif
		else
			SoundEvent \{ Event = Single_Player_Bad_Note_Guitar }
		endif
	else
		if ($<player_status>.Player = 1)
			get_song_rhythm_track song = ($current_song)
			if ($<player_status>.part = rhythm)
				if (<rhythm_track> = 1)
					SoundEvent \{ Event = First_Player_Bad_Note_Guitar }
				else
					SoundEvent \{ Event = First_Player_Bad_Note_Bass }
				endif
			else
				SoundEvent \{ Event = First_Player_Bad_Note_Guitar }
			endif
		else
			get_song_rhythm_track song = ($current_song)
			if ($boss_battle = 1)
				SoundEvent \{ Event = Second_Player_Bad_Note_Guitar }
			else
				if ($<player_status>.part = rhythm)
					if (<rhythm_track> = 1)
						SoundEvent \{ Event = Second_Player_Bad_Note_Guitar }
					else
						SoundEvent \{ Event = Second_Player_Bad_Note_Bass }
					endif
				else
					SoundEvent \{ Event = Second_Player_Bad_Note_Guitar }
				endif
			endif
		endif
	endif
endscript

script GuitarEvent_UnnecessaryNote
	Guitar_Wrong_Note_Sound_Logic <...>
	if NOT ($is_network_game & ($<player_status>.Player = 2))
		Change StructureName = <player_status> guitar_volume = 0
		UpdateGuitarVolume
	endif
	CrowdDecrease player_status = <player_status>
	if ($always_strum = FALSE)
		if ($disable_band = 0)
			if CompositeObjectExists name = (<player_status>.band_Member)
				LaunchEvent Type = Anim_MissedNote Target = (<player_status>.band_Member)
			endif
		endif
	endif
	if ($show_play_log = 1)
		if (<array_entry> > 0)
			<songtime> = (<songtime> - ($check_time_early * 1000.0))
			next_note = ($<song> [ <array_entry> ] [ 0 ])
			prev_note = ($<song> [(<array_entry> -1)] [ 0 ])
			next_time = (<next_note> - <songtime>)
			prev_time = (<songtime> - <prev_note>)
			if (<prev_time> < ($check_time_late * 1000.0))
				<prev_time> = 1000000.0
			endif
			if (<next_time> < <prev_time>)
				<next_time> = (0 - <next_time>)
				output_log_text "ME: %n (%t)" n = <next_time> t = <next_note> Color = Red
			else
				output_log_text "ML: %n (%t)" n = <prev_time> t = <prev_note> Color = darkred
			endif
		endif
	endif
endscript

script GuitarEvent_HitNotes
	if GuitarEvent_HitNotes_CFunc
		UpdateGuitarVolume
	endif
endscript

script GuitarEvent_HitNote
	spawnscriptnow GuitarEvent_HitNote_Spawned Params = { <...>	 }
endscript

script GuitarEvent_HitNote_Spawned
	if ($game_mode = p2_battle || $boss_battle = 1)
		Change StructureName = <player_status> last_hit_note = <Color>
	endif
	wait \{ 1 GameFrame }
	spawnscriptnow hit_note_fx Params = {name = <fx_id> Pos = <Pos> player_text = <player_text> star = ($<player_status>.star_power_used)Player = <Player>}
endscript
hit_particle_params = {
	z_priority = 8.0
	Material = sys_Particle_Spark01_sys_Particle_Spark01
	start_color = [ 255 128 0 255 ]
	end_color = [ 255 0 0 0 ]
	start_scale = (1.0, 1.0)
	end_scale = (0.5, 0.5)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	Emit_Rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	Time = 0.25
}
star_hit_particle_params = {
	z_priority = 8.0
	Material = sys_Particle_Spark01_sys_Particle_Spark01
	start_color = [ 0 255 255 255 ]
	end_color = [ 0 255 255 0 ]
	start_scale = (1.0, 1.0)
	end_scale = (0.5, 0.5)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	Emit_Rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	Time = 0.25
}
whammy_particle_params = {
	z_priority = 8.0
	Material = sys_Particle_Spark01_sys_Particle_Spark01
	start_color = [ 255 128 0 255 ]
	end_color = [ 255 0 0 0 ]
	start_scale = (1.0, 1.0)
	end_scale = (0.5, 0.5)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	Emit_Rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	Time = 0.5
}

script hit_note_fx
	NoteFX <...>
	wait \{ 6 gameframes }
	Destroy2DParticleSystem Id = <particle_id> kill_when_empty
	wait \{ 10 gameframes }
	if ScreenElementExists Id = <fx_id>
		DestroyScreenElement Id = <fx_id>
	endif
endscript

script GuitarEvent_StarPowerOn
	GH_Star_Power_Verb_On
	FormatText ChecksumName = scriptID '%p_StarPower_StageFX' p = <player_text>
	SpawnScriptLater Do_StarPower_StageFX Id = <scriptID> Params = { <...>	}
	StarPowerOn Player = <Player>
endscript

script GuitarEvent_StarPowerOff
	GH_Star_Power_Verb_Off
	spawnscriptnow rock_meter_star_power_off Params = { player_text = <player_text> }
	SpawnScriptLater Kill_StarPower_StageFX Params = { <...>  }
	FormatText ChecksumName = cont 'starpower_container_left%p' p = <player_text> AddToStringLookup = TRUE
	if ScreenElementExists Id = <cont>
		DoScreenElementMorph Id = <cont> Alpha = 0
	endif
	FormatText ChecksumName = cont 'starpower_container_right%p' p = <player_text> AddToStringLookup = TRUE
	if ScreenElementExists Id = <cont>
		DoScreenElementMorph Id = <cont> Alpha = 0
	endif
	FormatText ChecksumName = highway 'Highway_2D%p' p = <player_text> AddToStringLookup = TRUE
	if ScreenElementExists Id = <highway>
		SetScreenElementProps Id = <highway> rgba = ($highway_normal)
	endif
	spawnscriptnow \{ Kill_StarPower_Camera }
endscript
winport_clap_delay = 0.18

script GuitarEvent_PreFretbar
	if ($winport_clap_delay > 0)
		wait \{ $winport_clap_delay seconds }
		if ($<player_status>.star_power_used = 1)
			if ($game_mode != tutorial)
				Printf \{ channel = SFX "Clap" }
				SoundEvent \{ Event = Crowd_Individual_Clap_To_Beat }
			endif
		else
			if ($CrowdListenerStateClapOn1234 = 1)
				SoundEvent \{ Event = Crowd_Individual_Clap_To_Beat }
			endif
		endif
	endif
endscript
beat_flip = 0

script GuitarEvent_Fretbar
	if ($current_num_players = 2)
		if ($game_mode = p2_battle || $boss_battle)
			<dying> = 0
			if (($player1_status.current_health)<= $crowd_poor_medium * $highway_flash_dying)
				<dying> = 1
			endif
			set_sidebar_flash <...> player_status = player1_status
			<dying> = 0
			if (($player2_status.current_health)<= $crowd_poor_medium * $highway_flash_dying)
				<dying> = 1
			endif
			if NOT ($player1_status.highway_layout = solo_highway)
				set_sidebar_flash <...> player_status = player2_status
			endif
		else
			<dying> = 0
			if ($current_crowd <= $crowd_poor_medium * $highway_flash_dying)
				<dying> = 1
			endif
			if ($game_mode = p2_faceoff)
				<dying> = 0
			endif
			if ($game_mode = p2_pro_faceoff)
				<dying> = 0
			endif
			set_sidebar_flash <...> player_status = player1_status
			if NOT ($player1_status.highway_layout = solo_highway)
				set_sidebar_flash <...> player_status = player2_status
			endif
		endif
	else
		<dying> = 0
		if ($current_crowd <= $crowd_poor_medium * $highway_flash_dying)
			<dying> = 1
		endif
		set_sidebar_flash <...> player_status = player1_status
	endif
	Change beat_flip = (1 - $beat_flip)
endscript

script set_sidebar_flash
	FormatText ChecksumName = Left 'sidebar_left%p' p = ($<player_status>.text)AddToStringLookup = TRUE
	FormatText ChecksumName = Right 'sidebar_right%p' p = ($<player_status>.text)AddToStringLookup = TRUE
	if ($<player_status>.star_power_used = 1)
		if ($beat_flip = 0)
			SetScreenElementProps Id = <Left> rgba = ($sidebar_starpower0)
			SetScreenElementProps Id = <Right> rgba = ($sidebar_starpower0)
		else
			SetScreenElementProps Id = <Left> rgba = ($sidebar_starpower1)
			SetScreenElementProps Id = <Right> rgba = ($sidebar_starpower1)
		endif
	else
		if (<dying> = 1)
			if ($beat_flip = 0)
				SetScreenElementProps Id = <Left> rgba = ($sidebar_dying0)
				SetScreenElementProps Id = <Right> rgba = ($sidebar_dying0)
			else
				SetScreenElementProps Id = <Left> rgba = ($sidebar_dying1)
				SetScreenElementProps Id = <Right> rgba = ($sidebar_dying1)
			endif
		else
			if ($<player_status>.star_power_amount >= 50.0)
				if ($beat_flip = 0)
					SetScreenElementProps Id = <Left> rgba = ($sidebar_starready0)
					SetScreenElementProps Id = <Right> rgba = ($sidebar_starready0)
				else
					SetScreenElementProps Id = <Left> rgba = ($sidebar_starready1)
					SetScreenElementProps Id = <Right> rgba = ($sidebar_starready1)
				endif
			else
				if ($beat_flip = 0)
					SetScreenElementProps Id = <Left> rgba = ($sidebar_normal0)
					SetScreenElementProps Id = <Right> rgba = ($sidebar_normal0)
				else
					SetScreenElementProps Id = <Left> rgba = ($sidebar_normal1)
					SetScreenElementProps Id = <Right> rgba = ($sidebar_normal1)
				endif
			endif
		endif
	endif
endscript

script GuitarEvent_Fretbar_Early
endscript

script GuitarEvent_Fretbar_Late
endscript

script check_first_note_formed
	getsongtime
	<starttime> = (<songtime> - 0.0167)
	Duration = ($<player_status>.check_time_early + $<player_status>.check_time_late)
	begin
		GetHeldPattern controller = ($<player_status>.controller)player_status = <player_status>
		if (<strum> = <hold_pattern>)
			Change StructureName = <player_status> guitar_volume = 100
			UpdateGuitarVolume
		endif
		wait \{ 1 GameFrame }
		getsongtime
		if ((<songtime> - <starttime>)>= <Duration>)
			break
		endif
	repeat
endscript

script GuitarEvent_FirstNote_Window_Open
	if IsGuitarController controller = ($<player_status>.controller)
		GetStrumPattern entry = 0 song = <song>
		spawnscriptnow check_first_note_formed Params = {strum = <strum> player_status = <player_status>}
	else
		Change StructureName = <player_status> guitar_volume = 100
		UpdateGuitarVolume
	endif
endscript

script GuitarEvent_Note_Window_Open
	if ($Debug_Audible_Open = 1)
		SoundEvent \{ Event = GH_SFX_BeatWindowOpenSoundEvent }
	endif
	getsongtime
	<starttime> = (<songtime> - 0.0167)
	begin
		wait \{ 1 GameFrame }
		getsongtime
		if ((<songtime> - <starttime>)>= $check_time_early)
			break
		endif
	repeat
	if ($Debug_Audible_Downbeat = 1)
		SoundEvent \{ Event = GH_SFX_BeatSoundEvent }
	endif
endscript

script GuitarEvent_Note_Window_Close
	if ($Debug_Audible_Close = 1)
		SoundEvent \{ Event = GH_SFX_BeatWindowCloseSoundEvent }
	endif
endscript
blueWhammyFXID01p1 = JOW_NIL
blueWhammyFXID02p1 = JOW_NIL
greenWhammyFXID01p1 = JOW_NIL
greenWhammyFXID02p1 = JOW_NIL
orangeWhammyFXID01p1 = JOW_NIL
orangeWhammyFXID02p1 = JOW_NIL
redWhammyFXID01p1 = JOW_NIL
redWhammyFXID02p1 = JOW_NIL
yellowWhammyFXID01p1 = JOW_NIL
yellowWhammyFXID02p1 = JOW_NIL
blueWhammyFXID01p2 = JOW_NIL
blueWhammyFXID02p2 = JOW_NIL
greenWhammyFXID01p2 = JOW_NIL
greenWhammyFXID02p2 = JOW_NIL
orangeWhammyFXID01p2 = JOW_NIL
orangeWhammyFXID02p2 = JOW_NIL
redWhammyFXID01p2 = JOW_NIL
redWhammyFXID02p2 = JOW_NIL
yellowWhammyFXID01p2 = JOW_NIL
yellowWhammyFXID02p2 = JOW_NIL

script Destroy_AllWhammyFX
	WhammyFXOffAll \{ player_status = player1_status }
	WhammyFXOffAll \{ player_status = player2_status }
endscript

script GuitarEvent_WhammyOn
	WhammyFXOn <...>
endscript

script GuitarEvent_WhammyOff
	WhammyFXOff <...>
endscript

script GuitarEvent_StarWhammyOn
endscript

script GuitarEvent_StarWhammyOff
endscript

script GuitarEvent_SongFailed
	if ($game_mode = training || $game_mode = tutorial)
		return
	endif
	if ($is_network_game)
		spawnscriptnow \{ online_fail_song }
		return
	endif
	if ($game_mode = p2_battle)
		GuitarEvent_SongWon \{ battle_win = 1 }
	else
		killspawnedscript \{ name = GuitarEvent_SongWon_Spawned }
		spawnscriptnow \{ GuitarEvent_SongFailed_Spawned }
	endif
endscript

script GuitarEvent_SongFailed_Spawned
	if NOT ($boss_battle = 1)
		disable_highway_prepass
		disable_bg_viewport
	endif
	if ($is_network_game)
		Change \{ gIsInNetGame = 0 }
	endif
	if ($is_network_game)
		killspawnedscript \{ name = dispatch_player_state }
		kill_start_key_binding
		if ($ui_flow_manager_state [ 0 ] = online_pause_fs)
			net_unpausegh3
		endif
		mark_unsafe_for_shutdown
	endif
	GetSongTimeMS
	Change failed_song_time = <Time>
	Achievements_SongFailed
	PauseGame
	Progression_SongFailed
	if ($boss_battle = 1)
		kill_start_key_binding
		if ($current_song = bossdevil)
			preload_movie = 'Satan-Battle_LOSS'
		else
			preload_movie = 'Player2_wins'
		endif
		KillMovie \{ TextureSlot = 1 }
		PreLoadMovie {
			movie = <preload_movie>
			TextureSlot = 1
			TexturePri = 70
			no_looping
			no_hold
			noWait
		}
		FormatText textname = winner_text "%s Rocks!" s = ($current_boss.character_name)
		winner_space_between = (50.0, 0.0)
		winner_scale = 1.0
		if ($current_boss.character_profile = Morello)
			<winner_space_between> = (40.0, 0.0)
			<winner_scale> = 1.0
		endif
		if ($current_boss.character_profile = Slash)
			<winner_space_between> = (40.0, 0.0)
			<winner_scale> = 1.0
		endif
		if ($current_boss.character_profile = Satan)
			<winner_space_between> = (40.0, 0.0)
			<winner_scale> = 1.0
		endif
		spawnscriptnow \{ wait_and_play_you_rock_movie }
		wait \{ 0.2 seconds }
		destroy_menu \{ menu_id = yourock_text }
		destroy_menu \{ menu_id = yourock_text_2 }
		StringLength string = <winner_text>
		<fit_dims> = (<str_len> * (23.0, 0.0))
		if (<fit_dims>.(1.0, 0.0) >= 350)
			<fit_dims> = (350.0, 0.0)
		endif
		split_text_into_array_elements {
			Id = yourock_text
			text = <winner_text>
			text_pos = (640.0, 360.0)
			space_between = <winner_space_between>
			just = [ center center ]
			fit_dims = <fit_dims>
			flags = {
				rgba = [ 255 255 255 255 ]
				Scale = <winner_scale>
				z_priority = 95
				font = text_a10_Large
				rgba = [ 223 223 223 255 ]
				just = [ center center ]
				Alpha = 1
			}
			centered
		}
		spawnscriptnow \{ waitAndKillHighway }
		killspawnedscript \{ name = jiggle_text_array_elements }
		spawnscriptnow \{jiggle_text_array_elements Params = { Id = yourock_text Time = 1.0 wait_time = 3000 explode = 1 }}
	endif
	if ($is_network_game = 0)
		xenon_singleplayer_session_begin_uninit
		spawnscriptnow \{ xenon_singleplayer_session_complete_uninit }
	endif
	UnPauseGame
	SoundEvent \{ Event = Crowd_Fail_Song_SFX }
	SoundEvent \{ Event = GH_SFX_You_Lose_Single_Player }
	Transition_Play \{ Type = songlost }
	Transition_Wait
	Change \{ current_transition = None }
	PauseGame
	restore_start_key_binding
	spawnscriptnow \{ui_flow_manager_respond_to_action Params = { action = fail_song }}
	if ($current_num_players = 1)
		SoundEvent \{ Event = Crowd_Fail_Song_SFX }
	else
		SoundEvent \{ Event = Crowd_Med_To_Good_SFX }
	endif
	if ($is_network_game)
		mark_safe_for_shutdown
	endif
endscript

script GuitarEvent_SongWon \{ battle_win = 0 }
	if NotCD
		if ($output_gpu_log = 1)
			if IsPS3
				FormatText \{ textname = FileName "%s_gpu_ps3" s = $current_level DontAssertForChecksums }
			else
				FormatText \{ textname = FileName "%s_gpu" s = $current_level DontAssertForChecksums }
			endif
			TextOutputEnd output_text FileName = <FileName>
		endif
		if ($output_song_stats = 1)
			FormatText \{ textname = FileName "%s_stats" s = $current_song DontAssertForChecksums }
			TextOutputStart
			TextOutput \{ text = "Player 1" }
			FormatText textname = text "Score: %s" s = ($player1_status.score)DontAssertForChecksums
			TextOutput text = <text>
			FormatText textname = text "Notes Hit: %n of %t" n = ($player1_status.notes_hit)t = ($player1_status.total_notes)DontAssertForChecksums
			TextOutput text = <text>
			FormatText textname = text "Best Run: %r" r = ($player1_status.best_run)DontAssertForChecksums
			TextOutput text = <text>
			FormatText textname = text "Max Notes: %m" m = ($player1_status.max_notes)DontAssertForChecksums
			TextOutput text = <text>
			FormatText textname = text "Base score: %b" b = ($player1_status.base_score)DontAssertForChecksums
			TextOutput text = <text>
			if (($player1_status.base_score)= 0)
				FormatText \{ textname = text "Score Scale: n/a" }
			else
				FormatText textname = text "Score Scale: %s" s = (($player1_status.score)/ ($player1_status.base_score))DontAssertForChecksums
			endif
			TextOutput text = <text>
			if (($player1_status.total_notes)= 0)
				FormatText \{ textname = text "Notes Hit Percentage: n/a" }
			else
				FormatText textname = text "Notes Hit Percentage: %s" s = ((($player1_status.notes_hit)/ ($player1_status.total_notes))* 100.0)DontAssertForChecksums
			endif
			TextOutput text = <text>
			TextOutputEnd output_text FileName = <FileName>
		endif
	endif
	if ($current_num_players = 2)
		GetSongTimeMS
		if ($last_time_in_lead_player = 0)
			Change StructureName = player1_status time_in_lead = ($player1_status.time_in_lead + <Time> - $last_time_in_lead)
		elseif ($last_time_in_lead_player = 1)
			Change StructureName = player2_status time_in_lead = ($player2_status.time_in_lead + <Time> - $last_time_in_lead)
		endif
		Change \{ last_time_in_lead_player = -1 }
	endif
	if ($game_mode = p2_battle)
		if NOT (<battle_win> = 1)
			Change \{ save_current_powerups_p1 = $current_powerups_p1 }
			Change \{ save_current_powerups_p2 = $current_powerups_p2 }
			Change \{current_powerups_p1 = [ 0 0 0 ]}
			Change \{current_powerups_p2 = [ 0 0 0 ]}
			Change StructureName = player1_status save_num_powerups = ($player1_status.current_num_powerups)
			Change StructureName = player2_status save_num_powerups = ($player2_status.current_num_powerups)
			Change \{ StructureName = player1_status current_num_powerups = 0 }
			Change \{ StructureName = player2_status current_num_powerups = 0 }
			p1_health = ($player1_status.current_health)
			p2_health = ($player2_status.current_health)
			Change StructureName = player1_status save_health = <p1_health>
			Change StructureName = player2_status save_health = <p2_health>
			battlemode_killspawnedscripts
			if ScreenElementExists \{ Id = battlemode_container }
				DestroyScreenElement \{ Id = battlemode_container }
			endif
			Change \{ battle_sudden_death = 1 }
		else
			battlemode_killspawnedscripts
			Change \{ battle_sudden_death = 0 }
		endif
	endif
	killspawnedscript \{ name = GuitarEvent_SongFailed_Spawned }
	spawnscriptnow \{ GuitarEvent_SongWon_Spawned }
endscript

script GuitarEvent_SongWon_Spawned
	if ($is_network_game)
		mark_unsafe_for_shutdown
		if ($is_network_game)
			Change \{ gIsInNetGame = 0 }
		endif
		if ($shutdown_game_for_signin_change_flag = 1)
			return
		endif
		if ($ui_flow_manager_state [ 0 ] = online_pause_fs)
			net_unpausegh3
		endif
		killspawnedscript \{ name = dispatch_player_state }
		if ($player2_present)
			SendNetMessage {
				Type = net_win_song
				stars = ($player1_status.stars)
				note_streak = ($player1_status.best_run)
				notes_hit = ($player1_status.notes_hit)
				total_notes = ($player1_status.total_notes)
			}
		endif
		if NOT ($game_mode = p2_battle || $Cheat_NoFail = 1 || $Cheat_EasyExpert = 1)
			if ($game_mode = p2_coop)
				online_song_end_write_stats \{ song_type = coop }
			else
				online_song_end_write_stats \{ song_type = single }
			endif
		endif
	endif
	if ($is_attract_mode = 1)
		spawnscriptnow \{ui_flow_manager_respond_to_action Params = { action = exit_attract_mode play_sound = 0 }}
		return
	endif
	if ($game_mode = training || $game_mode = tutorial)
		return
	endif
	if ($current_song = bossdevil & $devil_finish = 0)
		Change \{ devil_finish = 1 }
	else
		Change \{ devil_finish = 0 }
	endif
	Progression_EndCredits_Done
	PauseGame
	kill_start_key_binding
	if ($battle_sudden_death = 1)
		SoundEvent \{ Event = GH_SFX_BattleMode_Sudden_Death }
	else
		if ($game_mode = p1_career || $game_mode = p2_career || $game_mode = p2_coop || $game_mode = p1_quickplay)
			SoundEvent \{ Event = You_Rock_End_SFX }
		endif
	endif
	spawnscriptnow \{ You_Rock_Waiting_Crowd_SFX }
	if ($game_mode = p2_battle || $boss_battle = 1)
		if ($player1_status.current_health >= $player2_status.current_health)
			if ($current_song = bossdevil)
				preload_movie = 'Satan-Battle_WIN'
			else
				preload_movie = 'Player1_wins'
			endif
		else
			if ($current_song = bossdevil)
				preload_movie = 'Satan-Battle_LOSS'
			else
				preload_movie = 'Player2_wins'
			endif
		endif
		if ($current_song = bossdevil & $devil_finish = 0)
			preload_movie = 'Golden_Guitar'
		endif
		if ($battle_sudden_death = 1)
			preload_movie = 'Fret_Flames'
		endif
		KillMovie \{ TextureSlot = 1 }
		PreLoadMovie {
			movie = <preload_movie>
			TextureSlot = 1
			TexturePri = 70
			no_looping
			no_hold
			noWait
		}
	endif
	if NOT ($devil_finish = 1 || $battle_sudden_death = 1)
		spawnscriptnow \{ wait_and_play_you_rock_movie }
	endif
	destroy_menu \{ menu_id = yourock_text }
	destroy_menu \{ menu_id = yourock_text_2 }
	tie = FALSE
	text_pos = (640.0, 360.0)
	rock_legend = 0
	fit_dims = (350.0, 0.0)
	if ($battle_sudden_death = 1)
		winner_text = "Sudden Death!"
		winner_space_between = (65.0, 0.0)
		winner_scale = 1.8
	else
		if ($game_mode = p2_battle)
			p1_health = ($player1_status.current_health)
			p2_health = ($player2_status.current_health)
			if (<p2_health> > <p1_health>)
				winner = "Two"
				SoundEvent \{ Event = UI_2ndPlayerWins_SFX }
			else
				winner = "One"
				SoundEvent \{ Event = UI_1stPlayerWins_SFX }
			endif
			if ($is_network_game)
				if (<p2_health> > <p1_health>)
					name = ($opponent_gamertag)
				else
					if (NetSessionFunc Obj = match func = get_gamertag)
						name = <name>
					endif
				endif
				FormatText textname = winner_text <name>
				<text_pos> = (640.0, 240.0)
			else
				FormatText textname = winner_text "Player %s Rocks!" s = <winner>
			endif
			winner_space_between = (50.0, 0.0)
			winner_scale = 1.5
		elseif ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff)
			p1_score = ($player1_status.score)
			p2_score = ($player2_status.score)
			if (<p2_score> > <p1_score>)
				winner = "Two"
				SoundEvent \{ Event = UI_2ndPlayerWins_SFX }
			elseif (<p1_score> > <p2_score>)
				winner = "One"
				SoundEvent \{ Event = UI_1stPlayerWins_SFX }
			else
				<tie> = TRUE
				SoundEvent \{ Event = You_Rock_End_SFX }
			endif
			if (<tie> = TRUE)
				winner_text = "TIE!"
				winner_space_between = (15.0, 0.0)
				winner_scale = 0.5
				fit_dims = (100.0, 0.0)
			else
				if ($is_network_game)
					if (<p2_score> > <p1_score>)
						name = ($opponent_gamertag)
					else
						if (NetSessionFunc Obj = match func = get_gamertag)
							name = <name>
						endif
					endif
					FormatText textname = winner_text <name>
					<text_pos> = (640.0, 240.0)
				else
					FormatText textname = winner_text "Player %s Rocks!" s = <winner>
				endif
				winner_space_between = (50.0, 0.0)
				winner_scale = 1.5
			endif
		else
			winner_text = "You Rock!"
			winner_space_between = (40.0, 0.0)
			fit_dims = (350.0, 0.0)
			winner_scale = 1.0
		endif
		if ($devil_finish = 1)
			winner_text = "Now Finish Him!"
			winner_space_between = (55.0, 0.0)
			winner_scale = 1.8
		endif
		if ($current_song = bossdevil & $devil_finish = 0)
			<rock_legend> = 1
			winner_text = "YOU'RE A"
			<text_pos> = (800.0, 300.0)
			winner_space_between = (40.0, 0.0)
			winner_scale = 1.1
			fit_dims = (200.0, 0.0)
		endif
	endif
	StringLength string = <winner_text>
	<fit_dims> = (<str_len> * (23.0, 0.0))
	if (<fit_dims>.(1.0, 0.0) >= 350)
		<fit_dims> = (350.0, 0.0)
	endif
	split_text_into_array_elements {
		Id = yourock_text
		text = <winner_text>
		text_pos = <text_pos>
		space_between = <winner_space_between>
		fit_dims = <fit_dims>
		flags = {
			rgba = [ 255 255 255 255 ]
			Scale = <winner_scale>
			z_priority = 95
			font = text_a10_Large
			rgba = [ 223 223 223 255 ]
			just = [ center center ]
			Alpha = 1
		}
		centered
	}
	if (<rock_legend> = 1)
		split_text_into_array_elements {
			Id = yourock_text_legend
			text = "ROCK LEGEND!"
			text_pos = (800.0, 420.0)
			space_between = <winner_space_between>
			fit_dims = (200.0, 0.0)
			flags = {
				rgba = [ 255 255 255 255 ]
				Scale = <winner_scale>
				z_priority = 95
				font = text_a10_Large
				rgba = [ 223 223 223 255 ]
				just = [ center center ]
				Alpha = 1
			}
			centered
		}
	endif
	if (($is_network_game)& ($battle_sudden_death = 0)& (<tie> = FALSE))
		if NOT ($game_mode = p2_coop)
			split_text_into_array_elements {
				Id = yourock_text_2
				text = "Rocks!"
				text_pos = (640.0, 380.0)
				fit_dims = <fit_dims>
				space_between = <winner_space_between>
				flags = {
					rgba = [ 255 255 255 255 ]
					Scale = <winner_scale>
					z_priority = 95
					font = text_a10_Large
					rgba = [ 223 223 223 255 ]
					just = [ center center ]
					Alpha = 1
				}
				centered
			}
		endif
	endif
	if NOT ($devil_finish = 1 || $battle_sudden_death = 1)
		spawnscriptnow \{ waitAndKillHighway }
		killspawnedscript \{ name = jiggle_text_array_elements }
		spawnscriptnow \{jiggle_text_array_elements Params = { Id = yourock_text Time = 1.0 wait_time = 3000 explode = 1 }}
		if (<rock_legend> = 1)
			spawnscriptnow \{jiggle_text_array_elements Params = { Id = yourock_text_legend Time = 1.0 wait_time = 3000 explode = 1 }}
		endif
		if ($is_network_game)
			spawnscriptnow \{jiggle_text_array_elements Params = { Id = yourock_text_2 Time = 1.0 wait_time = 3000 explode = 1 }}
		endif
		if ($current_song = bossslash || $current_song = bosstom || $current_song = bossdevil)
			boss_character = -1
			if ($current_song = bossslash)
				<boss_character> = 0
			elseif ($current_song = bosstom)
				<boss_character> = 1
			elseif ($current_song = bossdevil)
				<boss_character> = 2
			endif
			if (<boss_character> >= 0)
				unlocked_for_purchase = 1
				GetGlobalTags ($Secret_Characters [ <boss_character> ].Id)
				if (<unlocked_for_purchase> = 0)
					spawnscriptnow \{Boss_Unlocked_Text Params = { parent_id = yourock_text }}
					SetGlobalTags ($Secret_Characters [ <boss_character> ].Id)Params = { unlocked_for_purchase = 1 }
				endif
			endif
		endif
	endif
	Change \{ old_song = None }
	if NOT ($devil_finish = 1)
		if NOT ($battle_sudden_death = 1)
			Progression_SongWon
			if ($current_transition = preencore)
				end_song
				UnPauseGame
				Transition_Play \{ Type = preencore }
				Transition_Wait
				Change \{ current_transition = None }
				PauseGame
				ui_flow_manager_respond_to_action \{ action = preencore_win_song }
				ENCORE_TRANSITION = 1
			elseif ($current_transition = preboss)
				end_song
				UnPauseGame
				Transition_Play \{ Type = preboss }
				Transition_Wait
				Change \{ current_transition = None }
				PauseGame
				Change \{ use_last_player_scores = 1 }
				Change old_song = ($current_song)
				Change \{ show_boss_helper_screen = 1 }
				ui_flow_manager_respond_to_action \{ action = preboss_win_song }
				if ($is_network_game = 0)
					if NOT ($boss_battle = 1)
						if NOT ($devil_finish)
							agora_write_stats
						endif
					endif
					net_write_single_player_stats
					SpawnScriptLater \{ xenon_singleplayer_session_complete_uninit }
				endif
				return
			else
				UnPauseGame
				Transition_Play \{ Type = songwon }
				Transition_Wait
				Change \{ current_transition = None }
				PauseGame
			endif
		else
			UnPauseGame
			Transition_Play \{ Type = songwon }
			spawnscriptnow \{ wait_and_play_you_rock_movie }
			killspawnedscript \{ name = jiggle_text_array_elements }
			spawnscriptnow \{jiggle_text_array_elements Params = { Id = yourock_text Time = 1.0 wait_time = 3000 explode = 1 }}
			spawnscriptnow \{Sudden_Death_Helper_Text Params = { parent_id = yourock_text }}
			wait \{ 0.1 seconds }
			spawnscriptnow \{ waitAndKillHighway }
			wait \{ 4 seconds }
			Change \{ current_transition = None }
			PauseGame
		endif
	else
		UnPauseGame
		Transition_Play \{ Type = songwon }
		spawnscriptnow \{ wait_and_play_you_rock_movie }
		killspawnedscript \{ name = jiggle_text_array_elements }
		spawnscriptnow \{jiggle_text_array_elements Params = { Id = yourock_text Time = 1.0 wait_time = 2000 explode = 1 }}
		devil_finish_anim
		wait \{ 0.15 seconds }
		spawnscriptnow \{ waitAndKillHighway }
		wait \{ 2.5 seconds }
		SoundEvent \{ Event = Devil_Die_Transition_SFX }
		wait \{ 0.5 seconds }
		Change \{ current_transition = None }
		PauseGame
	endif
	if ($end_credits = 1 & $current_song = bossdevil)
		Menu_Music_Off
		PlayMovieAndWait \{ movie = 'singleplayer_end' }
		get_movie_id_by_name \{ movie = 'singleplayer_end' }
		SetGlobalTags <Id> Params = { unlocked = 1 }
	endif
	if ($battle_sudden_death = 1)
		StopSoundEvent \{ GH_SFX_BattleMode_Sudden_Death }
		Printf \{ "BATTLE MODE, Song Won, Begin Sudden Death" }
		Change \{ battle_sudden_death = 1 }
		if ($is_network_game)
			ui_flow_manager_respond_to_action \{ action = sudden_death_begin }
			SpawnScriptLater \{load_and_sync_timing Params = { start_delay = 4000 player_status = player1_status }}
		else
			ui_flow_manager_respond_to_action \{ action = select_retry }
			spawnscriptnow \{restart_song Params = { sudden_death = 1 }}
		endif
		if ScreenElementExists \{ Id = yourock_text }
			DestroyScreenElement \{ Id = yourock_text }
		endif
	elseif ($end_credits = 1 & $current_song = rainingblood)
		destroy_menu \{ menu_id = yourock_text }
		destroy_menu \{ menu_id = yourock_text_2 }
		Change \{ end_credits = 0 }
		career_song_ended_select_quit
		start_flow_manager \{ flow_state = career_credits_autosave_fs }
	elseif ($devil_finish = 1)
		start_devil_finish
	else
		destroy_menu \{ menu_id = yourock_text }
		destroy_menu \{ menu_id = yourock_text_2 }
		destroy_menu \{ menu_id = yourock_text_legend }
		ui_flow_manager_respond_to_action \{ action = win_song }
	endif
	if ($is_network_game = 1)
		if IsHost
			agora_write_stats
		endif
	elseif NOT ($boss_battle = 1)
		if NOT ($devil_finish)
			agora_write_stats
		endif
	endif
	if ($is_network_game = 0)
		net_write_single_player_stats
	endif
	if (($game_mode = p1_career)|| ($game_mode = p2_career))
		agora_update
	endif
	if ($is_network_game = 0)
		if NOT ($devil_finish = 1)
			if NOT ($battle_sudden_death = 1)
				if NOT GotParam \{ ENCORE_TRANSITION }
					spawnscriptnow \{ xenon_singleplayer_session_complete_uninit }
				endif
			endif
		endif
	endif
	SoundEvent \{ Event = Crowd_Med_To_Good_SFX }
	if ($is_network_game)
		mark_safe_for_shutdown
	endif
endscript

script Sudden_Death_Helper_Text
	FormatText \{ ChecksumName = text_checksum 'sudden_death_helper' }
	CreateScreenElement {
		Type = TextElement
		Id = <text_checksum>
		PARENT = <parent_id>
		Pos = (640.0, 500.0)
		text = "All powerups are death drain attacks!"
		font = text_A4
		Scale = 0.8
		rgba = [ 255 255 255 255 ]
		just = [ center bottom ]
		z_priority = 500
	}
	FormatText \{ ChecksumName = text_checksum2 'sudden_death_helper2' }
	CreateScreenElement {
		Type = TextElement
		Id = <text_checksum2>
		PARENT = <parent_id>
		Pos = (640.0, 540.0)
		text = "Launch a devastating DEATH DRAIN!"
		font = text_A4
		Scale = 0.8
		rgba = [ 255 255 255 255 ]
		just = [ center bottom ]
		z_priority = 500
	}
	wait \{ 3 seconds }
	DoScreenElementMorph {
		Id = <text_checksum>
		Alpha = 0
		Time = 1
	}
	DoScreenElementMorph {
		Id = <text_checksum2>
		Alpha = 0
		Time = 1
	}
endscript

script Boss_Unlocked_Text
	if ($current_song = bosstom)
		FormatText \{ textname = boss "Tom Morello" }
		Pos = (634.0, 580.0)
	elseif ($current_song = bossslash)
		Pos = (634.0, 580.0)
		FormatText \{ textname = boss "Slash" }
	elseif ($current_song = bossdevil)
		Pos = (800.0, 580.0)
		FormatText \{ textname = boss "Lou" }
	endif
	FormatText \{ textname = unlocked "unlocked" }
	FormatText \{ textname = visit_store "VISIT STORE" }
	FormatText textname = text "%s %b, %v" s = <boss> b = <unlocked> v = <visit_store>
	FormatText \{ ChecksumName = boss_unlocked 'boss_unlocked' }
	if ScreenElementExists Id = <boss_unlocked>
		DestroyScreenElement Id = <boss_unlocked>
	endif
	CreateScreenElement {
		Type = TextElement
		Id = <boss_unlocked>
		PARENT = <parent_id>
		Pos = <Pos>
		text = <text>
		font = text_a11
		Scale = 0.8
		rgba = [ 255 255 255 255 ]
		just = [ center bottom ]
		z_priority = 500
		Shadow
		shadow_offs = (1.0, 1.0)
		shadow_rgba = [ 0 0 0 255 ]
	}
	wait \{ 3 seconds }
	if ScreenElementExists Id = <boss_unlocked>
		DoScreenElementMorph {
			Id = <boss_unlocked>
			Alpha = 0
			Time = 1
		}
	endif
endscript

script start_devil_finish
	Change \{ end_credits = 0 }
	marker_count = 37
	get_song_prefix song = ($current_song)
	FormatText ChecksumName = marker_array '%s_markers' s = <song_prefix>
	starttime = ($<marker_array> [ <marker_count> ].Time)
	startmarker = <marker_count>
	Change \{ CameraCuts_ForceTime = 0 }
	StopRendering
	restart_gem_scroller song_name = ($current_song)difficulty = ($current_difficulty)difficulty2 = ($current_difficulty2)starttime = <starttime> startmarker = <startmarker> no_render = 1 devil_finish_restart = 1
	devil_lose_anim
	wait \{ 20 frames }
	StartRendering
	if ScreenElementExists \{ Id = yourock_text }
		DestroyScreenElement \{ Id = yourock_text }
	endif
	if ScreenElementExists \{ Id = yourock_text_legend }
		DestroyScreenElement \{ Id = yourock_text_legend }
	endif
endscript

script devil_finish_anim
	wait \{ 1 GameFrame }
	BASSIST ::Obj_SwitchScript \{Transition_PlayAnim_Spawned Params = { Anim = GH3_Guit_Satn_A_Lose02 }}
	Change \{ CameraCuts_AllowNoteScripts = FALSE }
	Change \{ CameraCuts_ForceTime = 3.2 }
	CameraCuts_SetArrayPrefix \{ prefix = 'cameras_boss_finish' length = 0 changenow }
	spawnscriptnow \{ devil_camera_flash }
endscript

script devil_camera_flash
	wait \{ 2.7 seconds }
	fadetoblack \{ON Time = 0.03 Alpha = 1.0 z_priority = 1000 texture = White rgba = [ 255 255 255 255 ]}
	wait \{ 0.04 seconds }
	SoundEvent \{ Event = Song_Intro_Kick_SFX }
	SoundEvent \{ Event = Practice_Mode_Crash2 }
	fadetoblack \{ OFF }
endscript

script devil_lose_anim
	Change \{ CameraCuts_AllowNoteScripts = FALSE }
	CameraCuts_SetArrayPrefix \{ prefix = 'cameras_boss_dead' length = 0 changenow }
	BASSIST ::Obj_SwitchScript \{Transition_PlayAnim_Spawned Params = { Cycle = 1 stance = Lose Anim = GH3_Guit_Satn_A_Lose03 }}
endscript

script wait_and_play_you_rock_movie
	begin
		if (isMoviePreLoaded TextureSlot = 1)
			StartPreLoadedMovie \{ TextureSlot = 1 }
			return
		endif
		wait \{ 1 GameFrame }
	repeat
endscript

script waitAndKillHighway
	wait \{ 0.5 seconds }
	SoundEvent \{ Event = Crowd_Fast_Surge_Cheer }
	disable_bg_viewport
endscript

script GuitarEvent_crowd_poor_medium
	Printf \{ "Crowd went from poor to medium" }
endscript

script GuitarEvent_crowd_medium_good
	Printf \{ "Crowd went from medium to good" }
endscript

script GuitarEvent_crowd_medium_poor
	Printf \{ "Crowd went from medium to poor" }
endscript

script GuitarEvent_crowd_good_medium
	Printf \{ "Crowd went from good to medium" }
endscript

script GuitarEvent_StarHitNote
endscript

script GuitarEvent_StarSequenceBonus
	if ($is_attract_mode = 1)
		return
	endif
	Change StructureName = <player_status> sp_phrases_hit = ($<player_status>.sp_phrases_hit + 1)
	SoundEvent \{ Event = Star_Power_Awarded_SFX }
	FormatText ChecksumName = container_id 'gem_container%p' p = ($<player_status>.text)AddToStringLookup = TRUE
	GetArraySize \{ $gem_colors }
	gem_count = 0
	begin
		<note> = ($<song> [ <array_entry> ] [(<gem_count> + 1)])
		if (<note> > 0)
			Color = ($gem_colors [ <gem_count> ])
			if ($<player_status>.lefthanded_button_ups = 1)
				<pos2d> = ($button_up_models.<Color>.left_pos_2d)
				<Angle> = ($button_models.<Color>.Angle)
			else
				<pos2d> = ($button_up_models.<Color>.pos_2d)
				<Angle> = ($button_models.<Color>.left_angle)
			endif
			FormatText ChecksumName = name 'big_bolt%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = TRUE
			CreateScreenElement {
				Type = SpriteElement
				Id = <name>
				PARENT = <container_id>
				Material = sys_Big_Bolt01_sys_Big_Bolt01
				rgba = [ 255 255 255 255 ]
				Pos = <pos2d>
				rot_angle = <Angle>
				Scale = $star_power_bolt_scale
				just = [ center bottom ]
				z_priority = 6
			}
			FormatText ChecksumName = fx_id 'big_bolt_particle%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = TRUE
			Destroy2DParticleSystem Id = <fx_id>
			<particle_pos> = (<pos2d> - (0.0, 0.0))
			Create2DParticleSystem {
				Id = <fx_id>
				Pos = <particle_pos>
				z_priority = 8.0
				Material = sys_Particle_Star01_sys_Particle_Star01
				PARENT = <container_id>
				start_color = [ 0 128 255 255 ]
				end_color = [ 0 128 128 0 ]
				start_scale = (0.550000011920929, 0.550000011920929)
				end_scale = (0.25, 0.25)
				start_angle_spread = 360.0
				min_rotation = -120.0
				max_rotation = 240.0
				emit_start_radius = 0.0
				emit_radius = 2.0
				Emit_Rate = 0.04
				emit_dir = 0.0
				emit_spread = 44.0
				velocity = 24.0
				friction = (0.0, 66.0)
				Time = 2.0
			}
			FormatText ChecksumName = fx2_id 'big_bolt_particle2%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = TRUE
			<particle_pos> = (<pos2d> - (0.0, 0.0))
			Create2DParticleSystem {
				Id = <fx2_id>
				Pos = <particle_pos>
				z_priority = 8.0
				Material = sys_Particle_Star02_sys_Particle_Star02
				PARENT = <container_id>
				start_color = [ 255 255 255 255 ]
				end_color = [ 128 128 128 0 ]
				start_scale = (0.5, 0.5)
				end_scale = (0.25, 0.25)
				start_angle_spread = 360.0
				min_rotation = -120.0
				max_rotation = 508.0
				emit_start_radius = 0.0
				emit_radius = 2.0
				Emit_Rate = 0.04
				emit_dir = 0.0
				emit_spread = 28.0
				velocity = 22.0
				friction = (0.0, 55.0)
				Time = 2.0
			}
			FormatText ChecksumName = fx3_id 'big_bolt_particle3%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = TRUE
			<particle_pos> = (<pos2d> - (0.0, 15.0))
			Create2DParticleSystem {
				Id = <fx3_id>
				Pos = <particle_pos>
				z_priority = 8.0
				Material = sys_Particle_Spark01_sys_Particle_Spark01
				PARENT = <container_id>
				start_color = [ 0 255 255 255 ]
				end_color = [ 0 255 255 0 ]
				start_scale = (1.5, 1.5)
				end_scale = (0.25, 0.25)
				start_angle_spread = 360.0
				min_rotation = -500.0
				max_rotation = 500.0
				emit_start_radius = 0.0
				emit_radius = 2.0
				Emit_Rate = 0.04
				emit_dir = 0.0
				emit_spread = 180.0
				velocity = 12.0
				friction = (0.0, 0.0)
				Time = 1.0
			}
		endif
		gem_count = (<gem_count> + 1)
	repeat <array_Size>
	wait \{ $star_power_bolt_time seconds }
	gem_count = 0
	begin
		<note> = ($<song> [ <array_entry> ] [(<gem_count> + 1)])
		if (<note> > 0)
			FormatText ChecksumName = name 'big_bolt%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = TRUE
			DestroyScreenElement Id = <name>
			FormatText ChecksumName = fx_id 'big_bolt_particle%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = TRUE
			Destroy2DParticleSystem Id = <fx_id> kill_when_empty
			FormatText ChecksumName = fx2_id 'big_bolt_particle2%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = TRUE
			Destroy2DParticleSystem Id = <fx2_id> kill_when_empty
			FormatText ChecksumName = fx3_id 'big_bolt_particle3%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = TRUE
			Destroy2DParticleSystem Id = <fx3_id> kill_when_empty
			wait \{ 1 GameFrame }
		endif
		gem_count = (<gem_count> + 1)
	repeat <array_Size>
endscript

script GuitarEvent_StarMissNote
endscript

script GuitarEvent_Multiplier4xOn
	spawnscriptnow GuitarEvent_Multiplier4xOn_Spawned Params = { <...>	}
endscript

script GuitarEvent_Multiplier4xOn_Spawned
	if ($disable_band = 0)
		ObjID = (<player_status>.band_Member)
		GetPakManCurrent \{ map = Zones }
		if NOT (<pak> = Z_Soundcheck)
			wait \{ 1 GameFrame }
			SafeGetUniqueCompositeObjectID PreferredId = FingerSparks01 ObjID = <ObjID>
			CreateParticleSystem_Fast name = <UniqueId> ObjID = <ObjID> groupID = zoneparticles Bone = Bone_Hand_Middle_Mid_L params_Script = $GP_4X_FingerSparks01
			MangleChecksums a = <UniqueId> b = <ObjID>
			Change StructureName = <player_status> FourX_FingerFXID01 = <mangled_ID>
			wait \{ 1 GameFrame }
			SafeGetUniqueCompositeObjectID PreferredId = FingerFlames01 ObjID = <ObjID>
			CreateParticleSystem_Fast name = <UniqueId> ObjID = <ObjID> groupID = zoneparticles Bone = Bone_Hand_Middle_Mid_L params_Script = $GP_4X_FingerFlames01
			MangleChecksums a = <UniqueId> b = <ObjID>
			Change StructureName = <player_status> FourX_FingerFXID02 = <mangled_ID>
			wait \{ 1 GameFrame }
			SafeGetUniqueCompositeObjectID PreferredId = FingerSparks02 ObjID = <ObjID>
			CreateParticleSystem_Fast name = <UniqueId> ObjID = <ObjID> groupID = zoneparticles Bone = Bone_Hand_Middle_Mid_R params_Script = {$GP_4X_FingerSparks01 Emit_Target = (0.0, -1.0, 0.0)}
			MangleChecksums a = <UniqueId> b = <ObjID>
			Change StructureName = <player_status> FourX_FingerFXID03 = <mangled_ID>
			wait \{ 1 GameFrame }
			SafeGetUniqueCompositeObjectID PreferredId = FingerFlames02 ObjID = <ObjID>
			CreateParticleSystem_Fast name = <UniqueId> ObjID = <ObjID> groupID = zoneparticles Bone = Bone_Hand_Middle_Mid_R params_Script = $GP_4X_FingerFlames01
			MangleChecksums a = <UniqueId> b = <ObjID>
			Change StructureName = <player_status> FourX_FingerFXID04 = <mangled_ID>
		endif
	endif
endscript

script GuitarEvent_Multiplier3xOn
endscript

script GuitarEvent_Multiplier2xOn
endscript

script kill_4x_fx
	killspawnedscript \{ name = GuitarEvent_Multiplier4xOn_Spawned }
	if IsCreated ($<player_status>.FourX_FingerFXID01)
		($<player_status>.FourX_FingerFXID01)::EmitRate RATE = 0
		($<player_status>.FourX_FingerFXID01)::Destroy IfEmpty = 1
	endif
	if IsCreated ($<player_status>.FourX_FingerFXID02)
		($<player_status>.FourX_FingerFXID02)::EmitRate RATE = 0
		($<player_status>.FourX_FingerFXID02)::Destroy IfEmpty = 1
	endif
	if IsCreated ($<player_status>.FourX_FingerFXID03)
		($<player_status>.FourX_FingerFXID03)::EmitRate RATE = 0
		($<player_status>.FourX_FingerFXID03)::Destroy IfEmpty = 1
	endif
	if IsCreated ($<player_status>.FourX_FingerFXID04)
		($<player_status>.FourX_FingerFXID04)::EmitRate RATE = 0
		($<player_status>.FourX_FingerFXID04)::Destroy IfEmpty = 1
	endif
	Change StructureName = <player_status> FourX_FingerFXID01 = JOW_NIL
	Change StructureName = <player_status> FourX_FingerFXID02 = JOW_NIL
	Change StructureName = <player_status> FourX_FingerFXID03 = JOW_NIL
	Change StructureName = <player_status> FourX_FingerFXID04 = JOW_NIL
endscript

script GuitarEvent_Multiplier4xOff
	SoundEvent \{ Event = UI_SFX_Lose_Multiplier_4X }
	SoundEvent \{ Event = Lose_Multiplier_Crowd }
	spawnscriptnow highway_pulse_multiplier_loss Params = {player_text = ($<player_status>.text)multiplier = 4}
	kill_4x_fx <...>
endscript

script GuitarEvent_Multiplier3xOff
	SoundEvent \{ Event = UI_SFX_Lose_Multiplier_3X }
	spawnscriptnow highway_pulse_multiplier_loss Params = {player_text = ($<player_status>.text)multiplier = 3}
endscript

script GuitarEvent_Multiplier2xOff
	SoundEvent \{ Event = UI_SFX_Lose_Multiplier_2X }
	spawnscriptnow highway_pulse_multiplier_loss Params = {player_text = ($<player_status>.text)multiplier = 2}
endscript

script GuitarEvent_KillSong
	GH3_SFX_Stop_Sounds_For_KillSong
	GH_Star_Power_Verb_Off
	FormatText \{ ChecksumName = player_status 'player1_status' }
	kill_4x_fx player_status = <player_status>
	FormatText \{ ChecksumName = player_status 'player2_status' }
	kill_4x_fx player_status = <player_status>
endscript

script GuitarEvent_EnterVenue
	GetPakManCurrentName \{ map = Zones }
	FormatText ChecksumName = echo_params 'Echo_Crowd_Buss_%s' s = <pakname>
	FormatText ChecksumName = reverb_params 'Reverb_Crowd_Buss_%s' s = <pakname>
	if NOT GlobalExists name = <echo_params>
		echo_params = Echo_Crowd_Buss_Default
	endif
	if NOT GlobalExists name = <reverb_params>
		reverb_params = Reverb_Crowd_Buss_Default
	endif
	SetSoundBussEffects effect = $<echo_params>
	SetSoundBussEffects effect = $<reverb_params>
endscript

script GuitarEvent_ExitVenue
	SetSoundBussEffects \{ effect = $Echo_Crowd_Buss }
	SetSoundBussEffects \{ effect = $Reverb_Crowd_Buss }
endscript

script GuitarEvent_CreateFirstGem
	spawnscriptnow first_gem_fx Params = { <...>  }
endscript

script first_gem_fx
	ExtendCRC <gem_id> '_particle' out = fx_id
	if GotParam \{ is_star }
		if ($game_mode = p2_battle || $boss_battle = 1)
			<Pos> = (125.0, 170.0)
		else
			<Pos> = (255.0, 170.0)
		endif
	else
		<Pos> = (66.0, 20.0)
	endif
	Destroy2DParticleSystem Id = <fx_id>
	Create2DParticleSystem {
		Id = <fx_id>
		Pos = <Pos>
		z_priority = 8.0
		Material = sys_Particle_lnzflare02_sys_Particle_lnzflare02
		PARENT = <gem_id>
		start_color = [ 255 255 255 255 ]
		end_color = [ 255 255 255 0 ]
		start_scale = (1.0, 1.0)
		end_scale = (2.0, 2.0)
		start_angle_spread = 360.0
		min_rotation = -500.0
		max_rotation = 500.0
		emit_start_radius = 0.0
		emit_radius = 0.0
		Emit_Rate = 0.3
		emit_dir = 0.0
		emit_spread = 160.0
		velocity = 0.01
		friction = (0.0, 0.0)
		Time = 1.25
	}
	spawnscriptnow destroy_first_gem_fx Params = {gem_id = <gem_id> fx_id = <fx_id>}
	wait \{ 0.8 seconds }
	Destroy2DParticleSystem Id = <fx_id> kill_when_empty
endscript

script destroy_first_gem_fx
	begin
		if NOT ScreenElementExists Id = <gem_id>
			Destroy2DParticleSystem Id = <fx_id>
			break
		endif
		wait \{ 1 GameFrame }
	repeat
endscript

script GuitarEvent_GemStarPowerOn
endscript

script GuitarEvent_BattleAttackFinished
	GH3_Battle_Attack_Finished_SFX <...>
	Reset_Battle_DSP_Effects <...>
endscript

script GuitarEvent_TransitionIntro
endscript

script GuitarEvent_TransitionFastIntro
endscript

script GuitarEvent_TransitionPreEncore
endscript

script GuitarEvent_TransitionEncore
endscript

script GuitarEvent_TransitionPreBoss
endscript

script GuitarEvent_TransitionBoss
endscript
