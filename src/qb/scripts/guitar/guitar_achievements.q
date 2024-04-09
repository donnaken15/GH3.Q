gStar_Power_Triggered = 0
Achievement_Atoms = [
	{
		name = PERFECTIONIST
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_PERFECTIONIST permanent = FALSE }
			{ Type = Scr Scr = Achievements_IsSongWon permanent = FALSE }
		]
	}
	{
		name = WHO_NEEDS_THE_POWER
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_WhoNeedsThePower }
		]
	}
	{
		name = TONE_DEAF
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_TONE_DEAF permanent = FALSE }
			{ Type = Scr Scr = Achievements_IsSongWon permanent = FALSE }
		]
	}
	{
		name = STAR_MANIA
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_STAR_MANIA }
		]
	}
	{
		name = LIFE_OF_THE_PARTY
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_LIFE_OF_THE_PARTY }
		]
	}
	{
		name = SEARCH_AND_DESTROY
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_SEARCH_AND_DESTROY }
		]
	}
	{
		name = BUTTON_MASHER
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_BUTTON_MASHER }
		]
	}
	{
		name = BIG_OL_PILE_OF_WINS
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_BIG_OL_PILE_OF_WINS }
		]
	}
	{
		name = HALF_MILL_CLUB
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_HALF_MILL_CLUB }
		]
	}
	{
		name = MILLIONAIRE_CLUB
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_MILLIONAIRE_CLUB }
		]
	}
	{
		name = HIGHER_THAN_MOST
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_HIGHER_THAN_MOST }
		]
	}
	{
		name = LEADERS_OF_THE_PACK
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_LEADERS_OF_THE_PACK permanent = FALSE }
			{ Type = Scr Scr = Achievements_IsSongWon permanent = FALSE }
		]
	}
	{
		name = ENLIGHTENED_GUITARIST
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_ENLIGHTENED_GUITARIST }
		]
	}
	{
		name = THATS_WHAT_FRIENDS_ARE_FOR
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Achievements_IsGameFinished
				Params = { game_mode = p2_career difficulty = Any }
			}
		]
	}
	{
		name = EASY_RIDER
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Achievements_IsGameFinished
				Params = { game_mode = p1_career difficulty = easy }
			}
		]
	}
	{
		name = MEDIUM_RARE
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Achievements_IsGameFinished
				Params = { game_mode = p1_career difficulty = medium }
			}
		]
	}
	{
		name = ALWAYS_HARD
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Achievements_IsGameFinished
				Params = { game_mode = p1_career difficulty = hard }
			}
		]
	}
	{
		name = RIGHT_HAND_OF_GOD
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Achievements_IsGameFinished
				Params = { game_mode = p1_career difficulty = expert }
			}
		]
	}
	{
		name = SOLO_CAREER
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Achievements_IsGameFinished
				Params = { game_mode = p1_career difficulty = All }
			}
		]
	}
	{
		name = AXE_GRINDER
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = easy mode = p1_career }
				permanent = FALSE
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
				permanent = FALSE
			}
		]
	}
	{
		name = ROCK_GURU
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = medium mode = p1_career }
				permanent = FALSE
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
				permanent = FALSE
			}
		]
	}
	{
		name = SHREDDER
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = hard mode = p1_career }
				permanent = FALSE
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
				permanent = FALSE
			}
		]
	}
	{
		name = GUITAR_HERO
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = expert mode = p1_career }
				permanent = FALSE
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
				permanent = FALSE
			}
		]
	}
	{
		name = EASY_DUO
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = easy mode = p2_career }
				permanent = FALSE
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
				permanent = FALSE
			}
		]
	}
	{
		name = MEDIUM_DUO
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = medium mode = p2_career }
				permanent = FALSE
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
				permanent = FALSE
			}
		]
	}
	{
		name = HARD_DUO
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = hard mode = p2_career }
				permanent = FALSE
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
				permanent = FALSE
			}
		]
	}
	{
		name = LIVING_LEGENDS
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = expert mode = p2_career }
				permanent = FALSE
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
				permanent = FALSE
			}
		]
	}
	{
		name = SMOKIN_ACES
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_SMOKIN_ACES }
		]
	}
	{
		name = FIRST_BIG_SCORE
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_FIRST_BIG_SCORE }
		]
	}
	{
		name = HALF_A_MILL
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_HALF_A_MILL }
		]
	}
	{
		name = FIRST_MILL
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_FIRST_MILL }
		]
	}
	{
		name = GUITAR_WIZARD
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Achievements_CoopBeatenPart
				Params = { part = guitar }
			}
		]
	}
	{
		name = BACK_UP_HERO
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{
				Type = Scr
				Scr = Achievements_CoopBeatenPart
				Params = { part = rhythm }
			}
		]
	}
	{
		name = WELCOME_TO_HELL
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_WELCOME_TO_HELL }
		]
	}
	{
		name = HENDRIX_REBORN
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_HENDRIX_REBORN }
		]
	}
	{
		name = WHAMMY_MANIA
		Type = Scr
		atom_script = Achievements_DummyScript
		atom_params = { achievement }
		depends_on = [
			{ Type = Scr Scr = Achievements_WHAMMY_MANIA permanent = FALSE }
			{ Type = Scr Scr = Achievements_IsSongWon permanent = FALSE }
		]
	}
]
Achievements_SongWonFlag = 0

script Achievements_IsSongWon
	if ($Achievements_SongWonFlag = 1)
		return \{ TRUE }
	endif
	return \{ FALSE }
endscript

script Achievements_DummyScript
endscript

script Achievements_SongWon
	if ($game_mode = p1_career)
		GetGlobalTags \{ achievement_info }
		total_cash_in_career_mode = (<total_cash_in_career_mode> + <additional_cash>)
		total_notes_in_career_mode = (<total_notes_in_career_mode> + $player1_status.notes_hit)
		total_points_in_career_mode = (<total_points_in_career_mode> + $player1_status.score)
		SetGlobalTags achievement_info Params = {total_cash_in_career_mode = <total_cash_in_career_mode>
			total_notes_in_career_mode = <total_notes_in_career_mode>
			total_points_in_career_mode = <total_points_in_career_mode>}
		if ($current_difficulty = easy)
			total_points_in_career_mode_easy = (<total_points_in_career_mode_easy> + $player1_status.score)
			SetGlobalTags achievement_info Params = { total_points_in_career_mode_easy = <total_points_in_career_mode_easy> }
		endif
		if ($current_difficulty = medium)
			total_points_in_career_mode_medium = (<total_points_in_career_mode_medium> + $player1_status.score)
			SetGlobalTags achievement_info Params = { total_points_in_career_mode_medium = <total_points_in_career_mode_medium> }
		endif
		if ($current_difficulty = hard)
			total_points_in_career_mode_hard = (<total_points_in_career_mode_hard> + $player1_status.score)
			SetGlobalTags achievement_info Params = { total_points_in_career_mode_hard = <total_points_in_career_mode_hard> }
		endif
		if ($current_difficulty = expert)
			total_points_in_career_mode_expert = (<total_points_in_career_mode_expert> + $player1_status.score)
			SetGlobalTags achievement_info Params = { total_points_in_career_mode_expert = <total_points_in_career_mode_expert> }
		endif
		Achievements_CheckCareerTotals
	endif
	if ($game_mode = p2_career)
		if ($player1_status.controller = ($primary_controller))
			if ($player1_status.part = rhythm)
				SetGlobalTags ($current_song)Params = { beaten_coop_as_rhythm = 1 }
			else
				SetGlobalTags ($current_song)Params = { beaten_coop_as_lead = 1 }
			endif
		elseif ($player2_status.controller = ($primary_controller))
			if ($player2_status.part = rhythm)
				SetGlobalTags ($current_song)Params = { beaten_coop_as_rhythm = 1 }
			else
				SetGlobalTags ($current_song)Params = { beaten_coop_as_lead = 1 }
			endif
		endif
	endif
	if ($game_mode = p2_coop)
		if ($player1_status.part = rhythm)
			SetGlobalTags ($current_song)Params = { beaten_coop_as_rhythm = 1 }
		else
			SetGlobalTags ($current_song)Params = { beaten_coop_as_lead = 1 }
		endif
	endif
	if ($game_mode = p1_career)
		get_difficulty_text_nl difficulty = ($current_difficulty)
		FormatText ChecksumName = bandname_id 'band%i_info_%g' i = ($current_band)g = 'p1_career'
		FormatText ChecksumName = hendrix_checksum 'hendrix_achievement_%s' s = <difficulty_text_nl>
		GetGlobalTags <bandname_id> param = <hendrix_checksum>
		GetGlobalTags \{ user_options Params = lefty_flip_p1 }
		if ((<...> .<hendrix_checksum>)= 2)
		elseif ((<...> .<hendrix_checksum>)= -1)
			AddParam name = <hendrix_checksum> structure_name = new_params value = <lefty_flip_p1>
			SetGlobalTags <bandname_id> Params = <new_params>
		elseif NOT ((<...> .<hendrix_checksum>)= <lefty_flip_p1>)
			AddParam name = <hendrix_checksum> structure_name = new_params value = 2
			SetGlobalTags <bandname_id> Params = <new_params>
		endif
	endif
	if ($game_mode = p1_career || $game_mode = p1_quickplay)
		if ($current_song = thrufireandflames & $current_difficulty = expert & $boss_battle = 0 & $end_credits = 0)
			WriteAchievements \{ achievement = ONLY_THE_L33T }
		endif
	endif
endscript

script Achievements_PERFECTIONIST
	Printf \{ "Achievements_PERFECTIONIST" }
	if ($is_attract_mode = 0 &
		($game_mode = p1_career ||
		$game_mode = p1_quickplay))
		if ($player1_status.notes_hit = $player1_status.max_notes &
			$player1_status.max_notes > 0)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_WhoNeedsThePower
	Printf \{ "Achievements_WhoNeedsThePower" }
	if ($game_mode = training ||
		$game_mode = practice ||
		$boss_battle = 1)
		return \{ FALSE }
	endif
	if ($is_network_game = 0 &
		($game_mode = p2_pro_faceoff ||
		$game_mode = p2_faceoff ||
		$game_mode = p2_battle))
		return \{ FALSE }
	endif
	if ($game_mode = p2_coop ||
		$game_mode = p2_career)
		return \{ FALSE }
	endif
	Printf \{ "star power trigged  = %d" d = $gStar_Power_Triggered }
	if ($player1_status.score > 199999 &
		$gStar_Power_Triggered = 0 &
		$current_song = cultofpersonality)
		return \{ TRUE }
	endif
	return \{ FALSE }
endscript

script Achievements_TONE_DEAF
	Printf \{ "Achievements_TONE_DEAF" }
	if ($game_mode = p1_quickplay ||
		($game_mode = p1_career & $boss_battle = 0))
		GetGlobalTags \{ user_options }
		if ($current_difficulty = expert)
			if (<guitar_volume> = 0)
				return \{ TRUE }
			endif
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_STAR_MANIA
	Printf \{ "Achievements_STAR_MANIA" }
	if ($game_mode = training ||
		$game_mode = practice ||
		$boss_battle = 1)
		return \{ FALSE }
	endif
	if NOT ($game_mode = p1_quickplay)
		return \{ FALSE }
	endif
	Printf \{ "star power trigged  = %d" d = $gStar_Power_Triggered }
	if ($gStar_Power_Triggered > 2)
		if ($current_song = thrufireandflames & $current_difficulty = expert)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_LIFE_OF_THE_PARTY
	Printf \{ "Achievements_LIFE_OF_THE_PARTY" }
	if ($is_network_game = 1)
		GetGlobalTags \{ achievement_info }
		if (<ranked_consecutive_won_as_host> > 14)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_SEARCH_AND_DESTROY
	Printf \{ "Achievements_SEARCH_AND_DESTROY" }
	if ($is_network_game = 1)
		GetGlobalTags \{ achievement_info }
		if (<ranked_consecutive_won_as_client> > 14)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_BUTTON_MASHER
	Printf \{ "Achievements_BUTTON_MASHER" }
	if ($is_network_game = 1)
		GetGlobalTags \{ achievement_info }
		if (<ranked_matches_won_with_standard_controller> > 14)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_BIG_OL_PILE_OF_WINS
	Printf \{ "Achievements_BIG_OL_PILE_OF_WINS" }
	if ($is_network_game = 1)
		GetGlobalTags \{ achievement_info }
		if (<ranked_matches_won> > 499)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_HALF_MILL_CLUB
	Printf \{ "Achievements_HALF_MILL_CLUB" }
	if ($game_mode = p2_career || $game_mode = p2_coop)
		if (($player1_status.score + $player2_status.score)> 499999)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_MILLIONAIRE_CLUB
	Printf \{ "Achievements_MILLIONAIRE_CLUB" }
	if ($game_mode = p2_career || $game_mode = p2_coop)
		if (($player1_status.score + $player2_status.score)> 999999)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_HIGHER_THAN_MOST
	Printf \{ "Achievements_HIGHER_THAN_MOST" }
	if ($game_mode = p2_career || $game_mode = p2_coop)
		if (($player1_status.score + $player2_status.score)> 699999)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_LEADERS_OF_THE_PACK
	Printf \{ "Achievements_LEADERS_OF_THE_PACK" }
	if ($game_mode = p2_career || $game_mode = p2_coop)
		if ($player1_status.total_notes = $player1_status.notes_hit)
			if NOT ($player1_status.total_notes = 0)
				return \{ TRUE }
			endif
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_ENLIGHTENED_GUITARIST
	array_entry = 0
	get_songlist_size
	num_gold_star_games = 0
	begin
		get_songlist_checksum Index = <array_entry>
		get_difficulty_text_nl \{ difficulty = expert }
		get_song_prefix song = <song_checksum>
		FormatText ChecksumName = songname '%s_%d' s = <song_prefix> d = <difficulty_text_nl>
		GetGlobalTags <songname>
		if (<achievement_gold_star> = 1)
			num_gold_star_games = (<num_gold_star_games> + 1)
		endif
		array_entry = (<array_entry> + 1)
	repeat <array_Size>
	if (<num_gold_star_games> > 19)
		return \{ TRUE }
	endif
	return \{ FALSE }
endscript

script Achievement_AXE_COLLECTOR
	guitar_array = ($Bonus_Guitars)
	GetArraySize <guitar_array>
	Index = 0
	begin
		guitar_id = (<guitar_array> [ <Index> ].Id)
		GetGlobalTags <guitar_id>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	guitar_array = ($Secret_Guitars)
	GetArraySize <guitar_array>
	Index = 0
	begin
		guitar_id = (<guitar_array> [ <Index> ].Id)
		GetGlobalTags <guitar_id>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	guitar_array = ($Bonus_Basses)
	GetArraySize <guitar_array>
	Index = 0
	begin
		guitar_id = (<guitar_array> [ <Index> ].Id)
		GetGlobalTags <guitar_id>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	guitar_array = ($Secret_Basses)
	GetArraySize <guitar_array>
	Index = 0
	begin
		guitar_id = (<guitar_array> [ <Index> ].Id)
		GetGlobalTags <guitar_id>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	guitar_array = ($Bonus_Guitar_Finishes)
	GetArraySize <guitar_array>
	Index = 0
	begin
		guitar_id = (<guitar_array> [ <Index> ].Id)
		GetGlobalTags <guitar_id>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	guitar_array = ($Bonus_Bass_Finishes)
	GetArraySize <guitar_array>
	Index = 0
	begin
		guitar_id = (<guitar_array> [ <Index> ].Id)
		GetGlobalTags <guitar_id>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	return \{ TRUE }
endscript

script Achievement_TRACK_MASTER
	GetArraySize ($Bonus_Songs_Info)
	Index = 0
	begin
		GetGlobalTags ($Bonus_Songs_Info [ <Index> ].item)
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	return \{ TRUE }
endscript

script Achievement_GOT_EM_ALL
	character_array = ($Secret_Characters)
	GetArraySize <character_array>
	Index = 0
	begin
		character_id = (<character_array> [ <Index> ].Id)
		GetGlobalTags <character_id>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	return \{ TRUE }
endscript

script Achievement_BURNING_A_HOLE_IN_YOUR_POCKET
	GetArraySize ($Bonus_videos)
	Index = 0
	begin
		video_checksum = ($Bonus_videos [ <Index> ].Id)
		GetGlobalTags <video_checksum>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	if NOT Achievement_TRACK_MASTER
		return \{ FALSE }
	endif
	if NOT Achievement_AXE_COLLECTOR
		return \{ FALSE }
	endif
	if NOT Achievement_GOT_EM_ALL
		return \{ FALSE }
	endif
	character_array = ($Bonus_Outfits)
	GetArraySize <character_array>
	Index = 0
	begin
		character_id = (<character_array> [ <Index> ].Id)
		GetGlobalTags <character_id>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	character_array = ($Bonus_Styles)
	GetArraySize <character_array>
	Index = 0
	begin
		character_id = (<character_array> [ <Index> ].Id)
		GetGlobalTags <character_id>
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		<Index> = (<Index> + 1)
	repeat <array_Size>
	return \{ TRUE }
endscript

script Achievement_CheckBuyAchievements
	if Achievement_AXE_COLLECTOR
		WriteAchievements \{ achievement = AXE_COLLECTOR }
	endif
	if Achievement_TRACK_MASTER
		WriteAchievements \{ achievement = TRACK_MASTER }
	endif
	if Achievement_GOT_EM_ALL
		WriteAchievements \{ achievement = GOT_EM_ALL }
	endif
	if Achievement_BURNING_A_HOLE_IN_YOUR_POCKET
		WriteAchievements \{ achievement = BURNING_A_HOLE_IN_YOUR_POCKET }
	endif
	if Achievements_WELCOME_TO_HELL
		WriteAchievements \{ achievement = WELCOME_TO_HELL }
	endif
endscript

script Achievements_IsGameFinished
	if NOT GotParam \{ difficulty }
		ScriptAssert \{ "No difficulty" }
	endif
	if NOT GotParam \{ game_mode }
		ScriptAssert \{ "No game mode" }
	endif
	GetArraySize ($difficulty_list)
	array_count = 0
	begin
		get_difficulty_text_nl difficulty = ($difficulty_list [ <array_count> ])
		get_progression_globals game_mode = <game_mode>
		setlist_prefix = ($<tier_global>.prefix)
		FormatText ChecksumName = gametype_checksum '%p_%s' p = <setlist_prefix> s = <difficulty_text_nl>
		GetGlobalTags <gametype_checksum>
		if (<difficulty> = Any)
			if (<complete> = 1)
				return \{ TRUE }
			endif
		endif
		if (<difficulty> = All)
			if (<complete> = 0)
				return \{ FALSE }
			endif
		endif
		if (<difficulty> = ($difficulty_list [ <array_count> ]))
			if (<complete> = 1)
				return \{ TRUE }
			else
				return \{ FALSE }
			endif
		endif
		array_count = (<array_count> + 1)
	repeat <array_Size>
	if (<difficulty> = Any)
		return \{ FALSE }
	else
		return \{ TRUE }
	endif
endscript

script Achievements_SMOKIN_ACES
	Printf \{ "Achievements_SMOKIN_ACES" }
	if ($game_mode = p2_career)
		if ($player1_status.score > 1000000)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_FIRST_BIG_SCORE
	Printf \{ "Achievements_FIRST_BIG_SCORE" }
	if ($game_mode = p1_quickplay || $game_mode = p1_career)
		if ($player1_status.score > 250000)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_HALF_A_MILL
	Printf \{ "Achievements_HALF_A_MILL" }
	if ($game_mode = p1_quickplay || $game_mode = p1_career)
		if ($player1_status.score > 500000)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_FIRST_MILL
	Printf \{ "Achievements_FIRST_MILL" }
	if ($game_mode = p1_quickplay || $game_mode = p1_career)
		if ($player1_status.score > 750000)
			return \{ TRUE }
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_CheckCareerTotals
	GetGlobalTags \{ achievement_info }
	if (<total_cash_in_career_mode> > 350000)
		WriteAchievements \{ achievement = NEVER_GONNA_SPEND_IT_ALL }
	endif
	if (<total_notes_in_career_mode> > 250000)
		WriteAchievements \{ achievement = NOTES_FROM_HELL }
	endif
	if (<total_points_in_career_mode> > 100000000)
		WriteAchievements \{ achievement = BILLION_GULP }
	endif
endscript

script Achievements_CoopBeatenPart
	get_progression_globals \{ game_mode = p2_coop }
	setlist_prefix = ($<tier_global>.prefix)
	Tier = 1
	begin
		FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <Tier>
		FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
		GetArraySize ($<tier_global>.<tier_checksum>.songs)
		array_count = 0
		begin
			GetGlobalTags ($<tier_global>.<tier_checksum>.songs [ <array_count> ])
			if (<part> = rhythm)
				if (<beaten_coop_as_rhythm> = 0)
					return \{ FALSE }
				endif
			else
				if (<beaten_coop_as_lead> = 0)
					return \{ FALSE }
				endif
			endif
			array_count = (<array_count> + 1)
		repeat <array_Size>
		Tier = (<Tier> + 1)
	repeat ($<tier_global>.num_tiers)
	return \{ TRUE }
endscript

script Achievements_WELCOME_TO_HELL
	GetGlobalTags \{ achievement_info param = ranked_matches_played }
	if (<ranked_matches_played> < 100)
		return \{ FALSE }
	endif
	if NOT Achievement_BURNING_A_HOLE_IN_YOUR_POCKET
		return \{ FALSE }
	endif
	if NOT Achievements_IsGameFinished \{ game_mode = p1_career difficulty = All }
		return \{ FALSE }
	endif
	return \{ TRUE }
endscript

script Achievements_HENDRIX_REBORN
	GetGlobalTags \{ achievement_info }
	if (<hendrix_achievement_lefty_off> = 1 &
		<hendrix_achievement_lefty_on> = 1)
		return \{ TRUE }
	endif
	return \{ FALSE }
endscript

script Achievements_WHAMMY_MANIA
	if ($current_song = numberofthebeast)
		if ($game_mode = p1_career || $game_mode = p1_quickplay)
			if ($whammy_mania_achievement_invalidated = 0)
				return \{ TRUE }
			endif
		endif
	endif
	return \{ FALSE }
endscript

script Achievements_SongFailed
	completion = 0
	get_song_end_time song = ($current_song)
	if (<total_end_time> > 0)
		completion = (100 * $failed_song_time / <total_end_time>)
	endif
	casttointeger \{ completion }
	if ($game_mode = p1_career || $game_mode = p1_quickplay)
		if NOT ($boss_battle = 1)
			if (<completion> > 89)
				WriteAchievements \{ achievement = ALMOST_GOT_IT }
			endif
		endif
		get_difficulty_text_nl difficulty = ($current_difficulty)
		get_song_prefix song = ($current_song)
		FormatText ChecksumName = songname '%s_%d' s = <song_prefix> d = <difficulty_text_nl>
		GetGlobalTags <songname> param = failedtimes
		failedtimes = (<failedtimes> + 1)
		SetGlobalTags <songname> Params = { failedtimes = <failedtimes> }
		GetArraySize \{ $difficulty_list }
		array_count = 0
		total_failedtimes = 0
		begin
			get_difficulty_text_nl difficulty = ($difficulty_list [ <array_count> ])
			get_song_prefix song = ($current_song)
			FormatText ChecksumName = songname '%s_%d' s = <song_prefix> d = <difficulty_text_nl>
			GetGlobalTags <songname> param = failedtimes
			total_failedtimes = (<total_failedtimes> + <failedtimes>)
			PrintStruct <...>
			array_count = (<array_count> + 1)
		repeat <array_Size>
		if (<total_failedtimes> > 9)
			WriteAchievements \{ achievement = BLOWIN_IT }
		endif
	endif
	if ($game_mode = p1_career)
		GetGlobalTags \{ achievement_info }
		total_notes_in_career_mode = (<total_notes_in_career_mode> + $player1_status.notes_hit)
		total_points_in_career_mode = (<total_points_in_career_mode> + $player1_status.score)
		SetGlobalTags achievement_info Params = {total_notes_in_career_mode = <total_notes_in_career_mode>
			total_points_in_career_mode = <total_points_in_career_mode>}
		Achievements_CheckCareerTotals
	endif
endscript
