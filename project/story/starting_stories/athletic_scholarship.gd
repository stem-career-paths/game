extends SimpleStory

var npc_name := "Mary"

var text := '"I would love to go to college and play soccer for a university team. Do you think I could do it?"'

var options := {
	"Give it 110%": {
		"text": '"I never understood that phrase. Isn\'t 100% enough?"',
		"effects": {
			"resilience": +1
		}
	},
	"Try to get a scholarship": {
		"text": '"Yeah! I am hoping to get a scholarship so I can afford college. It\'s expensive."',
	},
	"Do you want to be a professional athlete?": {
		"text": "Nah, I love sports and want to keep playing, though. I think I\'d like to be a coach."
	}
}
