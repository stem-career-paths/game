extends SimpleStory

const MEAN_OPTION := "Whatever."

var text := '"Can I tell you something? I feel like I have a hard time making friends."'

var npc_name := "Steven"

var options := {
	"Try being more engaged!":
	{
		"text": '"You mean, like, join a club or a team or something? Yeah, that\'s probably a good way to meet people."',
		"effects": {
			"engagement": +1,
		}
	},
	"Don\'t feel bad.":
	{
		"text": '"It\'s hard not to feel [i]bad[/i] when I don\'t feel [i]good[/i]."',
	},
	"Talk to your classmates!":
	{
		"text": '"Talking to people can be [b]so[/b] hard! But I guess I can\'t be friends if I can\'t say hello..."'
	},
	"Whatever.":
	{
		"text": '"Ha, yeah. I guess. Whatever. ..."',
		"tags": Tags.Tag.MEAN_TO_STEVEN
	}
}


