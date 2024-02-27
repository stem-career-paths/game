extends SimpleStory

var text := [
	'"Good morning class! I have some wonderful news!"',
	'"The other science teachers and I have been talking, and we decided to take initiative and look at applying for college scholarships!"',
	'"When you apply for a scholarship, you need to brag about yourself a little. What\'s something you\'re good at?"'
]

var npc_name := "Ms. Finch"

var location := "classroom"

# The effects are adjacently related to the response; each option can apply to any field,
# but can be more helpful in a particular STEM field
var options := {
	"Being creative": {
		"text": [
			'"Creativity is a hot commodity! In a lot of fields you need to think outside the box!"',
			'"When you apply for a scholarship, you should make sure to flaunt your creativity!"'
		],
		"effects": {
			"technology": +1
		} 
	},
	"Following directions": {
		"text": [
			'"Following directions is a good trait to have! Some fields have been around a long time, so you need a good understanding of how to navigate them."',
			'"You can exemplify that in applications by following their instructions to the best of your ability!"'
		],
		"effects": {
			"mathematics": +1
		}
	},
	"Leading": {
		"text": [
			'"Every project needs a leader, or some kind of driving force. Being able to sort out the needs and wants of everyone is a [i]great[/i] skill."',
			'"You can show them you\'re a leader by applying early."'
		],
		"effects": {
			"engineering": +1
		}
	},
	"Being myself": {
		"text": [
			'"And don\'t sell [i]yourself[/i] short! There\'s only one [b]you[/b] in this world!"',
			'"Whenever you apply for scholarships, you\'re telling them what you want to do in the world. That\'s not an easy thing to know!"'
		],
		"effects": {
			"science": +1
		}
	}
}
