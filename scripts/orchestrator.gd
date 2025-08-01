extends Node

# The Orchestrator 

# The Orchestrator is responsible for planning ahead the beats and dynamics to play. 
# It generates measure by measure, the moment playback starts!
# Note that the orchestrator itself doesn't save the measures! These are published by signals and handled by subscriber nodes.

var is_playing = Constants.PlaybackState.STOPPED
var beatmap = []
var curr_measure
var elapsed_time
var beat_per_minute
var beat_per_measure

# Dictates how many measures ahead to generate for
var generate_ahead = 2
var seconds_per_measure
var curr_measure_index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pubsub.playback_state_changed.connect(_on_playback_state_changed)
	Pubsub.clock_elapsed_time_changed.connect(_on_elapsed_time_changed)
	Pubsub.bpm_changed.connect(_on_beat_per_minute_changed)
	Pubsub.beat_per_measure_changed.connect(_on_beat_per_measure_changed)
	Pubsub.timing_cache_new_timing.connect(_on_timing_cache_new_timing)
	
	_reset()

# When a play session ends, we need to generate a new set.
func _on_playback_state_changed(new_playback_state: Constants.PlaybackState, old_playback_state: Constants.PlaybackState) -> void:
	if new_playback_state == Constants.PlaybackState.STOPPED:
		_reset()
	elif new_playback_state == Constants.PlaybackState.PLAYING && old_playback_state == Constants.PlaybackState.STOPPED:
		generate_initial_measures()

func _on_elapsed_time_changed(new_elapsed_time: int) -> void:
	elapsed_time = new_elapsed_time
	if elapsed_time > (curr_measure_index) * seconds_per_measure:
		generate_measure(curr_measure_index + generate_ahead)
		curr_measure_index += 1

func _on_beat_per_minute_changed(new_beat_per_minute: int) -> void:
	beat_per_minute = new_beat_per_minute

func _on_beat_per_measure_changed(new_beat_per_measure: int) -> void:
	beat_per_measure = new_beat_per_measure

func _on_timing_cache_new_timing(new_seconds_per_beat, new_seconds_per_measure):
	seconds_per_measure  = new_seconds_per_measure

# Generate the initial measures of a play session
func generate_initial_measures() -> void:
	# generate_ahead helps us generate ahead measures of time
	for i in generate_ahead:
		generate_measure(i);
	pass

# Generates a measure and publishes it.
# TODO: Implement proper generation. Currently returns a don do-don do-don beat
func generate_measure(measure: int) -> void:
	var generated_measure = []
	generated_measure.append({"measure": measure, "beat": 0, "dynamics": Constants.Dynamics.LOUD})
	generated_measure.append({"measure": measure, "beat": 1, "dynamics": Constants.Dynamics.NORMAL})
	generated_measure.append({"measure": measure, "beat": 1.5, "dynamics": Constants.Dynamics.NORMAL})
	generated_measure.append({"measure": measure, "beat": 2.5, "dynamics": Constants.Dynamics.NORMAL})
	generated_measure.append({"measure": measure, "beat": 3, "dynamics": Constants.Dynamics.QUIET})
	Pubsub.orchestrator_measure_generated.emit(generated_measure)

func _reset() -> void:
	curr_measure_index = 0
	elapsed_time = 0
