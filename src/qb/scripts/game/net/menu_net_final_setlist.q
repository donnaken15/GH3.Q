
script create_final_set_list_menu {
		menu_id = online_final_setlist_menu
		vmenu_id = online_final_setlist_vmenu
		pad_back_script = check_back_action_final_setlist
		pad_choose_script = check_for_both_players_ready
		Pos = ($menu_pos)
	}
	online_final_setlist_event_handlers = [
		{ pad_back <pad_back_script> }
		{ pad_choose <pad_choose_script> }
	]
	new_menu scrollid = <menu_id> vmenuid = <vmenu_id> use_backdrop = (1)menu_pos = <Pos> event_handlers = <online_final_setlist_event_handlers>
	array_entry = 0
	begin
		if (($FinalSongList [ <array_entry> ])= -1)
			<newtext> = "--------"
		else
			get_songlist_checksum Index = ($FinalSongList [ <array_entry> ])
			get_song_title song = <song_checksum>
			<newtext> = <song_title>
		endif
		FormatText ChecksumName = item_id 'final_setlist_item_%s' s = <array_entry>
		CreateScreenElement {
			Type = TextElement
			PARENT = <vmenu_id>
			Id = <item_id>
			font = text_a1
			Scale = 0.75
			rgba = [ 210 210 210 250 ]
			text = <newtext>
			just = [ Left top ]
		}
		<array_entry> = (<array_entry> + 1)
	repeat (($NumberOfSongsInfo [($NumberOfSongs [ ($MenuControl) ].value)]).value)
	if IsHost
		CreateScreenElement {
			Type = TextElement
			PARENT = <vmenu_id>
			font = text_a1
			Scale = 0.75
			rgba = [ 210 210 210 250 ]
			text = "Press A when the final song is selected"
			just = [ Left top ]
		}
	endif
	LaunchEvent Type = Focus Target = <vmenu_id>
	check_final_setlist_ready
endscript

script destroy_final_set_list_menu
	destroy_menu \{ menu_id = online_final_setlist_menu }
	destroy_gamertag_container
	destroy_menu_backdrop
endscript

script check_back_action_final_setlist
	if (($NumberOfSongsInfo [($NumberOfSongs [ ($MenuControl) ].value)].value)= 1)
		check_for_final_song_selection
		if (<can_select_final_song> = FALSE)
			SendNetMessage \{Type = song_selection song_index = -1 selection_value = 0 final_selection = -1 tie_breaker_selection = -1 menu_jump = -1}
			clear_setlists
		endif
	endif
	ui_flow_manager_respond_to_action \{ action = go_back }
endscript

script network_player_change_final_setlist \{ Type = Select tie_breaker_song = FALSE }
	if (<Type> = Select)
		if (<tie_breaker_song> = TRUE)
			FormatText ChecksumName = Id 'final_setlist_item_%s' s = (($NumberOfSongsInfo [($NumberOfSongs [ ($MenuControl) ].value)].value)-1)
			get_song_title song = ($gh3_songlist [($FinalSongList [(($NumberOfSongsInfo [($NumberOfSongs [ ($MenuControl) ].value)].value)-1)])])
		endif
		if IsHost
			FormatText ChecksumName = Id 'final_setlist_item_%s' s = ((($RemotePlayerSongSelections)* 2)+ 1)
			get_song_title song = ($gh3_songlist [($FinalSongList [((($RemotePlayerSongSelections)* 2)+ 1)])])
		else
			FormatText ChecksumName = Id 'final_setlist_item_%s' s = (($RemotePlayerSongSelections)* 2)
			get_song_title song = ($gh3_songlist [($FinalSongList [(($RemotePlayerSongSelections)* 2)])])
		endif
		new_text = <song_title>
	else
		new_text = "--------"
		if (<tie_breaker_song> = TRUE)
			FormatText ChecksumName = Id 'final_setlist_item_%s' s = (($NumberOfSongsInfo [($NumberOfSongs [ ($MenuControl) ].value)].value)-1)
		endif
		if IsHost
			FormatText ChecksumName = Id 'final_setlist_item_%s' s = ((($RemotePlayerSongSelections)* 2)+ 1)
		else
			FormatText ChecksumName = Id 'final_setlist_item_%s' s = (($RemotePlayerSongSelections)* 2)
		endif
	endif
	<Id> ::SetProps text = <new_text>
endscript
