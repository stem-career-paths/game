extends SimpleStory

var npc_name := "Mary"

var text := [
	"This is multiple lines of text.",
	"I am now on the second of three lines.",
	"This is the third of three lines."
]

var options := {
	"The Only Option": {
		"text": [
			"This is the first of two lines of option results.",
			"This is the second of two lines of option results."
		],
		"effects": {
			"science": +2,
		}
	}
}
