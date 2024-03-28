extends Control

func play(presenter, content:Array[EpilogueText]) -> void:
	for entry in content:
		var label := preload("res://ui/epilogue/epilogue_label.tscn").instantiate()
		label.text = entry.text
		if entry.type == EpilogueText.Type.MAIN_POINT:
			label.text = label.text.to_upper()
		add_child(label)
	
	await presenter.show_continue()
