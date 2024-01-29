extends PanelContainer

var npc : Npc:
	set(value):
		npc = value
		if npc!=null:
			%Npc.texture = npc.image
			%NameLabel.text = npc.name + " " # Extra whitespace at the end


var location : Texture:
	set(value):
		location = value
		%Location.texture = location
