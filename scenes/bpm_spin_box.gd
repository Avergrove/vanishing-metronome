extends SpinBox

var playback_state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pubsub.playback_state_changed.connect(_on_playback_state_changed)
	playback_state = Constants.PlaybackState.STOPPED

func _on_playback_state_changed(new_state: Constants.PlaybackState, old_state:Constants.PlaybackState) -> void:
	playback_state = new_state
	match playback_state:
		Constants.PlaybackState.PLAYING:
			editable = false
		Constants.PlaybackState.PAUSED:
			editable = false
		Constants.PlaybackState.STOPPED:
			editable = true
		_:
			pass
