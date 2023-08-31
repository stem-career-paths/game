class_name StoryEvent extends RefCounted

const _SAMPLE := "Would you like to go to bird banding or play video games?"

func get_intro_text(_world:World)->String:
	return _SAMPLE


func get_options(_world:World)->Array[StoryOption]:
	var option1 := StoryOption.new()
	option1.text = "Bird Banding"
	option1.result = StoryResult.new("You see a cardinal. Neat.")
	var option2 := StoryOption.new()
	option2.text = "Video Games"
	option2.result = StoryResult.new("You scream like Sam Kinnison until your throat is raw.")
	return [
		option1,
		option2
	]

