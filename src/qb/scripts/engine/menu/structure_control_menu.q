
script create_vmenu_with_title \{PARENT = root_window text = "Default Title" vmenu_id = structure_control_vmenu Scale = 1.8 padding_scale = 0.8 internal_scale = 0.5 Pos = (50.0, 180.0) dims = (200.0, 100.0) internal_just = [ Left top ] just = [ Left top ] title_color = [ 240 90 8 255 ] title_scale = 0.7}
	SetScreenElementLock Id = <PARENT> OFF
	CreateScreenElement {
		Type = VMenu
		PARENT = <PARENT>
		Id = <vmenu_id>
		font = text_a1
		just = [ Left top ]
		Pos = <Pos>
		Scale = <Scale>
		padding_scale = <padding_scale>
		internal_scale = <internal_scale>
		internal_just = <internal_just>
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = <vmenu_id>
		font = text_a1
		text = <text>
		Scale = <title_scale>
		rgba = <title_color>
		not_focusable
	}
	AssignAlias Id = <vmenu_id> alias = current_menu
endscript

script structure_control_menu_create \{title_color = [ 240 90 8 255 ] label_color = [ 176 210 224 255 ] value_color = [ 255 255 255 255 ] run_callback_on_create = 0}
	create_vmenu_with_title <...>
	SetScreenElementProps {
		Id = current_menu
		event_handlers = [
			{pad_back <pad_back_script> Params = <pad_back_params>}
			{ pad_square structure_control_menu_toggle_link }
			{ pad_choose structure_control_menu_toggle_step_speed }
		]
		Replace_Handlers
	}
	current_menu ::SetTags label_color = <label_color> value_color = <value_color>
	structure_control_menu_toggle_link
	structure_control_menu_toggle_step_speed
	if NOT GlobalExists name = <Structure> Type = Structure
		ScriptAssert "global structure '%s' does not exist!" s = <Structure>
	endif
	GetArraySize \{ control_items }
	i = 0
	begin
		structure_control_menu_add_item {
			menu_callback = <callback>
			menu_structure = <Structure>
			index_item_labels = <index_item_labels>
			(<control_items> [ <i> ])
		}
		i = (<i> + 1)
	repeat <array_Size>
	if GotParam \{ choose_items }
		ForEachIn <choose_items> do = structure_control_menu_add_choose_item
	endif
	if (<run_callback_on_create> = 1)
		<callback> <Structure>
	endif
	LaunchEvent \{ Type = Focus Target = current_menu }
endscript

script structure_control_menu_refresh \{ Id = current_menu }
	if NOT ScreenElementExists Id = <Id>
		return
	endif
	GetScreenElementChildren Id = <Id>
	GetArraySize \{ children }
	i = 0
	begin
		RunScriptOnScreenElement Id = (<children> [ <i> ])structure_control_menu_control_item_refresh
		i = (<i> + 1)
	repeat <array_Size>
endscript

script structure_control_menu_toggle_link
	values_linked = 1
	current_menu ::GetSingleTag \{ values_linked }
	if (<values_linked> = 0)
		current_menu ::SetTags \{ values_linked = 1 }
	else
		current_menu ::SetTags \{ values_linked = 0 }
	endif
endscript

script structure_control_menu_toggle_step_speed
	if current_menu ::GetSingleTag \{ choose_action_override }
		<choose_action_override> ::structure_control_menu_choose_item_action
	else
		step_speed = 1
		current_menu ::GetSingleTag \{ step_speed }
		if (<step_speed> = 10)
			current_menu ::SetTags \{ step_speed = 1 }
		else
			current_menu ::SetTags \{ step_speed = 10 }
		endif
	endif
endscript

script structure_control_menu_verify_presence
	if NOT StructureContains Structure = (<Structure>)<param>
		ScriptAssert \{ "param does not exist in given structure! look above for details" }
	endif
	if GlobalExists name = <param>
		ScriptAssert \{ "you can't have a param name that conflicts with a global. this causes script interpreter errors" }
	endif
endscript

script structure_control_menu_add_item \{text = "Default Param Name" min = 1 Max = 10 range_loop = 0 step = 1}
	if GotParam \{ separator }
		CreateScreenElement \{Type = TextElement PARENT = current_menu text = " " font = text_a1 Scale = 0.4 not_focusable}
		return
	endif
	if NOT GotParam \{ callback }
		callback = <menu_callback>
	endif
	if NOT GotParam \{ Structure }
		Structure = <menu_structure>
	endif
	structure_control_menu_verify_presence Structure = <Structure> param = <param>
	if IsArray (<Structure>.<param>)
		GetArraySize (<Structure>.<param>)
		i = 0
		begin
			if GotParam \{ index_item_labels }
				sub = (<index_item_labels> [ <i> ])
			else
				sub = <i>
			endif
			FormatText textname = new_text "%s(%i)" s = <text> i = <sub>
			MangleChecksums a = <param> b = <i>
			structure_control_menu_add_control_item {
				<...>
				array_param_index = <i>
				array_param_size = <array_Size>
				text = <new_text>
				Id = <mangled_ID>
			}
			i = (<i> + 1)
		repeat <array_Size>
	else
		structure_control_menu_add_control_item {
			<...>
			text = <text>
			Id = <param>
		}
	endif
endscript

script structure_control_menu_add_choose_item \{ text = "Default Text" }
	current_menu ::GetSingleTag \{ label_color }
	CreateScreenElement {
		Type = TextElement
		PARENT = current_menu
		local_id = <Id>
		text = <text>
		font = text_a1
		Scale = 0.4
		rgba = <label_color>
		<focusable>
		event_handlers = [
			{ Focus structure_control_menu_choose_item_focus }
			{ unfocus structure_control_menu_choose_item_unfocus }
		]
	}
	<Id> ::SetTags {
		action = {
			pad_choose_script = <pad_choose_script>
			pad_choose_params = <pad_choose_params>
		}
	}
endscript

script structure_control_menu_add_control_item
	control_params = <...>
	current_menu ::GetSingleTag \{ label_color }
	CreateScreenElement {
		Type = TextElement
		PARENT = current_menu
		local_id = <Id>
		text = <text>
		font = text_a1
		Scale = 0.4
		rgba = <label_color>
		event_handlers = [
			{ Focus structure_control_menu_control_item_focus }
			{ unfocus structure_control_menu_control_item_unfocus }
		]
	}
	PARENT = <Id>
	<PARENT> ::SetTags control_params = <control_params>
	current_menu ::GetSingleTag \{ value_color }
	CreateScreenElement {
		Type = TextElement
		PARENT = <PARENT>
		local_id = value_display
		font = text_a1
		just = [ center top ]
		Pos = (450.0, 0.0)
		text = " "
		rgba = <value_color>
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <PARENT>
		local_id = left_arrow
		texture = left_arrow
		rgba = <label_color>
		Pos = (375.0, 5.0)
		just = [ Right top ]
		Scale = 0.75
		Alpha = 0
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = <PARENT>
		local_id = right_arrow
		texture = right_arrow
		rgba = <label_color>
		Pos = (525.0, 5.0)
		just = [ Left top ]
		Scale = 0.75
		Alpha = 0
	}
	SetScreenElementProps {
		Id = <PARENT>
		event_handlers = [{pad_left structure_control_menu_control_item_change Params = { Left }}
			{pad_right structure_control_menu_control_item_change Params = { Right }}
		]
		Replace_Handlers
	}
	<PARENT> ::structure_control_menu_control_item_refresh
endscript

script structure_control_menu_find_existing_value_index
	if GotParam \{ values }
		GetArraySize \{ values }
		num_values = <array_Size>
		GetArraySize \{ value_labels }
		if NOT (<num_values> = <array_Size>)
			ScriptAssert \{ "Mismatch in size of values and value_labels!" }
		endif
		selection_index = -1
		i = 0
		begin
			if ((<values> [ <i> ])= <value>)
				selection_index = <i>
			endif
			i = (<i> + 1)
		repeat <num_values>
		if (<selection_index> < 0)
			ScriptAssert \{ "current param value not found in item options" }
		endif
		SetTags selection_index = <selection_index>
	endif
endscript

script structure_control_menu_control_item_change
	Obj_GetID
	GetSingleTag \{ control_params }
	current_menu ::GetSingleTag \{ step_speed }
	if GotParam \{ Left }
		DoScreenElementMorph Id = {<ObjID> child = right_arrow}Alpha = 1
		DoScreenElementMorph Id = {<ObjID> child = left_arrow}Alpha = 0
		if StructureContains \{ Structure = control_params values }
			GetSingleTag \{ selection_index }
			selection_index = (<selection_index> -1)
			GetArraySize (<control_params>.values)
			if (<selection_index> < 0)
				if ((<control_params>.range_loop)= 1)
					selection_index = (<array_Size> -1)
					DoScreenElementMorph Id = {<ObjID> child = left_arrow}Alpha = 1 Time = 0.3
				else
					selection_index = 0
				endif
			else
				if ((<selection_index> > 0)|| ((<control_params>.range_loop)= 1))
					DoScreenElementMorph Id = {<ObjID> child = left_arrow}Alpha = 1 Time = 0.3
				endif
			endif
			new_value = (<control_params>.values [ <selection_index> ])
			SetTags selection_index = <selection_index>
		else
			new_value = ((<control_params>.value)- ((<control_params>.step)* <step_speed>))
			if NOT (<new_value> > (<control_params>.min))
				if ((<control_params>.range_loop)= 1)
					new_value = ((<control_params>.Max)+ <new_value>)
					DoScreenElementMorph Id = {<ObjID> child = left_arrow}Alpha = 1 Time = 0.3
				else
					new_value = (<control_params>.min)
				endif
			else
				DoScreenElementMorph Id = {<ObjID> child = left_arrow}Alpha = 1 Time = 0.3
			endif
		endif
	endif
	if GotParam \{ Right }
		DoScreenElementMorph Id = {<ObjID> child = right_arrow}Alpha = 0
		DoScreenElementMorph Id = {<ObjID> child = left_arrow}Alpha = 1
		if StructureContains \{ Structure = control_params values }
			GetSingleTag \{ selection_index }
			selection_index = (<selection_index> + 1)
			GetArraySize (<control_params>.values)
			if NOT (<selection_index> < <array_Size>)
				if ((<control_params>.range_loop)= 1)
					selection_index = 0
					DoScreenElementMorph Id = {<ObjID> child = right_arrow}Alpha = 1 Time = 0.3
				else
					selection_index = (<array_Size> -1)
				endif
			else
				if ((<selection_index> < (<array_Size> -1))|| ((<control_params>.range_loop)= 1))
					DoScreenElementMorph Id = {<ObjID> child = right_arrow}Alpha = 1 Time = 0.3
				endif
			endif
			new_value = (<control_params>.values [ <selection_index> ])
			SetTags selection_index = <selection_index>
		else
			new_value = ((<control_params>.value)+ ((<control_params>.step)* <step_speed>))
			if NOT (<new_value> < (<control_params>.Max))
				if ((<control_params>.range_loop)= 1)
					new_value = (<new_value> - (<control_params>.Max))
					DoScreenElementMorph Id = {<ObjID> child = right_arrow}Alpha = 1 Time = 0.3
				else
					new_value = (<control_params>.Max)
				endif
			else
				DoScreenElementMorph Id = {<ObjID> child = right_arrow}Alpha = 1 Time = 0.3
			endif
		endif
	endif
	structure_control_menu_change_structure new_value = <new_value>
endscript

script structure_control_menu_change_structure
	GetSingleTag \{ control_params }
	Structure = (<control_params>.Structure)
	param = (<control_params>.param)
	param_links = (<control_params>.param_links)
	value = <new_value>
	Index = (<control_params>.array_param_index)
	structure_control_menu_apply_param_change param {
		Structure = <Structure>
		param = <param>
		new_value = <value>
		Index = <Index>
	}
	current_menu ::GetSingleTag \{ values_linked }
	if (<values_linked> = 1)
		if GotParam \{ Index }
			i = 0
			begin
				if NOT (<i> = <Index>)
					structure_control_menu_apply_param_change param {
						Structure = <Structure>
						param = <param>
						new_value = <value>
						Index = <i>
					}
				endif
				i = (<i> + 1)
			repeat (<control_params>.array_param_size)
		endif
		if GotParam \{ param_links }
			i = 0
			GetArraySize \{ param_links }
			begin
				structure_control_menu_apply_param_change param {
					Structure = <Structure>
					param = (<param_links> [ <i> ])
					new_value = <value>
					Index = <Index>
				}
				i = (<i> + 1)
			repeat <array_Size>
		endif
	endif
	(<control_params>.callback)(<Structure>)
endscript

script structure_control_menu_apply_param_change
	structure_control_menu_verify_presence Structure = <Structure> param = <param>
	Id = <param>
	if GotParam \{ Index }
		array_value = (<Structure>.<param>)
		SetArrayElement ArrayName = array_value Index = <Index> NewValue = <new_value>
		AddParam name = <param> structure_name = new_params value = <array_value>
		MangleChecksums a = <param> b = <Index>
		Id = <mangled_ID>
	else
		AddParam name = <param> structure_name = new_params value = <new_value>
	endif
	Change GlobalName = <Structure> NewValue = {(<Structure>)<new_params>}
	RunScriptOnScreenElement Id = {current_menu child = <Id>}structure_control_menu_control_item_refresh
endscript

script structure_control_menu_control_item_refresh
	Obj_GetID
	if NOT GetSingleTag \{ control_params }
		return
	endif
	Structure = (<control_params>.Structure)
	param = (<control_params>.param)
	Index = (<control_params>.array_param_index)
	values = (<control_params>.values)
	structure_control_menu_verify_presence Structure = <Structure> param = <param>
	if GotParam \{ Index }
		array_value = (<Structure>.<param>)
		new_value = (<array_value> [ <Index> ])
	else
		new_value = (<Structure>.<param>)
		if GotParam \{ values }
			structure_control_menu_find_existing_value_index <control_params> value = <new_value>
		endif
	endif
	new_params = {<control_params> value = <new_value>}
	SetTags control_params = <new_params>
	control_params = <new_params>
	if GotParam \{ values }
		GetSingleTag \{ selection_index }
		display_value = (<control_params>.value_labels [ <selection_index> ])
	else
		FormatText textname = display_value "%v" v = (<control_params>.value)DecimalPlaces = 2
	endif
	SetScreenElementProps {
		Id = {<ObjID> child = value_display}
		text = <display_value>
	}
endscript

script structure_control_menu_control_item_focus
	Obj_GetID
	GetSingleTag \{ control_params }
	if StructureContains \{ Structure = control_params values }
		GetSingleTag \{ selection_index }
		GetArraySize (<control_params>.values)
		if ((<selection_index> > 0)|| ((<control_params>.range_loop)= 1))
			DoScreenElementMorph Id = {<ObjID> child = left_arrow}Alpha = 1
		endif
		if ((<selection_index> < (<array_Size> -1))|| ((<control_params>.range_loop)= 1))
			DoScreenElementMorph Id = {<ObjID> child = right_arrow}Alpha = 1
		endif
	else
		if (((<control_params>.value)> (<control_params>.min))|| ((<control_params>.range_loop)= 1))
			DoScreenElementMorph Id = {<ObjID> child = left_arrow}Alpha = 1
		endif
		if (((<control_params>.value)< (<control_params>.Max))|| ((<control_params>.range_loop)= 1))
			DoScreenElementMorph Id = {<ObjID> child = right_arrow}Alpha = 1
		endif
	endif
endscript

script structure_control_menu_control_item_unfocus
	Obj_GetID
	DoScreenElementMorph Id = {<ObjID> child = right_arrow}Alpha = 0
	DoScreenElementMorph Id = {<ObjID> child = left_arrow}Alpha = 0
endscript

script structure_control_menu_choose_item_focus
	GetProps
	SetTags old_rgba = <rgba>
	SetProps \{rgba = [ 255 208 0 200 ]}
	Obj_GetID
	current_menu ::SetTags choose_action_override = <ObjID>
endscript

script structure_control_menu_choose_item_unfocus \{old_rgba = [ 176 210 244 255 ]}
	GetSingleTag \{ old_rgba }
	SetProps rgba = <old_rgba>
	current_menu ::RemoveTags \{[ choose_action_override ]}
endscript

script structure_control_menu_choose_item_action
	GetSingleTag \{ action }
	(<action>.pad_choose_script)(<action>.pad_choose_params)
endscript
