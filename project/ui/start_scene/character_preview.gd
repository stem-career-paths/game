@tool
extends PanelContainer


@export var npc_image : Texture:
	set(value):
		npc_image = value
		if %Npc != null:
			%Npc.texture = npc_image


@export var location_image : Texture:
	set(value):
		location_image = value
		if %Location != null:
			%Location.texture = location_image


func _ready() -> void:
	%Npc.texture = npc_image
	%Location.texture = location_image
