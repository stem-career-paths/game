extends SimpleStory

var text := '"Sometimes I feel so cooped up in here. I cannot wait to go camping this weekend with the scouts."'

var location := "classroom"

var options := {
	"I love being outside": {
		"text": '"[b]Yes![/b] There is so much to see and do."',
		"effects": {
			"science": +1
		}
	},
	"What do you like about it?": {
		"text": '"The scout leader is hilarious and teaches us neat stuff."',
		"effects": {
			"curiosity": +1,
		}
	},
	"OK Hippie": {
		"text": '"Don\'t knock it til you tried it. Camping rules."',
	},
	"FIRE! FIRE!": {
		"text": '"Calm down, Beavis."'
	},
}
