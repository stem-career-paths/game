extends GutTest


const REQUIREMENT_TYPE = JobRequirement.JobRequirementType


func test_job_requirement_met_minimum():
	var requirement := JobRequirement.new("science", 1, REQUIREMENT_TYPE.MINIMUM)
	var character = Character.new()

	assert_false(requirement.met(character))

	character.science = 1
	assert_true(requirement.met(character))


func test_job_requirement_met_maximum():
	var requirement := JobRequirement.new("science", 0, REQUIREMENT_TYPE.MAXIMUM)
	var character = Character.new()

	assert_true(requirement.met(character))

	character.science = 1
	assert_false(requirement.met(character))


func test_job_requirement_met_exact():
	var requirement := JobRequirement.new("science", 1, REQUIREMENT_TYPE.EXACT)
	var character = Character.new()

	assert_false(requirement.met(character))

	character.science = 1
	assert_true(requirement.met(character))

	character.science = 2
	assert_false(requirement.met(character))


func test_job_requirement_met_lowest():
	var requirement := JobRequirement.new("science", 0, REQUIREMENT_TYPE.LOWEST)
	var character = Character.new()

	assert_true(requirement.met(character))

	character.science = 1
	assert_false(requirement.met(character))

	character.science = -1
	assert_true(requirement.met(character))


func test_job_requirement_met_highest():
	var requirement := JobRequirement.new("science", 0, REQUIREMENT_TYPE.HIGHEST)
	var character = Character.new()

	assert_true(requirement.met(character))

	character.science = -1
	assert_false(requirement.met(character))

	character.science = 1
	assert_true(requirement.met(character))
