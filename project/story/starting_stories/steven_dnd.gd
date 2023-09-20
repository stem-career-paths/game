extends SimpleStory

var text := "Steven invites you to play Dungeons & Dragons, what do you do?"

var image := "ui_test_image"

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
