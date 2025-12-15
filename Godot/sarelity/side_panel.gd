extends Node2D

# --- SPRITY PRO JEDNOTLIVÉ BARY ---

@export var consumption_sprites: Array[Sprite2D] = []
@export var storage_sprites: Array[Sprite2D] = []
@export var creation_sprites: Array[Sprite2D] = []

# --- BARVY ---

@export var consumption_color: Color = Color.RED 
@export var storage_color: Color = Color.BLUE
@export var creation_color: Color = Color.GREEN

@export var empty_color: Color = Color(0.4, 0.4, 0.4) # šedá pro prázdné dílky
@export var warning_color: Color = Color(1.0, 0.5, 0.0) # oranžová pro chybějící

@export var tween_duration: float = 0.25

@export var values: Array[int] = [0,0,0]:
	set(v):
		values = v
		_update_all_bars()



func _ready() -> void:
	_update_all_bars()


func _update_all_bars() -> void:
	
	var tween := create_tween()
	tween.set_parallel(true)
	var temp_color : Color
	print_debug(values[0]," ", values[1]," ", values[2])
	for i in consumption_sprites.size():
		
		temp_color = empty_color
		if i < values[0]: temp_color = consumption_color			
		_tween_sprite_color(consumption_sprites[i], temp_color, tween)
		temp_color = empty_color
		if i < values[0]: temp_color = warning_color
		if i < values[1]: temp_color = storage_color
		_tween_sprite_color(storage_sprites[i], temp_color, tween)
		temp_color = empty_color
		if i < values[0]: temp_color = warning_color
		if i < values[2]: temp_color = creation_color
		_tween_sprite_color(creation_sprites[i], temp_color, tween)


func _tween_sprite_color(node: Sprite2D, target_color: Color, tween : Tween) -> void:

	var current_color: Color = node.self_modulate
	if current_color == target_color:
		return
	
	tween.tween_property(node, "modulate", target_color, tween_duration) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
