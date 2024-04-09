button_up_models = {
	Green = {
		name = button_g
		name_string = 'button_g'
		material_lip = sys_NowBar_Button01_Green_Lip_sys_NowBar_Button01_Green_Lip
		material_mid = sys_NowBar_Button01_Green_Mid2_sys_NowBar_Button01_Green_Mid2
		material_head = sys_NowBar_Head_Green_sys_NowBar_Head_Green
		material_head_lit = sys_NowBar_Head_GreenL_sys_NowBar_Head_GreenL
		material_neck = sys_NowBar_Neck01_sys_NowBar_Neck01
		material_down = sys_NowBar_Button01_Green_Down_sys_NowBar_Button01_Green_Down
	}
	Red = {
		name = button_r
		name_string = 'button_r'
		material_lip = sys_NowBar_Button01_Red_Lip_sys_NowBar_Button01_Red_Lip
		material_mid = sys_NowBar_Button01_Red_Mid2_sys_NowBar_Button01_Red_Mid2
		material_head = sys_NowBar_Head_Red_sys_NowBar_Head_Red
		material_head_lit = sys_NowBar_Head_RedL_sys_NowBar_Head_RedL
		material_neck = sys_NowBar_Neck01_sys_NowBar_Neck01
		material_down = sys_NowBar_Button01_Red_Down_sys_NowBar_Button01_Red_Down
	}
	Yellow = {
		name = button_y
		name_string = 'button_y'
		material_lip = sys_NowBar_Button01_Yellow_Lip_sys_NowBar_Button01_Yellow_Lip
		material_mid = sys_NowBar_Button01_Yellow_Mid2_sys_NowBar_Button01_Yellow_Mid2
		material_head = sys_NowBar_Head_Yellow_sys_NowBar_Head_Yellow
		material_head_lit = sys_NowBar_Head_YellowL_sys_NowBar_Head_YellowL
		material_neck = sys_NowBar_Neck01_sys_NowBar_Neck01
		material_down = sys_NowBar_Button01_Yellow_Down_sys_NowBar_Button01_Yellow_Down
	}
	Blue = {
		name = button_b
		name_string = 'button_b'
		material_lip = sys_NowBar_Button01_Blue_Lip_sys_NowBar_Button01_Blue_Lip
		material_mid = sys_NowBar_Button01_Blue_Mid2_sys_NowBar_Button01_Blue_Mid2
		material_head = sys_NowBar_Head_Blue_sys_NowBar_Head_Blue
		material_head_lit = sys_NowBar_Head_BlueL_sys_NowBar_Head_BlueL
		material_neck = sys_NowBar_Neck01_sys_NowBar_Neck01
		material_down = sys_NowBar_Button01_Blue_Down_sys_NowBar_Button01_Blue_Down
	}
	Orange = {
		name = button_o
		name_string = 'button_o'
		material_lip = sys_NowBar_Button01_Orange_Lip_sys_NowBar_Button01_Orange_Lip
		material_mid = sys_NowBar_Button01_Orange_Mid2_sys_NowBar_Button01_Orange_Mid2
		material_head = sys_NowBar_Head_Orange_sys_NowBar_Head_Orange
		material_head_lit = sys_NowBar_Head_OrangeL_sys_NowBar_Head_OrangeL
		material_neck = sys_NowBar_Neck01_sys_NowBar_Neck01
		material_down = sys_NowBar_Button01_Orange_Down_sys_NowBar_Button01_Orange_Down
	}
}

script setup_highway \{ Player = 1 }
	generate_pos_table
	SetScreenElementLock \{ Id = root_window OFF }
	if ($current_num_players = 1)
		<Pos> = (0.0, 0.0)
		<Scale> = (1.0, 1.0)
	else
		if (<Player> = 1)
			<Pos> = ((0 - $x_offset_p2)* (1.0, 0.0))
		else
			if NOT ($devil_finish = 1)
				<Pos> = ($x_offset_p2 * (1.0, 0.0))
			else
				<Pos> = (1000.0, 0.0)
			endif
		endif
		<Scale> = (1.0, 1.0)
	endif
	<container_pos> = (<Pos> + (0.0, 720.0))
	FormatText ChecksumName = container_id 'gem_container%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = ContainerElement
		Id = <container_id>
		PARENT = root_window
		Pos = <container_pos>
		just = [ Left top ]
		Scale = <Scale>
		z_priority = 0
	}
	hpos = ((640.0 - ($highway_top_width / 2.0))* (1.0, 0.0))
	hDims = ($highway_top_width * (1.0, 0.0))
	<highway_material> = ($<player_status>.highway_material)
	FormatText ChecksumName = highway_name 'Highway_2D%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = SpriteElement
		Id = <highway_name>
		PARENT = <container_id>
		clonematerial = <highway_material>
		rgba = $highway_normal
		Pos = <hpos>
		dims = <hDims>
		just = [ Left Left ]
		z_priority = 0.1
	}
	highway_speed = (0.0 - ($gHighwayTiling / ($<player_status>.scroll_time - $destroy_time)))
	Printf "Setting highway speed to: %h" h = <highway_speed>
	Set2DHighwaySpeed Speed = <highway_speed> Id = <highway_name> player_status = <player_status>
	fe = ($highway_playline - $highway_height)
	fs = (<fe> + $highway_fade)
	Set2DHighwayFade Start = <fs> End = <fe> Id = <highway_name> Player = <Player>
	Pos = ((640 * (1.0, 0.0))+ ($highway_playline * (0.0, 1.0)))
	now_scale = (($nowbar_scale_x * (1.0, 0.0))+ ($nowbar_scale_y * (0.0, 1.0)))
	lpos = (($sidebar_x * (1.0, 0.0))+ ($sidebar_y * (0.0, 1.0)))
	langle = ($sidebar_angle)
	rpos = ((((640.0 - $sidebar_x)+ 640.0)* (1.0, 0.0))+ ($sidebar_y * (0.0, 1.0)))
	rangle = (0.0 - ($sidebar_angle))
	Scale = (($sidebar_x_scale * (1.0, 0.0))+ ($sidebar_y_scale * (0.0, 1.0)))
	rscale = (((0 - $sidebar_x_scale)* (1.0, 0.0))+ ($sidebar_y_scale * (0.0, 1.0)))
	FormatText ChecksumName = cont 'sidebar_container_left%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = ContainerElement
		Id = <cont>
		PARENT = <container_id>
		Pos = <lpos>
		rot_angle = <langle>
		just = [ center bottom ]
		z_priority = 3
	}
	FormatText ChecksumName = name 'sidebar_left%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = SpriteElement
		Id = <name>
		PARENT = <cont>
		Material = sys_sidebar2D_sys_sidebar2D
		rgba = [ 255 255 255 255 ]
		Pos = (0.0, 0.0)
		Scale = <Scale>
		just = [ center bottom ]
		z_priority = 3
	}
	Set2DGemFade Id = <name> Player = <Player>
	FormatText ChecksumName = cont 'starpower_container_left%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = ContainerElement
		Id = <cont>
		PARENT = <container_id>
		Pos = <lpos>
		rot_angle = <langle>
		just = [ center bottom ]
		z_priority = 3
	}
	starpower_pos = (((-55.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((55.0 * $starpower_fx_scale)* (0.0, 1.0)))
	starpower_scale = (((1.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((1.1 * $starpower_fx_scale)* (0.0, 1.0)))
	FormatText ChecksumName = name 'sidebar_left_glow%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = SpriteElement
		Id = <name>
		PARENT = <cont>
		Material = sys_Starpower_SDGLOW_sys_Starpower_SDGLOW
		rgba = [ 255 255 255 255 ]
		Pos = <starpower_pos>
		Scale = <starpower_scale>
		just = [ center bottom ]
		z_priority = 0
	}
	starpower_pos = (((0.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((0 * $starpower_fx_scale)* (0.0, 1.0)))
	starpower_scale = (((-0.5 * $starpower_fx_scale)* (1.0, 0.0))+ ((0.9 * $starpower_fx_scale)* (0.0, 1.0)))
	FormatText ChecksumName = name 'sidebar_left_Lightning01%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = SpriteElement
		Id = <name>
		PARENT = <cont>
		Material = sys_Big_Bolt01_sys_Big_Bolt01
		rgba = [ 0 0 128 128 ]
		Pos = <starpower_pos>
		rot_angle = (180)
		Scale = <starpower_scale>
		just = [ center top ]
		z_priority = 4
	}
	starpower_pos = (((0.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((0.0 * $starpower_fx_scale)* (0.0, 1.0)))
	starpower_scale = (((2.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((0.9 * $starpower_fx_scale)* (0.0, 1.0)))
	FormatText ChecksumName = name 'sidebar_left_Lightning02%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = SpriteElement
		Id = <name>
		PARENT = <cont>
		Material = sys_Big_Bolt01_sys_Big_Bolt01
		rgba = [ 255 255 255 255 ]
		Pos = <starpower_pos>
		rot_angle = (180)
		Scale = <starpower_scale>
		just = [ center top ]
		z_priority = 0.02
	}
	FormatText ChecksumName = cont 'sidebar_container_right%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = ContainerElement
		Id = <cont>
		PARENT = <container_id>
		Pos = <rpos>
		rot_angle = <rangle>
		just = [ center bottom ]
		z_priority = 3
	}
	FormatText ChecksumName = name 'sidebar_right%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = SpriteElement
		Id = <name>
		PARENT = <cont>
		Material = sys_sidebar2D_sys_sidebar2D
		rgba = [ 255 255 255 255 ]
		Pos = (0.0, 0.0)
		Scale = <rscale>
		just = [ center bottom ]
		z_priority = 3
	}
	Set2DGemFade Id = <name> Player = <Player>
	FormatText ChecksumName = cont 'starpower_container_right%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = ContainerElement
		Id = <cont>
		PARENT = <container_id>
		Pos = <rpos>
		rot_angle = <rangle>
		just = [ center bottom ]
		z_priority = 3
	}
	starpower_pos = (((55.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((55.0 * $starpower_fx_scale)* (0.0, 1.0)))
	starpower_scale = (((-1.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((1.1 * $starpower_fx_scale)* (0.0, 1.0)))
	FormatText ChecksumName = name 'sidebar_Right_glow%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = SpriteElement
		Id = <name>
		PARENT = <cont>
		Material = sys_Starpower_SDGLOW_sys_Starpower_SDGLOW
		rgba = [ 255 255 255 255 ]
		Pos = <starpower_pos>
		Scale = <starpower_scale>
		just = [ center bottom ]
		z_priority = 0
	}
	starpower_pos = (((0.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((0 * $starpower_fx_scale)* (0.0, 1.0)))
	starpower_scale = (((0.5 * $starpower_fx_scale)* (1.0, 0.0))+ ((0.9 * $starpower_fx_scale)* (0.0, 1.0)))
	FormatText ChecksumName = name 'sidebar_Right_Lightning01%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = SpriteElement
		Id = <name>
		PARENT = <cont>
		Material = sys_Big_Bolt01_sys_Big_Bolt01
		rgba = [ 0 0 128 128 ]
		Pos = <starpower_pos>
		rot_angle = (180)
		Scale = <starpower_scale>
		just = [ center top ]
		z_priority = 4
	}
	starpower_pos = (((0.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((0.0 * $starpower_fx_scale)* (0.0, 1.0)))
	starpower_scale = (((2.0 * $starpower_fx_scale)* (1.0, 0.0))+ ((0.9 * $starpower_fx_scale)* (0.0, 1.0)))
	FormatText ChecksumName = name 'sidebar_Right_Lightning02%p' p = <player_text> AddToStringLookup = TRUE
	CreateScreenElement {
		Type = SpriteElement
		Id = <name>
		PARENT = <cont>
		Material = sys_Big_Bolt01_sys_Big_Bolt01
		rgba = [ 255 255 255 255 ]
		Pos = <starpower_pos>
		rot_angle = (180)
		Scale = <starpower_scale>
		just = [ center top ]
		z_priority = 0.02
	}
	FormatText ChecksumName = cont 'starpower_container_left%p' p = <player_text> AddToStringLookup = TRUE
	DoScreenElementMorph Id = <cont> Alpha = 0
	FormatText ChecksumName = cont 'starpower_container_right%p' p = <player_text> AddToStringLookup = TRUE
	DoScreenElementMorph Id = <cont> Alpha = 0
	GetArraySize \{ $gem_colors }
	array_count = 0
	begin
		Color = ($gem_colors [ <array_count> ])
		if StructureContains Structure = ($button_up_models.<Color>)name = name
			if ($<player_status>.lefthanded_button_ups = 1)
				<pos2d> = ($button_up_models.<Color>.left_pos_2d)
			else
				<pos2d> = ($button_up_models.<Color>.pos_2d)
			endif
			Pos = (640.0, 643.0)
			FormatText ChecksumName = name_base '%s_base%p' s = ($button_up_models.<Color>.name_string)p = <player_text> AddToStringLookup = TRUE
			FormatText ChecksumName = name_string '%s_string%p' s = ($button_up_models.<Color>.name_string)p = <player_text> AddToStringLookup = TRUE
			FormatText ChecksumName = name_lip '%s_lip%p' s = ($button_up_models.<Color>.name_string)p = <player_text> AddToStringLookup = TRUE
			FormatText ChecksumName = name_mid '%s_mid%p' s = ($button_up_models.<Color>.name_string)p = <player_text> AddToStringLookup = TRUE
			FormatText ChecksumName = name_neck '%s_neck%p' s = ($button_up_models.<Color>.name_string)p = <player_text> AddToStringLookup = TRUE
			FormatText ChecksumName = name_head '%s_head%p' s = ($button_up_models.<Color>.name_string)p = <player_text> AddToStringLookup = TRUE
			<Pos> = (((<pos2d>.(1.0, 0.0))* (1.0, 0.0))+ (1024 * (0.0, 1.0)))
			if ($<player_status>.lefthanded_button_ups = 1)
				<playline_scale> = (((0 - <now_scale>.(1.0, 0.0))* (1.0, 0.0))+ (<now_scale>.(0.0, 1.0) * (0.0, 1.0)))
			else
				<playline_scale> = <now_scale>
			endif
			CreateScreenElement {
				Type = ContainerElement
				Id = <name_base>
				PARENT = <container_id>
				Pos = (0.0, 0.0)
				just = [ center bottom ]
				z_priority = 3
			}
			CreateScreenElement {
				Type = SpriteElement
				Id = <name_lip>
				PARENT = <name_base>
				Material = ($button_up_models.<Color>.material_lip)
				rgba = [ 255 255 255 255 ]
				Pos = <pos2d>
				Scale = <playline_scale>
				just = [ center bottom ]
				z_priority = 3.9
			}
			CreateScreenElement {
				Type = SpriteElement
				Id = <name_mid>
				PARENT = <name_base>
				Material = ($button_up_models.<Color>.material_mid)
				rgba = [ 255 255 255 255 ]
				Pos = <pos2d>
				Scale = <playline_scale>
				just = [ center bottom ]
				z_priority = 3.6
			}
			<y_scale> = ($neck_lip_add / $neck_sprite_size)
			<Pos> = (<pos2d> - ($neck_lip_base * (0.0, 1.0)))
			<neck_scale> = (((<playline_scale>.(1.0, 0.0))* (1.0, 0.0))+ (<y_scale> * (0.0, 1.0)))
			CreateScreenElement {
				Type = SpriteElement
				Id = <name_neck>
				PARENT = <name_base>
				Material = ($button_up_models.<Color>.material_neck)
				rgba = [ 255 255 255 255 ]
				Pos = <Pos>
				Scale = <neck_scale>
				just = [ center bottom ]
				z_priority = 3.7
			}
			CreateScreenElement {
				Type = SpriteElement
				Id = <name_head>
				PARENT = <name_base>
				Material = ($button_up_models.<Color>.material_head)
				rgba = [ 255 255 255 255 ]
				Pos = <pos2d>
				Scale = <playline_scale>
				just = [ center bottom ]
				z_priority = 3.8
			}
			string_pos2d = ($button_up_models.<Color>.pos_2d)
			<string_scale> = (($string_scale_x * (1.0, 0.0))+ ($string_scale_y * (0.0, 1.0)))
			CreateScreenElement {
				Type = SpriteElement
				Id = <name_string>
				PARENT = <container_id>
				Material = sys_String01_sys_String01
				rgba = [ 200 200 200 200 ]
				Scale = <string_scale>
				rot_angle = ($button_models.<Color>.Angle)
				Pos = <string_pos2d>
				just = [ center bottom ]
				z_priority = 2
			}
		endif
		array_count = (<array_count> + 1)
	repeat <array_Size>
	SpawnScriptLater move_highway_2d Params = { <...>  }
	create_highway_prepass <...>
	SetScreenElementLock \{ Id = root_window ON }
endscript

script destroy_highway
	killspawnedscript \{ name = MoveGem }
	destroy_highway_prepass <...>
	FormatText ChecksumName = name 'Highway_2D%p' p = <player_text> AddToStringLookup = TRUE
	if ScreenElementExists Id = <name>
		DestroyScreenElement Id = <name>
	endif
	FormatText ChecksumName = name 'gem_container%p' p = <player_text> AddToStringLookup = TRUE
	if ScreenElementExists Id = <name>
		DestroyScreenElement Id = <name>
	endif
	FormatText ChecksumName = name 'Gem_basebar%p' p = <player_text> AddToStringLookup = TRUE
	if ScreenElementExists Id = <name>
		DestroyScreenElement Id = <name>
	endif
	GetArraySize \{ $gem_colors }
	array_count = 0
	begin
		Color = ($gem_colors [ <array_count> ])
		if StructureContains Structure = ($button_up_models.<Color>)name = name_string
			FormatText ChecksumName = name '%s%p' s = ($button_up_models.<Color>.name_string)p = <player_text> AddToStringLookup = TRUE
			if ScreenElementExists Id = <name>
				DestroyScreenElement Id = <name>
			endif
		endif
		array_count = (<array_count> + 1)
	repeat <array_Size>
endscript
prepass_camera_pos = (500.0, -100.0, -100.0)
prepass_border = 8

script calculate_prepass_poly_params \{ x_offset = 0 }
	prepass_mdl_top_width = 1
	prepass_mdl_bottom_width = 3.5
	prepass_mdl_height = 1
	w0 = ($highway_top_width)
	highway_slope = (<w0> * $widthOffsetFactor / $highway_height)
	highway_start = ($highway_playline - $highway_height)
	prepass_start = ($highway_fade + $prepass_border)
	prepass_top_width = (<w0> + <highway_slope> * <prepass_start> -2 * $prepass_border)
	tan_theta = 0.674
	prepass_z_offset = (<prepass_mdl_top_width> / (<tan_theta> * <prepass_top_width> / 640))
	prepass_y_offset = ((360 - (<highway_start> + <prepass_start>))* <prepass_z_offset> * <tan_theta> / 640)
	prepass_x_offset = (<x_offset> * <prepass_z_offset> * <tan_theta> / 640)
	prepass_y_scale = ((<prepass_mdl_bottom_width> - <prepass_mdl_top_width>)/ (<prepass_mdl_height> * <highway_slope>))
	return prepass_offset = (<prepass_z_offset> * (0.0, 0.0, 1.0) + <prepass_y_offset> * (0.0, 1.0, 0.0) + <prepass_x_offset> * (-1.0, 0.0, 0.0))prepass_scale = ((1.0, 0.0, 1.0) + <prepass_y_scale> * (0.0, 1.0, 0.0))
endscript

script calculate_prepass_offset
	GetScreenElementProps Id = <screen_element>
	tan_theta = 0.674
	x_screen = (<Pos>.(1.0, 0.0))
	y_screen = (360 - ($highway_playline - $highway_height + $highway_fade + $prepass_border + <Pos>.(0.0, 1.0)))
	prepass_x_offset = (<x_screen> * <distance> * <tan_theta> / 640)
	prepass_y_offset = (<y_screen> * <distance> * <tan_theta> / 640)
	return prepass_offset = (<prepass_x_offset> * (-1.0, 0.0, 0.0) + <prepass_y_offset> * (0.0, 1.0, 0.0) + <distance> * (0.0, 0.0, 1.0))
endscript

script update_prepass_position
	<Obj> ::Obj_GetPosition
	prepass_distance = (<Pos>.(0.0, 0.0, 1.0) - $prepass_camera_pos.(0.0, 0.0, 1.0))
	calculate_prepass_offset screen_element = <elem> distance = <prepass_distance>
	<Obj> ::Obj_SetPosition Position = (<prepass_offset> + $prepass_camera_pos)
	<Obj> ::obj_updatemodel
endscript

script update_highway_prepass
	if CompositeObjectExists \{ highway_prepassp1 }
		update_prepass_position \{ Obj = highway_prepassp1 elem = gem_containerp1 }
	endif
	if CompositeObjectExists \{ highway_prepassp2 }
		update_prepass_position \{ Obj = highway_prepassp2 elem = gem_containerp2 }
	endif
endscript

script create_highway_prepass_object \{ roty = 0 }
	FormatText ChecksumName = highway_prepass_name 'highway_prepass%p' p = <player_text> AddToStringLookup = TRUE
	FormatText ChecksumName = container_id 'gem_container%p' p = <player_text> AddToStringLookup = TRUE
	calculate_prepass_poly_params <...>
	CreateCompositeObjectInstance {
		Priority = $COIM_Priority_Permanent
		Heap = Generic
		Components = [
			{Component = Model LightGroup = highway}
		]
		Params = {
			name = <highway_prepass_name>
			Model = 'Props\\highway\\highway_prepass\\highway_prepass.mdl'
			Pos = (<cam_pos> + <prepass_offset>)
			SuspendDistance = 60
			lod_dist1 = 10
			lod_dist2 = 100
			object_type = highway
			profilebudget = 20
		}
	}
	<highway_prepass_name> ::Obj_SetOrientation Y = 180
	<highway_prepass_name> ::Obj_EnableScaling
	<highway_prepass_name> ::Obj_ApplyScaling Scale = <prepass_scale>
	<highway_prepass_name> ::Obj_SetBoundingSphere 1000.0
	<highway_prepass_name> ::Obj_SetNoSizeCull
endscript

script create_highway_prepass
	<cam_pos> = ($prepass_camera_pos)
	if ($current_num_players = 1)
		<style> = highway_prepass_rendering_1p
		create_highway_prepass_object <...>
	else
		<style> = highway_prepass_rendering_1p
		if (<Player> = 1)
			create_highway_prepass_object <...> player_text = 'p1' x_offset = (<container_pos>.(1.0, 0.0))
		else
			create_highway_prepass_object <...> player_text = 'p2' x_offset = (<container_pos>.(1.0, 0.0))
		endif
	endif
	if (<Player> = 1)
		<highway_cam> = {
			LockTo = World
			Pos = <cam_pos>
			Facing = (0.0, 0.0, 1.0)
			FOV = 68.0
		}
		texture = highway_prepass_texture
		ExtendCRC <texture> <player_text> out = texture
		AddPrepassViewport viewport = bg_viewport style = <style>
		FormatText ChecksumName = Camera 'highway_prepass_camera%p' p = <player_text> AddToStringLookup = TRUE
		CreateCompositeObjectInstance {
			Priority = $COIM_Priority_Permanent
			Heap = Generic
			Components = [
				{
					Component = CinematicCamera
					UpdateWhenCameraInactive = TRUE
					Enabled = TRUE
				}
				{
					Component = Camera
				}
			]
			Params = {
				name = <Camera>
				object_type = highway
				profilebudget = 20
				use_jq
			}
		}
		SetPrepassViewportCamera viewport = bg_viewport Id = <Camera> prepass = (<Player> - 1)
		<Camera> ::UnPause
		<Camera> ::CCam_DoMorph <highway_cam>
		<Camera> ::Obj_ForceUpdate
		enable_highway_prepass
	endif
endscript

script destroy_highway_prepass
	if (<Player> = 1)
		RemovePrepassViewport \{ viewport = bg_viewport }
	endif
	FormatText ChecksumName = name 'highway_prepass%p' p = <player_text> AddToStringLookup = TRUE
	if CompositeObjectExists name = <name>
		<name> ::DIE
	endif
	FormatText ChecksumName = name 'highway_prepass_camera%p' p = <player_text> AddToStringLookup = TRUE
	if CompositeObjectExists name = <name>
		<name> ::DIE
	endif
	SetViewportProperties \{ viewport = bg_viewport clear_colorbuffer = TRUE }
	SetViewportProperties \{ viewport = bg_viewport clear_depthstencilbuffer = TRUE }
endscript

script disable_highway_prepass
	GetDisplaySettings
	if (<widescreen> = TRUE)
		if ViewportExists \{ Id = bg_viewport }
			if PrepassViewportExists \{ viewport = bg_viewport }
				SetViewportProperties \{ viewport = bg_viewport clear_colorbuffer = TRUE }
				SetViewportProperties \{ viewport = bg_viewport clear_depthstencilbuffer = TRUE }
				SetViewportProperties \{ viewport = bg_viewport prepass = 0 Active = FALSE }
				SetViewportProperties \{ viewport = bg_viewport prepass = 1 Active = FALSE }
			endif
		endif
	endif
endscript

script enable_highway_prepass
	GetDisplaySettings
	if (<widescreen> = TRUE)
		if ViewportExists \{ Id = bg_viewport }
			if PrepassViewportExists \{ viewport = bg_viewport }
				SetViewportProperties \{ viewport = bg_viewport clear_colorbuffer = FALSE }
				SetViewportProperties \{ viewport = bg_viewport clear_depthstencilbuffer = FALSE }
				SetViewportProperties \{ viewport = bg_viewport prepass = 0 Active = TRUE }
				SetViewportProperties \{ viewport = bg_viewport prepass = 1 Active = TRUE }
			endif
		endif
	endif
endscript
start_2d_move = 0

script move_highway_2d
	Change \{ start_2d_move = 0 }
	begin
		if ($start_2d_move = 1)
			break
		endif
		wait \{ 1 GameFrame }
	repeat
	highway_start_y = 720
	pos_start_orig = 0
	pos_add = -720
	elapsed_time = 0.0
	begin
		<Pos> = (((<container_pos>.(1.0, 0.0))* (1.0, 0.0))+ (<highway_start_y> * (0.0, 1.0)))
		SetScreenElementProps Id = <container_id> Pos = <Pos>
		GetDeltaTime \{ ignore_slomo }
		<elapsed_time> = (<elapsed_time> + <delta_time>)
		<scaled_time> = (<elapsed_time> / 1.3)
		if (<scaled_time> > 1.0)
			<scaled_time> = 1.0
		endif
		ln (1.005 - <scaled_time>)
		<speed_modifier> = ((<ln> * 0.25)+ 1.0)
		if (<speed_modifier> < 0.05)
			<speed_modifier> = 0.05
		endif
		<highway_start_y> = (<highway_start_y> + (<pos_add> * <delta_time> * <speed_modifier>))
		if (<highway_start_y> <= <pos_start_orig>)
			<Pos> = (((<container_pos>.(1.0, 0.0))* (1.0, 0.0))+ (<pos_start_orig> * (0.0, 1.0)))
			SetScreenElementProps Id = <container_id> Pos = <Pos>
			break
		endif
		wait \{ 1 GameFrame }
	repeat
endscript

script move_highway_camera_to_default \{ Player = 1 }
	Change \{ start_2d_move = 1 }
endscript

script disable_bg_viewport_properties
	SetViewportProperties \{ viewport = bg_viewport clear_colorbuffer = TRUE }
	SetViewportProperties \{ viewport = bg_viewport clear_depthstencilbuffer = TRUE }
	if PrepassViewportExists \{ viewport = bg_viewport }
		SetViewportProperties \{ viewport = bg_viewport prepass = 0 Active = FALSE }
		SetViewportProperties \{ viewport = bg_viewport prepass = 1 Active = FALSE }
	endif
endscript

script disable_highway
	if ScreenElementExists \{ Id = gem_containerp1 }
		DoScreenElementMorph \{ Id = gem_containerp1 Alpha = 0 }
	endif
	if ScreenElementExists \{ Id = gem_containerp2 }
		DoScreenElementMorph \{ Id = gem_containerp2 Alpha = 0 }
	endif
	if ScreenElementExists \{ Id = HUD_2D_Containerp1 }
		DoScreenElementMorph \{ Id = HUD_2D_Containerp1 Alpha = 0 }
	endif
	if ScreenElementExists \{ Id = HUD_2D_Containerp2 }
		DoScreenElementMorph \{ Id = HUD_2D_Containerp2 Alpha = 0 }
	endif
	if ScreenElementExists \{ Id = battle_alert_containerp1 }
		DoScreenElementMorph \{ Id = battle_alert_containerp1 Alpha = 0 }
	endif
	if ScreenElementExists \{ Id = battle_alert_containerp2 }
		DoScreenElementMorph \{ Id = battle_alert_containerp2 Alpha = 0 }
	endif
endscript

script disable_bg_viewport
	disable_highway <...>
	kill_dummy_bg_camera
	ui_clip_root ::SetProps \{ Hide }
	disable_bg_viewport_properties
	SetActiveCamera \{ Id = viewer_cam viewport = bg_viewport }
endscript

script enable_bg_viewport_properties
	if PrepassViewportExists \{ viewport = bg_viewport }
		SetViewportProperties \{ viewport = bg_viewport clear_colorbuffer = FALSE }
		SetViewportProperties \{ viewport = bg_viewport clear_depthstencilbuffer = FALSE }
		SetViewportProperties \{ viewport = bg_viewport no_resolve_depthstencilbuffer = TRUE }
		SetViewportProperties \{ viewport = bg_viewport no_resolve_colorbuffer = TRUE }
		SetViewportProperties \{ viewport = bg_viewport prepass = 0 Active = TRUE }
		SetViewportProperties \{ viewport = bg_viewport prepass = 1 Active = TRUE }
	else
		SetViewportProperties \{ viewport = bg_viewport clear_colorbuffer = TRUE }
		SetViewportProperties \{ viewport = bg_viewport clear_depthstencilbuffer = TRUE }
		SetViewportProperties \{ viewport = bg_viewport no_resolve_depthstencilbuffer = TRUE }
		SetViewportProperties \{ viewport = bg_viewport no_resolve_colorbuffer = TRUE }
	endif
	TOD_Proxim_Update_LightFX_Viewport \{ fxParam = $Default_TOD_Manager viewport = bg_viewport Time = 0 }
endscript

script enable_highway
	if ScreenElementExists \{ Id = gem_containerp1 }
		DoScreenElementMorph \{ Id = gem_containerp1 Alpha = 1 }
	endif
	if ScreenElementExists \{ Id = gem_containerp2 }
		DoScreenElementMorph \{ Id = gem_containerp2 Alpha = 1 }
	endif
	if ScreenElementExists \{ Id = HUD_2D_Containerp1 }
		DoScreenElementMorph \{ Id = HUD_2D_Containerp1 Alpha = 1 }
	endif
	if ScreenElementExists \{ Id = HUD_2D_Containerp2 }
		DoScreenElementMorph \{ Id = HUD_2D_Containerp2 Alpha = 1 }
	endif
	if ScreenElementExists \{ Id = battle_alert_containerp1 }
		DoScreenElementMorph \{ Id = battle_alert_containerp1 Alpha = 1 }
	endif
	if ScreenElementExists \{ Id = battle_alert_containerp2 }
		DoScreenElementMorph \{ Id = battle_alert_containerp2 Alpha = 1 }
	endif
endscript

script enable_bg_viewport
	enable_highway <...>
	enable_bg_viewport_properties
	ui_clip_root ::SetProps \{ Unhide }
endscript

script destroy_bg_viewport
	kill_dummy_bg_camera
	if ScreenElementExists \{ Id = ui_clip_root }
		DestroyScreenElement \{ Id = ui_clip_root }
	endif
	SetScreenMode \{ one_camera }
	SetViewportProperties \{ viewport = 0 clear_colorbuffer = TRUE }
	SetViewportProperties \{ viewport = 0 no_resolve_depthstencilbuffer = FALSE }
endscript
Highway_Fader_Params = {
	style = highway_fader
	rt_size = (1280.0, 720.0)
	rt_offset = (0.0, 0.0)
	clip_dims = (256.0, 256.0)
	clip_offset = (0.0, -64.0)
	mask_dims = (512.0, 200.0)
}
Highway_Fader_Params_2p = {
	style = highway_fader_2p
	rt_size = (1280.0, 720.0)
	rt_offset = (0.0, 0.0)
	clip_dims = (1024.0, 200.0)
	clip_offset = (0.0, 0.0)
	mask_dims = (1280.0, 200.0)
}
Highway_Fader_Params_ps3 = {
	style = highway_fader_ps3
	rt_size = (1280.0, 720.0)
	rt_offset = (0.0, 0.0)
	clip_dims = (256.0, 256.0)
	clip_offset = (0.0, -64.0)
	mask_dims = (512.0, 200.0)
}
Highway_Fader_Params_2p_ps3 = {
	style = highway_fader_2p_ps3
	rt_size = (1280.0, 720.0)
	rt_offset = (0.0, 0.0)
	clip_dims = (832.0, 200.0)
	clip_offset = (0.0, 0.0)
	mask_dims = (1040.0, 200.0)
}

script setup_bg_viewport
	Printf \{ "Setting bg viewport" }
	destroy_bg_viewport
	if IsXenon
		if ($current_num_players = 1)
			AddParams \{ $Highway_Fader_Params }
		else
			AddParams \{ $Highway_Fader_Params_2p }
		endif
	else
		if ($current_num_players = 1)
			AddParams \{ $Highway_Fader_Params_ps3 }
		else
			AddParams \{ $Highway_Fader_Params_2p_ps3 }
		endif
	endif
	Pos = (2000.0, 300.0)
	Pos = (<Pos> + <clip_offset>)
	mask_pos = (<clip_dims> * 0.5 - <clip_offset>)
	bg_pos = (<clip_dims> * 0.5 - <Pos> + <rt_offset>)
	if NOT ScreenElementExists \{ Id = ui_clip_root }
		CreateScreenElement {
			PARENT = root_window
			Type = WindowElement
			Id = ui_clip_root
			just = [ center center ]
			Pos = <Pos>
			dims = <clip_dims>
		}
		CreateMaskedScreenElements {
			z_priority = -10
			mask_element = {
				Id = viewport_mask_sprite
				PARENT = ui_clip_root
				Type = SpriteElement
				Pos = <mask_pos>
				just = [ center center ]
				dims = <mask_dims>
				rgba = [ 255 255 255 255 ]
				Alpha = 1
				z_priority = 110
				texture = white2
				rot_angle = -180
			}
			elements = [
				{
					PARENT = ui_clip_root
					Type = ViewportElement
					Id = bg_viewport
					texture = viewport0
					Pos = <bg_pos>
					just = [ Left top ]
					dims = <rt_size>
					rgba = [ 128 128 128 255 ]
					Alpha = 1
					has_shadow = TRUE
					draw_debug_lines = TRUE
					show_lightvolumes = TRUE
					style = <style>
				}
			]
		}
	endif
	enable_bg_viewport_properties
	Printf \{ "Setting bg viewport end" }
endscript
highway_pulse_p1 = 0
highway_pulse_p2 = 0

script highway_pulse_multiplier_loss \{ player_text = 'p1' multiplier = 1 }
	if ($game_mode = p2_battle || $boss_battle = 1)
		return
	endif
	Time = 0.1
	switch <multiplier>
		case 1
			push_pos = (0.0, 3.0)
		case 2
			push_pos = (0.0, 4.0)
		case 3
			push_pos = (0.0, 10.0)
		case 4
			push_pos = (0.0, 15.0)
			Time = 0.11
		default
			push_pos = (0.0, 3.0)
	endswitch
	if (($game_mode = p2_faceoff)|| ($game_mode = p2_pro_faceoff)|| ($game_mode = p2_career)|| ($game_mode = p2_coop))
		<push_pos> = (<push_pos> * 0.6)
	endif
	if (<player_text> = 'p1')
		highway_pulse = $highway_pulse_p1
	else
		highway_pulse = $highway_pulse_p2
	endif
	if (<highway_pulse> = 0)
		Change \{ highway_pulse = 1 }
		FormatText ChecksumName = container_id 'gem_container%p' p = <player_text> AddToStringLookup = TRUE
		GetScreenElementPosition Id = <container_id>
		original_position = <ScreenElementPos>
		GetRandomValue \{ name = random_x a = -7 b = 7 Integer }
		DoScreenElementMorph {Id = <container_id> Pos = (<original_position> + <push_pos> + ((1.0, 0.0) * <random_x>))just = [ center bottom ] Time = <Time>}
		wait <Time> seconds
		GetRandomValue \{ name = random_x a = -7 b = 7 Integer }
		DoScreenElementMorph {Id = <container_id> Pos = (<original_position> - (<push_pos> * 0.7)+ ((1.0, 0.0) * <random_x>))just = [ center bottom ] Time = <Time>}
		wait <Time> seconds
		GetRandomValue \{ name = random_x a = -5 b = 5 Integer }
		DoScreenElementMorph {Id = <container_id> Pos = (<original_position> + (<push_pos> * 0.4)+ ((1.0, 0.0) * <random_x>))just = [ center bottom ] Time = <Time>}
		wait <Time> seconds
		GetRandomValue \{ name = random_x a = -5 b = 5 Integer }
		DoScreenElementMorph {Id = <container_id> Pos = (<original_position> - (<push_pos> * 0.3)+ ((1.0, 0.0) * <random_x>))just = [ center bottom ] Time = <Time>}
		wait <Time> seconds
		GetRandomValue \{ name = random_x a = -3 b = 3 Integer }
		DoScreenElementMorph {Id = <container_id> Pos = (<original_position> + (<push_pos> * 0.2)+ ((1.0, 0.0) * <random_x>))just = [ center bottom ] Time = <Time>}
		wait <Time> seconds
		DoScreenElementMorph {Id = <container_id> Pos = <original_position> just = [ center bottom ] Time = <Time>}
	endif
	Change \{ highway_pulse = 0 }
endscript

script highway_visible
	Change \{ highwayvisible = ON }
endscript

script highway_invisible
	Change \{ highwayvisible = OFF }
endscript
