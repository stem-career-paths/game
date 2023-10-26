extends Control

var npc : Npc :
	set(value):
		npc = value
		if npc!=null:
			%MainImage.texture = npc.image
			%CharacterName.text = npc.name
