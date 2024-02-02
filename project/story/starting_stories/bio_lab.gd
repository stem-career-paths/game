extends SimpleStory

var text := "You and your lab partner have to cut open a frog. Will you cut the frog or write measurements down?"

var npc_name := "Mary" 

var location := "classroom"

var options := {
	"Cut the frog":
	{	
		"text": [
			"Cutting open the frog is a lot harder than you thought! Some parts are squishy and some are solid. There are organs everywhere!",
			"[b]All[/b] of it smells bad though."
		],
		"effects": {
			"science": +1,
			"engagement": +1
		}
	},
	"Write measurements": 
	{
		"text": "You measure the frog. When you ask the other students what they got, you find your frog is the second biggest!",
		"effects": {
			"mathematics": +1
		}
	}
}
