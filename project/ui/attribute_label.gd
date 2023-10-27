extends Control

const _STAR := "★"

@export var text : String:
	set(value):
		text = value
		%Label.text = value

@export var animation_duration := 0.3

var attribute : Attribute:
	set(value):
		assert(value!=null, "Attribute may not be null")
		assert(attribute==null, "Attribute may only be specified once")
		attribute = value
		attribute.value_changed.connect(func(_old_value, _new_value):
			# In the simple case, this animates the progress bar upward to
			# its new value. However, we also have to consider the case
			# where the ratio "loops" around, hitting 100% and then going back
			# to n>0% toward the next rank.
			var target_ratio := attribute.get_ratio()
			if target_ratio > %ProgressBar.ratio:
				create_tween()\
					.tween_property(%ProgressBar, "ratio", attribute.get_ratio(), animation_duration)\
					.set_ease(Tween.EASE_IN)
			else:
				var tween_to_full := create_tween()
				tween_to_full.tween_property(%ProgressBar, "ratio", 1.0, animation_duration / 2)
				tween_to_full.set_ease(Tween.EASE_IN)
				await tween_to_full.finished
				%ProgressBar.ratio = 0
				var tween_from_zero := create_tween()
				tween_from_zero.tween_property(%ProgressBar, "ratio", target_ratio, animation_duration / 2)
				tween_from_zero.set_ease(Tween.EASE_IN)
		)
		attribute.rank_changed.connect(func(_old_rank, new_rank):
			_set_visible_stars(new_rank)
		)


func _set_visible_stars(count:int) -> void:
	var label := %StarLabel
	label.text = ""
	for i in count:
		label.text += _STAR
