extends Sprite2D

@export var componentID = 0
@export var	textureEnabled: Texture
@export var	textureDisabled: Texture
@onready var comp_lib: Node = %CompLib

@onready var name_tag: Label = $Label
@onready var icon: Sprite2D = $icon
@onready var indicator: Node2D = $Label/Indicator

var thisComponent: Component
var compEnabled = true

func enableButon(enabled: bool) -> void:
	compEnabled = enabled
	name_tag.visible = enabled
	icon.visible = enabled
	if enabled:
		$".".texture = textureEnabled
	else:
		$".".texture = textureDisabled
		

func _ready() -> void:
	thisComponent = comp_lib.Comps[componentID]
	icon.texture = thisComponent.icon
	name_tag.text = thisComponent.name
	var solar = false
	if thisComponent.ID == 11 or thisComponent.ID == 12:
		solar = true
	indicator.visible = solar
	enableButon(true)	
