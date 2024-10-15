extends Control

## How long is the crossfade, in seconds
@export var crossfade_speed := 0.5

## The child index that is currently shown
var _index := 0

@onready var _cast: Control = %Cast
@onready var _cast_previews : Array[Node] = _cast.get_children()


func _ready() -> void:
	_cast_previews.shuffle()
	for i in _cast_previews.size():
		if i != _index:
			_cast_previews[i].modulate.a = 0


func _on_visible_duration_timeout() -> void:
	var current := _cast_previews[_index]
	create_tween().tween_property(current, "modulate:a", 0, crossfade_speed)
	_index = (_index + 1) % _cast_previews.size()
	var next := _cast_previews[_index]
	next.modulate.a = 1
	_cast.move_child(next, 0)
