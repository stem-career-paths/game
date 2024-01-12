extends SimpleStory

var text := '"Do you want to go bird banding with me, or should we play some video games?"'

var npc_name := "Hilda"

var options := {
	"...Bird what?": {
		"text": [
			'"Bird banding! It\'s something they do at the nearby park!"',
			'"They catch birds in nets, then we go out and tag them for research! Cool, huh?"'
			],
		"effects":{
			"curiosity": +1
		}
	},
	"Bird Banding":
	{
		"text": '"I can\'t believe we found a cardinal! They\'re so much bigger than I thought!"',
		"effects": {
			"engagement": +1,
			"science": +1
		}
	},
	"Video Games": {
		"text": [
			'You both play the best fighting game known to man: Hit People With Sticks 3: Steel Thunder.',
			'"That was fun. I\'d love to be able to make my own video games someday."',
			],
		"effects": {
			"technology": +1
		}
	}
}
