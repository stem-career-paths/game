extends SimpleStory

var text := '"I have enough math to graduate. I think I\'ll just skip taking it next semester."'

var options := {
	"You can\'t know too much!": {
		"text": '"Yeah, I guess [u]then[/u] no matter what I do in college, I\'ll be ready."',
		"effects": {
			"mathematics": +1,
			"engagement": +1,
		}
	},
	"Math is interesting": {
		"text": '"I didn\'t think about it that way. Probably? I have to think about it."',
		"effects": {
			"mathematics": +1,
			"curiosity": +1
		}
	},
	"You need math to do a lot of things in science.": {
		"text": '"Yeah, I guess if I wanted to study science, I should probably take more math."',
		"effects": {
			"science": +1,
		}
	},
	"Math is stupid. Don\'t take it.": {
		"text": [
			'"[b]Hey[/b]! Not taking it doesn\'t mean I don\'t like it!"',
			'"I think I\'ll take my math class out of [u]spite[/u]."'
			]
	}
}
