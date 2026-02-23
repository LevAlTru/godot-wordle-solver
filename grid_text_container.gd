extends CenterContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setWords(words: Array) -> void:
	var textContainers := getContainerChildren($GridContainer)
	if words.is_empty():
		for cont in textContainers:
			cont.setText("")
		return
	var areWordsSorted := words[0] is Array
	if not areWordsSorted:
		for i in range(textContainers.size()):
			var wordIndex: int = max(i, roundi(i * (words.size() as float) / textContainers.size()))
			if wordIndex < words.size():
				textContainers[i].setText(words[wordIndex])
			else:
				textContainers[i].setText("")
			if areWordsSorted: i += 1
	
	else:
		for i in range(textContainers.size()):
			#var wordIndex: int = max(i, roundi(i * (words.size() as float) / textContainers.size()))
			if i < words.size():
				textContainers[i].setText(words[i][0], TextOnTheGrid.Mode.HELP if words[i][1] > 0 else TextOnTheGrid.Mode.HELP_UNPROBABLE)
			else:
				textContainers[i].setText("")
			if areWordsSorted: i += 1

func getContainerChildren(node: Node) -> Array[TextOnTheGrid]:
	var c := node.get_children()
	var t: Array[TextOnTheGrid] = []
	for cchi in c:
		if cchi is TextOnTheGrid:
			t.append(cchi)
	return t

func _on_margin_container_set_words(words: Array) -> void:
	setWords(words)
	$Label.modulate.a = 1 if words.is_empty() else 0
	pass # Replace with function body.
