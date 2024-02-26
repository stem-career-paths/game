extends SimpleStory

var text := [
	'"Looks like someone is going to have to program the robot for the club."',
	'"I\'ve been programming since I was a kid. I guess I could do it."'
]

var npc_name := "Ethan"

var location := "robotics"

var options := {
	"Do it! You will get even better.": {
		"text": '"Yeah, I suppose so. Maybe I can be an engineer or a programmer or something in college."',
		"effects": {
			"engineering": +1,
			"engagement": +1,
		}
	},
	"Only if you want to.": {
		"text": '"Oh, man, I can\'t decide. Part of me wants to, but part wants to try something new."',
		"effects": {
			"curiosity": +1
		}
	},
	"No, try something new.": {
		"text": '"I guess this is my chance, right? Maybe I will try using the 3D printer or CNC machine."',
		"effects": {
			"curiosity": +1,
			"engineering": +1
		}
	}
}
