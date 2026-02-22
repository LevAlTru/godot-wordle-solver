extends Control
class_name Word

@onready
var letter_1: Letter = $LetterRect
@onready
var letter_2: Letter = $LetterRect2
@onready
var letter_3: Letter = $LetterRect3
@onready
var letter_4: Letter = $LetterRect4
@onready
var letter_5: Letter = $LetterRect5

@onready
var letters: Array[Letter] = [
	letter_1,
	letter_2,
	letter_3,
	letter_4,
	letter_5
]

var _is_locked := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func handleInput(input: String) -> Result:
	if _is_locked: return Result.LOCKED
	if input.is_empty(): return Result.FAIL
	if input == "Backspace":
		for i: int in range(letters.size() - 1, -1, -1):
			if !(letters[i] as Letter).get_letter().is_empty():
				(letters[i] as Letter).set_letter("")
				break
	elif input == "Enter":
		#print(getWord())
		if Global.isWorldValid(getWord()):
			#print("valid")
			setLocked(true)
			return Result.WORD_COMPLETE
	else:
		for letter: Letter in letters:
			if letter.get_letter().is_empty():
				letter.set_letter(input)
				break
	return Result.DONE

func setLocked(b: bool) -> void:
	_is_locked = b
	for let: Node in letters:
		if let is Letter:
			let.wordFinished = b
			if not b:
				let.colorIndex = 0

func getWord() -> String:
	return letter_1.get_letter() + \
	letter_2.get_letter() + \
	letter_3.get_letter() + \
	letter_4.get_letter() + \
	letter_5.get_letter()

func getContext() -> WordSearchContext:
	var ctx := WordSearchContext.new()
	for i in range(letters.size()):
		var let := letters[i].get_letter()
		if let.is_empty(): return ctx
		var colorIndex := letters[i].colorIndex
		if colorIndex == Letter.YELLOW_INDEX: ctx.addYellow(let)
		elif colorIndex == Letter.GREEN_INDEX: ctx.setGreen(i, let)
		else: ctx.addGrey(let)
	#print(ctx)
	return ctx

enum Result{
	LOCKED, FAIL, DONE, WORD_COMPLETE
}
