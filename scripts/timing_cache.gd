extends Node

# Automatically calculates new timing information
var bpm = 60
var beat_per_measure = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pubsub.bpm_changed.connect(_on_bpm_changed)
	Pubsub.beat_per_measure_changed.connect(_on_beat_per_measure_changed)
	
	# We want everything to be connected to the signal first
	get_tree().create_timer(0.1).timeout.connect(_recalculate_timing)

func _on_bpm_changed(new_bpm: int) -> void:
	bpm = new_bpm
	_recalculate_timing()

func _on_beat_per_measure_changed(new_beat_per_measure: int) -> void:
	beat_per_measure = new_beat_per_measure
	_recalculate_timing()

func _recalculate_timing() -> void:
	var new_seconds_per_beat    = _calculate_seconds_per_beat()
	var new_seconds_per_measure = new_seconds_per_beat * beat_per_measure
	Pubsub.timing_cache_new_timing.emit(new_seconds_per_beat, new_seconds_per_measure)

# Calculate how much time is in a beat
func _calculate_seconds_per_beat() -> float:
	return 1 / (bpm / 60.0)
