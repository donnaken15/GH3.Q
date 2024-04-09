
script turn_to_face \{ Pos = (0.0, 0.0, 0.0) }
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	walking_set = (<anim_set>.Walking)
	Target = <Pos>
	get_angle_to_target Target = <Target>
	Angle = (<Angle> * -1)
	Obj_RotY Angle = <Angle> Speed = (<anim_set>.Walking.turn_speed)
endscript

script play_turn_anim
	Blend = (<Angle> / <max_turn>)
	if (<Blend> < 0)
		Blend = 0
	elseif (<Blend> > 1.0)
		Blend = 1.0
	endif
	Printf "playing turn with %a, %b, and %c............." a = <turn_idle> b = <turn_left> c = <turn_right>
	if (<turning_left> = TRUE)
		hero_play_turn_anim idleAnim = <turn_idle> turnAnim = <turn_left> TurnBlend = <Blend>
	else
		hero_play_turn_anim idleAnim = <turn_idle> turnAnim = <turn_right> TurnBlend = <Blend>
	endif
endscript

script walk_to_waypoint \{ Rotate = TRUE }
	if GotParam \{ Index }
		get_waypoint_id Index = <Index>
	elseif GotParam \{ node }
		GetPakManCurrent \{ map = Zones }
		GetPakManCurrentName \{ map = Zones }
		FormatText textname = suffix '_TRG_Waypoint_%a' a = <node>
		AppendSuffixToChecksum Base = <pak> SuffixString = <suffix>
		waypoint_id = <appended_id>
	else
		Printf \{ "node not specified in walk_to_waypoint!" }
		return
	endif
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	if DoesWayPointExist name = <waypoint_id>
		Change StructureName = <info_struct> target_node = <waypoint_id>
		GetWaypointPos name = <waypoint_id>
		walk_to_pos dest = <Pos>
		face_audience
	else
		Printf \{ "waypoint not found............" }
	endif
endscript

script walk_to_pos \{ walkspeed = 2 Rotate = TRUE backward = FALSE }
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	Obj_GetPosition
	world_pos_dest = (<dest>)
	offset = (<world_pos_dest> - <Pos>)
	VectorLength vector = <offset>
	Printf "dist to target is %a..........." a = <length>
	if (<length> < $min_walk_dist)
		return
	endif
	get_angle_to_target Target = <dest>
	min_turn = (<anim_set>.Walking.min_turn)
	if ((<Angle> > (-180 + <min_turn>)& <Angle> < (0.0 - <min_turn>))|| (<Angle> > <min_turn> & <Angle> < (180 - <min_turn>)))
		if (<Rotate> = TRUE)
			turn_to_face Pos = <world_pos_dest>
		endif
	else
		if (<Angle> <= -90)
			Angle = (<Angle> + 180)
		elseif (<Angle> >= 90)
			Angle = (<Angle> - 180)
		endif
		Angle = (<Angle> * -1)
		Obj_RotY Angle = <Angle> Speed = (<anim_set>.Walking.turn_speed)
	endif
	if IsFacing Pos = <dest>
		walking_set = (<anim_set>.Walking.forward)
	else
		walking_set = (<anim_set>.Walking.backward)
	endif
	delta = (<Pos> - <world_pos_dest>)
	X = (<delta>.(1.0, 0.0, 0.0))
	z = (<delta>.(0.0, 0.0, 1.0))
	delta = (<X> * (1.0, 0.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	VectorLength vector = <delta>
	if (<length> = 0.1)
		Printf \{ "not going anywhere?.........." }
		return
	endif
	Time = (<length> / <walkspeed>)
	desired_dist = (<length>)
	get_anim_speed_for_tempo_cfunc
	SetSearchAllAssetContexts
	anim_scale = (<info_struct>.Scale)
	Anim_GetTotalDisplacement Anim = (<walking_set>.start_anim.<anim_speed>)
	displacement = (<displacement> * <anim_scale>)
	desired_dist = (<desired_dist> - <displacement>)
	Anim_GetTotalDisplacement Anim = (<walking_set>.stop_left_anim.<anim_speed>)
	displacement = (<displacement> * <anim_scale>)
	desired_dist = (<desired_dist> - <displacement>)
	Anim_GetAnimLength Anim = (<walking_set>.cycle_anim.<anim_speed>)
	Anim_GetTotalDisplacement Anim = (<walking_set>.cycle_anim.<anim_speed>)
	displacement = (<displacement> * <anim_scale>)
	SetSearchAllAssetContexts \{ OFF }
	if (<displacement> = 0.0)
		cycles_needed = 3
	else
		cycles_needed = (<desired_dist> / <displacement>)
	endif
	precision_mode = FALSE
	if (<precision_mode> = FALSE)
		cycles_needed_float = (<cycles_needed>)
		casttointeger \{ cycles_needed }
		fraction = (<cycles_needed_float> - <cycles_needed>)
		if (<fraction> > 0.75)
			cycles_needed = (<cycles_needed> + 1)
		elseif (<fraction> > 0.25)
			cycles_needed = (<cycles_needed> + 0.5)
		endif
	endif
	time_needed = (<cycles_needed> * <length>)
	Printf \{ "starting to walk........." }
	hero_play_anim Anim = (<walking_set>.start_anim.<anim_speed>)
	hero_wait_until_anim_finished
	Printf \{ "playing cycle......" }
	if (<time_needed> > 0)
		hero_play_anim Anim = (<walking_set>.cycle_anim.<anim_speed>)BlendDuration = 0.0 Cycle
		wait <time_needed> seconds
	endif
	hero_get_foot_down
	Printf \{ "playing stop......" }
	get_angle_to_target \{ Target = (0.0, 0.0, 50.0) }
	if (<Angle> < <min_turn> & <Angle> > (0.0 - <min_turn>))
		Angle = (<Angle> * -1)
		Obj_RotY Angle = <Angle> Speed = (<anim_set>.Walking.face_audience_speed)
	endif
	if (<foot> = Left)
		hero_play_anim Anim = (<walking_set>.stop_left_anim.<anim_speed>)
	else
		hero_play_anim Anim = (<walking_set>.stop_right_anim.<anim_speed>)
	endif
	hero_wait_until_anim_finished
	Printf \{ "all done!................." }
endscript

script hero_get_foot_down
	if Anim_AnimNodeExists \{ Id = BodyTimer }
		Anim_Command \{ Target = BodyTimer Command = Timer_GetFrameFactor }
		if (<FrameFactor> > 0.12 & <FrameFactor> < 0.62)
			return \{ foot = Right }
		else
			return \{ foot = Left }
		endif
	endif
endscript

script face_audience
	turn_to_face \{ Pos = (0.0, 0.0, 50.0) }
endscript

script IsFacing
	Obj_GetMatrix
	X = (<at>.(1.0, 0.0, 0.0))
	z = (<at>.(0.0, 0.0, 1.0))
	at = (<X> * (1.0, 0.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	dest_pos = <Pos>
	Obj_GetPosition
	delta = (<dest_pos> - <Pos>)
	X = (<delta>.(1.0, 0.0, 0.0))
	z = (<delta>.(0.0, 0.0, 1.0))
	delta = (<X> * (1.0, 0.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	if (<at>.<delta> < 0)
		return \{ FALSE }
	else
		return \{ TRUE }
	endif
endscript

script get_angle_to_target
	Obj_GetPosition
	Obj_GetMatrix
	vec_to_pos = (<Target> - <Pos>)
	GetAngle vec1 = <at> vec2 = <vec_to_pos> rot_axis = Y
	crossprod = (<vec_to_pos>.<Left>)
	if (<crossprod> > 0.0)
		<Angle> = (0.0 - <Angle>)
	endif
	return { Angle = <Angle> }
endscript
