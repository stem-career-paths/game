extends SimpleStory

var text := [
	"You find Mary lost in thought just outside the classroom door.",
	'"Oh! Hey! Maybe you can help me. I want to know more about engineering, but when I look it up, it doesn\'t make sense. What should I ask the teacher?"'
]

var npc_name := "Mary"

var location := "hallway"

var options := {
	"What do engineers do?": {
		"text": [
			'You and Mary go in together and ask the teacher "What do engineers do?"',
			"The teacher tells you that they can do many things, but they all invent and design answers to problems."
		],
		"effects": {
			"engineering": +1,
			"curiosity": +1
		}
	},
	"What kinds of engineers are there?": {
		"text": [
			'You and Mary go in together and ask the teacher "What kind of engineers are there?"',
			"The teacher tells you there are all kinds, ones that work with chemicals, electricity, buildings, machines, and many more."
		],
		"effects": {
			"engineering": +1,
			"curiosity": +1
		}
	},
	"Are you an engineer?": {
		"text": '"I don\'t know about that one... I think our teacher is a [i]teacher[/i], not an engineer. Thanks for trying, though."'
	},
	"How do you become an engineer?": {
		"text": [
			'You and Mary go in together and ask the teacher "How do you become an engineer?"',
			"The teacher explains that engineers need lots of knowledge and training to make things for people to use. Most engineers go to college and get a degree."
		],
		"effects": {
			"engineering": +1,
			"curiosity": +1
		}
	}
}
