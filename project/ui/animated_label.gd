class_name AnimatedLabel extends Label

@export var characters_per_second := 50.0

var _tween : Tween

func _ready() -> void:
	_restart_animation()


func _set(property, value) -> bool:
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


func _on_game_screen_tapped_anywhere() -> void:
	_tween.kill()
	visible_ratio = 1.0
