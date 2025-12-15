extends Label
@onready var txt = $"."
@onready var resolution = get_viewport().get_size()


func _process(_delta: float) -> void:
	resolution = get_viewport().get_size()
	txt.text = "rez %s %s" % [resolution.x, resolution.y]
