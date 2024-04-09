igc_debug = 0
igc_debug_hold_camera = 0
igc_playing = 0

script igc_temporarily_disable_input
	DeBounce \{ X }
	killspawnedscript \{ Id = igc_input_toggle }
	spawnscriptnow \{TemporarilyDisableInput Params = { Time = 350 }Id = igc_input_toggle}
endscript

script TemporarilyDisableInput \{ Time = 1500 }
	OnExitRun \{ TemporarilyDisableInput_Reenable }
	SetButtonEventMappings \{ block_menu_input }
	if GotParam \{ seconds }
		wait <Time> seconds IgnoreSlomo
	else
		wait <Time> IgnoreSlomo
	endif
endscript

script TemporarilyDisableInput_Reenable
	SetButtonEventMappings \{ unblock_menu_input }
endscript

script igc_immediately_start_rendering
	killspawnedscript \{ Id = igc_render_toggle }
	StartRendering
endscript

script igc_temporarily_disable_rendering
	if NOT IsTrue \{ $is_changing_levels }
		killspawnedscript \{ Id = igc_render_toggle }
		spawnscriptnow igc_temporarily_disable_rendering_with_wait Params = <...> Id = igc_render_toggle
	endif
endscript

script igc_temporarily_disable_rendering_with_wait
	OnExitRun \{ igc_temporarily_disable_rendering_with_wait_end }
	StopRendering
	wait <...>
endscript

script igc_temporarily_disable_rendering_with_wait_end
	StartRendering
endscript
