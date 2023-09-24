class_name JobRequirement
extends Resource


enum JobRequirementType {
	MINIMUM, # The minimum value of the attribute must be at least the value
	MAXIMUM, # The maximum value of the attribute must be at most the value
	EXACT, # The value of the attribute must be exactly the value
	LOWEST, # The value of the attribute must be the lowest of all attributes (ignores attribute_value)
	HIGHEST, # The value of the attribute must be the highest of all attributes (ignores attribute_value)
}

@export var attribute_name: String
@export var attribute_value: int
@export var requirement_type: JobRequirementType


func _init(req_attribute_name := "", req_attribute_value := 0, req_requirement_type := JobRequirementType.HIGHEST) -> void:
	attribute_name = req_attribute_name
	attribute_value = req_attribute_value
	requirement_type = req_requirement_type


func met(character: Character) -> bool:
	match requirement_type:
		JobRequirementType.MINIMUM:
			return _met_minimum(character)
		JobRequirementType.MAXIMUM:
			return _met_maximum(character)
		JobRequirementType.EXACT:
			return _met_exact(character)
		JobRequirementType.LOWEST:
			return _met_lowest(character)
		JobRequirementType.HIGHEST:
			return _met_highest(character)

	return false


func _met_minimum(character: Character) -> bool:
	return character.get(attribute_name) >= attribute_value


func _met_maximum(character: Character) -> bool:
	return character.get(attribute_name) <= attribute_value


func _met_exact(character: Character) -> bool:
	return character.get(attribute_name) == attribute_value


func _met_lowest(character: Character) -> bool:
	return character.lowest_attributes().has(attribute_name)


func _met_highest(character: Character) -> bool:
	return character.highest_attributes().has(attribute_name)
