extends VBoxContainer

@export var fill_rate_per_frame := 0.3

var world : World:
	set(value):
		world = value
		world.turns_changed.connect(func(turns):
			_target_ratio = float(turns) / (world.turns_per_year * 4)
		)

@onready var _progress_bar := $ProgressBar

var _target_ratio := 0.0


func _ready():
	if world == null:
		push_warning("World not specified in year indicator")


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
