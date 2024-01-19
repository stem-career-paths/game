extends SimpleStory

var text := '"I can\'t figure out this science homework. What should I do?"'

var npc_name := "Steven"

var options := {
	"Let\'s study together": {
		"text": '"Really? That would be great. Thanks!"',
		"effects": {
			"science": +1,
			"engagement": +1,
		}
	},
	"Ask the teacher for help": {
		"text": '"Yeah, they are there to help me. Might as well talk to them!"',
		"effects": {
			"resilience": +1,
			"curiosity": +1
		},
	},
	"Keep trying": {
		"text": '"I\'ve been trying! It feels like I\'m banging my head up against a wall..."'
	},
	"Give up": {
		"text": "I don't need help. I’ll just fail, it doesn't matter.",
	}
}
