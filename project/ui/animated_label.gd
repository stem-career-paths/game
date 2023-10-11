class_name AnimatedLabel extends Label

@export var characters_per_second := 50.0

var _tween : Tween

func _ready():
	_restart_animation()


func _set(property, value):
	if property=="text":
		text = value
		_restart_animation()
		return true
	else:
		return false


func _restart_animation() -> void:
	if _tween != null:
		_tween.kill()
	
	visible_ratio = 0
	_tween = create_tween()
	_tween.tween_property(self, "visible_ratio", 1.0, 
		text.length() / characters_per_second)
