extends Control
class_name Letter

@export_color_no_alpha
var GRAY_COLOR: Color;
@export_color_no_alpha
var YELLOW_COLOR: Color;
@export_color_no_alpha
var GREEN_COLOR: Color;

@onready
var colors: Array[Color] = [GRAY_COLOR, YELLOW_COLOR, GREEN_COLOR]

const GRAY_INDEX = 0
const YELLOW_INDEX = 1
const GREEN_INDEX = 2

@onready
var nowCol: Color = GRAY_COLOR
var colorIndex := 0
var wordFinished := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	nowCol = nowCol * .8 + colors[colorIndex] * .2
	$Panel.modulate = nowCol


func set_letter(letter: String) -> void:
	if letter.is_empty(): 
		$Label.text = ""
		return
	$Label.text = letter[-1]

func get_letter() -> String:
	return $Label.text

#func _gui_input(event: InputEvent) -> void:
	#print(get_parent().name + " " + event.as_text())


func _on_link_button_pressed() -> void:
	if not wordFinished: return
	colorIndex = (colorIndex + 1) % colors.size()
