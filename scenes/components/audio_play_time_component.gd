extends Timer

@export var audio_strem_player_2D: AudioStreamPlayer2D

func _on_timeout() -> void:
	audio_strem_player_2D.play()
