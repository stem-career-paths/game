extends SimpleStory

const POSITIVE := {
	"Rogue": "I'll make a Rogue!",
	"DM": "I can be the DM!"
}

var text := '"Do you want to play Dungeons & Dragons with me?!"'

var npc_name := "Steven"

var options := {
	POSITIVE["Rogue"]: {
		"text": '"Awesome! Sneaking around the dungeons is gonna be fun."',
		"effects": {
			"engagement": 1,
			"curiosity": 1,
		},
	},
	POSITIVE["DM"]: {
		"text": '"Great! You look a little nervous, but I think you will do great."',
		"effects": {
			"engineering": 1,
			"curiosity": 1,
		},
	},
	"Er... No thanks.": {
		"text": "\"Oh, Okay.\" \nSteven walks away dejectedly.",
	},
}

func on_option_selected(option:String, world: World) -> void:
	if POSITIVE.values().has(option):
		var dir := DirAccess.open("res://story/rpg")
		var result := world.add_stories(dir)
		
