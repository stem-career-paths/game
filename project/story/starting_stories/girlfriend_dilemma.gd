extends SimpleStory

var text := '"Oh man... I got accepted into the college I really wanted but... it\'s out of state! What am I gonna do about my girlfriend?"'

var npc_name := "Steven"

var location := "hallway"

var years := [ Year.Name.JUNIOR, Year.Name.SENIOR ]

var options := {
	"Break up with her now": {
		"text": [
			'"I guess that would lessen the heartbreak I\'d get later but..."',
			'"I can\'t give up now because of the [i]potential[/i] of it going bad! I\'d give up so much good!"'
		],
		"effects": {
			"resilience": +1
		}
	},
	"Try long distance": {
		"text": '"Long distance is pretty hard, I\'ve heard. But I can give it a shot! We already call almost daily!"',
		"effects": {
			"technology": +1
		}
	},
	"Try for a different school": {
		"text": '"I could, but nothing local has any of the programs I want. This might just have to happen."'
	},
	"You have a GIRLFRIEND??": {
		"text": '"Hm? Yeah? She goes to the private school nearby. Haven\'t I told you about her?"',
		"effects": {
			"curiosity": +1
		}
	}
}
