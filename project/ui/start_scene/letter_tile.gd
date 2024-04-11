@tool extends PanelContainer

@export var letter := "X":
	set(value):
		letter = value
		$Label.text = letter
