extends SimpleStory

var text := "[font_size=70]Woah![/font_size]\n There's a cat at school!\n\n...What do you do?"

var npc_name := "Cat"

var location := "drama"

var options := {
	"Pet it!": {
		"text": '"Myow!" \n It seems to have liked that!',
		"effects": {
			"curiosity": +1
		}
	},
	"Play with it!": {
		"text": '"Mrrow!" \n It likes chasing your shoe laces!',
		"effects": {
			"curiosity": +1
		}
	},
	"Get a teacher!": {
		"text": "You run to grab the nearest teacher, but by the time you come back, the cat is gone...",
		"effects": {
			"resilience": +1
		}
	},
	"Run away!": {
		"text": "You run away from the cat. Not getting any fur on your clothes today!",
		"effects": {
			"resilience": +1
		}
	}
}
