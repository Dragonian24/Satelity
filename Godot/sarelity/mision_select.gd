extends Control

@export var butt_fir : TextureButton
@export var butt_far : TextureButton
@export var butt_gps : TextureButton
@export var butt_rad : TextureButton
@export var butt_poc : TextureButton
@export var butt_sat : TextureButton
var time = 0.3
var tween: Tween


func _stop_tween() -> void:
	pass
	if tween and tween.is_running():
		tween.kill()
		tween = null
		butt_fir.size_flags_stretch_ratio = 1
		butt_far.size_flags_stretch_ratio = 1
		butt_gps.size_flags_stretch_ratio = 1
		butt_rad.size_flags_stretch_ratio = 1
		butt_poc.size_flags_stretch_ratio = 1
		butt_sat.size_flags_stretch_ratio = 1


func mouse_exited() -> void:
	tween = get_tree().create_tween().parallel()
	tween.tween_property(butt_fir, "size_flags_stretch_ratio", 1, 0.1)
	tween.tween_property(butt_far, "size_flags_stretch_ratio", 1, 0.1)
	tween.tween_property(butt_gps, "size_flags_stretch_ratio", 1, 0.1)
	tween.tween_property(butt_rad, "size_flags_stretch_ratio", 1, 0.1)
	tween.tween_property(butt_poc, "size_flags_stretch_ratio", 1,  0.1)
	tween.tween_property(butt_sat, "size_flags_stretch_ratio", 1, 0.1)


func _on_button_m_fir_mouse_entered() -> void:
	_stop_tween()
	tween = get_tree().create_tween()
	tween.tween_property(butt_fir, "size_flags_stretch_ratio", 2, time)

func _on_button_m_fir_mouse_exited() -> void:
	print_debug("mouse exited")
	mouse_exited()


func _on_button_m_far_mouse_entered() -> void:
	_stop_tween()
	tween = get_tree().create_tween()
	tween.tween_property(butt_far, "size_flags_stretch_ratio", 2, time)

func _on_button_m_far_mouse_exited() -> void:
	print_debug("mouse exited")
	mouse_exited()


func _on_button_m_gps_mouse_entered() -> void:
	_stop_tween()
	tween = get_tree().create_tween()
	tween.tween_property(butt_gps, "size_flags_stretch_ratio", 2, time)

func _on_button_m_gps_mouse_exited() -> void:
	print_debug("mouse exited")
	mouse_exited()


func _on_button_m_rad_mouse_entered() -> void:
	_stop_tween()
	tween = get_tree().create_tween()
	tween.tween_property(butt_rad, "size_flags_stretch_ratio", 2, time)

func _on_button_m_rad_mouse_exited() -> void:
	print_debug("mouse exited")
	mouse_exited()


func _on_button_m_poc_mouse_entered() -> void:
	_stop_tween()
	tween = get_tree().create_tween()
	tween.tween_property(butt_poc, "size_flags_stretch_ratio", 2, time)

func _on_button_m_poc_mouse_exited() -> void:
	print_debug("mouse exited")
	mouse_exited()


func _on_button_m_sat_mouse_entered() -> void:
	_stop_tween()
	tween = get_tree().create_tween()
	tween.tween_property(butt_sat, "size_flags_stretch_ratio", 2, time)

func _on_button_m_sat_mouse_exited() -> void:
	print_debug("mouse exited")
	mouse_exited()
