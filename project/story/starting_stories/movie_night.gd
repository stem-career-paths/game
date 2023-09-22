extends SimpleStory

var text := "At a sleepover with some friends, you watched two movies. Which was more interesting?"

var npc_name := "Hilda"

var options := {
	"The Martian":
	{
		"text": "Living on Mars is my new dream!",
		"effects": {
			"science": +3,
			"mathematics": +2,
			"curiosity": +1
		}
	},
	"Big Hero 6":
	{	
		"text": "Robots are awesome, can I really make my own?",
		"effects": {
			"technology": +3,
			"engineering": +2,
			"curiosity": +1
		}
	}
}
