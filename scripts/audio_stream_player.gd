extends AudioStreamPlayer

var bpm = 60
var is_playing = false
var time_to_next_beat = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_to_next_beat -= delta
	if time_to_next_beat <= 0:
		time_to_next_beat += (60/bpm)		
		if is_playing:
			play()
	pass

func metronome_play() -> void:
	is_playing = !is_playing
	pass

func _on_play_pause_button_pressed() -> void:
	metronome_play()
	pass # Replace with function body.


func _on_bpm_spin_box_value_changed(value: float) -> void:
	bpm = value
	pass # Replace with function body.
