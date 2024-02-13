extends SimpleStory

var text := [
	'"All right! Let\'s get our Dungeons & Dragons session started!"',
	'"You have travelled far through the caves of Sire Gest Wick. Now you come upon a [b]locked door...[/b]"',
	'"How do you open it?"'
	]

var npc_name := "Steven"

var location :="classroom"

var options := {
	"Door-melting potion" :{
		"text": [
			'"You pull together every potion ingredient you might have and stir it up..."',
			"Steven rolls a big die.",
			'"Well, the door\'s just [b]gone[/b] now. Just... melted into goop."'
			],
		"effects": {
			"science": +1
		}
	},
	"Pick the lock" :{
		"text": [
			'"With your expert tools you begin to pick the lock..."',
			"Steven rolls a die.",
			'"And the door clicks open!"'
			],
		"effects": {
			"engineering": +1
		}
	},
	"Ricochet a pebble to break the lock" :{
		"text": [
			'"You throw a pebble at the wall..."',
			"Steven rolls two dice.",
			'"At just the right angle! The lock snaps off, letting the door creep open."'
		],
		"effects": {
			"mathematics": +1
		}
	},
	"Hack the door":{
		"text": [
			'"[i]Hack[/i] the door? How do you- wait a minute..."',
			"Steven rolls lots of tiny dice.",
			'"You use magic to get into the door\'s head, making it forget it\'s a door. It slides open."'
		],
		"effects": {
			"technology": +1
		}
	}
}
