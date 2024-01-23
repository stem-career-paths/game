class_name AnimationHandle extends RefCounted

signal stopped

var _animation_player : AnimationPlayer


func _init(animation_player:AnimationPlayer):
	assert(animation_player != null)
	_animation_player = animation_player


## Stop the animation for which this is a handle.
## This will emit the [stopped] signal whether the animation was running or not.
func stop_animation() -> void:
	_animation_player.stop()
	stopped.emit()
