## A game event logging system
extends Node

const LOG_FILE := "user://game_log.json"

var _logs := []


func count_logs() -> int:
	return _logs.size()


func get_current_size() -> int:
	if _logs.is_empty():
		push_error("Cannot get current log: there is not one!")
		return -1
	else:
		return _logs[0].size()


func made_choice(choice_text: String) -> void:
	if _logs.is_empty():
		push_error("Cannot get current log: there is not one!")
	else:
		_logs[0].append({
			"timestamp": Time.get_datetime_string_from_system(),
			"choice": choice_text,
		})


func start_game() -> void:
	_logs.append([])


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_write_logs_to_file()


func _write_logs_to_file() -> void:
	var file := FileAccess.open(LOG_FILE, FileAccess.WRITE)
	if file == null:
		push_error("Could not open file %s: %s" % [LOG_FILE, str(FileAccess.get_open_error())])
	else:
		var json := JSON.stringify(_logs)
		file.store_string(json)
		file.close()
