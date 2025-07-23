extends Button

var is_playing = Constants.PlaybackState.STOPPED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pubsub.playback_state_changed.connect(_on_playback_state_changed)

func _on_playback_state_changed(state: Constants.PlaybackState) -> void:
	if is_playing == Constants.PlaybackState.PLAYING:
		is_playing = Constants.PlaybackState.STOPPED
		text = tr("PLAYBACK_BUTTON_play")
	else:
		is_playing = Constants.PlaybackState.PLAYING
		text = tr("PLAYBACK_BUTTON_stop")

func _on_pressed() -> void:
	if is_playing == Constants.PlaybackState.STOPPED:
		Pubsub.playback_state_changed.emit(Constants.PlaybackState.PLAYING)
	else :
		Pubsub.playback_state_changed.emit(Constants.PlaybackState.STOPPED)
	pass # Replace with function body.
