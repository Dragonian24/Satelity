extends Sprite2D
@export var componentID = 0
@export var	textureEnabled: Texture
@export var	textureDisabled: Texture
@onready var comp_lib: Node = %CompLib

@onready var icon: Sprite2D = $PanelIn/Icon
@onready var size_icon_big: Sprite2D = $PanelIn/SizeIconBig
@onready var size_icon_small: Sprite2D = $PanelIn/SizeIconSmall
@onready var name_tag: Label = $PanelIn/NameTag
@onready var panel_in: Node2D = $PanelIn

@onready var indicator_stor: Node2D = $PanelIn/IndicatorStor
@onready var label_stor: Label = $PanelIn/IndicatorStor/LabelStor
@onready var indicator_cons: Node2D = $PanelIn/IndicatorCons
@onready var label_cons: Label = $PanelIn/IndicatorCons/LabelCons

var compEnabled = true
var thisComponent: Component

func enableButon(enabled: bool) -> void:
	compEnabled = enabled
	panel_in.visible = compEnabled
	if compEnabled:
		$".".texture = textureEnabled
	else:
		$".".texture = textureDisabled

		
		
		
func _ready() -> void:

	thisComponent = comp_lib.Comps[componentID]
	icon.texture = thisComponent.icon
	
	var consVal = thisComponent.EnergyConsumption
	if thisComponent.size == 2: consVal = consVal *2	
	label_cons.text = str(consVal)
	indicator_cons.visible = false
	if thisComponent.EnergyConsumption > 0:
		indicator_cons.visible = true
	
	var storVal = thisComponent.EnergyStorage
	if thisComponent.size == 2: storVal = storVal *2	
	label_stor.text = str(storVal)
	indicator_stor.visible = false
	if thisComponent.EnergyStorage > 0:
		indicator_stor.visible = true
	
	
	
	if thisComponent.size == 2:
		size_icon_small.hide()
	else:
		size_icon_big.hide()
	name_tag.text = thisComponent.name	
