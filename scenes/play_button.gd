extends Button

var is_playing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	is_playing = !is_playing
	text = "Play" if !is_playing else "Stop"
	pass 
