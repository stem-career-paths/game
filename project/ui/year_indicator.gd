extends VBoxContainer

@export var fill_rate_per_frame := 0.3

var world : World:
	set(value):
		if world != null:
			if world != value:
				world.turns_changed.disconnect(_on_turns_changed)
		
		world = value
		value.turns_changed.connect(_on_turns_changed)


@onready var _progress_bar := $ProgressBar

var _target_ratio := 0.0


func _process(_delta):
	_progress_bar.ratio += (_target_ratio - _progress_bar.ratio) * fill_rate_per_frame
	$YearName.text = _lookup_year_name(_target_ratio)


func _lookup_year_name(percent_complete : float) -> String:
	if percent_complete < 0.25:
		return "Freshman"
	elif percent_complete < 0.5:
		return "Sophomore"
	elif percent_complete < 0.75:
		return "Junior"
	else:
		return "Senior"


func _on_turns_changed(turns:int) -> void:
	_target_ratio = float(turns) / (world.turns_per_year * 4)
