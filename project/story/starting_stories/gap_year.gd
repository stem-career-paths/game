extends SimpleStory

var text := [
	"One day, one of your classmates asks Ms. Finch what her school experience was like.",
	'"Believe it or not, I didn\'t know I wanted to be a teacher when I graduated high school. I took a gap year before going to college to try and decide what I wanted to do with my life."'
]

var npc_name := "Ms. Finch"

var location := "classroom"

var options := {
	"Aren\'t gap years bad?": {
		"text": '"No, not at all! If anything, I think it helped me greatly! I got a chance to save up some money to buy my own car."',
		"effects": {
			"mathematics": +1
		}
	},
	"What were you like in high school?": {
		"text": '"I had 30 motorcycles and a big mohawk! [i]Haha[/i], just kidding. I was a nerd that really liked frogs."',
		"effects": {
			"engagement": +1
		}
	},
	"What about online classes?": {
		"text": [
			'"Online classes weren\'t a thing when I wass a kid, but I like the idea of them!"',
			'"But when you take an online class, it\'s a big test of will. You need to be responsible and pay attention, or there\'s no point in being there!"'
		],
		"effects": {
			"technology": +1
		}
	}
}
