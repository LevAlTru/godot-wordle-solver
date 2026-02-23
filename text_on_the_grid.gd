extends Control
class_name TextOnTheGrid

@export_color_no_alpha
var NO_TEXT_COLOR : Color
@export_color_no_alpha
var YES_TEXT_COLOR : Color 
@export_color_no_alpha
var HELP_YES_TEXT_COLOR : Color 
@export_color_no_alpha
var UNHELPFUL_YES_TEXT_COLOR : Color 

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
	if s.is_empty(): desiredCol = NO_TEXT_COLOR
	elif mode == Mode.POTENTIAL: desiredCol = YES_TEXT_COLOR
	elif mode == Mode.HELP: desiredCol = HELP_YES_TEXT_COLOR
	elif mode == Mode.HELP_UNPROBABLE: desiredCol = UNHELPFUL_YES_TEXT_COLOR

enum Mode{
	POTENTIAL, HELP_UNPROBABLE, HELP
}
