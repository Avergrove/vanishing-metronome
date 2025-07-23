extends AudioStreamPlayer

var bpm = 60
var is_playing = Constants.PlaybackState.STOPPED
var time_to_next_beat = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pubsub.bpm_changed.connect(_on_bpm_change)
	Pubsub.playback_state_changed.connect(_on_playback_state_changed)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_to_next_beat -= delta
	if time_to_next_beat <= 0:
		if is_playing == Constants.PlaybackState.PLAYING:
			play()
		time_to_next_beat += (60/bpm)		
	pass

func metronome_play(state:Constants.PlaybackState) -> void:
	is_playing = state
	if is_playing == Constants.PlaybackState.PLAYING:
		time_to_next_beat = 0

func _on_playback_state_changed(state:Constants.PlaybackState) -> void:
	metronome_play(state)
	pass # Replace with function body.

func _on_bpm_change(value: float) -> void:
	bpm = value
	pass # Replace with function body.
