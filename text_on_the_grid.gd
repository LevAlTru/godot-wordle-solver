extends Control
class_name TextOnTheGrid

@export_color_no_alpha
var NO_TEXT_COLOR : Color
@export_color_no_alpha
var YES_TEXT_COLOR : Color 
@export_color_no_alpha
var HELP_YES_TEXT_COLOR : Color 

@onready
var nowCol: Color = NO_TEXT_COLOR
@onready
var desiredCol: Color = NO_TEXT_COLOR
var colorIndex := 0
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	nowCol = nowCol * .8 + desiredCol * .2
	$Panel.modulate = nowCol
	pass

func setText(s: String, mode: Mode = Mode.POTENTIAL) -> void:
	$Label.text = s.left(5)
	desiredCol = NO_TEXT_COLOR if s.is_empty() else (YES_TEXT_COLOR if mode == Mode.POTENTIAL else HELP_YES_TEXT_COLOR)

enum Mode{
	POTENTIAL, HELP
}
