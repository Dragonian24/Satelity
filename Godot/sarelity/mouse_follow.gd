extends Node2D
@onready var mouse_follow: Node2D = $"."

func _process(_delta: float) -> void:
	mouse_follow.position = get_viewport().get_mouse_position()
