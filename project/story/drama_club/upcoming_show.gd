extends SimpleStory

var npc_name := "Hilda"

var text := [
	'"Oh man oh man oh man. There is a show this weekend, and I have math and English exams coming up."',
	'"I am royally stressed."'
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
		"text": '"Yeah, I have responsibilities to both. I will need to make a schedule for sure."',
		"effects": {
			"resilience": +2,
		}
	}
}
