extends Control


@export var _scroll_speed: float = 300.0

var _index = 0

@onready var _image_scroll_container: ScrollContainer = %ImageScrollContainer
@onready var _image_parent: Container = %ImageScrollContainer.get_child(0)
@onready var _cast: Cast = Cast.new()


func _ready() -> void:
	_cast.load_cast("res://cast/")

	for image in _image_parent.get_children():
		image.texture = _get_image()


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


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_screen.tscn")
