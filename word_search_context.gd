extends Node
class_name WordSearchContext

var _yellowLetters: Dictionary[String, int] = {}
var _greenLetters: Array[String] = ["", "", "", "", ""]
var _greyLetters: Array[String] = []
var _unusable := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setGreen(i: int, l: String) -> WordSearchContext:
	_checkLetterCount(_greenLetters.get(i).is_empty())
	assert (i >= 0 and i <= 4, "ERROR: total number of letter went over 5")
	_greenLetters.set(i, l[0].to_lower())
	return self
	
func addYellow(l: String) -> WordSearchContext:
	_checkLetterCount()
	var let := l[0].to_lower()
	if _yellowLetters.has(let):
		_yellowLetters[let] = _yellowLetters[let] + 1
	else:_yellowLetters[let] = 1
	return self
	
func setYellow(l: String, i: int) -> WordSearchContext:
	var let := l[0].to_lower()
	var nteger := _yellowLetters[let] if _yellowLetters.has(let) else 0
	_checkLetterCount(i - nteger)
	_yellowLetters[let] = i
	return self
	
func addGrey(l: String) -> WordSearchContext:
	_checkLetterCount()
	var let := l[0].to_lower()
	if not _greyLetters.has(let): _greyLetters.append(let)
	return self

func _checkLetterCount(plus: int = 1) -> void:
	var i := plus
	#for g in _greenLetters:
		#if not g.is_empty(): i += 1
	i += getNonEmptyGreensCount()
	for y in _yellowLetters:
		i += _yellowLetters[y]
	assert(i < 6, "ERROR: the number of letters is more than 5")

func isEmpty() -> bool:
	for g in _greenLetters: if not g.is_empty(): return false
	return _yellowLetters.is_empty() and _greyLetters.is_empty()
	
func makeUnusable() -> WordSearchContext:
	_unusable = true
	return self

func _to_string() -> String:
	return str(_greenLetters) + " : " + str(_yellowLetters) + " : " + str(_greyLetters)

func getNonEmptyGreensCount() -> int:
	var i := 0
	for g in _greenLetters:
		if not g.is_empty(): i += 1
	return i
