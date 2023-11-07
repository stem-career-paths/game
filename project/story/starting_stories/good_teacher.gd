extends SimpleStory

var text := '"I love my science teacher. She is so smart!"'

var options := {
	"Become a teacher later": {
		"text": '"I was thinking the same thing. I could major in some kind of science and teach high school."',
		"effects": {
			"science": +2
		}
	},
	"Be a teacher's aid now": {
		"text": [
			'"Oh, I guess I could! I will have to ask her about that. I would love to prep labs."',
			'"She could probably write me a great recommendation for college and scholarships, too."'
		],
		"effects": {
			"science": +1,
			"engagement": +1
		},
	},
	"Whatever": {
		"text": '"She really cares about me and how I am doing. Maybe more than some of my friends..."',
	},
}
