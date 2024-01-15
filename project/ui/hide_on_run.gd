## A simple script that sets its node to transparent when the game is run
extends ColorRect

func _ready():
	color.a = 0
