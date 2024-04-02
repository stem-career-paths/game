extends SimpleStory

const MEAN_OPTION := "OK hippie"

var text := '"Sometimes I feel so cooped up in here. I can\'t [i]wait[/i] to go camping this weekend with the scouts."'

var location := "classroom"

var npc_name := "Hilda"

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
	"Can I come with you?": {
		"text": '"I think so? I\'ll ask the scout leader tomorrow."',
	},
	MEAN_OPTION: {
		"text": '"Don\'t knock it til you\'ve tried it. Camping [b]RULES[/b]."',
	},
}


func on_option_selected(option: String, world : World) -> void:
	match option:
		MEAN_OPTION:
			world.character.add_tag(Tags.Tag.MEAN_TO_HILDA)
