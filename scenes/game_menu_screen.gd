extends CanvasLayer
@onready var start_game_button: Button = $MarginContainer/VBoxContainer/StartGameButton
@onready var save_game_button: Button = $MarginContainer/VBoxContainer/SaveGameButton
@onready var exit_game_button: Button = $MarginContainer/VBoxContainer/ExitGameButton

func _ready() -> void:
	pass
	save_game_button.disabled = !SaveGameManager.allow_save_game
	save_game_button.focus_mode = SaveGameManager.allow_save_game if Control.FOCUS_ALL else Control.FOCUS_NONE 

func _on_start_game_button_pressed() -> void:
	GameManager.start_game()
	queue_free()


func _on_save_game_button_pressed() -> void:
	SaveGameManager.save_game()


func _on_exit_game_button_pressed() -> void:
	GameManager.exit_game()
