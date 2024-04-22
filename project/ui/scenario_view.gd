extends PanelContainer

var world : World

var npc : Npc:
	set(value):
		npc = value
		if npc!=null:
			%Npc.texture = npc.underclass_image\
				if Year.is_underclass(world.year) \
				else npc.upperclass_image
			%NameLabel.text = npc.name + " " # Extra whitespace at the end


var location : Texture:
	set(value):
		location = value
		%Location.texture = location
