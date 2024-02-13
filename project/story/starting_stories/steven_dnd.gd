extends SimpleStory

const POSITIVE := {
	"Rogue": "I'll make a Rogue!",
	"DM": "I can be the DM!",
	"Curious": "I don\'t know much about it, but I\'d like to!"
}

var text := '"Do you want to play Dungeons & Dragons with me?!"'

var npc_name := "Steven"

var location := "hallway"

var options := {
	POSITIVE["Rogue"]: {
		"text": '"Awesome! Sneaking around the dungeons is gonna be fun."',
		"effects": {
			"engagement": 1,
			"curiosity": 1,
		},
	},
	POSITIVE["DM"]: {
		"text": '"Great! You look a little nervous, but I think you\'ll do [i]great[/i]!"',
		"effects": {
			"engineering": 1,
			"curiosity": 1,
		},
	},
	POSITIVE["Curious"]: {
		"text": '"That\'s okay! I can teach you! It\'s [i]so[/i] fun, I promise!"',
		"effects": {
			"curiosity": 1,
		}
	},
	"Er... No thanks. ": {
		"text": '"Oh, Okay." \nSteven walks away dejectedly.',
	},
}

func on_option_selected(option:String, world: World) -> void:
	if POSITIVE.values().has(option):
		var dir := DirAccess.open("res://story/rpg")
		world.add_stories(dir)
		
