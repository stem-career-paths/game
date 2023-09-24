class_name Job
extends Resource

## The title of the job
@export var title := ""
## The major required for the job
@export var major := ""

## The attribute requirements for the job
@export var requirements: Array[JobRequirement] = []

## Returns true if all requirements are met
func requirements_met(world: World) -> bool:
	for req in requirements:
		if not req.met(world.character):
			return false

	return true
