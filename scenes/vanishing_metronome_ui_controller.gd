extends Node

# UIController for handling the metronome scene specifically
var playback_state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _reset() -> void:
	playback_state = Constants.PlaybackState.STOPPED

func _on_play_pause_button_button_pressed() -> void:
	if playback_state in [Constants.PlaybackState.PLAYING]:
		Pubsub.playback_state_changed.emit(Constants.PlaybackState.PAUSED, playback_state)
		playback_state = Constants.PlaybackState.PAUSED
	elif playback_state in [Constants.PlaybackState.PAUSED, Constants.PlaybackState.STOPPED]:
		Pubsub.playback_state_changed.emit(Constants.PlaybackState.PLAYING, playback_state)
		playback_state = Constants.PlaybackState.PLAYING

func _on_stop_button_pressed() -> void:
	Pubsub.playback_state_changed.emit(Constants.PlaybackState.STOPPED, playback_state)
	playback_state = Constants.PlaybackState.STOPPED

func _on_bpm_spin_box_value_changed(value: float) -> void:
	Pubsub.bpm_changed.emit(value)

func _on_beat_per_measure_spin_box_value_changed(value: float) -> void:
	Pubsub.beat_per_measure_changed.emit(value)
