extends SimpleStory

const _MATHEMATICS_ENGINEERING_OPTION := "Movement and Force"
const _SCIENCE_TECHNOLOGY_OPTION := "Electricity and Waves"

var text := "Today is the day of the AP physics exam. If you pass, you'll get some college credit. \n Which sections do you try your best on?"

var npc_name := "Ms. Finch"

var location := "classroom"

var options := {
	_MATHEMATICS_ENGINEERING_OPTION: {
		"text": "Velocity affects force... Aha! You've got it!",
		"effects": {
			"mathematics": +1,
			"engineering": +1
		}
	},
	_SCIENCE_TECHNOLOGY_OPTION: {
		"text": "The properties and resistances of an object affect how waves travel through it... Aha! You've got it!",
		"effects": {
			"science": +1,
			"technology": +1
		}
	}
}


func on_option_selected(option: String, world : World) -> void:
	var combo_value := 0
	match option:
		_MATHEMATICS_ENGINEERING_OPTION:
			combo_value = world.character.engineering.value + world.character.mathematics.value
		_SCIENCE_TECHNOLOGY_OPTION:
			combo_value = world.character.science.value + world.character.technology.value

	if combo_value > 2:
		world.character.add_tag(Tags.Tag.SUCCEEDED_AP_EXAM)
	else:
		world.character.add_tag(Tags.Tag.FAILED_AP_EXAM)
