extends Control

const _FULLSCREEN_MODES := [DisplayServer.WINDOW_MODE_FULLSCREEN, DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN]
const _FULLSCREEN_ID := 0

@export var scroll_speed: float = 300.0

@onready var _main_scene := preload("res://ui/main_scene.tscn")
@onready var _settings_popup := %SettingsPopup

func _ready() -> void:
	# Add debug options if running from the editor
	if OS.has_feature("editor"):
		_add_debug_start_options()


func _add_debug_start_options() -> void:
	_add_turns_per_year_buttons()


func _add_turns_per_year_buttons() -> void:
	for i in range(1, World.DEFAULT_TURNS_PER_YEAR + 1):
		var button: Control = preload("res://ui/audible_button.tscn").instantiate()
		button.text = str(i)
		button.pressed.connect(_on_turns_per_year_button_pressed.bind(i))
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		%DebugOptions.add_child(button)


func _on_turns_per_year_button_pressed(turns_per_year: int) -> void:
	var new_scene: Control = _main_scene.instantiate()
	new_scene.call_deferred("set_turns_per_year", turns_per_year)
	owner.change_scene(new_scene)


func _on_start_button_pressed() -> void:
	var new_scene: Control = _main_scene.instantiate()
	owner.change_scene(new_scene)


func _on_settings_button_pressed():
	var button : TextureButton = %SettingsButton
	var offset := Vector2(0, button.size.y)
	_settings_popup.position = button.get_screen_position() + offset
	
	_settings_popup.set_item_checked(_FULLSCREEN_ID, _is_fullscreen())
	
	_settings_popup.popup()


func _is_fullscreen() -> bool:
	var mode := DisplayServer.window_get_mode()
	return mode in _FULLSCREEN_MODES


func _on_settings_popup_id_pressed(id):
	if id == _FULLSCREEN_ID:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED \
			if _is_fullscreen() \
			else DisplayServer.WINDOW_MODE_FULLSCREEN)
