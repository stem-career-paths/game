extends SimpleStory

var text := [
	'"I\'ve been thinking about college. My dad\'s an engineer. He designs electronics systems for factories."',
	'"I always thought that sounded good, but I also like creative writing. What should I look for in a major?"',
]

var npc_name := "Ethan"

var location := "robotics"

var options := {
	"Do whatever you want": {
		"text": '"Sure, but I\'m not sure what that is."',
	},
	"Engineers make good money": {
		"text": '"Yeah, I guess I should think about what I want to do, and what\'ll be a good career path."',
		"effects": {
			"engineering": +1,
			"engagement": +1,
		}
	},
	"You can do a lot with English": {
		"text": [
			'"That\'s what I think!"', 
			'"My dad works with a lot of technical writers, who write stuff that normal people can read."',
			'"Maybe that\'s a good combination of technology and communication for me."'
		],
		"effects": {
			"curiosity": +1,
		}
	},
	"Do both": {
		"text": [
			'"I guess I can double major, or have a minor in one."',
			'"That\'s a bunch of work, but maybe I can do it!"'
		],
		"effects": {
			"engineering": +1,
			"resilience": +1
		}
	}
}
