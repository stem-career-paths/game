class_name Attribute extends RefCounted

signal value_changed(old_value, new_value)
signal rank_changed(old_value, new_rank)

var value_per_rank := 4

# The raw numeric value of this attribute, from zero to infinity
var value : int:
	set(new_value):
		if value!=new_value:
			var old_value := value
			value = new_value
			value_changed.emit(old_value, value)
			@warning_ignore("integer_division")
			rank = value / value_per_rank


# The rank of this value as determined by the game rules.
# This is essentially the number of stars a player has earned in this attribute.
var rank : int:
	set(new_rank):
		if rank!=new_rank:
			var old_rank := rank
			rank = new_rank
			rank_changed.emit(old_rank, new_rank)


## How much progress is this toward the next rank?
func get_ratio() -> float:
	return float(value % value_per_rank) / value_per_rank
