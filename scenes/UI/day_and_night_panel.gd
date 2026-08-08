extends Control

@onready var normal_speed_button: Button = $Control/NormalSpeedButton
@onready var fast_speed_button: Button = $Control/FastSpeedButton
@onready var cheetah_speed_button: Button = $Control/CheetahSpeedButton

@onready var day_label: Label = $DayPanel/MarginContainer/DayLabel
@onready var time_label: Label = $TimePanel/MarginContainer/TimeLabel

@export var normal_speed: int = 5
@export var fast_speed: int = 100
@export var cheetah_speed: int = 200

var is_normal_speed_active: bool = false
var is_fast_speed_active: bool = false
var is_cheetah_speed_active: bool = false


func _ready() -> void:
	normal_speed_button.focus_exited.connect(func(): is_normal_speed_active = false)
	fast_speed_button.focus_exited.connect(func(): is_fast_speed_active = false)
	cheetah_speed_button.focus_exited.connect(func(): is_cheetah_speed_active = false)

	DayAndNightCycleManager.time_tick.connect(on_time_tick)


func on_time_tick(day: int, hour: int, minute: int) -> void:
	day_label.text = "Day " + str(day)
	time_label.text = "%02d:%02d" % [hour, minute]


func _on_normal_speed_button_pressed() -> void:
	DayAndNightCycleManager.game_speed = normal_speed
	toggle_button_focus(normal_speed_button, "normal")


func _on_fast_speed_button_pressed() -> void:
	DayAndNightCycleManager.game_speed = fast_speed
	toggle_button_focus(fast_speed_button, "fast")


func _on_cheetah_speed_button_pressed() -> void:
	DayAndNightCycleManager.game_speed = cheetah_speed
	toggle_button_focus(cheetah_speed_button, "cheetah")


func toggle_button_focus(button: Button, button_type: String) -> void:
	var is_active: bool = false
	match button_type:
		"normal": is_active = is_normal_speed_active
		"fast": is_active = is_fast_speed_active
		"cheetah": is_active = is_cheetah_speed_active

	if button.has_focus() and is_active:
		button.release_focus()
		set_active(button_type, false)
	else:
		reset_all_active()
		button.grab_focus()
		set_active(button_type, true)


func set_active(button_type: String, active: bool) -> void:
	match button_type:
		"normal": is_normal_speed_active = active
		"fast": is_fast_speed_active = active
		"cheetah": is_cheetah_speed_active = active


func reset_all_active() -> void:
	is_normal_speed_active = false
	is_fast_speed_active = false
	is_cheetah_speed_active = false
