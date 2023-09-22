extends SimpleStory

var text := '"Do you want to play Dungeons & Dragons with me?!"'

var npc_name := "Steven"

var options := {
	"I'll make a Rogue!": {
		"text": '"Awesome! Sneaking around the dungeons is gonna be fun."',
		"effects": {
			"engagement": 1,
			"curiosity": 1,
		},
	},
	"I can be the DM!": {
		"text": '"Great! You look a little nervous, but I think you will do great."',
		"effects": {
			"engineering": 1,
			"curiosity": 1,
		},
	},
	"Er... No thanks.": {
		"text": "\"Oh, Okay.\" \nSteven walks away dejectedly.",
		"effects": {
			"curiosity": -1,
		},
	},
}
