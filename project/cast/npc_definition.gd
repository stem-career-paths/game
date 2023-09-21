class_name NpcDefinition extends Resource

@export var name : String
@export var image : Texture

func create_npc() -> Npc:
	var npc := Npc.new()
	npc.name = name
	npc.image = image
	return npc
