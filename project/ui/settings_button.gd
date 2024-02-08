extends TextureButton

const _FULLSCREEN_MODES := [DisplayServer.WINDOW_MODE_FULLSCREEN, DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN]
const _FULLSCREEN_ID := 0

@onready var _settings_popup := %SettingsPopup

func _ready():
	# Make sure the popup is always starting invisible, even if someone forgets
	# to set that in the editor
	_settings_popup.visible = false


func _on_settings_popup_id_pressed(id):
	if id == _FULLSCREEN_ID:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED \
			if _is_fullscreen() \
			else DisplayServer.WINDOW_MODE_FULLSCREEN)


func _is_fullscreen() -> bool:
	var mode := DisplayServer.window_get_mode()
	return mode in _FULLSCREEN_MODES


func _on_pressed():
	var offset := Vector2(0, size.y)
	_settings_popup.position = get_screen_position() + offset
	
	_settings_popup.set_item_checked(_FULLSCREEN_ID, _is_fullscreen())
	
	_settings_popup.popup()
