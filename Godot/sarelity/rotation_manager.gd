extends Node
@onready var side_panel_inside: Sprite2D = $"../SidePanelInside"
@onready var side_panel_outside: Sprite2D = $"../SidePanelOutside"
@onready var sat_base: Sprite2D = $"../SatBase"
@onready var inside_modules: Node2D = $"../InsideModules"
@onready var inside_modules_small: Node2D = $"../InsideModulesSmall"
@onready var side_panel: Node2D = $"../SidePanel"
@onready var outside_modules: Node2D = $"../OutsideModules"
@onready var outside_modules_small: Node2D = $"../OutsideModulesSmall"
@onready var outside_module_buttons: CanvasLayer = $"../OutsideModuleButtons"
@onready var inside_module_buttons: CanvasLayer = $"../InsideModuleButtons"
@onready var mouse_moove_out: Sprite2D = $"../DragDropManager/MouseFollow/MouseMooveOut"
@onready var inside_panel: Sprite2D = $"../DragDropManager/MouseFollow/InsidePanel"
@onready var inside_panel_2: Sprite2D = $"../DragDropManager/MouseFollow/InsidePanel2"

var inside = false


func swap_side() -> void:
	inside = !inside
	#inside group
	side_panel_inside.visible = inside
	inside_modules.visible = inside
	outside_modules_small.visible = inside
	inside_module_buttons.visible = inside
	inside_panel.visible = inside
	inside_panel_2.visible = inside
	
	
	mouse_moove_out.visible = !inside 
	side_panel_outside.visible = !inside
	outside_modules.visible =!inside
	inside_modules_small.visible = !inside
	outside_module_buttons.visible = !inside

func _on_rotate_button_3_pressed() -> void:
	print_debug("button")
	swap_side()


func _on_rotate_button_2_pressed() -> void:
	print_debug("button")
	swap_side()


func _on_rotate_button_pressed() -> void:
	print_debug("button")
	swap_side()
