# STEM Career Paths Game

## Development Notes
- Godot 4.1.x
- Follow [GDQuest's Godot GDScript guidelines](https://gdquest.gitbook.io/gdquests-guidelines/godot-gdscript-guidelines)

### Per-Developer Project Settings Override

The `override.cfg` file, [which can be used to override project
settings](https://docs.godotengine.org/en/stable/classes/class_projectsettings.html),
is [not version controlled](project/.gitignore). Each developer can have their own settings in this file.
The most common use case for this is that a developer may need to adjust the 
test game window's resolution to fit on their current display. For example, in this case, putting the following into a `override.cfg` in the project folder will run the
game at 360x640.
```
display/window/size/window_width_override=360
display/window/size/window_height_override=640
```