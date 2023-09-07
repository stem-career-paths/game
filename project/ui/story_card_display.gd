extends VBoxContainer

var card : StoryCard
var world : World

@onready var _story_text := $StoryText
@onready var _options_box := %OptionsBox
@onready var _effects_box := %EffectsBox


func _ready():
	assert(card!=null, "card must be specified prior to adding to node tree")
	assert(world!=null, "world must be specified prior to adding to node tree")
	_update_display()


## Update this control to show the content of the current card
func _update_display()->void:
	_story_text.text = card.text
	_clear(_options_box)
	_clear(_effects_box)
	
	if not card.effects.is_empty():
		for effect in card.effects:
			# Set up a label to show that this effect is applied
			var label := Label.new()
			label.text = "%s: %+d" % [effect.attribute_name.to_pascal_case(), effect.value]
			_effects_box.add_child(label)
			effect.apply(world)
	
	if card.options != []:
		for option in card.options:
			# Put the option into a StoryOption variable for ease of type hinting.
			var story_option := option as StoryOption 
			var button := Button.new()
			button.text = story_option.text
			button.pressed.connect(func():
				world.card = option.make_card()
			)
			_options_box.add_child(button)
	else:
		var ok_button := Button.new()
		ok_button.text = "OK"
		
		if world.deck.is_empty():
			print("Uh oh, there are no more story cards")
			ok_button.disabled = true
		else:
			ok_button.pressed.connect(func():
				world.card = world.deck.draw()
			)
		
		_options_box.add_child(ok_button)


func _clear(container:Control)->void:
	while container.get_child_count() > 0:
		container.remove_child(container.get_child(0))
