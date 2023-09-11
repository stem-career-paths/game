# STEM Career Paths Game

## Development Notes
- Godot 4.1.x
- Follow [GDQuest's Godot GDScript guidelines](https://gdquest.gitbook.io/gdquests-guidelines/godot-gdscript-guidelines)

### Configuration

Run the `install_hooks.sh` script after cloning the project to install
the pre-commit hooks. This will run the automated tests in the `test`
folder before completing your commit.

In order for this to work,
you will need to set up a shell command `godot`. One Linux-friendly option is
to have Godot Engine in an apps directory on your path. Windows and Mac users
may prefer to set up an alias. To do this, add something like the following to
the end of the `.bashrc` file in your home directory:
```
alias godot='path-to-godot'
```
For example, on Windows, this might be:
```
alias godot='/c/Users/pvg/Desktop/Godot-v4.1.1-stable_windows.exe'
```
Remember that you will need to either restart your shell or `source` your
configuration file before that alias takes effect.

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