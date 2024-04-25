extends SimpleStory

const _AP_PHYSICS := "AP Physics"
const _AP_DIR := "res://story/ap_physics/class/"

var text := '"I just reviewed my four year plan, and I\'m taking AP history! What classes are you planning on taking??"'

var npc_name := "Mary"

var options := {
	"What's AP?": {
		"text": '"I think it stands for Advanced Placement. It\'s a kind of class that teaches college-level stuff, [b]and[/b] you get college credit from it too!"',
		"effects": {
			"curiosity": +1
		}
	},
	"English": {
		"text": '"Do you know who your teacher is? I\'ve heard lots of good things about Mr. Smith."'
	},
	_AP_PHYSICS: {
		"text": '"Oh I heard Ms. Finch teaches that! I hope you have fun!"',
		"effects": {
			"mathematics": +1
		}
	},
	"Algebra": {
		"text": '"Oh, cool! Math isn\'t my strong suit. I\'m kinda dreading taking that class."',
		"effects": {
			"mathematics": +1
		}
	}
}

func on_option_selected(option: String, world : World) -> void:
	if option == _AP_PHYSICS:
			world.add_stories(_AP_DIR)
