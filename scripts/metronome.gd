extends AudioStreamPlayer

# The Metronome reads in beatmap event changes from signals (Orchestrator) and plays sounds accordingly.

var bpm                 = 60
var beat_per_measure    = 4
var playback_state      = Constants.PlaybackState.STOPPED
var seconds_per_beat    
var seconds_per_measure 
var elapsed_time        = 0
var timings             = []


# Temporary variables
var curr_beat_timing_index     = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pubsub.bpm_changed.connect(_on_bpm_change)
	Pubsub.timing_cache_new_timing.connect(_on_timing_cache_new_timing)
	Pubsub.playback_state_changed.connect(_on_playback_state_changed)
	Pubsub.orchestrator_measure_generated.connect(_on_orchestrator_measure_generated)
	Pubsub.clock_elapsed_time_changed.connect(_on_clock_elapsed_time_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playback_state == Constants.PlaybackState.PLAYING:
		if elapsed_time > timings[curr_beat_timing_index]["timing"]:
			play()
			curr_beat_timing_index += 1
	pass

func _on_playback_state_changed(new_state:Constants.PlaybackState, old_state:Constants.PlaybackState) -> void:
	playback_state = new_state
	if playback_state == Constants.PlaybackState.STOPPED:
		_reset()

func _on_bpm_change(new_bpm: float) -> void:
	bpm = new_bpm

# Append onto measures in play for.. play..
func _on_orchestrator_measure_generated(generated_measure: Array) -> void:
	var converted_timings_array = _convert_to_timing(generated_measure)
	for beat_timing in converted_timings_array:
		timings.append(beat_timing)

func _on_clock_elapsed_time_changed(new_elapsed_time: float) -> void:
	elapsed_time = new_elapsed_time

func _on_timing_cache_new_timing(new_seconds_per_beat, new_seconds_per_measure):
	seconds_per_beat     = new_seconds_per_beat
	seconds_per_measure  = new_seconds_per_measure
	

# Converts a measure array into a timing array.
func _convert_to_timing(measure):
	# Read in each beat in the measure
	var new_timings = []
	for beat in measure:
		var beat_timing = beat["measure"] * seconds_per_measure + beat["beat"] * seconds_per_beat
		new_timings.append({"timing": beat_timing})
	return new_timings

# Resets non-signal playback variables to initial state
func _reset():
	timings = []
	curr_beat_timing_index = 0
	elapsed_time = 0
