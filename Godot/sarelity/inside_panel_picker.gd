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

func enableButon(enabled: bool) -> void:
	panel_in.visible = enabled
	if enabled:
		$".".texture = textureEnabled
	else:
		$".".texture = textureDisabled
func _ready() -> void:
	icon.texture = comp_lib.Comps[componentID].icon
	if comp_lib.Comps[componentID].size == 2:
		size_icon_small.hide()
	else:
		size_icon_big.hide()
	name_tag.text = comp_lib.Comps[componentID].name	
