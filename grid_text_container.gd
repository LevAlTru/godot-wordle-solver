extends CenterContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setWords(words: Array[String], mode: TextOnTheGrid.Mode) -> void:
	var textContainers := getContainerChildren($GridContainer)
	if mode == TextOnTheGrid.Mode.HELP:	textContainers = textContainers.slice(0, textContainers.size())
	for i in range(textContainers.size()):
		var wordIndex: int = max(i, roundi(i * (words.size() as float) / textContainers.size()))
		if wordIndex < words.size():
			textContainers[i].setText(words[wordIndex], mode)
		else:
			textContainers[i].setText("")

func getContainerChildren(node: Node) -> Array[TextOnTheGrid]:
	var c := node.get_children()
	var t: Array[TextOnTheGrid] = []
	for cchi in c:
		if cchi is TextOnTheGrid:
			t.append(cchi)
	return t

func _on_margin_container_set_words(words: Array[String], mode: TextOnTheGrid.Mode) -> void:
	setWords(words, mode)
	$Label.modulate.a = 1 if words.is_empty() else 0
	pass # Replace with function body.
