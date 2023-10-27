extends SimpleStory

var text := '"Were you at the soccer game last night? Did you see how the goalie didn\'t give up even when things got really hard?"'

var options := {
	"That shows resilience!": {
		"text": '"That\'s the word for it, right."',
		"effects": {
			"resilience": +1
		},
	},
	"I would have given up.": {
		"text": '"Really? I guess that\'s an option. Wouldn\'t it be better to keep trying though?"',
	},
	"I missed it. I had to walk my dog.": {
		"text": '"Ha, whatever dude. You don\'t even have a dog."',
	}
}
