extends Control

@onready var normal_speed_button: Button = $Control/NormalSpeedButton

var is_normal_speed_active: bool = false


func _ready() -> void:
	normal_speed_button.pressed.connect(on_normal_speed_pressed)
	normal_speed_button.focus_exited.connect(on_normal_speed_focus_exited)


func on_normal_speed_pressed() -> void:
	if normal_speed_button.has_focus() and is_normal_speed_active:
		normal_speed_button.release_focus()
		is_normal_speed_active = false
	else:
		normal_speed_button.grab_focus()
		is_normal_speed_active = true


func on_normal_speed_focus_exited() -> void:
	is_normal_speed_active = false
