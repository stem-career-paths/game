extends SimpleStory

var text := '"Were you at the soccer game last night? Did you see how the goalie [b]didn\'t[/b] give up even when things got [b]really[/b] hard?"'

var npc_name := "Hilda"

var options := {
	"That shows resilience!": {
		"text": '"[i]That\'s[/i] the word for it, right!"',
		"effects": {
			"resilience": +1
		},
	},
	"I would have given up.": {
		"text": '"But the cool thing is how the goalie didn\'t! I think it\'s worth it to see how it\'ll all end."',
	},
	"Remember those crazy goals?": {
		"text": '"YES!! When they hit the ball and it went [i]P-TING[/i] and bounced off the goal post into the goal? [i]SO COOl![/i]"',
		"effects":{
			"mathematics": +1
		} 
	},
	"I missed it. I had to walk my dog.": {
		"text": '"Ha, whatever dude. You don\'t even [i]have[/i] a dog."',
	}
}
