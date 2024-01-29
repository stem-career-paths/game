## Holds all the available locations
class_name GameMap extends RefCounted

## Maps location names to their textures.
## The keys are plain location names, like "hallway".
var _dictionary := {}

func get_by_name(name:String)->Texture:
	return _dictionary[name]


func has_location(name:String)->bool:
	return _dictionary.keys().has(name)


## Load all of the png images in the given folder as locations
func load(path:String)->void:
	for file_name in DirAccess.get_files_at(path):
		if file_name.ends_with(".png"):
			var resource_path := path + file_name
			var texture := load(resource_path)
			var key := file_name.substr(0, file_name.find(".png"))
			_dictionary[key] = texture


func pick_random() -> Texture:
	return _dictionary.values().pick_random()


## Count the number of locations in the map
func size() -> int:
	return _dictionary.size()
