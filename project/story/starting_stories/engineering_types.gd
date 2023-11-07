extends SimpleStory

var npc_name := "Aubrey"

var text := [
	'"Have you thought about engineering?"',
	'"It\'s a great field to get into and there are so many different types of engineering!"',
	'"What do you like to do?"',
]

var options := {
	"I like to build things.": {
		"text": '"You should look into mechanical or electrical engineering!"',
		"effects": {
			"engineering": 1,
			"curiosity": 1,
		}
	},
	"I like to solve problems.": {
		"text": '"You should look into chemical or software engineering!"',
		"effects": {
			"engineering": 1,
			"resilience": 1,
		}
	},
	"I like to help people.": {
		"text": '"You should look into biomedical engineering!"',
		"effects": {
			"engineering": 1,
			"engagement": 1,
		}
	},
}
