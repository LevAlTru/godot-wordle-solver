extends Node
class_name WordSearchResult

var temp: Dictionary[String, int] = {}
var lettersFound: Dictionary[String, int] = {}
var words : Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func bufferIncreaseLetter(l: String) -> void:
	var letter := l[0]
	if temp.has(letter): temp[letter] = temp[letter] + 1
	else: temp[letter] = 1

func confirmIncrease(b: bool = true) -> void:
	if b:
		#print(temp)
		for t in temp:
			if lettersFound.has(t): lettersFound[t] = lettersFound[t] + temp[t]
			else: lettersFound[t] = temp[t]
		for l in lettersFound:
			if lettersFound[l] <= 0: lettersFound.erase(l)
	temp.clear()

func setWords(s: Array[String]) -> WordSearchResult:
	words = s.duplicate()
	return self
