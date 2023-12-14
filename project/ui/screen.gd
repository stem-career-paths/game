extends Control

@export var content_scene := preload("res://ui/start_scene.tscn")

@onready var _content := $Content

func _ready():
	if content_scene == null:
		push_warning('No content given to app screen. Nothing will be shown.')
	else:
		var scene := content_scene.instantiate()
		$Content.add_child(scene)
		scene.owner = self
	
func change_scene(new_scene: Control) -> void:
	assert(new_scene != null)
	assert(_content.get_child_count() == 1, "There should only be one scene on the screen at a time")
	_content.remove_child(_content.get_child(0))
	_content.add_child(new_scene)
	new_scene.owner = self
