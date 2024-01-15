extends Control

@onready var _content := $Content

func _ready():
	var scene := preload("res://ui/start_scene.tscn").instantiate()
	$Content.add_child(scene)
	scene.owner = self
	
func change_scene(new_scene: Control) -> void:
	assert(new_scene != null)
	assert(_content.get_child_count() == 1, "There should only be one scene on the screen at a time")
	_content.remove_child(_content.get_child(0))
	_content.add_child(new_scene)
	new_scene.owner = self
