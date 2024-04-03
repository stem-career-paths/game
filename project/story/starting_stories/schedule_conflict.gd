extends SimpleStory

const _DRAMA_CLUB := "Drama Club"
const _ROBOTICS_CLUB := "Robotics Club"
const _DRAMA_DIR := "res://story/drama_club/"
const _ROBOTICS_DIR := "res://story/robotics_club/"

var npc_name := "Ethan"

var text := '"Oh no, the drama club meets the same time as robotics club! What do [i]you[/i] want to do?"'

var options := {
	_DRAMA_CLUB: {
		"text": '"Let\'s rock some Shakespeare like it\'s sixteen... ninety... something!"',
		"effects": {
			"engagement": +1,
		}
	},
	_ROBOTICS_CLUB: {
		"text": '"I call it, \'Doing the Robot.\'"',
		"effects": {
			"technology": +1,
			"engagement": +1,
		},
		"tags": Tags.Tag.JOINED_ROBOTICS_TEAM
	},
	"Neither one sounds interesting": {
		"text": '"Oh, yeah, I guess I was thinking the same thing."'
	}
}


func on_option_selected(option: String, world : World) -> void:
	match option:
		_DRAMA_CLUB:
			world.add_stories(_DRAMA_DIR)
		_ROBOTICS_CLUB:
			world.add_stories(_ROBOTICS_DIR)
			
