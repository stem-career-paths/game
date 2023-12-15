extends GutTest

var logger := GameLog


func test_start_game__adds_log_entry() -> void:
	var entries := logger.count_logs()
	logger.start_game()
	assert_eq(logger.count_logs(), entries + 1)


func test_made_choice__adds_choice() -> void:
	logger.start_game()
	var events_before_choice := logger.get_current_size()
	logger.made_choice("sample_choice")
	var events_after_choice := logger.get_current_size()
	assert_eq(events_after_choice, events_before_choice + 1)
	
