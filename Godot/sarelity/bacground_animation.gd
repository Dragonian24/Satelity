extends Node
@export var mainBcg_sprite : Sprite2D
@export var satelite_sprite : Sprite2D
@export var bcg_x_pos: Vector2
@export var bcg_y_pos: Vector2
@export var sat_x_pos: Vector2
@export var sat_y_pos: Vector2

var rng = RandomNumberGenerator.new()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_tween_bcg() 
	add_tween_sat()

func add_tween_bcg() -> void:
	var tween = get_tree().create_tween()
	var pos_x = rng.randf_range(bcg_x_pos.x, bcg_x_pos.y)
	var pos_y = rng.randf_range(bcg_y_pos.x, bcg_y_pos.y)
	var an_time = rng.randf_range(5,20)
	var an_pos : Vector2 = Vector2(pos_x, pos_y)
	tween.finished.connect(_on_tween_bcg_finished)
	tween.tween_property(mainBcg_sprite, "position", an_pos, an_time).set_trans(Tween.TRANS_CUBIC)
	
	
	
func _on_tween_bcg_finished():
	add_tween_bcg()
	
func add_tween_sat() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	var pos_x = rng.randf_range(sat_x_pos.x, sat_x_pos.y)
	var pos_y = rng.randf_range(sat_y_pos.x, sat_y_pos.y)
	var rotation = rng.randf_range(-45,45)
	var an_time = rng.randf_range(10,30)
	var an_pos : Vector2 = Vector2(pos_x, pos_y)
	tween.finished.connect(_on_tween_sat_finished)
	tween.tween_property(satelite_sprite, "position", an_pos, an_time).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(satelite_sprite, "rotation", deg_to_rad(rotation), an_time).set_trans(Tween.TRANS_ELASTIC)
	
	
func _on_tween_sat_finished():
	add_tween_sat()
