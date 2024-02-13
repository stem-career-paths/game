extends TextureButton

const _FULLSCREEN_MODES := [DisplayServer.WINDOW_MODE_FULLSCREEN, DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN]
const _FULLSCREEN_ID := 0
const _MUTE_SFX_ID := 1

@onready var _settings_popup :PopupMenu = %SettingsPopup
@onready var _sfx_bus_index := AudioServer.get_bus_index('Sfx')

func _ready():
	# Make sure the popup is always starting invisible, even if someone forgets
	# to set that in the editor
	_settings_popup.visible = false
	

func _on_settings_popup_id_pressed(id):
	match id:
		_FULLSCREEN_ID:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED \
				if _is_fullscreen() \
				else DisplayServer.WINDOW_MODE_FULLSCREEN)
		_MUTE_SFX_ID:
			var is_muted := AudioServer.is_bus_mute(_sfx_bus_index)
			AudioServer.set_bus_mute(_sfx_bus_index, not is_muted)
	
	Sfx.play_click_sound()


func _is_fullscreen() -> bool:
	var mode := DisplayServer.window_get_mode()
	return mode in _FULLSCREEN_MODES


func _on_pressed():
	Sfx.play_click_sound()
	
	# Place the popup in the right location
	var offset := Vector2(0, size.y)
	_settings_popup.position = get_screen_position() + offset
	
	# Configure the checkboxes based on the current game state.
	# Note that set_item_checked works on *index*, not *id*, so a 
	# conversion is necessary. 
	var fullscreen_index := _settings_popup.get_item_index(_FULLSCREEN_ID)
	_settings_popup.set_item_checked(\
		fullscreen_index, _is_fullscreen())
	var mute_sfx_index := _settings_popup.get_item_index(_MUTE_SFX_ID)
	_settings_popup.set_item_checked(
		mute_sfx_index, 
		AudioServer.is_bus_mute(_sfx_bus_index))
	
	_settings_popup.popup()
