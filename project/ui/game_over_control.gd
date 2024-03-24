extends VBoxContainer

signal animation_finished

var major: String:
	set(value):
		text = value
		%Major.text = value

var text: String:
	set(value):
		text = value
		%Label.text = value

@onready var animation: AnimationPlayer = %AnimationPlayer


func play() -> void:
	animation.play("play")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "play":
		animation_finished.emit()
