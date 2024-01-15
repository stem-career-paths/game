class_name Attribute extends RefCounted

signal value_changed(old_value, new_value)

# The raw numeric value of this attribute, from zero to infinity
var value : int:
	set(new_value):
		if value!=new_value:
			var old_value := value
			value = max(0, new_value) # Do not allow negative
			value_changed.emit(old_value, value)

# The logical maximum of the attribute range, from which the ratio is computed
var max_value := 4

## Get the percent is this attribute toward its maximum
##
## Returns a number in the range [0,1].
func get_ratio() -> float:
	return clamp(float(value) / max_value, 0.0, 1.0)
