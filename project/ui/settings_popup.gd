@tool
extends PopupMenu


func _get_configuration_warnings():
	if visible:
		return ["Popup should be hidden to prevent errors when running integration tests"]
	else:
		return []


func _on_visibility_changed():
	update_configuration_warnings()
