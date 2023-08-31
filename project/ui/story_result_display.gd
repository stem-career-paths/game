extends VBoxContainer

signal dismissed

var result : StoryResult
var world : World


func _ready():
	assert(result!=null, "result must be specified")
	assert(world!=null, "world must be specified")
	$Label.text = result.get_text(world)


func _on_ok_button_pressed():
	dismissed.emit()
