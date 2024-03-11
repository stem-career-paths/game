extends GutTest

const TEST_STORY_DIR := "res://test/unit/distribution_calculator_test_stories/"

var distribution_calculator: DistributionCalculator


func before_each() -> void:
	distribution_calculator = DistributionCalculator.new()


func test_single_story() -> void:
	var file_path := TEST_STORY_DIR.path_join("test_story.gd")
	var distribution := distribution_calculator.calculate_story(file_path)

	assert_eq(distribution.attributes.science, 1)


func test_single_story_with_attribute_greater_than_1() -> void:
	var file_path := TEST_STORY_DIR.path_join("test_story_attribute_greater_than_1.gd")
	var distribution := distribution_calculator.calculate_story(file_path)

	assert_eq(distribution.attributes.science, 2)


func test_single_story_with_multiple_attributes() -> void:
	var file_path := TEST_STORY_DIR.path_join("test_story_multiple_attributes.gd")
	var distribution := distribution_calculator.calculate_story(file_path)

	assert_eq(distribution.attributes.science, 1)
	assert_eq(distribution.attributes.technology, 1)


func test_single_story_with_multiple_options() -> void:
	var file_path := TEST_STORY_DIR.path_join("test_story_multiple_options.gd")
	var distribution := distribution_calculator.calculate_story(file_path)

	assert_eq(distribution.attributes.science, 1)
	assert_eq(distribution.attributes.technology, 1)


func test_single_story_with_multiple_options_with_same_attribute() -> void:
	var file_path := TEST_STORY_DIR.path_join("test_story_multiple_options_with_same_attribute.gd")
	var distribution := distribution_calculator.calculate_story(file_path)

	assert_eq(distribution.attributes.science, 2)


func test_multiple_stories() -> void:
	var path := TEST_STORY_DIR
	var distributions := distribution_calculator.calculate_stories(path)

	var distribution := DistributionCalculator.Distribution.combine(distributions)

	assert_eq(distribution.attributes.science, 7)
	assert_eq(distribution.attributes.technology, 2)
