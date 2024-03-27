extends Control

const INFO_SITE_URL := "https://stem-careers-game.github.io/"

@export var scroll_speed: float = 300.0

@onready var _main_scene := preload("res://ui/main_scene.tscn")


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
	# Track game start to Google Analytics
	if OS.get_name() == "Web":
		JavaScriptBridge.eval("""
		  gtag("event", "level_start", {
				"level_name": "Regular Game"
			});
		""")
	
	var new_scene: Control = _main_scene.instantiate()
	owner.change_scene(new_scene)


func _on_credits_button_pressed() -> void:
	%CreditsOverlay.visible = true


func _on_credits_panel_dismissed() -> void:
	%CreditsOverlay.visible = false


func _on_info_page_button_pressed() -> void:
	OS.shell_open(INFO_SITE_URL)
