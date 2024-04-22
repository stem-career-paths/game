class_name NpcDefinition extends Resource

@export var name : String
@export var upperclass_image : Texture
@export var underclass_image : Texture

func create_npc() -> Npc:
	var npc := Npc.new()
	npc.name = name
	npc.upperclass_image = upperclass_image
	npc.underclass_image = underclass_image
	return npc
