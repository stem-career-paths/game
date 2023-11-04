extends SimpleStory

const QUIT := "Alex is a creep and I quit"

var text := [
	'"Hey, it seemed like you and Alex were getting angry at each other in last night\'s D&D game."',
	'"I am concerned it might upset the game. What do you think?"',
]

var npc_name := "Steven"

var options := {
	"Forget about it": {
		"text": '"Um... You are sure this won\'t happen again? I don\'t know."',
	},
	"I will apologize": {
		"text": '"Thanks. I am sure Alex will be happy to clear it up."',
		"effects": {
			"resilience": +1
		}
	},
	"Make Alex apologize": {
		"text": '"It takes two to tango. I don\'t know that I can do that, but I will try."',
	},
	QUIT: {
		"text": '"Alex weirds me out, too, to be honest. I cannot stop you, but I am sorry to see you go."'
	}
}


func on_option_selected(option:String, world: World) -> void:
	if option == QUIT:
		var dir := DirAccess.open("res://story/rpg")

		world.remove_stories(dir)
