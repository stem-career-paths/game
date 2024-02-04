extends SimpleStory

var text := "This story will not be shown during the player's freshman year."

var years := Year.not_in([ Year.Freshman ])

var options := {
	"This is not my freshman year": {
		"text": "See? I told you so!",
	},
	"This is my freshman year": {
		"text": "If that's true, something is wrong. You should not be seeing this.",
	},
}
