extends PanelContainer

signal dismissed

func _on_audible_button_pressed() -> void:
	dismissed.emit()
