extends Control


const JOBS_DIRECTORY: String = "res://jobs/possible_jobs/"
const _END_STORY_PATH := "res://end/"

var world: World
var _jobs: Array[Job] = []

@onready var _character_display := %CharacterDisplay
@onready var _result_label := %ResultLabel


func _ready():
	assert(world!=null, "World must be specified")
	_character_display.character = world.character

	if world.end_stories.size() > 0:
		_show_end_story()
		return

	_load_jobs()
	_show_job()


func _show_end_story() -> void:
	var end_story_name := world.end_stories[randi() % world.end_stories.size()]
	var end_story = load("%send_%s.gd" % [_END_STORY_PATH, end_story_name]).new()

	_result_label.text = end_story.text


func _load_jobs() -> void:
	_jobs = []
	var dir := DirAccess.open(JOBS_DIRECTORY)

	for file_name in dir.get_files():
		var job: Job = load(JOBS_DIRECTORY + file_name)

		if job.requirements_met(world):
			_jobs.append(job)


func _show_job() -> void:
	var job := _jobs[randi() % _jobs.size()]

	_result_label.text = _result_label.text.format({
		"major": job.major,
		"job_title": job.title,
	})


func _on_play_again_button_pressed():
	# Naive implementation
	var main_scene: String = ProjectSettings.get_setting("application/run/main_scene")
	get_tree().change_scene_to_file(main_scene)
