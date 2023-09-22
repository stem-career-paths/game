extends SimpleStory

var text := "You and your lab partner have to cut open a frog. Will you cut the frog or write measurements down?"

var npc_name := "Mary" 

var options := {
	"Cut the frog":
	{	
		"text": "Gross! But awesome!!",
		"effects": {
			"science": +1,
			"engagement": +1
		}
	},
	"Write measurements": 
	{
		"text": "That's a big frog",
		"effects": {
			"mathematics": +1
		}
	}
}
