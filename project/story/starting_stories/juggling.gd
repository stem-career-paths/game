extends SimpleStory

var text := [
	"You find Mary asleep at her desk. She wakes up when you call her name a couple of times.",
	'"[i]yawn...[/i] Sorry about that. Yesterday I had club, and soccer practice, and ice cream with my friends, and homework..."',
	'"Guess I didn\'t get much sleep! It can be a lot to juggle, y\'know?"'
]

var npc_name := "Mary"

var location := "classroom"

var options := {
	"Tough it out": {
		"text": [
			'"[i]yawn...[/i] Yeah, I\'ll get through it... somehow.... zzz..."',
			"Mary falls back asleep."
		],
		"effects": {
			"resilience": +1
		}
	},
	"Play less soccer": {
		"text": '"But I love soccer! Though, it does make me tired. Maybe I\'ll talk to coach about playing less on club days."',
		"effects": {
			"resilience": +1
		}
	},
	"Attend club less": {
		"text": '"My parents like me attending club. I suppose I don\'t need to go to [i]every[/i] meeting, though."',
		"effects": {
			"resilience": +1
		}
	},
	"Hang out with friends less": {
		"text": "\"My friends are a good break from everything. But, I guess that doesn't mean I should say 'yes' when I'm busy.\"",
		"effects": {
			"resilience": +1
		}
	}
}
