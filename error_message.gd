extends Label

var transparency := 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	transparency -= delta * .2
	modulate.a = clamp(transparency, 0, 1)
	pass


func _on_margin_container_error_message(s: String) -> void:
	text = s
	transparency = 2.0
	pass # Replace with function body.
