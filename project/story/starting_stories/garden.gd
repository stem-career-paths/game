extends SimpleStory

var text := [
	'"I\'ve been asking my grandma to let me use her garden for experience since [i]forever[/i], and she finally let me!"',
	'"...Now the problem is, there\'s so many options I don\'t know where to start! Do you have any ideas for the garden?"'
]

var npc_name := "Ethan"

var location := "courtyard"

var options := {
	"Flower garden": {
		"text": [
			'"Flower gardens are classic for a reason! Flowers need certain amounts of light and water, but it\'s worth it!"',
			'"All the beautiful colors and shapes... some flowers even attract hummingbirds and butterflies! Grandma loves those!"',
		],
		"effects": {
			"science": +1
		}
	},
	"Zen garden": {
		"text": "\"Woah! I didn't think of that one! It's a lot of hard work, but it'll definitely pay off! Grandma will love it!\"",
		"effects": {
			"engineering": +1
		}
	},
	"Herb garden": {
		"text": '"That\'s perfect! Grandma loves cooking, and a lot of herbs need different kinds of care!"',
		"effects": {
			"science": +1
		}
	}
}
