extends SimpleStory

var npc_name := "Aubrey"

var text := [
	'"I\'ve been looking at some colleges with my parents."',
	'"I liked some of the smaller liberal arts schools I visited, but I also liked the engineering program at the big state university."'
]

var years := [ Year.Name.JUNIOR, Year.Name.SENIOR ]

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
		"text": '"A lot of my family are engineers. I like building and designing, and I\'m good at math, so I think I\'ll be good at it."',
		"effects": {
			"engineering": +1,
			"mathematics": +1,
		}
	},
	"Liberal what now?": {
		"text": [
			'"Liberal arts! Like [u]English[/u], [u]Philosophy[/u], [u]History[/u], and [u]Languages[/u]."',
			'"They aren\'t for specific jobs, but they help you learn to think for yourself."'
		],
		"effects": {
			"curiosity": +1
		}
	}
}
