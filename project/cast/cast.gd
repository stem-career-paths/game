class_name Cast extends RefCounted

## Maps names to Npc objects
var _dictionary := {}


func get_by_name(npc_name:String) -> Npc:
	return _dictionary[npc_name]


## Load the cast of NPCs from the given folder.
func load_cast(path:String) -> void:
	for file_name in DirAccess.get_files_at(path):
		if file_name.ends_with(".tres"):
			var resource_path := path + file_name
			var npc_definition := load(resource_path)
			assert(npc_definition != null, "Cannot load " + resource_path)
			if npc_definition is NpcDefinition:
				var npc : Npc = npc_definition.create_npc()
				_dictionary[npc.name] = npc


func pick_random() -> Npc:
	return _dictionary.values().pick_random()


func size() -> int:
	return _dictionary.size()
