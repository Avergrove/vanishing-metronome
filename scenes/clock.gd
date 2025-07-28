extends Node

# The clock acts as the sole source of truth for synchronizing time and input
var elapsed_time = 0
var playback_state = Constants.PlaybackState.STOPPED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pubsub.playback_state_changed.connect(_on_playback_state_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playback_state == Constants.PlaybackState.PLAYING:
		elapsed_time += delta
		Pubsub.clock_elapsed_time_changed.emit(elapsed_time)

func _on_playback_state_changed(new_state:Constants.PlaybackState, old_state:Constants.PlaybackState) -> void:
	if new_state == Constants.PlaybackState.PLAYING:
		_start_playback()
	elif new_state == Constants.PlaybackState.PAUSED:
		_pause_playback()
	else:
		_stop_playback()

func _start_playback() -> void:
	playback_state = Constants.PlaybackState.PLAYING

func _pause_playback() -> void:
	playback_state = Constants.PlaybackState.PAUSED

func _stop_playback() -> void:
	playback_state = Constants.PlaybackState.STOPPED
	elapsed_time = 0
