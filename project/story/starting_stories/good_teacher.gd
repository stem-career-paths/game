extends SimpleStory

const MEAN_OPTION := "Okay? And?"

var text := '"I love my science teacher. She\'s so smart! And fun!"'

var npc_name := "Hilda"

var options := {
	"You should eventually be a teacher": {
		"text": '"I was thinking the same thing! I could focus on both science AND teaching in college."',
		"effects": {
			"science": +1
		}
	},
	"You should be a teacher aid": {
		"text": [
			'"Oh, I guess I could! I\'ll have to ask her about that. I\'d love to help prep labs."',
			'"And she could probably write me a [i]great[/i] recommendation for college or scholarships!"'
		],
		"effects": {
			"science": +1,
			"engagement": +1
		},
	},
	"Okay? And?": {
		"text": '"She really cares about me and how I\'m doing. Maybe more than some of my friends..."',
		"tags": Tags.Tag.MEAN_TO_HILDA
	},
}

