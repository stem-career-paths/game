extends SimpleStory

var text := "Do you want to play Dungeons & Dragons with me?!"

var npc_name := "Steven"

var options := {
	"I'll make a Rogue!": {
		"text": "Awesome!",
		"effects": {
			"engagement": 1,
			"curiosity": 1,
		},
	},
	"I can be the DM!": {
		"text": "Awesome!",
		"effects": {
			"engineering": 1,
			"curiosity": 1,
		},
	},
	"Er... No thanks.": {
		"text": "\"Oh, Okay.\" \nYou rejected Steven.",
		"effects": {
			"curiosity": -1,
		},
	},
}
