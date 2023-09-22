extends SimpleStory

var text := "You're hanging out outside and looking for something to do."

var npc_name := "Mary"

var options := {
	"Build a secret base":
	{
		"text": "Let's build a secret base... in a tree!",
		"effects": {
			"engineering": +2,
			"curiosity": +1
		}
	},
	"Bug Hunting":
	{
		"text": "I saw some cool rocks over there, let's go bug hunting!",
		"effects": {
			"science": +2,
			"curiosity": +1
		}
	}
}
