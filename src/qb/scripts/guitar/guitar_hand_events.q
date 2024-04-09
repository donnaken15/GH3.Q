
script Strum_iterator \{ song_name = "test" difficulty = "easy" array_type = "song" part = '' }
	if NOT GotParam \{ Target }
		Printf \{ "Strum_iterator called without target!" }
		return
	endif
	get_song_prefix song = <song_name>
	FormatText ChecksumName = song '%s_song_%pexpert' s = <song_prefix> p = <part> AddToStringLookup
	array_entry = 0
	GetArraySize $<song>
	if (<array_Size> = 0)
		return
	endif
	song_array_size = (<array_Size> / $num_song_columns)
	GetSongTimeMS time_offset = <time_offset>
	if NOT (<song_array_size> = 0)
		begin
			if ((<Time> - <skipleadin>)< ($<song> [ <array_entry> ]))
				break
			endif
			<array_entry> = (<array_entry> + $num_song_columns)
		repeat <song_array_size>
		song_array_size = (<song_array_size> - (<array_entry> / $num_song_columns))
	endif
	begin
		if (<song_array_size> = 0)
			break
		endif
		TimeMarkerReached_SetParams time_offset = <time_offset> array = <song> array_entry = <array_entry>
		begin
			if TimeMarkerReached
				GetSongTimeMS time_offset = <time_offset>
				break
			endif
			wait \{ 1 GameFrame }
		repeat
		TimeMarkerReached_ClearParams
		note_length = ($<song> [(<array_entry> + 1)])
		if (<note_length> > 0)
			LaunchEvent Type = strum_guitar Target = <Target> Data = { note_length = <note_length> }
		endif
		<array_entry> = (<array_entry> + $num_song_columns)
	repeat <song_array_size>
endscript

script FretPos_iterator
	if NOT GotParam \{ Target }
		Printf \{ "FretPos_iterator called without target!" }
		return
	endif
	if ($disable_band = 1)
		return
	endif
	get_song_prefix song = <song_name>
	FormatText ChecksumName = event_array '%s_anim_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> Type = array
		Printf \{ "FRETPOS ANIMS DISABLED: No midi events found for this song" }
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	GetSongTimeMS time_offset = <time_offset>
	if NOT (<array_Size> = 0)
		begin
			if ((<Time> - <skipleadin>)< $<event_array> [ <array_entry> ] [ 0 ])
				break
			endif
			<array_entry> = (<array_entry> + 1)
		repeat <array_Size>
		array_Size = (<array_Size> - <array_entry>)
		if (<array_Size> = 0)
			return
		endif
		begin
			TimeMarkerReached_SetParams time_offset = <time_offset> array = <event_array> array_entry = <array_entry> ArrayOfArrays
			begin
				if TimeMarkerReached
					GetSongTimeMS time_offset = <time_offset>
					break
				endif
				wait \{ 1 GameFrame }
			repeat
			TimeMarkerReached_ClearParams
			note = ($<event_array> [ <array_entry> ] [ 1 ])
			length = ($<event_array> [ <array_entry> ] [ 2 ])
			if CompositeObjectExists name = <Target>
				if (<part> = guitar)
					if ((<note> >= 118)& (<note> <= 127))
						LaunchEvent Type = pose_fret Target = <Target> Data = {note = <note> note_length = <note_length>}
					endif
				else
					if ((<note> >= 101)& (<note> <= 110))
						LaunchEvent Type = pose_fret Target = <Target> Data = {note = <note> note_length = <note_length>}
					endif
				endif
			endif
			<array_entry> = (<array_entry> + 1)
		repeat <array_Size>
	endif
endscript

script FretFingers_iterator \{ part = '' }
	FretFingers_iterator_CFunc_Setup
	begin
		if FretFingers_iterator_CFunc
			break
		endif
		wait \{ 1 GameFrame }
	repeat
	FretFingers_iterator_CFunc_Cleanup
endscript

script WatchForStartPlaying_iterator
	get_song_prefix song = <song_name>
	FormatText ChecksumName = event_array '%s_song_expert' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> Type = array
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	song_array_size = (<array_Size> / $num_song_columns)
	GetSongTimeMS time_offset = <time_offset>
	if NOT (<song_array_size> = 0)
		begin
			if ((<Time> - <skipleadin>)< $<event_array> [ <array_entry> ])
				break
			endif
			<array_entry> = (<array_entry> + $num_song_columns)
		repeat <song_array_size>
		song_array_size = (<song_array_size> - (<array_entry> / $num_song_columns))
		if (<song_array_size> = 0)
			return
		endif
		TimeMarkerReached_SetParams time_offset = <time_offset> array = <event_array> array_entry = <array_entry>
		begin
			if TimeMarkerReached
				GetSongTimeMS time_offset = <time_offset>
				break
			endif
			wait \{ 1 GameFrame }
		repeat
		TimeMarkerReached_ClearParams
		BroadcastEvent \{ Type = start_playing }
	endif
endscript

script Drum_iterator
	Drum_iterator_CFunc_Setup
	begin
		if Drum_iterator_CFunc
			break
		endif
		wait \{ 1 GameFrame }
	repeat
	Drum_iterator_CFunc_Cleanup
endscript

script Drum_cymbal_iterator
	get_song_prefix song = <song_name>
	FormatText ChecksumName = event_array '%s_drums_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> Type = array
		Printf \{ "FRETPOS ANIMS DISABLED: No midi events found for this song" }
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	GetSongTimeMS time_offset = <time_offset>
	if NOT (<array_Size> = 0)
		begin
			if ((<Time> - <skipleadin>)< $<event_array> [ <array_entry> ] [ 0 ])
				break
			endif
			<array_entry> = (<array_entry> + 1)
		repeat <array_Size>
		array_Size = (<array_Size> - <array_entry>)
		if (<array_Size> = 0)
			return
		endif
		begin
			TimeMarkerReached_SetParams time_offset = <time_offset> array = <event_array> array_entry = <array_entry> ArrayOfArrays
			begin
				if TimeMarkerReached
					GetSongTimeMS time_offset = <time_offset>
					break
				endif
				wait \{ 1 GameFrame }
			repeat
			TimeMarkerReached_ClearParams
			if CompositeObjectExists \{ name = Drummer }
				note = ($<event_array> [ <array_entry> ] [ 1 ])
				length = ($<event_array> [ <array_entry> ] [ 2 ])
				if ((<note> >= 37)& (<note> <= 45))
					switch (<note>)
						case 44
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal1 timerId = CymbalTimer1 Anim = ($cymbal_anims [ 0 ])BlendDuration = $drum_blend_time
						case 45
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal2 timerId = CymbalTimer2 Anim = ($cymbal_anims [ 1 ])BlendDuration = $drum_blend_time
						case 43
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal3 timerId = CymbalTimer3 Anim = ($cymbal_anims [ 2 ])BlendDuration = $drum_blend_time
						case 41
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [ 3 ])BlendDuration = $drum_blend_time
						case 42
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [ 3 ])BlendDuration = $drum_blend_time
					endswitch
				elseif ((<note> >= 49)& (<note> <= 57))
					switch (<note>)
						case 56
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal1 timerId = CymbalTimer1 Anim = ($cymbal_anims [ 0 ])BlendDuration = $drum_blend_time
						case 57
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal2 timerId = CymbalTimer2 Anim = ($cymbal_anims [ 1 ])BlendDuration = $drum_blend_time
						case 55
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal3 timerId = CymbalTimer3 Anim = ($cymbal_anims [ 2 ])BlendDuration = $drum_blend_time
						case 53
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [ 3 ])BlendDuration = $drum_blend_time
						case 54
							Drummer ::hero_play_anim Tree = $hero_drumming_branch Target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [ 3 ])BlendDuration = $drum_blend_time
					endswitch
				endif
			endif
			<array_entry> = (<array_entry> + 1)
		repeat <array_Size>
	endif
endscript

script handle_strum_event
	Obj_KillSpawnedScript \{ name = hero_strum_guitar }
	Obj_SpawnScriptNow hero_strum_guitar Params = { note_length = <note_length> }
endscript

script handle_missed_strum_event
	Obj_KillSpawnedScript \{ name = hero_strum_guitar }
	Obj_SpawnScriptNow hero_strum_guitar Params = { note_length = <note_length> }
endscript

script handle_start_playing
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	if (<info_struct>.stance = Intro || <info_struct>.stance = Intro_SmStg)
		handle_change_stance \{ stance = Stance_A }
	endif
endscript

script handle_fret_event
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	FormatText ChecksumName = track 'track_%n' n = <note>
	fret_anims = ($<info_struct>.fret_anims)
	if ((<note> >= 118)& (<note> <= 127))
		Anim = (<fret_anims>.<track>)
	elseif ((<note> >= 101)& (<note> <= 110))
		Anim = (<fret_anims>.<track>)
	else
		return
	endif
	Obj_KillSpawnedScript \{ name = hero_play_fret_anim }
	Obj_SpawnScriptNow hero_play_fret_anim Params = { Anim = <Anim> }
endscript

script handle_finger_event
	Obj_KillSpawnedScript \{ name = hero_play_chord }
	Obj_SpawnScriptNow hero_play_chord Params = { chord = <chord> }
endscript

script handle_missed_note
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	if ($<info_struct>.playing_missed_note = FALSE)
		Change StructureName = <info_struct> playing_missed_note = TRUE
		strum_anims = $Bad_Strums
		anim_length = ($<info_struct>.last_strum_length)
		strum_anim = (<strum_anims>.<anim_length> [ 0 ])
		hero_play_strum_anim Anim = <strum_anim> BlendDuration = 0.1
	endif
endscript

script handle_hit_note
	Obj_GetID
	handle_hit_note_CFunc
endscript

script handle_change_stance \{ Speed = 1.0 }
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	display_debug_info = FALSE
	if (should_display_debug_info)
		display_debug_info = TRUE
	endif
	if GotParam \{ no_wait }
		anim_set = ($<info_struct>.anim_set)
		old_stance = ($<info_struct>.stance)
		if play_stance_transition_cfunc anim_set = <anim_set> old_stance = <old_stance> new_stance = <stance>
			hero_play_anim Anim = <anim_to_run> Speed = <Speed>
			Ragdoll_MarkForReset
			hero_wait_until_anim_finished
		else
			Ragdoll_MarkForReset
		endif
		Change StructureName = <info_struct> stance = <stance>
		Change StructureName = <info_struct> next_stance = <stance>
		if (<display_debug_info> = TRUE)
			Printf channel = AnimInfo "%a stance is immediately changing to %b ...." a = <ObjID> b = <stance>
		endif
		if (<ObjID> = GUITARIST || <ObjID> = BASSIST)
			if (<stance> = Intro || <stance> = Intro_SmStg || <stance> = Stance_FrontEnd || <stance> = Stance_FrontEnd_Guitar)
				Change StructureName = <info_struct> disable_arms = 2
				Change StructureName = <info_struct> next_anim_disable_arms = 2
			else
				Change StructureName = <info_struct> disable_arms = 0
				Change StructureName = <info_struct> next_anim_disable_arms = 0
			endif
			Obj_SwitchScript \{ guitarist_idle }
		else
			Obj_SwitchScript \{ bandmember_idle }
		endif
	else
		if (<display_debug_info> = TRUE)
			Printf channel = AnimInfo "%a is queuing stance change to %b............." a = <ObjID> b = <stance>
		endif
		Change StructureName = <info_struct> next_stance = <stance>
		if (<ObjID> = GUITARIST || <ObjID> = BASSIST)
			if (<stance> = Intro || <stance> = Intro_SmStg || <stance> = Stance_FrontEnd || <stance> = Stance_FrontEnd_Guitar)
				Change StructureName = <info_struct> next_anim_disable_arms = 2
			else
				Change StructureName = <info_struct> next_anim_disable_arms = 0
			endif
		endif
	endif
	return
endscript

script queue_change_stance
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	Change StructureName = <info_struct> next_stance = <stance>
endscript

script handle_play_anim
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	stance = ($<info_struct>.stance)
	display_debug_info = FALSE
	if (should_display_debug_info)
		display_debug_info = TRUE
	endif
	if GotParam \{ no_wait }
		if (<display_debug_info> = TRUE)
			Printf channel = AnimInfo "%a will immediately start the %b anim........" a = <ObjID> b = <Anim>
		endif
		Change StructureName = <info_struct> current_anim = <Anim>
		Change StructureName = <info_struct> next_anim = None
		if GotParam \{ repeat_count }
			Change StructureName = <info_struct> anim_repeat_count = <repeat_count>
		else
			Change StructureName = <info_struct> anim_repeat_count = 1
		endif
		if GotParam \{ Cycle }
			Change StructureName = <info_struct> cycle_anim = TRUE
		else
			Change StructureName = <info_struct> cycle_anim = FALSE
		endif
		if (<name> = GUITARIST || <name> = BASSIST)
			if GotParam \{ Disable_auto_arms }
				Change StructureName = <info_struct> disable_arms = 2
			elseif GotParam \{ disable_auto_strum }
				Change StructureName = <info_struct> disable_arms = 1
			else
				Change StructureName = <info_struct> disable_arms = 0
			endif
		endif
		Ragdoll_MarkForReset
		Obj_KillSpawnedScript \{ name = hero_play_adjusting_random_anims }
		Obj_SpawnScriptNow hero_play_adjusting_random_anims Params = { Anim = <Anim> }
	else
		if (<display_debug_info> = TRUE)
			if (<info_struct>.next_anim != None)
				Printf channel = AnimInfo "******* %a is replacing queued anim %b with %c ******* " a = <ObjID> b = (<info_struct>.next_anim)c = <Anim>
			else
				Printf channel = AnimInfo "%a is queueing the %b anim........" a = <ObjID> b = <Anim>
			endif
		endif
		Change StructureName = <info_struct> next_anim = <Anim>
		if GotParam \{ repeat_count }
			Change StructureName = <info_struct> next_anim_repeat_count = <repeat_count>
		else
			Change StructureName = <info_struct> next_anim_repeat_count = 1
		endif
		if GotParam \{ Cycle }
			Change StructureName = <info_struct> cycle_next_anim = TRUE
		else
			Change StructureName = <info_struct> cycle_next_anim = FALSE
		endif
		if (<name> = GUITARIST || <name> = BASSIST)
			if GotParam \{ Disable_auto_arms }
				Change StructureName = <info_struct> next_anim_disable_arms = 2
			elseif GotParam \{ disable_auto_strum }
				Change StructureName = <info_struct> next_anim_disable_arms = 1
			else
				Change StructureName = <info_struct> next_anim_disable_arms = 0
			endif
		endif
	endif
endscript

script handle_walking
	Obj_GetID
	if (<ObjID> != <name>)
		return
	endif
	ExtendCRC <ObjID> '_Info' out = info_struct
	if ($<info_struct>.allow_movement != TRUE)
		return
	endif
	if NOT ($<info_struct>.stance = Stance_A)
		anim_set = ($<info_struct>.anim_set)
		old_stance = ($<info_struct>.stance)
		if play_stance_transition_cfunc anim_set = <anim_set> old_stance = <old_stance> new_stance = Stance_A
			hero_play_anim Anim = <anim_to_run>
			hero_wait_until_anim_finished
		endif
		Change StructureName = <info_struct> stance = Stance_A
	endif
	Change StructureName = <info_struct> disable_arms = 0
	Obj_SwitchScript guitarist_walking Params = { <...>	 }
endscript

script play_drum_anim \{ arm = Left BlendDuration = $drum_blend_time }
	if NOT GotParam \{ Anim }
		return
	endif
	if (<arm> = Left)
		Obj_KillSpawnedScript \{ name = play_drummer_left_arm_anim }
		Obj_SpawnScriptNow play_drummer_left_arm_anim Params = {Anim = <Anim> BlendDuration = <BlendDuration>}
	else
		Obj_KillSpawnedScript \{ name = play_drummer_right_arm_anim }
		Obj_SpawnScriptNow play_drummer_right_arm_anim Params = { Anim = <Anim> }
	endif
endscript

script play_drummer_left_arm_anim
	hero_play_anim Tree = $hero_drumming_branch timerId = leftarm_timer Target = DrummerLeftArm Anim = <Anim> BlendDuration = <BlendDuration>
	hero_wait_until_anim_finished \{ Timer = leftarm_timer }
	wait \{ $drummer_arm_blend_out_delay seconds }
	hero_play_anim Tree = $hero_drumming_branch timerId = leftarm_timer Target = DrummerLeftArm Anim = ($drummer_anims.stickdown_l)BlendDuration = 0.6
	wait \{ $drummer_clear_arm_twist_value_delay seconds }
	Change \{ StructureName = drummer_info last_left_arm_note = 0 }
endscript

script play_drummer_right_arm_anim
	hero_play_anim Tree = $hero_drumming_branch timerId = rightarm_timer Target = DrummerRightArm Anim = <Anim> BlendDuration = <BlendDuration>
	hero_wait_until_anim_finished \{ Timer = rightarm_timer }
	wait \{ $drummer_arm_blend_out_delay seconds }
	hero_play_anim Tree = $hero_drumming_branch timerId = rightarm_timer Target = DrummerRightArm Anim = ($drummer_anims.stickdown_r)BlendDuration = 0.6
	wait \{ $drummer_clear_arm_twist_value_delay seconds }
	Change \{ StructureName = drummer_info last_right_arm_note = 0 }
endscript
