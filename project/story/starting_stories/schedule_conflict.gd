extends SimpleStory

const _DRAMA_CLUB := "Drama Club"
const _ROBOTICS_CLUB := "Robotics Club"

var npc_name := "Aubrey"

var text := '"Oh no, the drama club meets the same time as robotics club! What do you want to do?"'

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
		}
	},
	"Neither one sounds interesting": {
		"text": '"Oh, yeah, I guess I was thinking the same thing."'
	}
}


func on_option_selected(option: String, world : World) -> void:
	match option:
		_DRAMA_CLUB:
			var continuation := "res://story/drama_club/cast_or_crew.gd"
			world.available_stories.append(continuation)
		_ROBOTICS_CLUB:
			var continuation := "res://story/robotics_club/intimidated.gd"
			world.available_stories.append(continuation)
