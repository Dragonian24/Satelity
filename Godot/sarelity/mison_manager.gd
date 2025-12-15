extends Node

@onready var drag_drop_manager: Node = %DragDropManager
@onready var side_panel: Node2D = %SidePanel
@onready var comp_lib: Node = %CompLib
@onready var mision_header: Label = %MisionHeader
@onready var main_text: Label = %MainText

@export var this_mision : Mision
@onready var mision_info: Label = %MisionInfo

@onready var insidePanels: Array[Component] = [comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14]]

@onready var outsidePanels: Array[Component] = [comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14],comp_lib.Comps[14]]

@export var messages: Array[String] = ["Nedostatečné úložitě energie", "Nedostatečné nabíjení energie"]

@onready var error: TextureRect = $"../../Game/SateliteBuilder/Control/Error"

func update_text() -> void:
	var erText: String = ""
	var err = false
	if values[0] > values[1]: 
		err = true
		erText += messages[0] + "\n"
	if values[0] > values[2]:
		err = true
		erText += messages[1] + "\n"
	for i in this_mision.neededComps.size():
		var found = false
		for j in insidePanels.size():
			if insidePanels[j] == this_mision.neededComps[i] :
				found = true
				break
		for j in outsidePanels.size():
			if outsidePanels[j] == this_mision.neededComps[i] :
				found = true
				break
		if found == false: 
			err = true
			erText += "Chybí " + this_mision.neededComps[i].name + "\n"
	main_text.text = erText 
	error.visible = err
	
	

func misionload() -> void:
	mision_header.text = "Mise: " + this_mision.name
	mision_info.text = this_mision.info
	update_text()
	drag_drop_manager.AllReset()
	$"../BuilderRoot/RotationManager".swap_side()

var values: Array[int] = [0,0,0]

func set_inside_Panels(panels: Array[Component]) -> void:
	insidePanels = panels
	set_values_Arr()
	
func set_outside_Panels(panels: Array[Component]) -> void:
	outsidePanels = panels
	set_values_Arr()

func set_values_Arr() -> void:
	var val: Array[int] = [0,0,0]
	for i in outsidePanels.size():
		val[0] += int(outsidePanels[i].EnergyConsumption)
		val[1] += int(outsidePanels[i].EnergyStorage)
		val[2] += int(outsidePanels[i].EnergyCreation)
		
	for i in insidePanels.size():
		val[0] += int(insidePanels[i].EnergyConsumption)
		val[1] += int(insidePanels[i].EnergyStorage)
		val[2] += int(insidePanels[i].EnergyCreation)
	values = val
	side_panel.values = val
	update_text()
