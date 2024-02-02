## Holds all the available locations
class_name GameMap extends RefCounted

const _RESOURCE_PATHS : Array[String] = [
	"res://locations/classroom.png",
	"res://locations/hallway.png",
]

## Maps location names to their textures.
## The keys are plain location names, like "hallway".
var _dictionary := {}

func _init():
	for resource_path in _RESOURCE_PATHS:
		var file_name := resource_path.substr(resource_path.rfind("/")+1)
		var key := file_name.substr(0, file_name.rfind("."))
		_dictionary[key] = load(resource_path)


func get_by_name(name:String)->Texture:
	return _dictionary[name]


func has_location(name:String)->bool:
	return _dictionary.keys().has(name)


func pick_random() -> Texture:
	return _dictionary.values().pick_random()


## Count the number of locations in the map
func size() -> int:
	return _dictionary.size()
