extends SimpleStory

var text := "You can go BB or VG."

var options := {
	"Bird Banding":
	{
		"text": "You find a cardinal",
		"effects": {
			"engagement": +1,
			"science": +1
		}
	},
	"Video Games": {
		"text": "You buy the DLC.",
		"effects": {
			"technology": +1
		}
	}
}
