extends CanvasLayer

@export var missions : Array[Mision] = []

@onready var enter_screen: Control = $EnterScreen
@onready var mode_select: Control = $ModeSelect
@onready var mision_select: Control = $MisionSelect
@onready var rocket_builder: Control = $RocketBuilder
@onready var end_scene: Control = $EndScene
@onready var end_vid: VideoStreamPlayer = $EndScene/EndVid

@onready var bcg: Sprite2D = $"../Bacground/BCG"
@onready var satelite: Sprite2D = $"../Bacground/Satelite"

#builder
@onready var builder_root: Node2D = $"../SateliteBuilder/BuilderRoot"
@onready var inside_module_buttons: CanvasLayer = $"../SateliteBuilder/BuilderRoot/InsideModuleButtons"
@onready var outside_module_buttons: CanvasLayer = $"../SateliteBuilder/BuilderRoot/OutsideModuleButtons"
@onready var canvas_layer: CanvasLayer = $"../SateliteBuilder/BuilderRoot/RotationManager/CanvasLayer"
@onready var satelite_builder: Control = $SateliteBuilder
#end builder


@export var this_Mission : Mision


enum scenes {enter, mode, mision, rocket, end, builder}

func show_scene(scene: scenes) -> void:
	# všechno vypnout
	satelite.visible = false
	enter_screen.visible = false
	mode_select.visible = false
	mision_select.visible = false
	rocket_builder.visible = false
	end_scene.visible = false
	builder_root.visible = false
	inside_module_buttons.visible = false
	outside_module_buttons.visible = false
	canvas_layer.visible = false 
	satelite_builder.visible = false

	# zapnout jen vybranou scénu
	match scene:
		scenes.enter:
			satelite.visible = true
			enter_screen.visible = true
		scenes.mode:
			mode_select.visible = true
		scenes.mision:
			mision_select.visible = true
		scenes.rocket:
			rocket_builder.visible = true
		scenes.end:
			end_scene.visible = true
			end_vid.visible = true
			end_vid.play()
			await get_tree().create_timer(5).timeout
			end_vid.visible = false
			
		scenes.builder:
			builder_root.visible = true
			inside_module_buttons.visible = true
			outside_module_buttons.visible = true
			canvas_layer.visible = true 
			satelite_builder.visible = true
			%MisonManager.this_mision = this_Mission
			%MisonManager.misionload()


func _ready() -> void:
	show_scene(scenes.enter)

func _on_end_pressed() -> void:
	show_scene(scenes.end)


func _on_button_pressed() -> void:
	show_scene(scenes.mision)


func _on_button_m_fir_pressed() -> void:
	this_Mission = missions[0]
	show_scene(scenes.mode)


func _on_button_m_far_pressed() -> void:
	this_Mission = missions[1]
	show_scene(scenes.mode)

func _on_button_m_gps_pressed() -> void:
	this_Mission = missions[2]
	show_scene(scenes.mode)

func _on_button_m_rad_pressed() -> void:
	this_Mission = missions[3]
	show_scene(scenes.mode)

func _on_button_m_poc_pressed() -> void:
	this_Mission = missions[4]
	show_scene(scenes.mode)

func _on_button_m_sat_pressed() -> void:
	this_Mission = missions[5]
	show_scene(scenes.mode)


func _on_button_pos_pressed() -> void:
	show_scene(scenes.builder)


func _on_button_vys_pressed() -> void:
	show_scene(scenes.rocket)


func _on_exit_button_pressed() -> void:
	show_scene(scenes.mision)


func _on_start_button_pressed() -> void:
	show_scene(scenes.end)


func _on_end_back_pressed() -> void:
	show_scene(scenes.builder)

func _on_end_again_pressed() -> void:
	show_scene(scenes.enter)

func _on_end_mision_pressed() -> void:
	show_scene(scenes.mision)
