extends SimpleStory

var text := [
	'As you sit down in your seat, you notice that Ms. Finch doesn\'t seem like her usual self.\n"Good morning.... class..... [i]sigh[/i]"',
	'"I\'m sorry. I have no plans for today. We can watch a movie."\nShe struggles to get the projector and movie working.'
]

var npc_name := "Ms. Finch"

var location := "classroom"

var options := {
	"Ask what's wrong": {
		"text": [
			'"Mr. Squeakers, my hamster, passed away last night. I\'m still a little sad over it."',
			'She smiles. "Thank you for asking. I feel a little better. Now, who wants to learn about blood cells?"'
		],
		"effects": {
			"engagement": +1
		}
	},
	"Be on your best behavior": {
		"text": "You and your classmates act on your best behavior. By the time the bell rings, Ms. Finch is a lot more chipper.",
		"effects": {
			"resilience": +1
		}
	},
	"Help her set up": {
		"text": [
			"You help her get the projector up and running. Something was unplugged.",
			'"Thank you. I\'ve been having a bit of a bad day, so your kindess really means a lot."'
		],
		"effects": {
			"technology": +1
		}
	}
}
