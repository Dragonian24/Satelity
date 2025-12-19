extends Node

enum SateliteButtonGroup {
	INSIDE_PICKER,
	INSIDE_SATELITE,
	OUTSIDE_PICKER,
	OUTSIDE_SATELITE,
	NONE
}
@onready var comp_lib: Node = %CompLib
@onready var mison_manager: Node = %MisonManager


@onready var insidePanels: Array[Component] = [comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14]]:
	set(panels):
		print_debug("setter")
		mison_manager.insidePanels = panels
		insidePanels = panels
@onready var outsidePanels: Array[Component] = [comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14]]:
	set(panels):
		mison_manager.outsidePanels = panels
		outsidePanels = panels


@onready var icon0: Sprite2D = $MouseFollow/MouseMooveOut/Icon
@onready var icon1: Sprite2D = $MouseFollow/InsidePanel/icon
@onready var icLabel: Label = $MouseFollow/InsidePanel/Label
@onready var icon2: Sprite2D = $MouseFollow/InsidePanel2/icon
@onready var icLabel2: Label = $MouseFollow/InsidePanel2/Label
@onready var inside_panel_2: Sprite2D = $MouseFollow/InsidePanel2

@onready var mouse_follow: Node2D = $MouseFollow

@export var InsidePickerButtons: Array[Button] = []
@export var InsideSateliteButtons: Array[Button] = []
@export var OutsidePickerButtons: Array[Button] = []
@export var OutsideSateliteButtons: Array[Button] = []

@export var InsidePickerSlots: Array[Sprite2D] = []
@export var InsideSateliteSlots: Array[Sprite2D] = []
@export var OutsidePickerSlots: Array[Sprite2D] = []
@export var OutsideSateliteSlots: Array[Sprite2D] = []

var focusGroup: SateliteButtonGroup = SateliteButtonGroup.NONE
var focusId = 0
var selectedGroup: SateliteButtonGroup = SateliteButtonGroup.NONE
var selectedID = 0

var picked = false

func _ready():
	conect_all()	


func set_inside_panels(index: int, comp: Component) -> void:
	insidePanels[index] = comp
	mison_manager.set_inside_Panels(insidePanels)
	
func set_outside_panels(index: int, comp: Component) -> void:
	outsidePanels[index] = comp
	mison_manager.set_outside_Panels(outsidePanels)

#region ButtonConection	
func conect_all() ->void:
	_connect_button_array(InsidePickerButtons, SateliteButtonGroup.INSIDE_PICKER)
	_connect_button_array(InsideSateliteButtons, SateliteButtonGroup.INSIDE_SATELITE)
	_connect_button_array(OutsidePickerButtons, SateliteButtonGroup.OUTSIDE_PICKER)
	_connect_button_array(OutsideSateliteButtons, SateliteButtonGroup.OUTSIDE_SATELITE)
	
	_connect_button_array_focus_enter(InsidePickerButtons, SateliteButtonGroup.INSIDE_PICKER)
	_connect_button_array_focus_enter(InsideSateliteButtons, SateliteButtonGroup.INSIDE_SATELITE)
	_connect_button_array_focus_enter(OutsidePickerButtons, SateliteButtonGroup.OUTSIDE_PICKER)
	_connect_button_array_focus_enter(OutsideSateliteButtons, SateliteButtonGroup.OUTSIDE_SATELITE)
	
	_connect_button_array_focus_exit(InsidePickerButtons, SateliteButtonGroup.INSIDE_PICKER)
	_connect_button_array_focus_exit(InsideSateliteButtons, SateliteButtonGroup.INSIDE_SATELITE)
	_connect_button_array_focus_exit(OutsidePickerButtons, SateliteButtonGroup.OUTSIDE_PICKER)
	_connect_button_array_focus_exit(OutsideSateliteButtons, SateliteButtonGroup.OUTSIDE_SATELITE)

# button press
func _connect_button_array(buttons: Array[Button], group: int) -> void:
	for i in buttons.size():
		var button := buttons[i]
		if button:
			button.button_down.connect(_on_button_pressed.bind(group, i))

func _on_button_pressed(group: int, index: int) -> void:
	MouseClicked(group,index)

# button press

#mouse enter
func _connect_button_array_focus_enter(buttons: Array[Button], group: int) -> void:
	for i in buttons.size():
		var button := buttons[i]
		if button:
			button.mouse_entered.connect(_on_button_pressed_focus_enter.bind(group, i))

func _on_button_pressed_focus_enter(group: int, index: int) -> void:
	focusId = index
	focusGroup = group as SateliteButtonGroup
	print_debug("focus")
#mouse enter

#mouse exit
func _connect_button_array_focus_exit(buttons: Array[Button], group: int) -> void:
	for i in buttons.size():
		var button := buttons[i]
		if button:
			button.mouse_exited.connect(_on_button_pressed_focus_exit.bind(group, i))

func _on_button_pressed_focus_exit(_group: int, _index: int) -> void:
	focusId = 0
	focusGroup = SateliteButtonGroup.NONE

#mouse exit
#endregion
#region Reset
#func AllReset()-> void:
	#focusGroup = SateliteButtonGroup.NONE
	#selectedGroup = SateliteButtonGroup.NONE
	#focusId = 0
	#selectedID = 0
	#
	#for panel in insidePanels:
		#panel = comp_lib.Comps[14]
	#for panel in outsidePanels:
		#panel = comp_lib.Comps[14]
	#
	#mison_manager.insidePanels = insidePanels
	#mison_manager.outsidePanels = outsidePanels
	#
	#for slot in InsideSateliteSlots:
		#slot.visible = false	
	#for slot in OutsideSateliteSlots:
		#slot.visible = false
	#
	#for slot in InsidePickerSlots:
		#slot.visible = false	
	#for slot in OutsideSateliteSlots:
		#slot.visible = false
	
	
func AllReset() -> void:
	focusGroup = SateliteButtonGroup.NONE
	selectedGroup = SateliteButtonGroup.NONE
	focusId = 0
	selectedID = 0
	picked = false

	for i in range(insidePanels.size()):
		set_inside_panels(i, comp_lib.Comps[14])
		InsideSateliteSlots[i].visible = false

	for i in range(outsidePanels.size()):
		set_outside_panels(i, comp_lib.Comps[14])
		OutsideSateliteSlots[i].visible = false

	for slot in InsidePickerSlots:
		slot.visible = true
		slot.enableButon(true)

	for slot in OutsidePickerSlots:
		slot.visible = true
		slot.enableButon(true)
#endregion

func MouseClicked(group: int, index: int) -> void:
	match group:
		SateliteButtonGroup.INSIDE_PICKER:
			if InsidePickerSlots[index].compEnabled == true:
				picked = true
				selectedGroup = group as SateliteButtonGroup
				selectedID = index			
				mouse_follow.visible = true
				setMouse(InsidePickerSlots[index].thisComponent)
				InsidePickerSlots[index].enableButon(false)
		SateliteButtonGroup.OUTSIDE_PICKER:
			if OutsidePickerSlots[index].compEnabled == true:
				picked = true
				selectedGroup = group as SateliteButtonGroup
				selectedID = index
				mouse_follow.visible = true
				setMouse(OutsidePickerSlots[index].thisComponent)
				OutsidePickerSlots[index].enableButon(false)
		SateliteButtonGroup.OUTSIDE_SATELITE:
			if outsidePanels[index] != comp_lib.Comps[14]:
				picked = true
				var this_comp = outsidePanels[index]
				selectedGroup = SateliteButtonGroup.OUTSIDE_PICKER
				for i in OutsidePickerSlots.size():
					if OutsidePickerSlots[i].thisComponent == this_comp: 
						selectedID = i
				set_outside_panels(index, comp_lib.Comps[14])
				mouse_follow.visible = true
				setMouse(OutsidePickerSlots[selectedID].thisComponent)
				OutsideSateliteSlots[index].visible = false
				
		SateliteButtonGroup.INSIDE_SATELITE:
			if insidePanels[index] != comp_lib.Comps[14]:
				picked = true
				
				var this_comp = insidePanels[index]
				for k in insidePanels.size():
					if insidePanels[k] == this_comp:
						set_inside_panels(k, comp_lib.Comps[14])
						InsideSateliteSlots[k].visible = false
				
				selectedGroup = SateliteButtonGroup.INSIDE_PICKER
				for i in InsidePickerSlots.size():
					if InsidePickerSlots[i].thisComponent == this_comp: 
						selectedID = i
				mouse_follow.visible = true
				setMouse(InsidePickerSlots[selectedID].thisComponent)
				InsideSateliteSlots[index].visible = false
				
func setMouse(component: Component) -> void:
	icon0.texture = component.icon
	icon1.texture = component.icon
	icon2.texture = component.icon
	icLabel.text = component.name
	icLabel2.text = component.name
	if component.size == 2: inside_panel_2.visible = true
	else: inside_panel_2.visible = false 
	
func mouseReleased() -> void:
	mouse_follow.visible = false
	if focusGroup == SateliteButtonGroup.NONE:
		returnSlot()
	if selectedGroup == focusGroup:
		returnSlot()
	else:
		placeSlot()
		

func returnSlot() -> void :
	match selectedGroup:
			SateliteButtonGroup.INSIDE_PICKER:
				InsidePickerSlots[selectedID].enableButon(true)
			SateliteButtonGroup.INSIDE_SATELITE:
				InsideSateliteSlots[selectedID].enableButon(true)
			SateliteButtonGroup.OUTSIDE_PICKER:
				OutsidePickerSlots[selectedID].enableButon(true)
			SateliteButtonGroup.OUTSIDE_SATELITE:
				OutsideSateliteSlots[selectedID].enableButon(true)

func placeSlot() -> void:
	match focusGroup:
			SateliteButtonGroup.INSIDE_PICKER:
				returnSlot()
			SateliteButtonGroup.INSIDE_SATELITE:
				placeInside()
			SateliteButtonGroup.OUTSIDE_PICKER:
				returnSlot()
			SateliteButtonGroup.OUTSIDE_SATELITE:
				placeOutside()
				

func placeInside() -> void:
	
	var temp_component = InsidePickerSlots[selectedID].thisComponent
	var tmp_icon = InsideSateliteSlots[focusId].get_child(0)
	tmp_icon.texture = temp_component.icon
	var tmp_text = InsideSateliteSlots[focusId].get_child(1)
	tmp_text.text = temp_component.name				
	var prev_component = insidePanels[focusId]
	replaceInside(prev_component)
	
	InsideSateliteSlots[focusId].visible = true	
	set_inside_panels(focusId, temp_component)

	if temp_component.size == 2:
		var size_id
		if focusId == 4: size_id = 3
		else: size_id = focusId + 1
		
		var prev_size_component = insidePanels[size_id]
		replaceInside(prev_size_component)
		
		InsideSateliteSlots[size_id].visible = true
		
		var tmp_size_icon = InsideSateliteSlots[size_id].get_child(0)
		tmp_size_icon.texture = temp_component.icon
		var tmp_size_text = InsideSateliteSlots[size_id].get_child(1)
		tmp_size_text.text = temp_component.name		
		set_inside_panels(size_id, temp_component)


func replaceInside(prev_component) -> void:
	if prev_component != comp_lib.Comps[14]:
		for k in insidePanels.size():
					if insidePanels[k] == prev_component:
						set_inside_panels(k, comp_lib.Comps[14])
						InsideSateliteSlots[k].visible = false
			
		for comp in InsidePickerSlots:
			if comp.thisComponent == prev_component: 
				comp.enableButon(true)
				
			

func placeOutside() -> void:
	OutsideSateliteSlots[focusId].visible = true
	var prev_component = outsidePanels[focusId]				
	replaceOutside(prev_component)
	var temp_component = OutsidePickerSlots[selectedID].thisComponent
	var tmp_icon = OutsideSateliteSlots[focusId].get_child(0)
	tmp_icon.texture = temp_component.icon
	set_outside_panels(focusId, temp_component)
			
func replaceOutside(prev_component) -> void:
	if prev_component != comp_lib.Comps[14]:
		for comp in OutsidePickerSlots:
			if comp.thisComponent == prev_component: comp.enableButon(true)


func _input(event):
	if picked == true and event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and not event.pressed:
		picked = false
		mouseReleased()		
