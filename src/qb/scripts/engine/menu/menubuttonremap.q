pad_event_types = [
	pad_up
	pad_down
	pad_right
	pad_left
	pad_choose
	pad_back
	pad_square
	pad_circle
	pad_L1
	pad_R1
	pad_L2
	pad_R2
	pad_L3
	pad_R3
	pad_select
	pad_start
	pad_option
	pad_option2
	pad_backspace
	pad_space
	pad_alt
	pad_alt2
	pad_expand
	pad_btn_top
	pad_btn_right
	pad_btn_bottom
	pad_btn_left
]
pad_event_up_inversion = FALSE
ps3_pad = [
	[ X pad_choose ]
	[ Circle pad_back ]
	[ Square pad_square ]
	[ Circle pad_circle ]
	[ left_trigger1 pad_L1 ]
	[ right_trigger1 pad_R1 ]
	[ left_trigger2 pad_L2 ]
	[ right_trigger2 pad_R2 ]
	[ Select pad_select ]
	[ left_stick_button pad_L3 ]
	[ right_stick_button pad_R3 ]
	[ Square pad_option ]
	[ Triangle pad_option2 ]
	[ Square pad_backspace ]
	[ Circle pad_space ]
	[ right_trigger2 pad_alt ]
	[ left_trigger2 pad_alt2 ]
	[ Triangle pad_btn_top ]
	[ Circle pad_btn_right ]
	[ X pad_btn_bottom ]
	[ Square pad_btn_left ]
	[ Up pad_up ]
	[ Down pad_down ]
	[ Left pad_left ]
	[ Right pad_right ]
]
ps3_guitar = [
	[ X pad_choose ]
	[ Circle pad_back ]
	[ Triangle pad_square ]
	[ Circle pad_circle ]
	[ left_trigger1 pad_L1 ]
	[ right_trigger1 pad_R1 ]
	[ left_trigger2 pad_L2 ]
	[ right_trigger2 pad_R2 ]
	[ Select pad_select ]
	[ left_stick_button pad_L3 ]
	[ right_stick_button pad_R3 ]
	[ Triangle pad_option ]
	[ Square pad_option2 ]
	[ Triangle pad_backspace ]
	[ Circle pad_space ]
	[ right_trigger2 pad_alt ]
	[ left_trigger2 pad_alt2 ]
	[ Square pad_btn_top ]
	[ Circle pad_btn_right ]
	[ X pad_btn_bottom ]
	[ Triangle pad_btn_left ]
	[ Up pad_up ]
	[ Down pad_down ]
	[ Left pad_left ]
	[ Right pad_right ]
]
ps3_guitar_flip = [
	[ X pad_choose ]
	[ Circle pad_back ]
	[ Triangle pad_square ]
	[ Circle pad_circle ]
	[ left_trigger1 pad_L1 ]
	[ right_trigger1 pad_R1 ]
	[ left_trigger2 pad_L2 ]
	[ right_trigger2 pad_R2 ]
	[ Select pad_select ]
	[ left_stick_button pad_L3 ]
	[ right_stick_button pad_R3 ]
	[ Triangle pad_option ]
	[ Square pad_option2 ]
	[ Triangle pad_backspace ]
	[ Circle pad_space ]
	[ right_trigger2 pad_alt ]
	[ left_trigger2 pad_alt2 ]
	[ Square pad_btn_top ]
	[ Circle pad_btn_right ]
	[ X pad_btn_bottom ]
	[ Triangle pad_btn_left ]
	[ Up pad_down ]
	[ Down pad_up ]
	[ Left pad_left ]
	[ Right pad_right ]
]
xenon_pad = [
	[ a pad_choose ]
	[ back pad_back ]
	[ back pad_select ]
	[ X pad_square ]
	[ left_trigger1 pad_L1 ]
	[ right_trigger1 pad_R1 ]
	[ left_trigger2 pad_L2 ]
	[ right_trigger2 pad_R2 ]
	[ b pad_back ]
	[ b pad_circle ]
	[ left_stick_button pad_L3 ]
	[ right_stick_button pad_R3 ]
	[ X pad_option ]
	[ Y pad_option2 ]
	[ X pad_backspace ]
	[ Y pad_space ]
	[ right_trigger2 pad_alt ]
	[ left_trigger2 pad_alt2 ]
	[ Y pad_expand ]
	[ Y pad_btn_top ]
	[ b pad_btn_right ]
	[ a pad_btn_bottom ]
	[ X pad_btn_left ]
	[ Up pad_up ]
	[ Down pad_down ]
	[ Left pad_left ]
	[ Right pad_right ]
]
xenon_guitar_flip = [
	[ a pad_choose ]
	[ back pad_back ]
	[ back pad_select ]
	[ X pad_square ]
	[ left_trigger1 pad_L1 ]
	[ right_trigger1 pad_R1 ]
	[ left_trigger2 pad_L2 ]
	[ right_trigger2 pad_R2 ]
	[ b pad_back ]
	[ b pad_circle ]
	[ left_stick_button pad_L3 ]
	[ right_stick_button pad_R3 ]
	[ X pad_option ]
	[ Y pad_option2 ]
	[ X pad_backspace ]
	[ Y pad_space ]
	[ right_trigger2 pad_alt ]
	[ left_trigger2 pad_alt2 ]
	[ Y pad_expand ]
	[ Y pad_btn_top ]
	[ b pad_btn_right ]
	[ a pad_btn_bottom ]
	[ X pad_btn_left ]
	[ Up pad_down ]
	[ Down pad_up ]
	[ Left pad_left ]
	[ Right pad_right ]
]

script setup_main_button_event_mappings
	SetButtonEventMappings {
		PS3 = ($ps3_pad)
		Xenon = ($xenon_pad)
	}
endscript

script setup_controller_button_event_mappings \{ guitar = 0 Flip = 0 }
	if NOT (<guitar>)
		<Xenon> = $xenon_pad
		<PS3> = $ps3_pad
	else
		if NOT (<Flip>)
			<Xenon> = $xenon_pad
			<PS3> = $ps3_guitar
		else
			<Xenon> = $xenon_guitar_flip
			<PS3> = $ps3_guitar_flip
		endif
	endif
	AddArrayElement array = [] element = (<controller>)
	SetButtonEventMappings {
		PS3 = (<PS3>)
		Xenon = (<Xenon>)
		devices = (<array>)
		CLEAR
	}
endscript
player_controls_valid = 0
