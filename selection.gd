extends ColorRect

var desiredAltitude := 17.0
var altitude := 17.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	altitude = altitude * .925 + desiredAltitude * .075
	self.global_position.y = altitude
	pass


func _on_margin_container_changed_selected_word(pos: int) -> void:
	desiredAltitude = pos - 3
