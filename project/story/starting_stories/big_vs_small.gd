extends SimpleStory

var text := '"I\'ve been thinking about college. Do you think it\'s better for me to go a big school or small school?"'

var options := {
	"Bigger is better": {
		"text": '"Yeah, more people, more clubs, more opportunities. Thanks!"',
	},
	"Smaller is best": {
		"text": '"Yeah, smaller class sizes, and I can get to know my professors better."',
	},
	"Um, what?": {
		"text": [
			'"COLLEGE, duh. A college with 40,000 students must be different than one with 2,000."',
			'"My parents want me to go visit some colleges, so I guess I can learn more about it then."',
		],
	}
}
