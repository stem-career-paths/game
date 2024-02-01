extends VBoxContainer


## Remove the placeholder buttons before starting the game.
## The placeholder buttons that are in the option area allow us to ensure
## the size and style are correct, but they need to be removed before
## starting the game.
func _ready():
	while get_child_count() > 0:
		var placeholder_button := get_child(0)
		remove_child(placeholder_button)
		placeholder_button.free()
