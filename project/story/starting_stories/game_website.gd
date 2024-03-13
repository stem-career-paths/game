extends SimpleStory

var text := [
	"Hilda is on a tablet, not paying attention to class.",
	'"Sometimes I wish they had more games on this website that worked for [i]mobile[/i]."'
]

var npc_name := "Hilda"

var location := "classroom"

var options := {
	"Pay attention!": {
		"text": '"Huh? Is something happening in class?"'
	},
	"Make your own games": {
		"text": '"Huh, I\'ve never thought of that before. More games means more of them might be mobile friendly, right?"',
		"effects": {
			"technology": +1
		}
	},
	"There's more games on the computer version": {
		"text": '"I know! It\'s so frustrating that I can\'t play them whenever! They should change that."',
		"effects": {
			"technology": +1
		}
	}
}
