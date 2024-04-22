class_name NpcDefinition extends Resource

@export var name : String
@export var student := true
@export var images : Array[Texture]

func create_npc() -> Npc:
	var npc := Npc.new()
	npc.name = name
	npc.student = student
	npc.images = images
	return npc
