extends Control


@export var _scroll_speed: float = 300.0

var _index = 0

@onready var _image_scroll_container: ScrollContainer = %ImageScrollContainer
@onready var _image_parent: Container = %ImageScrollContainer.get_child(0)
@onready var _cast: Cast = Cast.new()
@onready var _main_scene := preload("res://ui/main_scene.tscn")


func _ready() -> void:
	_cast.load_cast("res://cast/")

	for image in _image_parent.get_children():
		image.texture = _get_image()

	# Add debug options if running from the editor
	if OS.has_feature("editor"):
		_add_debug_start_options()


func _process(delta) -> void:
	_image_scroll_container.scroll_horizontal += delta * _scroll_speed

	if _image_scroll_container.scroll_horizontal >= 720:
		_swap_children_images()


func _get_image() -> Texture:
	var image: Texture = _cast._dictionary[_cast._dictionary.keys()[_index]].image
	_index += 1

	if _index >= _cast._dictionary.size():
		_index = 0

	return image


func _swap_children_images() -> void:
	var first_child = _image_parent.get_child(0)
	_image_parent.remove_child(first_child)
	_image_parent.add_child(first_child)

	_image_parent.get_child(1).texture = _get_image()

	_image_scroll_container.scroll_horizontal = 0


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
