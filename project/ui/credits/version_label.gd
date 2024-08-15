extends Label

const _VERSION_KEY := "application/config/version"

func _ready() -> void:
	var version : String = ProjectSettings.get_setting(_VERSION_KEY)
	text = "Version %s" % version
