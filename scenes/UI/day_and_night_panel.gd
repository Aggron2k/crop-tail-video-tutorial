extends Control

@onready var normal_speed_button: Button = $Control/NormalSpeedButton
@onready var day_label: Label = $DayPanel/MarginContainer/DayLabel
@onready var time_label: Label = $TimePanel/MarginContainer/TimeLabel

@export var normal_speed: int = 5
@export var fast_speed: int = 100
@export var cheetah_speed: int = 200

var is_normal_speed_active: bool = false


func _ready() -> void:
	normal_speed_button.pressed.connect(on_normal_speed_pressed)
	normal_speed_button.focus_exited.connect(on_normal_speed_focus_exited)
	DayAndNightCycleManager.time_tick.connect(on_time_tick)
	
func on_time_tick(day: int, hour: int, minute:int) -> void:
	day_label.text = "Day " + str(day)
	time_label.text = "%02d:%02d" % [hour , minute]

func on_normal_speed_pressed() -> void:
	if normal_speed_button.has_focus() and is_normal_speed_active:
		normal_speed_button.release_focus()
		is_normal_speed_active = false
	else:
		normal_speed_button.grab_focus()
		is_normal_speed_active = true


func on_normal_speed_focus_exited() -> void:
	is_normal_speed_active = false


func _on_normal_speed_button_pressed() -> void:
	DayAndNightCycleManager.game_speed = normal_speed


func _on_fast_speed_button_pressed() -> void:
	DayAndNightCycleManager.game_speed = fast_speed


func _on_cheetah_speed_button_pressed() -> void:
	DayAndNightCycleManager.game_speed = cheetah_speed
