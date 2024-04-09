
script create_band_member \{ name = GUITARIST LightGroup = Band async = 0 animpak = 1 }
	create_band_member_wait_for_lock
	Printf "Create_Band_Member name=%a............." a = <name>
	FormatText ChecksumName = bandmember_body_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>)p = ($character_pak_crc_to_text.Body)
	FormatText ChecksumName = bandmember_anim_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>)p = ($character_pak_crc_to_text.Anim)
	FormatText ChecksumName = bandmember_instrument_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>)p = ($character_pak_crc_to_text.instrument)
	Pos = (0.0, 0.0, 0.0)
	Dir = (0.0, 0.0, 1.0)
	if GotParam \{ start_node }
		if DoesWayPointExist name = <start_node>
			GetWaypointPos name = <start_node>
			GetWaypointDir name = <start_node>
		endif
	endif
	if CompositeObjectExists <name>
		if GotParam \{ UseOldPos }
			<name> ::Obj_GetPosition
			<name> ::Obj_GetOrientation
			Dir = ((1.0, 0.0, 0.0) * <X> + (0.0, 1.0, 0.0) * <Y> + (0.0, 0.0, 1.0) * <z>)
		endif
		<name> ::DIE
	endif
	unload_musician_pak_file desc_id = ($<bandmember_body_pak>)async = <async> Type = Body
	unload_musician_pak_file desc_id = ($<bandmember_anim_pak>)async = <async> Type = Anim
	unload_musician_pak_file desc_id = ($<bandmember_instrument_pak>)async = <async> Type = instrument
	Change GlobalName = <bandmember_body_pak> NewValue = no_pak_id
	Change GlobalName = <bandmember_anim_pak> NewValue = no_pak_id
	Change GlobalName = <bandmember_instrument_pak> NewValue = no_pak_id
	if (<name> = GUITARIST || <name> = BASSIST)
		startslot = 0
	else
		startslot = 2
	endif
	body_asset_context = 0
	if (<name> = GUITARIST)
		if CompositeObjectExists \{ name = BASSIST }
			BASSIST ::hero_pause_anim
		endif
	elseif (<name> = BASSIST)
		if CompositeObjectExists \{ name = GUITARIST }
			GUITARIST ::hero_pause_anim
		endif
	endif
	if StructureContains Structure = <Profile> musician_body
		if NOT load_musician_pak_file Profile = <Profile> async = <async> Type = Body
			create_band_member_unlock
			return \{ FALSE }
		endif
		Change GlobalName = <bandmember_body_pak> NewValue = <filename_crc>
		body_asset_context = <AssetContext>
		if (<animpak> = 1)
			if NOT load_musician_pak_file Profile = <Profile> async = <async> Type = Anim startslot = <startslot>
				create_band_member_unlock
				return \{ FALSE }
			endif
			Change GlobalName = <bandmember_anim_pak> NewValue = <filename_crc>
		endif
	endif
	if StructureContains Structure = <Profile> musician_instrument
		if NOT load_musician_pak_file Profile = <Profile> async = <async> Type = instrument
			create_band_member_unlock
			return \{ FALSE }
		endif
		Change GlobalName = <bandmember_instrument_pak> NewValue = <filename_crc>
	endif
	if (<name> = GUITARIST)
		if CompositeObjectExists \{ name = BASSIST }
			BASSIST ::hero_unpause_anim
		endif
	elseif (<name> = BASSIST)
		if CompositeObjectExists \{ name = GUITARIST }
			GUITARIST ::hero_unpause_anim
		endif
	endif
	dump_pak_info
	GetPakManCurrent \{ map = Zones }
	switch <pak>
		case z_training
		case Z_Viewer
			LightGroup = None
		default
			if (<name> = GUITARIST)
				LightGroup = Alt_Band
			endif
	endswitch
	if ($soundcheck_in_store = 1)
		<LightGroup> = Guitar_Center_Band
	endif
	skeleton_name = (<Profile>.Skeleton)
	ragdoll_name = (<Profile>.Ragdoll)
	collision_group = (<Profile>.ragdoll_collision_group)
	if StructureContains Structure = <Profile> outfit
		if (<Profile>.outfit = 2)
			skeleton_name = (<Profile>.skeleton2)
			ragdoll_name = (<Profile>.ragdoll2)
			collision_group = (<Profile>.ragdoll_collision_group2)
		endif
	endif
	if StructureContains Structure = <Profile> ik_params
		ik_params = (<Profile>.ik_params)
	else
		ik_params = Hero_Ik_params
	endif
	CreateCompositeObject {
		Components = [
			{
				Component = Ragdoll
				initialize_empty = FALSE
				disable_collision_callbacks
				SkeletonName = <skeleton_name>
				ragdollName = <ragdoll_name>
				RagdollCollisionGroup = $<collision_group>
			}
			{
				Component = SetDisplayMatrix
			}
			{
				Component = AnimTree
				AnimEventTableName = ped_animevents
			}
			{
				Component = Skeleton
				SkeletonName = <skeleton_name>
			}
			{
				Component = Model
				LightGroup = <LightGroup>
			}
			{
				Component = Motion
			}
		]
		Params = {
			name = <name>
			Pos = <Pos>
			AssetContext = <body_asset_context>
			<Profile>
			object_type = bandmember
			profilebudget = 800
		}
	}
	<name> ::Obj_SetOrientation Dir = <Dir>
	<name> ::Obj_InitModelFromProfile struct = <Profile> buildscript = create_ped_model_from_appearance Params = { LightGroup = <LightGroup> }
	switch (<name>)
		case VOCALIST
			desired_tree = vocalist_static_tree
		case Drummer
			desired_tree = drummer_static_tree
		default
			desired_tree = guitarist_static_tree
	endswitch
	<name> ::Anim_InitTree {
		Tree = $<desired_tree>
		AnimEventTableName = ped_animevents
		NodeIdDeclaration = [
			Base
			Body
			BodyTimer
			StrumTimer
			FretTimer
			FingerTimer
			FacialTimer
			IK
			Standard_Branch
			Turn_Branch
			LeftArmPartial
			LeftHandPartial
			RightArmPartial
			DrummerLeftArm
			DrummerRightArm
			leftarm_timer
			rightarm_timer
			LeftArm
			LeftHand
			RightArm
			Face
			cymbal1
			cymbal2
			cymbal3
			cymbal4
			CymbalTimer1
			CymbalTimer2
			CymbalTimer3
			CymbalTimer4
			leftfoot
			leftfoot_timer
			rightfoot
			rightfoot_timer
			BodyTwist
			bodytwist_timer
			bodytwist_branch
			arm_branch
			left_arm_branch
			right_arm_branch
		]
		Params = {
			ik_params = <ik_params>
		}
	}
	create_band_member_unlock
	return \{ TRUE }
endscript

script preload_band_member \{ name = GUITARIST async = 0 }
	create_band_member_wait_for_lock
	filename_crc = None
	instrument_crc = None
	create_guitarist_profile <...>
	if (<found> = 1)
		if StructureContains Structure = <Profile> musician_instrument
			if NOT load_musician_pak_file Profile = <Profile> async = <async> Type = instrument
				create_band_member_unlock
				return \{ FALSE }
			endif
			instrument_crc = <filename_crc>
		endif
		if StructureContains Structure = <Profile> musician_body
			if NOT load_musician_pak_file Profile = <Profile> async = <async> Type = Body
				create_band_member_unlock
				return \{ FALSE }
			endif
		endif
	endif
	create_band_member_unlock
	return filename_crc = <filename_crc> instrument_crc = <instrument_crc> TRUE
endscript

script preload_band_member_finish \{ name = GUITARIST async = 0 }
	create_band_member_wait_for_lock
	if NOT (<instrument_crc> = None)
		unload_musician_pak_file desc_id = <instrument_crc> async = <async> Type = instrument
	endif
	if NOT (<filename_crc> = None)
		unload_musician_pak_file desc_id = <filename_crc> async = <async> Type = Body
	endif
	create_band_member_unlock
endscript
create_band_member_lock_queue = 0
create_band_member_lock = 0

script create_band_member_unlock
	Change \{ create_band_member_lock = 0 }
endscript

script create_band_member_wait_for_lock
	begin
		if ($create_band_member_lock_queue = 0)
			break
		endif
		wait \{ 1 GameFrame }
	repeat
	Change \{ create_band_member_lock_queue = 1 }
	begin
		if ($create_band_member_lock = 0)
			break
		endif
		wait \{ 1 GameFrame }
	repeat
	Change \{ create_band_member_lock_queue = 0 }
	Change \{ create_band_member_lock = 1 }
endscript

script destroy_band
	destroy_band_member \{ name = GUITARIST }
	destroy_band_member \{ name = BASSIST }
	destroy_band_member \{ name = Drummer }
	destroy_band_member \{ name = VOCALIST }
	if GotParam \{ unload_paks }
		force_unload_all_character_paks
	endif
endscript

script destroy_band_member
	if CompositeObjectExists name = <name>
		<name> ::DIE
		FormatText ChecksumName = bandmember_body_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>)p = ($character_pak_crc_to_text.Body)
		FormatText ChecksumName = bandmember_anim_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>)p = ($character_pak_crc_to_text.Anim)
		FormatText ChecksumName = bandmember_instrument_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>)p = ($character_pak_crc_to_text.instrument)
		unload_musician_pak_file desc_id = ($<bandmember_body_pak>)async = <async> Type = Body
		unload_musician_pak_file desc_id = ($<bandmember_anim_pak>)async = <async> Type = Anim
		unload_musician_pak_file desc_id = ($<bandmember_instrument_pak>)async = <async> Type = instrument
		Change GlobalName = <bandmember_body_pak> NewValue = no_pak_id
		Change GlobalName = <bandmember_anim_pak> NewValue = no_pak_id
		Change GlobalName = <bandmember_instrument_pak> NewValue = no_pak_id
	endif
endscript

script kill_character_scripts
	Printf \{ "kill character scripts......." }
	if CompositeObjectExists \{ name = GUITARIST }
		GUITARIST ::Obj_SwitchScript \{ EmptyScript }
	endif
	if CompositeObjectExists \{ name = BASSIST }
		BASSIST ::Obj_SwitchScript \{ EmptyScript }
	endif
	if CompositeObjectExists \{ name = VOCALIST }
		VOCALIST ::Obj_SwitchScript \{ EmptyScript }
	endif
	if CompositeObjectExists \{ name = Drummer }
		Drummer ::Obj_SwitchScript \{ EmptyScript }
	endif
endscript

script EmptyScript
endscript

script hero_pause_anim
	if Anim_AnimNodeExists \{ Id = BodyTimer }
		Anim_Command \{Target = BodyTimer Command = Timer_SetSpeed Params = { Speed = 0.0 }}
	endif
endscript

script hero_unpause_anim
	if Anim_AnimNodeExists \{ Id = BodyTimer }
		Anim_Command \{Target = BodyTimer Command = Timer_SetSpeed Params = { Speed = 1.0 }}
	endif
endscript

script hero_play_turn_anim \{ BlendDuration = 0.2 TurnBlend = 1.0 }
	Anim_Command {
		Target = Body
		Command = DegenerateBlend_AddBranch
		Params = {
			Tree = $Hero_turning_tree
			BlendDuration = <BlendDuration>
			Params = {
				timer_type = Play
				anim_name = <idleAnim>
				second_anim_name = <turnAnim>
				second_anim_blend = <TurnBlend>
			}
		}
	}
endscript

script hero_play_blended_anim \{ BlendDuration = 0.2 Blend = 1.0 }
	if GotParam \{ Cycle }
		timer_type = Cycle
	else
		timer_type = Play
	endif
	Anim_Command {
		Target = Body
		Command = DegenerateBlend_AddBranch
		Params = {
			Tree = $Hero_turning_tree
			BlendDuration = <BlendDuration>
			Params = {
				timer_type = <timer_type>
				anim_name = <first_anim>
				second_anim_name = <second_anim>
				second_anim_blend = <Blend>
			}
		}
	}
endscript

script hero_play_strum_anim \{ BlendDuration = 0.2 }
	if Anim_AnimNodeExists \{ Id = RightArm }
		Anim_Command {
			Target = RightArm
			Command = DegenerateBlend_AddBranch
			Params = {
				Tree = $hero_strumming_branch
				BlendDuration = <BlendDuration>
				Params = {
					strum_name = <Anim>
				}
			}
		}
	endif
endscript

script hero_play_fret_anim \{ BlendDuration = $fret_blend_time }
	if Anim_AnimNodeExists \{ Id = LeftArm }
		Anim_Command {
			Target = LeftArm
			Command = DegenerateBlend_AddBranch
			Params = {
				Tree = $hero_fret_branch
				BlendDuration = <BlendDuration>
				Params = {
					fret_anim = <Anim>
				}
			}
		}
	endif
endscript

script hero_play_finger_anim \{ BlendDuration = 0.2 }
	if Anim_AnimNodeExists \{ Id = LeftHand }
		Anim_Command {
			Target = LeftHand
			Command = DegenerateBlend_AddBranch
			Params = {
				Tree = $hero_finger_branch
				BlendDuration = <BlendDuration>
				Params = {
					finger_anim = <Anim>
				}
			}
		}
	endif
endscript

script hero_play_drum_anim \{ BlendDuration = $drum_blend_time }
	if Anim_AnimNodeExists \{ Id = cymbal1 }
		Anim_Command {
			Target = Body
			Command = DegenerateBlend_AddBranch
			Params = {
				Tree = $hero_cymbal_branch
				BlendDuration = <BlendDuration>
				Params = {
					fret_anim = <Anim>
				}
			}
		}
	endif
endscript

script hero_cymbal_anim \{ BlendDuration = $fret_blend_time }
	if Anim_AnimNodeExists \{ Id = cymbal1 }
		Anim_Command {
			Target = cymbal1
			Command = DegenerateBlend_AddBranch
			Params = {
				Tree = $hero_cymbal_branch
				BlendDuration = <BlendDuration>
				Params = {
					fret_anim = <Anim>
				}
			}
		}
	endif
endscript

script hero_play_facial_anim \{ BlendDuration = 0.0 }
	if Anim_AnimNodeExists \{ Id = Face }
		Anim_Command {
			Target = Face
			Command = DegenerateBlend_AddBranch
			Params = {
				Tree = $hero_face_branch
				BlendDuration = <BlendDuration>
				Params = {
					facial_anim = <Anim>
				}
			}
		}
	endif
endscript

script hero_wait_until_anim_finished \{ Timer = BodyTimer }
	begin
		if hero_anim_complete Timer = <Timer>
			break
		endif
		wait \{ 1 GameFrame }
	repeat
endscript

script hero_anim_complete \{ Timer = BodyTimer }
	if NOT Anim_AnimNodeExists Id = <Timer>
		return \{ TRUE }
	else
		if Anim_Command Target = <Timer> Command = Timer_IsAnimComplete
			return \{ TRUE }
		else
			return \{ FALSE }
		endif
	endif
endscript

script hero_wait_until_anim_near_end \{ Timer = BodyTimer time_from_end = 0.2 }
	begin
		if hero_anim_near_end Timer = <Timer> time_from_end = <time_from_end>
			break
		endif
		wait \{ 1 GameFrame }
	repeat
endscript

script hero_anim_near_end \{ Timer = BodyTimer }
	if NOT Anim_AnimNodeExists Id = <Timer>
		return \{ TRUE }
	else
		if Anim_Command Target = <Timer> Command = Timer_Wait Params = { SecondsFromEnd = <time_from_end> }
			return \{ TRUE }
		else
			return \{ FALSE }
		endif
	endif
endscript

script hero_disable_arms \{ blend_time = 0.25 }
	if Anim_AnimNodeExists \{ Id = arm_branch }
		if (<blend_time> = 0.0)
			Anim_Command \{Target = arm_branch Command = Modulate_SetStrength Params = { Strength = 0.0 BlendDuration = 2.0 }}
		else
			Anim_Command {
				Target = arm_branch
				Command = Modulate_StartBlend
				Params = {
					BlendCurve = [ 0.0 1.0 ]
					BlendDuration = <blend_time>
				}
			}
		endif
	endif
	if Anim_AnimNodeExists \{ Id = IK }
		Obj_GetID
		if (<ObjID> = Drummer)
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 0.0
					BlendDuration = <blend_time>
					Chain = Bone_IK_Hand_Slave_R
				}
			}
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 0.0
					BlendDuration = <blend_time>
					Chain = Bone_IK_Hand_Slave_L
				}
			}
		else
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 0.0
					BlendDuration = <blend_time>
					Chain = Bone_IK_Hand_Guitar_R
				}
			}
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 0.0
					BlendDuration = <blend_time>
					Chain = Bone_IK_Hand_Guitar_L
				}
			}
		endif
	endif
endscript

script hero_enable_arms \{ blend_time = 0.25 }
	if Anim_AnimNodeExists \{ Id = arm_branch }
		Anim_Command {
			Target = arm_branch
			Command = Modulate_StartBlend
			Params = {
				BlendCurve = [ 1.0 0.0 ]
				BlendDuration = <blend_time>
			}
		}
	endif
	if Anim_AnimNodeExists \{ Id = IK }
		Obj_GetID
		if (<ObjID> = Drummer)
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 1.0
					BlendDuration = <blend_time>
					Chain = Bone_IK_Hand_Slave_R
				}
			}
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 1.0
					BlendDuration = <blend_time>
					Chain = Bone_IK_Hand_Slave_L
				}
			}
		else
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 1.0
					BlendDuration = <blend_time>
					Chain = Bone_IK_Hand_Guitar_R
				}
			}
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 1.0
					BlendDuration = <blend_time>
					Chain = Bone_IK_Hand_Guitar_L
				}
			}
		endif
	endif
endscript

script hero_toggle_arms \{ num_arms = 2 prev_num_arms = 0 blend_time = 0.25 }
	disable_left_arm = FALSE
	enable_left_arm = FALSE
	disable_right_arm = FALSE
	enable_right_arm = FALSE
	if (<num_arms> = 0)
		if (<prev_num_arms> = 1)
			disable_right_arm = TRUE
		elseif (<prev_num_arms> = 2)
			disable_left_arm = TRUE
			disable_right_arm = TRUE
		endif
	elseif (<num_arms> = 1)
		if (<prev_num_arms> = 2)
			disable_right_arm = TRUE
			enable_left_arm = TRUE
		endif
	elseif (<num_arms> = 2)
		if (<prev_num_arms> = 0)
			enable_left_arm = TRUE
			enable_right_arm = TRUE
		elseif (<prev_num_arms> = 1)
			enable_right_arm = TRUE
		endif
	endif
	Obj_GetID
	if (<ObjID> = Drummer)
		left_hand_bone = Bone_IK_Hand_Slave_L
		right_hand_bone = Bone_IK_Hand_Slave_R
	else
		left_hand_bone = Bone_IK_Hand_Guitar_L
		right_hand_bone = Bone_IK_Hand_Guitar_R
	endif
	if (<disable_left_arm> = TRUE)
		Printf \{ channel = newdebug "disable_left_arm is true " }
		if Anim_AnimNodeExists \{ Id = left_arm_branch }
			if (<blend_time> = 0.0)
				Anim_Command \{Target = left_arm_branch Command = Modulate_SetStrength Params = { Strength = 0.0 BlendDuration = 2.0 }}
			else
				Anim_Command {
					Target = left_arm_branch
					Command = Modulate_StartBlend
					Params = {
						BlendCurve = [ 0.0 1.0 ]
						BlendDuration = <blend_time>
					}
				}
			endif
		else
			Printf \{ channel = newdebug "left_arm_branch doesn't exist......." }
		endif
		if Anim_AnimNodeExists \{ Id = IK }
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 0.0
					BlendDuration = <blend_time>
					Chain = <left_hand_bone>
				}
			}
		else
			Printf \{ channel = newdebug "ik node doesn't exist......." }
		endif
	endif
	if (<disable_right_arm> = TRUE)
		if Anim_AnimNodeExists \{ Id = right_arm_branch }
			if (<blend_time> = 0.0)
				Anim_Command \{Target = right_arm_branch Command = Modulate_SetStrength Params = { Strength = 0.0 BlendDuration = 2.0 }}
			else
				Anim_Command {
					Target = right_arm_branch
					Command = Modulate_StartBlend
					Params = {
						BlendCurve = [ 0.0 1.0 ]
						BlendDuration = <blend_time>
					}
				}
			endif
		endif
		if Anim_AnimNodeExists \{ Id = IK }
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 0.0
					BlendDuration = <blend_time>
					Chain = <right_hand_bone>
				}
			}
		endif
	endif
	if (<enable_left_arm> = TRUE)
		if Anim_AnimNodeExists \{ Id = left_arm_branch }
			Anim_Command {
				Target = left_arm_branch
				Command = Modulate_StartBlend
				Params = {
					BlendCurve = [ 1.0 0.0 ]
					BlendDuration = <blend_time>
				}
			}
		endif
		if Anim_AnimNodeExists \{ Id = IK }
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 1.0
					BlendDuration = <blend_time>
					Chain = <left_hand_bone>
				}
			}
		endif
	endif
	if (<enable_right_arm> = TRUE)
		if Anim_AnimNodeExists \{ Id = right_arm_branch }
			Anim_Command {
				Target = right_arm_branch
				Command = Modulate_StartBlend
				Params = {
					BlendCurve = [ 1.0 0.0 ]
					BlendDuration = <blend_time>
				}
			}
		endif
		if Anim_AnimNodeExists \{ Id = IK }
			Anim_Command {
				Target = IK
				Command = IK_SetChainStrength
				Params = {
					Strength = 1.0
					BlendDuration = <blend_time>
					Chain = <right_hand_bone>
				}
			}
		endif
	endif
endscript

script drummer_twist
	if Anim_AnimNodeExists \{ Id = bodytwist_branch }
		Anim_Command {
			Target = bodytwist_branch
			Command = Modulate_SetStrength
			Params = {
				Strength = <Strength>
			}
		}
	endif
endscript
generic_static_tree = { Type = DegenerateBlend Id = Body }
guitarist_static_tree = {
	Type = ConstraintBones
	ConstraintBones = hero_ConstraintBones
	[
		{
			Type = Ragdoll
			[
				{
					Type = IK
					two_bone_chains = ik_params
					Id = IK
					[
						{
							Type = PartialSwitch
							state = ON
							[
								{ Type = DegenerateBlend Id = Face }
								{
									Type = ApplyDifference
									Id = LeftHandPartial
									[
										{ $hero_arm_branch }
										{ Type = DegenerateBlend Id = Body }
									]
								}
							]
						}
					]
				}
			]
		}
	]
}
hero_arm_branch = {
	Type = modulate
	Strength = 1.0
	Id = arm_branch
	[
		{
			Type = Add
			[
				{
					Type = modulate
					Strength = 1.0
					Id = left_arm_branch
					[
						{
							Type = Add
							[
								{ Type = DegenerateBlend Id = LeftArm }
								{ Type = DegenerateBlend Id = LeftHand }
							]
						}
					]
				}
				{
					Type = modulate
					Strength = 1.0
					Id = right_arm_branch
					[
						{ Type = DegenerateBlend Id = RightArm }
					]
				}
			]
		}
	]
}
hero_body_branch = {
	Type = timer_type
	Id = BodyTimer
	Anim = anim_name
	Speed = Speed
	anim_events = ON
	[
		{ Type = source_type Anim = anim_name }
	]
}
hero_strumming_branch = {
	Type = Play
	Id = StrumTimer
	Anim = strum_name
	[
		{ Type = Source Anim = strum_name }
	]
}
hero_fret_branch = {
	Type = Play
	Id = FretTimer
	Anim = fret_anim
	[
		{ Type = Source Anim = fret_anim }
	]
}
hero_finger_branch = {
	Type = Play
	Id = FingerTimer
	Anim = finger_anim
	[
		{ Type = Source Anim = finger_anim }
	]
}
hero_face_branch = {
	Type = Play
	Id = FacialTimer
	Anim = facial_anim
	[
		{ Type = Source Anim = facial_anim }
	]
}
hero_drumming_branch = {
	Type = timer_type
	Id = timer_id
	Anim = anim_name
	Speed = Speed
	[
		{ Type = Source Anim = anim_name }
	]
}
drummer_twist_branch = {
	Type = Play
	Id = bodytwist_timer
	Anim = anim_name
	[
		{
			Type = modulate
			Strength = 1.0
			Id = bodytwist_branch
			[
				{ Type = Source Anim = anim_name }
			]
		}
	]
}
Hero_turning_tree = {
	Type = timer_type
	Id = BodyTimer
	Anim = anim_name
	[
		{
			Type = Blend
			blend_factor = second_anim_blend
			[
				{ Type = MotionExtractedSource Anim = anim_name }
				{ Type = MotionExtractedSource Anim = second_anim_name }
			]
		}
	]
}
vocalist_static_tree = {
	Type = ConstraintBones
	ConstraintBones = hero_ConstraintBones
	[
		{
			Type = Ragdoll
			[
				{
					Type = IK
					two_bone_chains = Singer_IK_Params
					[
						{
							Type = PartialSwitch
							state = ON
							[
								{ Type = DegenerateBlend Id = Face }
								{ Type = DegenerateBlend Id = Body }
							]
						}
					]
				}
			]
		}
	]
}
drummer_static_tree = {
	Type = ConstraintBones
	ConstraintBones = hero_ConstraintBones
	[
		{
			Type = Ragdoll
			[
				{
					Type = IK
					two_bone_chains = Drummer_IK_Params
					Id = IK
					[
						{
							Type = PartialSwitch
							state = ON
							[
								{ $drummer_cymbals_branch }
								{
									Type = ApplyDifference
									[
										{ Type = DegenerateBlend Id = BodyTwist }
										{
											Type = PartialSwitch
											state = ON
											[
												{
													Type = modulate
													Strength = 1.0
													Id = arm_branch
													[
														{
															Type = Add
															[
																{
																	Type = Add
																	[
																		{ Type = DegenerateBlend Id = DrummerLeftArm }
																		{ Type = DegenerateBlend Id = DrummerRightArm }
																	]
																}
																{
																	Type = Add
																	[
																		{ Type = DegenerateBlend Id = leftfoot }
																		{ Type = DegenerateBlend Id = rightfoot }
																	]
																}
															]
														}
													]
												}
												{ Type = DegenerateBlend Id = Body }
											]
										}
									]
								}
							]
						}
					]
				}
			]
		}
	]
}
hero_cymbal_branch = {
	Type = Play
	Id = cymbal_timer_id
	Anim = cymbal_anim
	[
		{ Type = Source Anim = cymbal_anim }
	]
}
drummer_cymbals_branch = {
	Type = Add
	[
		{
			Type = Add
			[
				{ Type = DegenerateBlend Id = cymbal1 }
				{ Type = DegenerateBlend Id = cymbal2 }
			]
		}
		{
			Type = Add
			[
				{ Type = DegenerateBlend Id = cymbal3 }
				{ Type = DegenerateBlend Id = cymbal4 }
			]
		}
	]
}
Hero_Ik_params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.97
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Hand_Guitar_R
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.97
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Hand_Guitar_L
	}
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.99
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.99
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
Satan_IK_Params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.97
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Hand_Guitar_R
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.97
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Hand_Guitar_L
	}
	{
		bone0 = Bone_Knee_L
		bone1 = Bone_Ankle_L
		bone2 = Bone_Toe_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.99
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Knee_R
		bone1 = Bone_Ankle_R
		bone2 = Bone_Toe_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.99
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
Singer_IK_Params = [
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.99
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.99
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
Drummer_IK_Params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.97
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Hand_Slave_R
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.97
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Hand_Slave_L
	}
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.99
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.99
		CosMinHingeAngle = 0.97
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
hero_ConstraintBones = [
	{ Type = Twistchild Bone = Bone_Twist_Wrist_L Target = Bone_Palm_L Amount = 0.5 }
	{ Type = Twistchild Bone = Bone_Twist_Wrist_R Target = Bone_Palm_R Amount = 0.5 }
	{ Type = TWIST Bone = Bone_Twist_Bicep_Mid_R Target = Bone_Bicep_R Amount = 0.5 }
	{ Type = TWIST Bone = Bone_Twist_Bicep_Mid_L Target = Bone_Bicep_L Amount = 0.5 }
	{ Type = TWIST Bone = Bone_Twist_Bicep_Top_R Target = Bone_Bicep_R Amount = 1.0 }
	{ Type = TWIST Bone = Bone_Twist_Bicep_Top_L Target = Bone_Bicep_L Amount = 1.0 }
	{ Type = TWIST Bone = Bone_Twist_Thigh_R Target = Bone_Thigh_R Amount = 0.5 }
	{ Type = TWIST Bone = Bone_Twist_Thigh_L Target = Bone_Thigh_L Amount = 0.5 }
	{ Type = Split Bone = Bone_Split_Knee_R Target = Bone_Knee_R Amount = 0.5 }
	{ Type = Split Bone = Bone_Split_Knee_L Target = Bone_Knee_L Amount = 0.5 }
	{ Type = SplitR Bone = Bone_Split_Ass_R Target = Bone_Twist_Thigh_R Amount = 0.5 }
	{ Type = SplitR Bone = Bone_Split_Ass_L Target = Bone_Twist_Thigh_L Amount = 0.5 }
	{ Type = Split Bone = Bone_Split_Elbow_R Target = Bone_Forearm_R Amount = 0.5 }
	{ Type = Split Bone = Bone_Split_Elbow_L Target = Bone_Forearm_L Amount = 0.5 }
]
