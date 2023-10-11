extends SimpleStory

var text := '"I didn\'t know that you liked robotics! I am so glad you are here. I... don\'t know much about any of this, though. Maybe I should just be on the media team."'

var npc_name := "Mary"

var options := {
	"If that\'s what you want." : {
		"text": '"I hope I am good at it."',
	},
	"Let's WELD something!": {
		"text": '"I... guess I could try that? Sure, why not? This is my chance, right?"',
		"effects": {
			"resilience": +1,
			"engineering": +1,
			"engagement": +1,
		}
	}
}
