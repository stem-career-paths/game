extends SimpleStory

var text := '"I didn\'t know that you liked robotics! I\'m so glad you are here. I... don\'t know much about any of this, truth be told. Maybe I aughta stick to soccer..."'

var npc_name := "Mary"

var options := {
	"If that\'s what you want." : {
		"text": '"I already know I\'m good at soccer. Maybe another club is too much."',
	},
	"Let's WELD something!": {
		"text": '"Wait wait wait- I get to [b]WELD[/b] in robotics? Pass me the fire stick!!"',
		"end_story": "robotics",
		"effects": {
			"engineering": +1,
			"engagement": +1,
		},
	}
}
