extends SimpleStory

const _EXAM_DIR := "res://story/ap_physics/exam/"

var text := [
	'"Good morning everyone! Welcome to AP Physics! Let\'s get started right away!"',
	'"We have a lot to cover. We\'ll be talking about movement, force, electricity, and waves."'
]

var npc_name := "Ms. Finch"

var location := "classroom"

var options := {
	"Movement?": {
		"text": '"Yes! We\'re all familiar with speed- in physics we call it [i]velocity[/i] because it may be in different directions. Up, down, left, right, forward, backward, and even rotating!"',
		"effects": {
			"mathematics": +1
		}
	},
	"Force?": {
		"text": '"[i]Force[/i] is how objects move and interact with each other. Have you ever wondered why you stop when you hit a wall instead of going through? That\'s force!"',
		"effects": {
			"engineering": +1
		}
	},
	"Electricity?": {
		"text": '"Some objects have different resistences and properties when in contact with [i]electricity[/i]! Metal has a low resistence to electricty, which is why our machines are made of metal!"',
		"effects": {
			"technology": +1
		}
	},
	"Waves?": {
		"text": '"Many things you can\'t see exist as [i]waves[/i], like sound and light! In physics we can find the ups and downs of these waves and how fast they are!"',
		"effects": {
			"science": +1
		}
	}
}


func on_option_selected(_option, world : World) -> void:
	world.add_stories(_EXAM_DIR)
