extends Control

var world : World:
	set(value):
		world = value
		%CharacterDisplay.character = world.character

signal _option_selected(option: String)
signal _tapped_anywhere


@onready var _anim_player := $AnimationPlayer
@onready var _button_area := %ButtonArea
@onready var _effect_label : Label = %EffectLabel
@onready var _main_image : TextureRect = %MainImage

func _ready():
	assert(world!=null)
	_anim_player.play("RESET")


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		_tapped_anywhere.emit()


func show_confirmation() -> void:
	_anim_player.play("show_advance_instructions")
	await _tapped_anywhere


func show_effects(effects: Dictionary) -> void:
	var effect_text := ""
	for attribute in effects.keys():
		world.character[attribute] += effects[attribute]
		effect_text += "%+d %s\n" % [effects[attribute], attribute]
	_effect_label.text = effect_text
	_anim_player.play("show_effect")
	await _anim_player.animation_finished


func show_npc(npc:Npc) -> void:
	%MainImage.texture = npc.image


func show_options(options: Array) -> String:
	var buttons : Array[Button] = []
	for option in options:
		var button := Button.new()
		button.text = option
		button.pressed.connect(func(): _option_selected.emit(option))
		_button_area.add_child(button)
		buttons.append(button)
	
	var selection = await _option_selected
	
	for button in buttons:
		button.disabled = true
	
	return selection


func show_text(text: String) -> void:
	%Text.text = text


func show_image(image: String) -> void:
	if image!=null:
		_main_image.texture = load("res://images/%s.png" % image)


func _clear(container:Control) -> void:
	while container.get_child_count() > 0:
		container.remove_child(container.get_child(0))
