extends SimpleStory

var text := '"Do you want to go bird banding with me, or should we play some video games?"'

var npc_name := "Hilda"

var options := {
	"Bird Banding":
	{
		"text": '"I can\'t believe we found a cardinal! That was fun."',
		"effects": {
			"engagement": +1,
			"science": +1
		}
	},
	"Video Games": {
		"text": '"That was fun. I\'d love to be able to make my own video games someday."',
		"effects": {
			"technology": +1
		}
	}
}
