extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pubsub.playback_state_changed.connect(_on_playback_state_changed)

func _on_playback_state_changed(new_state: Constants.PlaybackState, old_state:Constants.PlaybackState) -> void:
	if new_state in [Constants.PlaybackState.PLAYING, Constants.PlaybackState.PAUSED]:
		disabled = false
	elif new_state in [Constants.PlaybackState.STOPPED]:
		disabled = true
