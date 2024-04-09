progression_beat_game_last_song = 0
progression_unlock_tier_last_song = 0
progression_got_sponsored_last_song = 0
progression_play_completion_movie = 0
progression_completion_tier = 1
progression_unlocked_guitar = -1
progression_unlocked_guitar2 = -1
progression_unlocked_type = guitar
GH3_Career_Songs = {
	prefix = 'career'
	num_tiers = 1
	initial_movie = 'singleplayer_01'
	tier1 = {
		Title = "1. My project"
		songs = [
			tutorial_2a
			tutorial_2b
			tutorial_2c
			tutorial_3a
			rainingblood
		]
		encorep1
		level = load_z_party
		defaultunlocked = 4
		completion_movie = 'singleplayer_02'
		setlist_icon = #"0x3a4a769d"
	}
}
GH3_General_Songs = {
	prefix = 'general'
	num_tiers = 1
	tier1 = {
		Title = "1. My project"
		songs = [
			rainingblood
		]
		//encorep1
		//encorep2
		level = load_z_party
		defaultunlocked = 1
		setlist_icon = #"0x3a4a769d"
	}
}
GH3_GeneralP2_Songs = {
	prefix = 'general'
	num_tiers = 1
	tier1 = {
		Title = "1. My project"
		songs = [
			rainingblood
		]
		//encorep1
		//encorep2
		level = load_z_party
		defaultunlocked = 1
		setlist_icon = #"0x3a4a769d"
	}
}
GH3_GeneralP2_Songs_Coop = {
	prefix = 'general'
	num_tiers = 1
	tier1 = {
		Title = "1. My project"
		songs = [
			rainingblood
		]
		//encorep1
		//encorep2
		level = load_z_party
		defaultunlocked = 1
		setlist_icon = #"0x3a4a769d"
	}
}
GH3_Career_NumSongToProgress = { easy = 3 medium = 3 hard = 4 expert = 4 }
GH3_Career_Progression = [
	{
		name = set_initial_states
		Type = Scr
		atom_script = Progression_Init
		atom_params = {}
	}
	{
		name = career_tier1_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = { Tier = 1 }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = { Tier = 1 numsongstoprogress = $GH3_Career_NumSongToProgress }
			}
		]
	}
	{
		name = career_tier1_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = { Tier = 1 }
		depends_on = [
			{ Type = atom atom = career_tier1_songscomplete }
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [ 0 0 0 0 ]
			}
		]
	}
	{
		name = career_tier1_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = { Tier = 1 }
		depends_on = [
			{ Type = atom atom = career_tier1_encoreunlock }
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = { Tier = 1 }
			}
		]
	}
	{
		name = career_tier1_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = { Tier = 1 finished_game }
		depends_on = [
			{ Type = atom atom = career_tier1_songscomplete }
			{
				Type = atom
				atom = career_tier1_encorecomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = career_tier2_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = { Tier = 2 }
		depends_on = [
			{ Type = atom atom = career_tier1_complete }
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = { Tier = 2 numsongstoprogress = $GH3_Career_NumSongToProgress }
			}
		]
	}
	{
		name = career_tier2_bossunlock
		Type = Scr
		atom_script = Progression_TierBossUnlock
		atom_params = { Tier = 2 }
		depends_on = [
			{ Type = atom atom = career_tier2_songscomplete }
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [ 0 0 0 0 ]
			}
		]
	}
	{
		name = career_tier2_bosscomplete
		Type = Scr
		atom_script = Progression_TierBossComplete
		atom_params = { Tier = 2 }
		depends_on = [
			{ Type = atom atom = career_tier2_bossunlock }
			{
				Type = Scr
				Scr = Progression_CheckBossComplete
				Params = { Tier = 2 }
			}
		]
	}
	{
		name = career_tier2_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = { Tier = 2 }
		depends_on = [
			{ Type = atom atom = career_tier2_songscomplete }
			{
				Type = atom
				atom = career_tier2_bosscomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = career_tier2_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = { Tier = 2 }
		depends_on = [
			{ Type = atom atom = career_tier2_encoreunlock }
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = { Tier = 2 }
			}
		]
	}
	{
		name = career_tier2_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = { Tier = 2 }
		depends_on = [
			{ Type = atom atom = career_tier2_songscomplete }
			{
				Type = atom
				atom = career_tier2_encorecomplete
				required = [ 1 1 1 1 ]
			}
			{
				Type = atom
				atom = career_tier2_bosscomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = career_tier3_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = { Tier = 3 }
		depends_on = [
			{ Type = atom atom = career_tier2_complete }
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = { Tier = 3 numsongstoprogress = $GH3_Career_NumSongToProgress }
			}
		]
	}
	{
		name = career_tier3_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = { Tier = 3 }
		depends_on = [
			{ Type = atom atom = career_tier3_songscomplete }
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [ 0 0 0 0 ]
			}
		]
	}
	{
		name = career_tier3_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = { Tier = 3 }
		depends_on = [
			{ Type = atom atom = career_tier3_encoreunlock }
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = { Tier = 3 }
			}
		]
	}
	{
		name = career_tier3_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = { Tier = 3 }
		depends_on = [
			{ Type = atom atom = career_tier3_songscomplete }
			{
				Type = atom
				atom = career_tier3_encorecomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = career_tier4_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = { Tier = 4 }
		depends_on = [
			{ Type = atom atom = career_tier3_complete }
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = { Tier = 4 numsongstoprogress = $GH3_Career_NumSongToProgress }
			}
		]
	}
	{
		name = career_tier4_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = { Tier = 4 }
		depends_on = [
			{ Type = atom atom = career_tier4_songscomplete }
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [ 0 0 0 0 ]
			}
		]
	}
	{
		name = career_tier4_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = { Tier = 4 }
		depends_on = [
			{ Type = atom atom = career_tier4_encoreunlock }
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = { Tier = 4 }
			}
		]
	}
	{
		name = career_tier4_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = { Tier = 4 }
		depends_on = [
			{ Type = atom atom = career_tier4_songscomplete }
			{
				Type = atom
				atom = career_tier4_encorecomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = career_tier5_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = { Tier = 5 }
		depends_on = [
			{ Type = atom atom = career_tier4_complete }
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = { Tier = 5 numsongstoprogress = $GH3_Career_NumSongToProgress }
			}
		]
	}
	{
		name = career_tier5_bossunlock
		Type = Scr
		atom_script = Progression_TierBossUnlock
		atom_params = { Tier = 5 }
		depends_on = [
			{ Type = atom atom = career_tier5_songscomplete }
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [ 0 0 0 0 ]
			}
		]
	}
	{
		name = career_tier5_bosscomplete
		Type = Scr
		atom_script = Progression_TierBossComplete
		atom_params = { Tier = 5 }
		depends_on = [
			{ Type = atom atom = career_tier5_bossunlock }
			{
				Type = Scr
				Scr = Progression_CheckBossComplete
				Params = { Tier = 5 }
			}
		]
	}
	{
		name = career_tier5_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = { Tier = 5 }
		depends_on = [
			{ Type = atom atom = career_tier5_songscomplete }
			{
				Type = atom
				atom = career_tier5_bosscomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = career_tier5_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = { Tier = 5 }
		depends_on = [
			{ Type = atom atom = career_tier5_encoreunlock }
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = { Tier = 5 }
			}
		]
	}
	{
		name = career_tier5_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = { Tier = 5 }
		depends_on = [
			{ Type = atom atom = career_tier5_songscomplete }
			{
				Type = atom
				atom = career_tier5_encorecomplete
				required = [ 1 1 1 1 ]
			}
			{
				Type = atom
				atom = career_tier5_bosscomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = career_tier6_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = { Tier = 6 }
		depends_on = [
			{ Type = atom atom = career_tier5_complete }
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = { Tier = 6 numsongstoprogress = $GH3_Career_NumSongToProgress }
			}
		]
	}
	{
		name = career_tier6_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = { Tier = 6 }
		depends_on = [
			{ Type = atom atom = career_tier6_songscomplete }
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [ 0 0 0 0 ]
			}
		]
	}
	{
		name = career_tier6_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = { Tier = 6 }
		depends_on = [
			{ Type = atom atom = career_tier6_encoreunlock }
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = { Tier = 6 }
			}
		]
	}
	{
		name = career_tier6_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = { Tier = 6 }
		depends_on = [
			{ Type = atom atom = career_tier6_songscomplete }
			{
				Type = atom
				atom = career_tier6_encorecomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = career_tier7_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = { Tier = 7 }
		depends_on = [
			{ Type = atom atom = career_tier6_complete }
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = { Tier = 7 numsongstoprogress = $GH3_Career_NumSongToProgress }
			}
		]
	}
	{
		name = career_tier7_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = { Tier = 7 }
		depends_on = [
			{ Type = atom atom = career_tier7_songscomplete }
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [ 0 0 0 0 ]
			}
		]
	}
	{
		name = career_tier7_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = { Tier = 7 }
		depends_on = [
			{ Type = atom atom = career_tier7_encoreunlock }
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = { Tier = 7 }
			}
		]
	}
	{
		name = career_tier7_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = { Tier = 7 }
		depends_on = [
			{ Type = atom atom = career_tier7_songscomplete }
			{
				Type = atom
				atom = career_tier7_encorecomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = career_tier8_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = { Tier = 8 }
		depends_on = [
			{ Type = atom atom = career_tier7_complete }
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = { Tier = 8 numsongstoprogress = $GH3_Career_NumSongToProgress }
			}
		]
	}
	{
		name = career_tier8_bossunlock
		Type = Scr
		atom_script = Progression_TierBossUnlock
		atom_params = { Tier = 8 }
		depends_on = [
			{ Type = atom atom = career_tier8_songscomplete }
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [ 0 0 0 0 ]
			}
		]
	}
	{
		name = career_tier8_bosscomplete
		Type = Scr
		atom_script = Progression_TierBossComplete
		atom_params = { Tier = 8 }
		depends_on = [
			{ Type = atom atom = career_tier8_bossunlock }
			{
				Type = Scr
				Scr = Progression_CheckBossComplete
				Params = { Tier = 8 }
			}
		]
	}
	{
		name = career_tier8_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = { Tier = 8 finished_game }
		depends_on = [
			{ Type = atom atom = career_tier8_songscomplete }
			{
				Type = atom
				atom = career_tier8_bosscomplete
				required = [ 1 1 1 1 ]
			}
		]
	}
	{
		name = unlock_guitar1
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = { guitar = 1 for_difficulty }
		depends_on = [
			{ Type = atom atom = career_tier8_complete }
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = easy mode = p1_career }
			}
		]
	}
	{
		name = unlock_guitar2
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = { guitar = 2 for_stars }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = easy mode = p1_career }
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
			}
		]
	}
	{
		name = unlock_guitar3
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = { guitar = 3 for_difficulty }
		depends_on = [
			{ Type = atom atom = career_tier8_complete }
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = medium mode = p1_career }
			}
		]
	}
	{
		name = unlock_guitar4
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = { guitar = 4 for_stars }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = medium mode = p1_career }
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
			}
		]
	}
	{
		name = unlock_guitar5
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = { guitar = 5 for_difficulty }
		depends_on = [
			{ Type = atom atom = career_tier8_complete }
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = hard mode = p1_career }
			}
		]
	}
	{
		name = unlock_guitar6
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = { guitar = 6 for_stars }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = hard mode = p1_career }
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
			}
		]
	}
	{
		name = unlock_guitar7
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = { guitar = 7 for_difficulty }
		depends_on = [
			{ Type = atom atom = career_tier8_complete }
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = expert mode = p1_career }
			}
		]
	}
	{
		name = unlock_guitar8
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = { guitar = 8 for_stars }
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = { diff = expert mode = p1_career }
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {}
			}
		]
	}
	{
		name = end_of_first_update
		Type = Scr
		atom_script = Progression_EndOfFirstUpdate
		atom_params = {}
	}
]
Cash_System_rules = [
	{ diff = easy newstars = 3 oldstars = 0 Cash = 75 }
	{ diff = easy newstars = 4 oldstars = 0 Cash = 175 }
	{ diff = easy newstars = 5 oldstars = 0 Cash = 300 }
	{ diff = easy newstars = 4 oldstars = 3 Cash = 100 }
	{ diff = easy newstars = 5 oldstars = 3 Cash = 225 }
	{ diff = easy newstars = 5 oldstars = 4 Cash = 125 }
	{ diff = medium newstars = 3 oldstars = 0 Cash = 150 }
	{ diff = medium newstars = 4 oldstars = 0 Cash = 350 }
	{ diff = medium newstars = 5 oldstars = 0 Cash = 600 }
	{ diff = medium newstars = 4 oldstars = 3 Cash = 200 }
	{ diff = medium newstars = 5 oldstars = 3 Cash = 450 }
	{ diff = medium newstars = 5 oldstars = 4 Cash = 250 }
	{ diff = hard newstars = 3 oldstars = 0 Cash = 300 }
	{ diff = hard newstars = 4 oldstars = 0 Cash = 700 }
	{ diff = hard newstars = 5 oldstars = 0 Cash = 1200 }
	{ diff = hard newstars = 4 oldstars = 3 Cash = 400 }
	{ diff = hard newstars = 5 oldstars = 3 Cash = 900 }
	{ diff = hard newstars = 5 oldstars = 4 Cash = 500 }
	{ diff = expert newstars = 3 oldstars = 0 Cash = 450 }
	{ diff = expert newstars = 4 oldstars = 0 Cash = 1050 }
	{ diff = expert newstars = 5 oldstars = 0 Cash = 1800 }
	{ diff = expert newstars = 4 oldstars = 3 Cash = 600 }
	{ diff = expert newstars = 5 oldstars = 3 Cash = 1350 }
	{ diff = expert newstars = 5 oldstars = 4 Cash = 750 }
]

script Progression_Init
	Printf \{ "Progression_Init" }
	Tier = 0
	get_progression_globals game_mode = ($game_mode)
	if ($game_mode = p1_career || $game_mode = p2_career)
		FormatText ChecksumName = tiername 'tier%i' i = (<Tier> + 1)
		Change current_level = ($<tier_global>.<tiername>.level)
	endif
	Change \{ setlist_previous_tier = 1 }
	Change \{ setlist_previous_song = 0 }
	Change \{ setlist_previous_tab = tab_setlist }
endscript

script Progression_EndOfFirstUpdate
	Change \{ end_credits = 0 }
	Change \{ progression_beat_game_last_song = 0 }
	Change \{ progression_unlock_tier_last_song = 0 }
	Change \{ progression_got_sponsored_last_song = 0 }
	Change \{ progression_play_completion_movie = 0 }
	Change \{ progression_unlocked_guitar = -1 }
	Change \{ progression_unlocked_guitar2 = -1 }
	Change \{ progression_unlocked_type = guitar }
endscript

script Progression_TierSongsComplete
	Printf \{ "Progression_TierSongsComplete" }
endscript

script Progression_TierEncoreUnlock
	Printf \{ "Progression_TierEncoreUnlock" }
	get_progression_globals game_mode = ($game_mode)
	Progression_GetEncoreSong tier_global = <tier_global> Tier = <Tier>
	SetGlobalTags Progression Params = { encore_song = <song> }
	SetGlobalTags Progression Params = { next_tier = <Tier> }
	SetGlobalTags Progression Params = { next_song_count = <song_count> }
	Change setlist_previous_tier = <Tier>
	Change setlist_previous_song = <song_count>
	Change \{ current_transition = preencore }
	Progression_UnlockSong tier_global = <tier_global> song = <song> ENCORE = 1
	get_progression_globals \{ game_mode = p1_quickplay }
	Progression_UnlockSong tier_global = <tier_global> song = <song>
	get_progression_globals \{ game_mode = p2_battle }
	Progression_UnlockSong tier_global = <tier_global> song = <song>
endscript

script Progression_TierEncoreComplete
	Printf \{ "Progression_TierEncoreComplete" }
	Change \{ progression_got_sponsored_last_song = 1 }
	Change \{ progression_play_completion_movie = 1 }
	Change progression_completion_tier = <Tier>
endscript

script Progression_TierBossUnlock
	Printf \{ "Progression_TierBossUnlock" }
	get_progression_globals game_mode = ($game_mode)
	Progression_GetBossSong tier_global = <tier_global> Tier = <Tier>
	SetGlobalTags Progression Params = { boss_song = <song> }
	SetGlobalTags Progression Params = { next_tier = <Tier> }
	SetGlobalTags Progression Params = { next_song_count = <song_count> }
	Change setlist_previous_tier = <Tier>
	Change setlist_previous_song = <song_count>
	Change \{ current_transition = preboss }
	Progression_UnlockSong tier_global = <tier_global> song = <song> boss = 1
endscript

script Progression_TierBossComplete
	Printf \{ "Progression_TierBossComplete" }
endscript

script Progression_TierComplete
	Printf \{ "Progression_TierComplete" }
	get_progression_globals game_mode = ($game_mode)
	setlist_prefix = ($<tier_global>.prefix)
	FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <Tier>
	SetGlobalTags <tiername> Params = { complete = 1 }
	if GotParam \{ finished_game }
		if ($devil_finish = 0)
			Printf \{ "FINISHED GAME" }
			Change \{ end_credits = 0 }
			if NOT ($progression_beat_game_last_song = 1)
				if ($current_song = bossdevil)
					Change \{ end_credits = 1 }
					FormatText \{ChecksumName = bonus_song_checksum '%p_song%i_tier%s' p = 'bonus' i = 25 s = 1}
					SetGlobalTags <bonus_song_checksum> Params = { unlocked = 1 }
					SetGlobalTags ($GH3_Bonus_Songs.tier1.songs [ 24 ])Params = { unlocked = 1 }
				endif
			endif
			Change \{ progression_beat_game_last_song = 1 }
		endif
		get_difficulty_text_nl difficulty = ($current_difficulty)
		FormatText ChecksumName = gametype_checksum '%p_%s' p = <setlist_prefix> s = <difficulty_text_nl>
		SetGlobalTags <gametype_checksum> Params = { complete = 1 }
		if ($game_mode = p1_career)
			FormatText ChecksumName = bandname_id 'band%i_info_%g' i = ($current_band)g = 'p1_career'
			FormatText ChecksumName = hendrix_checksum 'hendrix_achievement_%s' s = <difficulty_text_nl>
			GetGlobalTags <bandname_id> param = <hendrix_checksum>
			if ((<...> .<hendrix_checksum>)= 0)
				SetGlobalTags \{achievement_info Params = { hendrix_achievement_lefty_off = 1 }}
			elseif ((<...> .<hendrix_checksum>)= 1)
				SetGlobalTags \{achievement_info Params = { hendrix_achievement_lefty_on = 1 }}
			endif
			if ($current_difficulty = hard || $current_difficulty = expert)
				if NOT IsGuitarController controller = ($player1_status.controller)
					WriteAchievements \{ achievement = BUY_A_GUITAR_ALREADY }
				endif
			endif
		endif
	else
		Tier = (<Tier> + 1)
		Progression_UnlockTier Tier = <Tier>
		FormatText ChecksumName = tiername 'tier%i' i = <Tier>
		Progression_UnlockVenue level_checksum = ($<tier_global>.<tiername>.level)
	endif
endscript

script Progression_UnlockVenue
	get_current_band_checksum
	final_checksum = <band_checksum>
	ExtendCRC <final_checksum> ($LevelZones.<level_checksum>.name)out = final_checksum
	SetGlobalTags <final_checksum> Params = { unlocked = 1 }
	FormatText ChecksumName = venue_checksum 'venue_%s' s = ($LevelZones.<level_checksum>.name)
	SetGlobalTags <venue_checksum> Params = { unlocked = 1 }
endscript

script Progression_UnlockTier
	get_progression_globals game_mode = ($game_mode)
	FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
	Change \{ progression_unlock_tier_last_song = 1 }
	Change current_level = ($<tier_global>.<tier_checksum>.level)
	Change setlist_previous_tier = <Tier>
	Change \{ setlist_previous_song = 0 }
	Progression_GetNumTierSong tier_global = <tier_global> Tier = <Tier>
	song_count = 0
	current_tier_global = <tier_global>
	begin
		Progression_GetTierSong tier_global = <current_tier_global> Tier = <Tier> song_count = <song_count>
		Progression_UnlockSong tier_global = <current_tier_global> song = <song>
		get_progression_globals \{ game_mode = p1_quickplay }
		Progression_UnlockSong tier_global = <tier_global> song = <song>
		get_progression_globals \{ game_mode = p2_battle }
		Progression_UnlockSong tier_global = <tier_global> song = <song>
		song_count = (<song_count> + 1)
	repeat <tier_size>
	if GotParam \{ complete }
		get_progression_globals game_mode = ($game_mode)
		setlist_prefix = ($<tier_global>.prefix)
		FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <Tier>
		SetGlobalTags <tiername> Params = { complete = 1 }
	endif
endscript

script Progression_CheckSongComplete
	Printf \{ "Progression_CheckSongComplete" }
	get_progression_globals game_mode = ($game_mode)
	if (<SongList>.tier_num > <tier>)
		ScriptAssert \{ "Tier number exceeds the number of tiers available in the progression global." }
		return \{ FALSE }
	endif
	SongList = <tier_global>
	Progression_GetDifficulty
	songs_required = (<numsongstoprogress>.<difficulty>)
	setlist_prefix = (<SongList>.prefix)
	FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <Tier>
	FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
	if NOT StructureContains structure=<songlist> <tier_checksum>
		ScriptAssert \{ "Tier number is not available in the progression global." }
		return \{ FALSE }
	endif
	GetArraySize (<SongList>.<tier_checksum>.songs)
	array_count = 0
	begin
		FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<array_count> + 1)s = <Tier> AddToStringLookup = TRUE
		GetGlobalTags <song_checksum> param = stars
		if (<stars> > 2)
			songs_required = (<songs_required> - 1)
		endif
		array_count = (<array_count> + 1)
	repeat <array_Size>
	SetGlobalTags <tiername> Params = { num_songs_to_progress = <songs_required> }
	if (<songs_required> > 0)
		return \{ FALSE }
	else
		return \{ TRUE }
	endif
endscript

script Progression_CheckEncoreComplete
	Printf \{ "Progression_CheckEncoreComplete" }
	get_progression_globals game_mode = ($game_mode)
	Progression_GetEncoreSong tier_global = <tier_global> Tier = <Tier>
	GetGlobalTags <song_checksum> param = stars
	if (<stars> > 2)
		return \{ TRUE }
	endif
	return \{ FALSE }
endscript

script Progression_CheckBossComplete
	Printf \{ "Progression_CheckBossComplete" }
	get_progression_globals game_mode = ($game_mode)
	Progression_GetBossSong tier_global = <tier_global> Tier = <Tier>
	GetGlobalTags <song_checksum> param = stars
	if (<stars> > 2)
		return \{ TRUE }
	endif
	return \{ FALSE }
endscript

script Progression_CheckSong5Star
	Printf \{ "Progression_CheckSong5Star" }
	get_progression_globals game_mode = ($game_mode)
	SongList = <tier_global>
	Tier = 1
	begin
		setlist_prefix = (<SongList>.prefix)
		FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <Tier>
		FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
		GetArraySize (<SongList>.<tier_checksum>.songs)
		GetGlobalTags <tiername> param = unlocked
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		array_count = 0
		begin
			FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<array_count> + 1)s = <Tier> AddToStringLookup = TRUE
			GetGlobalTags <song_checksum> param = unlocked
			GetGlobalTags <song_checksum> param = stars
			if NOT Progression_IsBossSong tier_global = <tier_global> Tier = <Tier> song = (<SongList>.<tier_checksum>.songs [ <array_count> ])
				if NOT (<stars> = 5)
					return \{ FALSE }
				endif
			endif
			array_count = (<array_count> + 1)
		repeat <array_Size>
		Tier = (<Tier> + 1)
	repeat (<SongList>.num_tiers)
	return \{ TRUE }
endscript

script Progression_CheckAllSongsCompleted
	Printf \{ "Progression_CheckAllSongsCompleted" }
	get_progression_globals game_mode = ($game_mode)
	SongList = <tier_global>
	Tier = 1
	begin
		setlist_prefix = (<SongList>.prefix)
		FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <Tier>
		FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
		GetArraySize (<SongList>.<tier_checksum>.songs)
		GetGlobalTags <tiername> param = unlocked
		if (<unlocked> = 0)
			return \{ FALSE }
		endif
		array_count = 0
		begin
			FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<array_count> + 1)s = <Tier> AddToStringLookup = TRUE
			GetGlobalTags <song_checksum> param = unlocked
			GetGlobalTags <song_checksum> param = stars
			if NOT (<stars> > 2)
				return \{ FALSE }
			endif
			array_count = (<array_count> + 1)
		repeat <array_Size>
		Tier = (<Tier> + 1)
	repeat (<SongList>.num_tiers)
	return \{ TRUE }
endscript

script Progression_AlwaysBlock
	Printf \{ "Progression_AlwaysBlock" }
	return \{ FALSE }
endscript

script Progression_CheckDiff
	Printf \{ "Progression_CheckDiff" }
	Progression_GetDifficulty
	if NOT (<diff> = <difficulty>)
		return \{ FALSE }
	endif
	if GotParam \{ mode }
		if NOT ($game_mode = <mode>)
			return \{ FALSE }
		endif
	endif
	return \{ TRUE }
endscript

script Progression_UnlockGuitar
	Printf \{ "Progression_UnlockGuitar" }
	if GotParam \{ guitar }
		SetGlobalTags ($Secret_Guitars [(<guitar> - 1)].Id)Params = { unlocked_for_purchase = 1 }
		if ($progression_unlocked_guitar = -1)
			Change progression_unlocked_guitar = ($Secret_Guitars [(<guitar> - 1)].Id)
		else
			Change progression_unlocked_guitar2 = ($Secret_Guitars [(<guitar> - 1)].Id)
		endif
		Change \{ progression_unlocked_type = guitar }
	else
		SetGlobalTags ($Secret_Basses [(<bass> - 1)].Id)Params = { unlocked_for_purchase = 1 }
		if ($progression_unlocked_guitar = -1)
			Change progression_unlocked_guitar = ($Secret_Basses [(<bass> - 1)].Id)
		else
			Change progression_unlocked_guitar2 = ($Secret_Basses [(<bass> - 1)].Id)
		endif
		Change \{ progression_unlocked_type = bass }
	endif
endscript

script Progression_SongFailed
	Printf \{ "Progression_SongFailed" }
	if ($coop_dlc_active = 1)
		return
	endif
	if ($game_mode = p1_career ||
		$game_mode = p2_career)
		UpdateAtoms \{ name = Progression }
	endif
	Change \{ Achievements_SongWonFlag = 0 }
	UpdateAtoms \{ name = achievement }
endscript

script Progression_SongWon
	Printf \{ "Progression_SongWon" }
	additional_cash = 0
	Change \{ progression_beat_game_last_song = 0 }
	Change \{ progression_unlock_tier_last_song = 0 }
	Change \{ progression_got_sponsored_last_song = 0 }
	Change \{ progression_play_completion_movie = 0 }
	Player = 1
	begin
		FormatText ChecksumName = player_status 'player%i_status' i = <Player>
		new_stars = 3
		if ($<player_status>.score >= $<player_status>.base_score * 2.8)
			new_stars = 5
		elseif ($<player_status>.score >= $<player_status>.base_score * 2)
			new_stars = 4
		endif
		Change StructureName = <player_status> stars = <new_stars>
		Player = (<Player> + 1)
	repeat $current_num_players
	if ($coop_dlc_active = 1)
		if ($player1_status.total_notes = $player1_status.notes_hit)
			if NOT ($player1_status.total_notes = 0)
				WriteAchievements \{ achievement = LEADERS_OF_THE_PACK }
			endif
		endif
		return
	endif
	get_difficulty_text_nl difficulty = ($current_difficulty)
	get_song_prefix song = ($current_song)
	FormatText ChecksumName = songname '%s_%d' s = <song_prefix> d = <difficulty_text_nl>
	if ($player1_status.total_notes > 0)
		p1_percent_complete = (100 * $player1_status.notes_hit / $player1_status.total_notes)
		if (<p1_percent_complete> = 100)
			if ($game_mode = p1_quickplay)
				SetGlobalTags <songname> Params = { percent100 = 1 }
			endif
			if ($game_mode = p1_quickplay ||
				$game_mode = p1_career)
				SetGlobalTags <songname> Params = { achievement_gold_star = 1 }
			endif
		endif
	endif
	if ($game_mode = p1_career ||
		$game_mode = p2_career)
		get_progression_globals game_mode = ($game_mode)use_current_tab = 1
		SongList = <tier_global>
		get_band_game_mode_name
		FormatText ChecksumName = bandname_id 'band%i_info_%g' i = ($current_band)g = <game_mode_name>
		SetGlobalTags <bandname_id> Params = { first_play = 0 }
		GetGlobalTags \{ Progression Params = current_tier }
		GetGlobalTags \{ Progression Params = current_song_count }
		song_count = <current_song_count>
		if GotParam \{ current_tier }
			setlist_prefix = ($<SongList>.prefix)
			FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1)s = <current_tier> AddToStringLookup = TRUE
			FormatText ChecksumName = tier_checksum 'tier%s' s = <current_tier>
			if Progression_IsBossSong tier_global = <tier_global> Tier = <current_tier> song = (<tier_global>.<tier_checksum>.songs [ <song_count> ])
				Change \{ StructureName = player1_status stars = 5 }
			endif
			GetGlobalTags <song_checksum> param = stars
			GetGlobalTags <song_checksum> param = score
			if ($game_mode = p1_career)
				new_score = ($player1_status.score)
				new_stars = ($player1_status.stars)
			else
				new_score = ($player1_status.score + $player2_status.score)
				new_stars = (($player1_status.stars + $player1_status.stars)/ 2)
			endif
			if ($player1_status.total_notes > 0)
				p1_percent_complete = (100 * $player1_status.notes_hit / $player1_status.total_notes)
				if (<p1_percent_complete> = 100)
					SetGlobalTags <song_checksum> Params = { percent100 = 1 }
				endif
			endif
			if (<new_stars> > <stars>)
				SetGlobalTags <song_checksum> Params = { stars = <new_stars> }
				if ($current_tab = tab_setlist)
					if NOT StructureContains Structure = (<tier_global>.<tier_checksum>)nocash
						Progression_AwardCash old_stars = <stars> new_stars = <new_stars>
					endif
				endif
			endif
			if (<new_score> > <score>)
				casttointeger \{ new_score }
				SetGlobalTags <song_checksum> Params = { score = <new_score> }
			endif
			Progression_CalcSetlistNextSong tier_global = <tier_global>
		endif
	endif
	Achievements_SongWon additional_cash = <additional_cash>
	if ($game_mode = p1_career || $game_mode = p2_career)
		UpdateAtoms \{ name = Progression }
	endif
	Change \{ Achievements_SongWonFlag = 1 }
	UpdateAtoms \{ name = achievement }
endscript
end_credits = 0
boss_devil_score = 0

script Progression_EndCredits
	Printf \{ "CREDITS BEGIN" }
	Change boss_devil_score = ($player1_status.score)
	Change \{ current_level = load_z_credits }
	ui_flow_manager_respond_to_action \{ action = select_retry }
	Change \{ current_song = rainingblood }
	create_loading_screen
	Load_Venue
	restart_gem_scroller song_name = ($current_song)difficulty = ($current_difficulty)difficulty2 = ($current_difficulty2)starttime = 0 end_credits_restart = 1
	destroy_loading_screen
	start_flow_manager \{ flow_state = career_play_song_fs }
	spawnscriptnow \{ scrolling_list_begin }
endscript

script Progression_EndCredits_Done
	if ($end_credits = 1)
		Change StructureName = player1_status score = ($boss_devil_score)
		Change \{ boss_devil_score = 0 }
	endif
	destroy_credits_menu
endscript

script PlayMovie_EndCredits
	KillMovie \{ TextureSlot = 1 }
	PreLoadMovie \{movie = 'Fret_Flames' TextureSlot = 1 TexturePri = -2 no_loop no_hold}
	begin
		if (isMoviePreLoaded TextureSlot = 1)
			StartPreLoadedMovie \{ TextureSlot = 1 }
			return
		endif
		wait \{ 1 GameFrame }
	repeat
endscript

script Progression_CalcSetlistNextSong
	if ($current_tab = tab_setlist)
		setlist_prefix = ($<tier_global>.prefix)
		num_tiers = ($<tier_global>.num_tiers)
		Tier = 1
		begin
			FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <Tier>
			GetGlobalTags <tiername> param = unlocked
			if (<unlocked> = 0)
				Tier = (<Tier> - 1)
				break
			endif
			Tier = (<Tier> + 1)
		repeat <num_tiers>
		if (<Tier> > <num_tiers>)
			Tier = <num_tiers>
		endif
		found = 0
		Progression_GetBossSong tier_global = <tier_global> Tier = <Tier>
		if (<song_count> = -1 & found = 0)
			FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1)s = <Tier> AddToStringLookup = TRUE
			GetGlobalTags <song_checksum> param = unlocked
			if (<unlocked> = 1)
				found = 1
			endif
		endif
		Progression_GetEncoreSong tier_global = <tier_global> Tier = <Tier>
		if (<song_count> = -1 & found = 0)
			FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1)s = <Tier> AddToStringLookup = TRUE
			GetGlobalTags <song_checksum> param = unlocked
			if (<unlocked> = 1)
				found = 1
			endif
		endif
		if (<found> = 0)
			FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
			GetArraySize (<tier_global>.<tier_checksum>.songs)
			song_count = 0
			begin
				FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1)s = <Tier> AddToStringLookup = TRUE
				GetGlobalTags <song_checksum> param = stars
				GetGlobalTags <song_checksum> param = unlocked
				if (<stars> < 3 & <unlocked> = 1)
					found = 1
					break
				endif
				song_count = (<song_count> + 1)
			repeat <array_Size>
		endif
		if (<found> = 1)
			Change setlist_previous_tier = <Tier>
			Change setlist_previous_song = <song_count>
		endif
	endif
endscript

script Progression_AwardCash
	Printf \{ "Progression_AwardCash" }
	Cash = -1
	GetArraySize \{ $Cash_System_rules }
	array_count = 0
	begin
		Progression_GetDifficulty
		if (<difficulty> = $Cash_System_rules [ <array_count> ].diff)
			if (<new_stars> = $Cash_System_rules [ <array_count> ].newstars)
				if (<old_stars> = $Cash_System_rules [ <array_count> ].oldstars)
					Cash = ($Cash_System_rules [ <array_count> ].Cash)
				endif
			endif
		endif
		array_count = (<array_count> + 1)
	repeat <array_Size>
	if (<new_stars> = <old_stars>)
		Cash = 0
	endif
	if (<Cash> = -1)
		PrintStruct <...>
		ScriptAssert \{ "Cash Rules not found" }
	endif
	Change StructureName = player1_status new_cash = (<Cash> + $player1_status.new_cash)
	additional_cash = <Cash>
	get_current_band_info
	GetGlobalTags <band_info>
	<Cash> = (<Cash> + <additional_cash>)
	SetGlobalTags <band_info> Params = { Cash = <Cash> }
	Printf "cash = %d" d = <Cash>
	return additional_cash = <additional_cash>
endscript

script Progression_CountCompletedSongsInCurrentTier
	completed_songs = 0
	get_progression_globals game_mode = ($game_mode)
	if NOT (<tier_global> = 0 || $setlist_selection_tier = 0)
		Progression_GetNumTierSong tier_global = <tier_global> Tier = ($setlist_selection_tier)All
		song_count = 0
		begin
			Progression_GetTierSong tier_global = <tier_global> Tier = ($setlist_selection_tier)song_count = <song_count>
			GetGlobalTags <song_checksum> param = stars
			if NOT (<stars> = 0)
				completed_songs = (<completed_songs> + 1)
			endif
			song_count = (<song_count> + 1)
		repeat <tier_size>
	endif
	return { completed_songs = <completed_songs> }
endscript

script Progression_GetNumTierSong
	FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
	GetArraySize ($<tier_global>.<tier_checksum>.songs)
	if GotParam \{ All }
		return tier_size = <array_Size>
	endif
	if StructureContains Structure = ($<tier_global>.<tier_checksum>)encorep1
		array_Size = (<array_Size> - 1)
	endif
	if StructureContains Structure = ($<tier_global>.<tier_checksum>)encorep2
		array_Size = (<array_Size> - 1)
	endif
	if StructureContains Structure = ($<tier_global>.<tier_checksum>)boss
		array_Size = (<array_Size> - 1)
	endif
	return tier_size = <array_Size>
endscript

script Progression_GetTierSong
	setlist_prefix = ($<tier_global>.prefix)
	FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
	FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1)s = <Tier>
	song = ($<tier_global>.<tier_checksum>.songs [ <song_count> ])
	return song = <song> song_checksum = <song_checksum>
endscript

script Progression_GetBossSong
	setlist_prefix = ($<tier_global>.prefix)
	FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
	if NOT StructureContains Structure = ($<tier_global>.<tier_checksum>)boss
		return \{ song_count = -1 song = None song_checksum = None }
	endif
	GetArraySize ($<tier_global>.<tier_checksum>.songs)
	array_count = (<array_Size> - 1)
	if StructureContains Structure = ($<tier_global>.<tier_checksum>)encorep1
		array_count = (<array_count> - 1)
	endif
	FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<array_count> + 1)s = <Tier>
	song = ($<tier_global>.<tier_checksum>.songs [ <array_count> ])
	return song_count = <array_count> song = <song> song_checksum = <song_checksum>
endscript

script Progression_GetEncoreSong \{ Type = Any }
	setlist_prefix = ($<tier_global>.prefix)
	FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
	if (<Type> = Any)
		if NOT StructureContains Structure = ($<tier_global>.<tier_checksum>)encorep1
			if NOT StructureContains Structure = ($<tier_global>.<tier_checksum>)encorep2
				return \{ song_count = -1 song = None song_checksum = None }
			endif
		endif
	endif
	if (<Type> = p1)
		if NOT StructureContains Structure = ($<tier_global>.<tier_checksum>)encorep1
			return \{ song_count = -1 song = None song_checksum = None }
		endif
	endif
	if (<Type> = p2)
		if NOT StructureContains Structure = ($<tier_global>.<tier_checksum>)encorep2
			return \{ song_count = -1 song = None song_checksum = None }
		endif
	endif
	GetArraySize ($<tier_global>.<tier_checksum>.songs)
	array_count = (<array_Size> - 1)
	if (<Type> = p1)
		if StructureContains Structure = ($<tier_global>.<tier_checksum>)encorep2
			array_count = (<array_count> - 1)
		endif
	endif
	FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<array_count> + 1)s = <Tier>
	song = ($<tier_global>.<tier_checksum>.songs [ <array_count> ])
	return song_count = <array_count> song = <song> song_checksum = <song_checksum>
endscript

script Progression_IsBossSong
	if NOT GotParam \{ Tier }
		return \{ FALSE }
	endif
	query_song = <song>
	Progression_GetBossSong <...>
	if (<song> = <query_song>)
		return \{ TRUE }
	endif
	return \{ FALSE }
endscript

script Progression_IsEncoreSong
	query_song = <song>
	Progression_GetEncoreSong <...> Type = p1
	PrintStruct <...>
	if (<song> = <query_song>)
		return \{ TRUE }
	endif
	Progression_GetEncoreSong <...> Type = p2
	PrintStruct <...>
	if (<song> = <query_song>)
		return \{ TRUE }
	endif
	return \{ FALSE }
endscript

script Progression_UnlockSong \{ ENCORE = 0 boss = 0 unlocked = 0 }
	setlist_prefix = ($<tier_global>.prefix)
	Tier = 1
	begin
		FormatText ChecksumName = tiername '%ptier%i' p = <setlist_prefix> i = <Tier>
		FormatText ChecksumName = tier_checksum 'tier%s' s = <Tier>
		GetArraySize ($<tier_global>.<tier_checksum>.songs)
		array_count = 0
		begin
			if ($<tier_global>.<tier_checksum>.songs [ <array_count> ] = <song>)
				FormatText ChecksumName = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<array_count> + 1)s = <Tier>
				SetGlobalTags <song_checksum> Params = { unlocked = 1 }
				if (<ENCORE> = 1)
					SetGlobalTags <tiername> Params = { encore_unlocked = 1 }
				elseif (<boss> = 1)
					SetGlobalTags <tiername> Params = { boss_unlocked = 1 }
				endif
				SetGlobalTags <tiername> Params = { unlocked = 1 }
			endif
			array_count = (<array_count> + 1)
		repeat <array_Size>
		Tier = (<Tier> + 1)
	repeat ($<tier_global>.num_tiers)
endscript

script Progression_GetDifficulty
	difficulty = ($current_difficulty)
	if ($game_mode = p2_career)
		get_minimum_difficulty difficulty1 = ($current_difficulty)difficulty2 = ($current_difficulty2)
		difficulty = <minimum_difficulty>
	endif
	return difficulty = <difficulty>
endscript

script Progression_SetProgressionNodeFlags
	if ($coop_dlc_active = 1)
		Change \{ game_mode = p2_career }
	endif
	ChangeNodeFlag \{ LS_ALWAYS 1 }
	ls_encore = 0
	ls_3_5 = 0
	get_progression_globals game_mode = ($game_mode)
	Tier = ($setlist_selection_tier)
	if ($coop_dlc_active = 0)
		if ($game_mode = p1_career ||
			$game_mode = p2_career)
			if Progression_IsEncoreSong tier_global = <tier_global> Tier = <Tier> song = ($current_song)
				ls_encore = 1
			endif
			Progression_GetDifficulty
			Progression_CountCompletedSongsInCurrentTier
			if (<difficulty> = easy || <difficulty> = medium)
				if (<completed_songs> >= 2)
					ls_3_5 = 1
				endif
			else
				if (<completed_songs> >= 3)
					ls_3_5 = 1
				endif
			endif
		endif
	endif
	Printf "Progression_SetProgressionNodeFlags encore = %d 3_5 = %i" d = <ls_encore> i = <ls_3_5>
	if (<ls_encore> = 1)
		ChangeNodeFlag \{ LS_3_5_PRE 0 }
		ChangeNodeFlag \{ LS_3_5_POST 1 }
		ChangeNodeFlag \{ LS_ENCORE_PRE 0 }
		ChangeNodeFlag \{ LS_ENCORE_POST 1 }
	elseif (<ls_3_5> = 1)
		ChangeNodeFlag \{ LS_3_5_PRE 0 }
		ChangeNodeFlag \{ LS_3_5_POST 1 }
		ChangeNodeFlag \{ LS_ENCORE_PRE 1 }
		ChangeNodeFlag \{ LS_ENCORE_POST 0 }
	else
		ChangeNodeFlag \{ LS_3_5_PRE 1 }
		ChangeNodeFlag \{ LS_3_5_POST 0 }
		ChangeNodeFlag \{ LS_ENCORE_PRE 1 }
		ChangeNodeFlag \{ LS_ENCORE_POST 0 }
	endif
endscript
P1_career_progression = { tier_global = GH3_Career_Songs progression_global = GH3_Career_Progression }
P2_career_progression = { tier_global = GH3_CoopCareer_Songs progression_global = GH3_CoopCareer_Progression }
Bonus_progression = { tier_global = GH3_Bonus_Songs progression_global = None }
Download_progression = { tier_global = GH3_Download_Songs progression_global = None }
General_progression = { tier_global = GH3_General_Songs progression_global = None }
GeneralP2_progression = { tier_global = GH3_GeneralP2_Songs progression_global = None }
P2_coop_progression = { tier_global = GH3_GeneralP2_Songs_Coop progression_global = None }
Demo_progression_Career = { tier_global = GH3_Demo_Songs_Career progression_global = None }
Demo_progression_Coop = { tier_global = GH3_Demo_Songs_Coop progression_global = None }
Demo_progression_Multiplayer = { tier_global = GH3_Demo_Songs_Multiplayer progression_global = None }
Demo_progression_Quickplay = { tier_global = GH3_Demo_Songs_Quickplay progression_global = None }

script get_progression_globals game_mode = <game_mode> use_current_tab = 0
	if (<use_current_tab> = 1)
		if ($current_tab = tab_bonus)
			Bonus = 1
		elseif ($current_tab = tab_downloads)
			Download = 1
		endif
	endif
	if ($is_demo_mode = 1)
		if GotParam \{ Bonus }
			AddParams ($Bonus_progression)
		elseif GotParam \{ Download }
			AddParams ($Download_progression)
		elseif (<game_mode> = p1_career)
			AddParams ($Demo_progression_Career)
		elseif (<game_mode> = p2_career)
			AddParams ($Demo_progression_Coop)
		elseif (<game_mode> = p1_quickplay)
			AddParams ($Demo_progression_Quickplay)
		else
			AddParams ($Demo_progression_Multiplayer)
		endif
		return tier_global = <tier_global> progression_global = <progression_global>
	endif
	if GotParam \{ Bonus }
		AddParams ($Bonus_progression)
	elseif GotParam \{ Download }
		AddParams ($Download_progression)
	elseif (<game_mode> = p1_career)
		AddParams ($P1_career_progression)
	elseif (<game_mode> = p2_career)
		AddParams ($P2_career_progression)
	elseif (<game_mode> = p1_quickplay)
		AddParams ($General_progression)
	elseif (<game_mode> = p2_coop)
		AddParams ($P2_coop_progression)
	else
		AddParams ($GeneralP2_progression)
	endif
	return tier_global = <tier_global> progression_global = <progression_global>
endscript




; stock setlists

/**
GH3_Career_Songs = {
	prefix = 'career'
	num_tiers = 8
	initial_movie = 'singleplayer_01'
	tier1 = {
		Title = "1. Starting out small"
		songs = [
			slowride
			TalkDirtyToMe
			hitmewithyourbestshot
			storyofmylife
			rocknrollallnite
		]
		encorep1
		level = load_z_party
		defaultunlocked = 4
		completion_movie = 'singleplayer_02'
		setlist_icon = #"0x3a4a769d"
	}
	tier2 = {
		Title = "2. Your first real gig"
		songs = [
			mississippiqueen
			schoolsout
			sunshineofyourlove
			barracuda
			bosstom
			bullsonparade
		]
		encorep1
		boss
		level = load_z_dive
		completion_movie = 'singleplayer_03'
		setlist_icon = #"0xc3210dfb"
	}
	tier3 = {
		Title = "3. Making the video"
		songs = [
			whenyouwereyoung
			missmurder
			theseeker
			laydown
			paintitblack
		]
		encorep1
		level = load_z_video
		completion_movie = 'singleplayer_04'
		setlist_icon = #"0xfbbd54e9"
	}
	tier4 = {
		Title = "4. European Invasion"
		songs = [
			paranoid
			anarchyintheuk
			koolthing
			mynameisjonas
			evenflow
		]
		encorep1
		level = load_z_artdeco
		completion_movie = 'singleplayer_05'
		setlist_icon = #"0x17b13dab"
	}
	tier5 = {
		Title = "5. Bighouse blues"
		songs = [
			holidayincambodia
			rockulikeahurricane
			sameoldsonganddance
			lagrange
			bossslash
			welcometothejungle
		]
		encorep1
		boss
		level = load_z_prison
		completion_movie = 'singleplayer_06'
		setlist_icon = #"0xb0c88183"
	}
	tier6 = {
		Title = "6. The Hottest band on Earth"
		songs = [
			blackmagicwoman
			cherubrock
			blacksunshine
			themetal
			pridenjoy
		]
		encorep1
		level = load_z_wikker
		completion_movie = 'singleplayer_07'
		setlist_icon = #"0xdf4e77c3"
	}
	tier7 = {
		Title = "7. Live in Japan"
		songs = [
			beforeiforget
			stricken
			threesandsevens
			knightsofcydonia
			cultofpersonality
		]
		encorep1
		level = load_z_budokan
		completion_movie = 'singleplayer_08'
		setlist_icon = #"0xd4b486d5"
	}
	tier8 = {
		Title = "8. Battle for your soul"
		songs = [
			rainingblood
			cliffsofdover
			numberofthebeast
			one
			bossdevil
		]
		boss
		level = load_z_hell
		completion_movie = 'singleplayer_end'
		setlist_icon = #"0xd25d508d"
	}
}
GH3_General_Songs = {
	prefix = 'general'
	num_tiers = 8
	tier1 = {
		Title = "1. Starting out small"
		songs = [
			slowride
			TalkDirtyToMe
			hitmewithyourbestshot
			storyofmylife
			rocknrollallnite
			sabotage
		]
		encorep1
		encorep2
		level = load_z_party
		defaultunlocked = 4
		setlist_icon = #"0x3a4a769d"
	}
	tier2 = {
		Title = "2. Your first real gig"
		songs = [
			mississippiqueen
			schoolsout
			sunshineofyourlove
			barracuda
			bullsonparade
			reptilia
		]
		encorep1
		encorep2
		level = load_z_dive
		defaultunlocked = 4
		setlist_icon = #"0xc3210dfb"
	}
	tier3 = {
		Title = "3. Making the video"
		songs = [
			whenyouwereyoung
			missmurder
			theseeker
			laydown
			paintitblack
			suckmykiss
		]
		encorep1
		encorep2
		level = load_z_video
		setlist_icon = #"0xfbbd54e9"
	}
	tier4 = {
		Title = "4. European Invasion"
		songs = [
			paranoid
			anarchyintheuk
			koolthing
			mynameisjonas
			evenflow
			citiesonflame
		]
		encorep1
		encorep2
		level = load_z_artdeco
		setlist_icon = #"0x17b13dab"
	}
	tier5 = {
		Title = "5. Bighouse Blues"
		songs = [
			holidayincambodia
			rockulikeahurricane
			sameoldsonganddance
			lagrange
			welcometothejungle
			helicopter
		]
		encorep1
		encorep2
		level = load_z_prison
		setlist_icon = #"0xb0c88183"
	}
	tier6 = {
		Title = "6. The Hottest band on Earth"
		songs = [
			blackmagicwoman
			cherubrock
			blacksunshine
			themetal
			pridenjoy
			monsters
		]
		encorep1
		encorep2
		level = load_z_wikker
		setlist_icon = #"0xdf4e77c3"
	}
	tier7 = {
		Title = "7. Live in Japan"
		songs = [
			beforeiforget
			stricken
			threesandsevens
			knightsofcydonia
			cultofpersonality
		]
		encorep1
		level = load_z_budokan
		setlist_icon = #"0xd4b486d5"
	}
	tier8 = {
		Title = "8. Battle for your Soul"
		songs = [ rainingblood cliffsofdover numberofthebeast one ]
		level = load_z_hell
		setlist_icon = #"0xd25d508d"
	}
}
GH3_GeneralP2_Songs = {
	prefix = 'general'
	num_tiers = 8
	tier1 = {
		Title = "1. Starting out small"
		songs = [
			slowride
			TalkDirtyToMe
			hitmewithyourbestshot
			storyofmylife
			rocknrollallnite
			sabotage
		]
		encorep1
		encorep2
		level = load_z_party
		defaultunlocked = 4
		setlist_icon = #"0x3a4a769d"
	}
	tier2 = {
		Title = "2. Your first real gig"
		songs = [
			mississippiqueen
			schoolsout
			sunshineofyourlove
			barracuda
			bullsonparade
			reptilia
		]
		encorep1
		encorep2
		level = load_z_dive
		defaultunlocked = 4
		setlist_icon = #"0xc3210dfb"
	}
	tier3 = {
		Title = "3. Making the video"
		songs = [
			whenyouwereyoung
			missmurder
			theseeker
			laydown
			paintitblack
			suckmykiss
		]
		encorep1
		encorep2
		level = load_z_video
		setlist_icon = #"0xfbbd54e9"
	}
	tier4 = {
		Title = "4. European Invasion"
		songs = [
			paranoid
			anarchyintheuk
			koolthing
			mynameisjonas
			evenflow
			citiesonflame
		]
		encorep1
		encorep2
		level = load_z_artdeco
		setlist_icon = #"0x17b13dab"
	}
	tier5 = {
		Title = "5. Bighouse Blues"
		songs = [
			holidayincambodia
			rockulikeahurricane
			sameoldsonganddance
			lagrange
			welcometothejungle
			helicopter
		]
		encorep1
		encorep2
		level = load_z_prison
		setlist_icon = #"0xb0c88183"
	}
	tier6 = {
		Title = "6. The Hottest band on Earth"
		songs = [
			blackmagicwoman
			cherubrock
			blacksunshine
			themetal
			pridenjoy
			monsters
		]
		encorep1
		encorep2
		level = load_z_wikker
		setlist_icon = #"0xdf4e77c3"
	}
	tier7 = {
		Title = "7. Live in Japan"
		songs = [
			beforeiforget
			stricken
			threesandsevens
			knightsofcydonia
			cultofpersonality
		]
		encorep1
		level = load_z_budokan
		setlist_icon = #"0xd4b486d5"
	}
	tier8 = {
		Title = "8. Battle for your Soul"
		songs = [ rainingblood cliffsofdover numberofthebeast one ]
		level = load_z_hell
		setlist_icon = #"0xd25d508d"
	}
}
GH3_GeneralP2_Songs_Coop = {
	prefix = 'general'
	num_tiers = 8
	tier1 = {
		Title = "1. Starting out small"
		songs = [
			slowride
			TalkDirtyToMe
			hitmewithyourbestshot
			storyofmylife
			rocknrollallnite
			sabotage
		]
		encorep1
		encorep2
		level = load_z_party
		defaultunlocked = 4
		setlist_icon = #"0x3a4a769d"
	}
	tier2 = {
		Title = "2. Your first real gig"
		songs = [
			mississippiqueen
			schoolsout
			sunshineofyourlove
			barracuda
			bullsonparade
			reptilia
		]
		encorep1
		encorep2
		level = load_z_dive
		defaultunlocked = 4
		setlist_icon = #"0xc3210dfb"
	}
	tier3 = {
		Title = "3. Making the video"
		songs = [
			whenyouwereyoung
			missmurder
			theseeker
			laydown
			suckmykiss
		]
		encorep1
		encorep2
		level = load_z_video
		setlist_icon = #"0xfbbd54e9"
	}
	tier4 = {
		Title = "4. European Invasion"
		songs = [
			paranoid
			anarchyintheuk
			koolthing
			mynameisjonas
			evenflow
			citiesonflame
		]
		encorep1
		encorep2
		level = load_z_artdeco
		setlist_icon = #"0x17b13dab"
	}
	tier5 = {
		Title = "5. Bighouse Blues"
		songs = [
			holidayincambodia
			rockulikeahurricane
			sameoldsonganddance
			lagrange
			welcometothejungle
			helicopter
		]
		encorep1
		encorep2
		level = load_z_prison
		setlist_icon = #"0xb0c88183"
	}
	tier6 = {
		Title = "6. The Hottest band on Earth"
		songs = [
			blackmagicwoman
			cherubrock
			blacksunshine
			themetal
			pridenjoy
			monsters
		]
		encorep1
		encorep2
		level = load_z_wikker
		setlist_icon = #"0xdf4e77c3"
	}
	tier7 = {
		Title = "7. Live in Japan"
		songs = [
			beforeiforget
			stricken
			threesandsevens
			knightsofcydonia
			cultofpersonality
		]
		encorep1
		level = load_z_budokan
		setlist_icon = #"0xd4b486d5"
	}
	tier8 = {
		Title = "8. Battle for your Soul"
		songs = [ rainingblood cliffsofdover numberofthebeast one ]
		level = load_z_hell
		setlist_icon = #"0xd25d508d"
	}
}
/**///














