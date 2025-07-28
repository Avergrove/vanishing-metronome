extends Node

# Timing Config
# Holds timing related configuration (bpm, beat per minute) and initial configuration
var bpm = 60
var beat_per_measure = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_beat_per_measure_spin_box_value_changed(value: float) -> void:
	Pubsub.beat_per_measure_changed.emit(value)
	pass # Replace with function body.
