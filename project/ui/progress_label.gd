@tool
extends Control


@export_range(0,1) var ratio : float:
	set(value):
		ratio = value


@export var text : String:
	set(value):
		text = value
		%Label.text = value

@export_range(0,1) var animation_speed := 0.30


func _process(_delta):
	if Engine.is_editor_hint():
		%ProgressBar.ratio = ratio
	else:
		%ProgressBar.ratio += (ratio - %ProgressBar.ratio) * animation_speed
	
	# If we're at basically 100%, show the star
	if %ProgressBar.ratio >= 0.99: 
		%StarLabel.visible = true
	
	
