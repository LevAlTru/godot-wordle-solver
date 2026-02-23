extends MarginContainer

signal changedSelectedWord
signal setWords
signal errorMessage

var lastSelectedWord := 0
var selectedWord := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.is_pressed(): return
	var children := getWordChildren($VBoxContainer)
	#print(event.as_text())
	#if event.as_text() == "Shift+Enter":
		#for i in range(children.size()):
			#if i == 4 or not children[i + 1]._is_locked:
				#var wordSearchResults := Global.getWords(children[i].getContext())
				#setWords.emit(wordSearchResults.words, TextOnTheGrid.Mode.POTENTIAL)
				#return
	#if event.as_text() == "Ctrl+Shift+Enter":
		#for i in range(children.size()):
			#if i == 4 or not children[i + 1]._is_locked:
				#var wordSearchResults := Global.getHelpingWords(children[i].getContext())
				#setWords.emit(wordSearchResults, TextOnTheGrid.Mode.HELP)
				#return
	var helperMode := event.as_text() == "Ctrl+Shift+Enter"
	if event.as_text() == "Shift+Enter" or helperMode:
		for i in range(children.size()):
			if i == 4 or not children[i + 1]._is_locked:
				if helperMode:
					var wordSearchResults := Global.getHelpingWords(self.getFullContext())
					setWords.emit(wordSearchResults)
				else:
					var wordSearchResults := Global.getWords(self.getFullContext())
					setWords.emit(wordSearchResults.words)
				return
	var input := Global.formatInput(event)
	lastSelectedWord = selectedWord
	var child: Word = null
	for i in range(children.size()):
		child = children[i]
		var result := child.handleInput(input)
		if result == Word.Result.DONE or result == Word.Result.FAIL: break
		elif result == Word.Result.WORD_COMPLETE:
			child = children[min(i + 1, children.size() - 1)]
			break
		elif result == Word.Result.LOCKED and input == "Backspace" and i < children.size() - 1 and children[i + 1].getWord().is_empty():
			child.setLocked(false)
			break
	if child != null:
		selectedWord = child.global_position.y
		#print(selectedWord)
		if (lastSelectedWord != selectedWord):
			#print("selectedWord")
			changedSelectedWord.emit(selectedWord)
	pass

func getWordChildren(n: Node) -> Array[Word]:
	var c := n.get_children()
	var t: Array[Word] = []
	for cchi in c:
		if cchi is Word:
			t.append(cchi)
	return t

var checkForErrors := true

func _on_check_button_toggled(toggled_on: bool) -> void:
	checkForErrors = toggled_on

func getFullContext() -> WordSearchContext:
	var greaterContext := WordSearchContext.new()
	var children := getWordChildren($VBoxContainer)
	for i in range(children.size()):
		if not children[i]._is_locked: continue
		var context := children[i].getContext()
		print("great: " + str(greaterContext))
		print("     : " + str(context))
		if context.isEmpty(): break
		for let in context._greyLetters:
			#if checkForErrors:
				#if greaterContext._greenLetters.has(let):
					#emitErrorMessage("ERROR: there is a letter that is both green and grey")
					#return WordSearchContext.new().makeUnusable()
				#if greaterContext._yellowLetters.has(let):
					#emitErrorMessage("ERROR: there is a letter that is both yellow and grey")
					#return WordSearchContext.new().makeUnusable()
			if not greaterContext._yellowLetters.has(let):
				greaterContext.addGrey(let)
		for j in range(5):
			var let := context._greenLetters[j]
			if not let.is_empty():
				if checkForErrors and not greaterContext._greenLetters[j].is_empty() and let != greaterContext._greenLetters[j]: 
					emitErrorMessage("ERROR: there is some places that have 2 green letters")
					return WordSearchContext.new().makeUnusable()
				if greaterContext._yellowLetters.has(let): greaterContext.setYellow(let, greaterContext._yellowLetters[let] - 1)
				greaterContext.setGreen(j, let)
		for let in context._yellowLetters:
			#if greaterContext._greenLetters.has(let):
				#greaterContext.setYellow(let, context._yellowLetters[let] - 1)
			if greaterContext._yellowLetters.has(let):
				greaterContext.setYellow(let, max(greaterContext._yellowLetters[let], context._yellowLetters[let]))
			else: greaterContext.setYellow(let, context._yellowLetters[let] - (1 if greaterContext._greenLetters.has(let) else 0))
	
	print(greaterContext)
	return greaterContext


func emitErrorMessage(s: String) -> void:
	printerr(s)
	errorMessage.emit(s)
