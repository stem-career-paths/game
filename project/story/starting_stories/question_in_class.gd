extends SimpleStory

var text := "You're confused about a question for class."

var npc_name := "Steven"

var options := {
	"Ask the teacher for help":
	{
		"text": "They're there to help me. Might as well utilize them!",
		"effects": {
			"resilience": +1,
			"curiosity": +1
		},
	},
	"Give up": {
		"text": "I don't need help. I’ll just fail, it doesn't matter.",
		"effects": {
			"curiosity": -1,
			"resilience": -1
		}
	}
}
