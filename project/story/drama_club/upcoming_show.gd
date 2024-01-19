extends SimpleStory

var npc_name := "Hilda"

var text := [
	'"Oh man oh man oh man. There is a show this weekend, and I have math and English tests coming up."',
	'"I\'m ROYALLY stressed."'
]

var options := {
	"Studying is most important": {
		"text" : '"That is easy to say, but what if I screw up the performance?!"',
		"effects": {
			"mathematics": +2,
		}
	},
	"Focus on the show": {
		"text": '"Yes, I NEED to do well... but I also need to pass these tests. UGH."',
	},
	"Do both": {
		"text": ['"I wanna do both! But it\'s really really stressful!"',
				'"Maybe that\'s why my mom keeps telling me to use my planner..."'
			],
		"effects": {
			"resilience": +2,
		}
	}
}
