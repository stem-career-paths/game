extends Control

const _LABEL_TEXT_META_KEY := "label_text"

@onready var _tree : Tree = %Tree

func _ready() -> void:
	var root := _tree.create_item()
	
	var components_item := _tree.create_item(root)
	components_item.set_text(0, "Components")
	for component in Engine.get_copyright_info():
		var entry := _tree.create_item(components_item)
		entry.set_text(0, component.name)
		var text := ""
		for part in component.parts:
			for copyright in part.copyright:
				text += "Copyright %s\n" % copyright
			text += "License: " + part.license
		entry.set_meta(_LABEL_TEXT_META_KEY, text)
	
	var licenses_item := _tree.create_item(root)
	licenses_item.set_text(0, "Licenses")
	for license in Engine.get_license_info():
		var entry := _tree.create_item(licenses_item)
		entry.set_text(0, license)
		entry.set_meta(_LABEL_TEXT_META_KEY, Engine.get_license_info()[license])

	# Selecting the first item ensures that we don't have a big empty box 
	# at the start.
	components_item.get_next_in_tree().select(0)


func _on_tree_item_selected() -> void:
	var selected := _tree.get_selected()
	if selected.has_meta(_LABEL_TEXT_META_KEY):
		%InfoLabel.text = selected.get_meta(_LABEL_TEXT_META_KEY)
	else:
		%InfoLabel.text = ""
