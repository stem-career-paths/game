extends SimpleStory

var npc_name := "Aubrey"

var text := [
	'"I have been looking at some colleges with my parents."',
	'"I liked some of the smaller liberal arts schools I visited, but I also liked the engineering program at the big state university."'
]

var options := {
	"Study liberal arts!": {
		"text": [
			'"This gives me a lot of options, whether I do something like law school or consulting later."',
			'"But it does mean I won\'t be an engineer like my parents are."',
		],
		"effects": {
			"curiosity": +2
		}
	},
	"Study engineering!": {
		"text": '"A lot of my family are engineers. I like building an designing, and I am good at math, so I think I will be good at it."',
		"effects": {
			"engineering": +1,
			"mathematics": +1,
		}
	},
	"Liberal what now?": {
		"text": [
			'"Liberal arts! Like English, Philosophy, History, and Languages."',
			'"They are not for specific jobs but help you learn to think for yourself."'
		],
		"effects": {
			"curiosity": +1
		}
	}
}
