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

func _on_playback_state_changed(state:Constants.PlaybackState) -> void:
	if state == Constants.PlaybackState.PLAYING:
		_start_playback()
	else:
		_stop_playback()

func _start_playback() -> void:
	playback_state = Constants.PlaybackState.PLAYING
	elapsed_time = 0
	
func _stop_playback() -> void:
	playback_state = Constants.PlaybackState.STOPPED
