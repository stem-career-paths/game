extends SimpleStory

const QUIT := "Alex is creepy. I quit"

var text := [
	'"Hey, it seemed like you and Alex were getting angry at each other in last night\'s D&D game."',
	'"I\'m worried this is more of a personal thing, and it\'ll ruin the game..."',
]

var npc_name := "Steven"

var location := "hallway"

var options := {
	"I will apologize": {
		"text": '"Thanks! I\'m sure Alex will be happy to clear it up."',
		"effects": {
			"resilience": +1
		}
	},
	"Make Alex apologize": {
		"text": '"I\'ll try talking to him. But I guess I can\'t make people apologize. Even if I try..."',
	},
	"We were just in character! It\'s fine":{
		"text": '"You two derailed the game pretty hard.... Are you sure everything\'s ok?"'
	},
	QUIT: {
		"text": '"Alex weirds me out, too, to be honest. I guess I can\'t stop you from leaving."'
	}
}


func on_option_selected(option:String, world: World) -> void:
	if option == QUIT:
		var dir := DirAccess.open("res://story/rpg")

		world.remove_stories(dir)
