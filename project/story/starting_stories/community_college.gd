extends SimpleStory

var text := '"My sister\'s [b]FINALLY[/b] graduating from her community college this year. I can\'t wait to not share the bathroom!"'

var npc_name := "Ethan"

var options := {
	"What\'s community college?": {
		"text": '"It\'s a kind of local college that\'s cheaper and shorter. They cover a lot of the basic classes four-year colleges need."',
		"effects": {
			"curiosity": +1
		}
	},
	"She's leaving?": {
		"text": [
			'"Yeah. After two years at community college, she\'s going to a big out-of-state private college to become a doctor."',
			'"...Maybe I lied about being excited for her to go. I\'m gonna miss her really bad."'
		],
		"effects": {
			"resilience": +1
		}
	},
	"More stuff for you!": {
		"text": '"Yeah! More food, more space, more time with my parents! But... no more time with my sister..."',
		"effects": {
			"mathematics": +1
		}
	}
}
