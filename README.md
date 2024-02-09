# STEM Career Paths Game

## Development Notes
- Godot 4.2.x
- Follow [GDQuest's Godot GDScript guidelines](https://gdquest.gitbook.io/gdquests-guidelines/godot-gdscript-guidelines)

### Configuration

Run the `install_hooks.sh` script after cloning the project to install
the pre-commit hooks. 
You can run this script from the command line by going to the directory
containing the project and issuing this command:
```bash
sh install_hooks.sh
```

Having set up that hook will ensure that all the automated tests are run prior to each commit. For this to work, you need to be able to run Godot Engine from the command line as `godot`. Here is a recommended approach for Windows and Git Bash users:
1. Download [Godot Engine](https://godotengine.org/) and extract the executable (`.exe` file) from the archive.
1. Rename that executable to `godot.exe`.
1. Move that file to the `bin` folder of your home directory. (Your home directory is something like `c:\Users\username`.)

That executable is now on your default path, so you can now run `godot` from the command line and the automated tests will work.
You can still create a shortcut to that executable on your Desktop for ease of mouse access, though there's real value to just opening the project you want from the command line.

### Locally testing the HTML build

[The Godot documentation](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html#serving-the-files) describes the approach that we can use
to locally test a web build. This requires using the [`serve.py`](build/web/serve.py)
Python script, which comes from the [Godot Engine repository](https://raw.githubusercontent.com/godotengine/godot/master/platform/web/serve.py) and is copied locally into
the [`build/web`](build/web) folder.

First, export the project as an HTML5 Web build as normal.
Then, from the [build/web](build/web) directory, run:
```bash
python serve.py --root .
```

It should bring up a browser that loads the web build from the build folder.

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

## Third-Party Assets

- [Shantell Sans font](https://fonts.google.com/specimen/Shantell+Sans) licensed under [OFL](project/common/ShantellSans-Regular_license.txt)

- [Rounds Black font](https://www.1001fonts.com/rounds-black-font.html) licensed under [OFL](project/common/RoundsBlack_license.txt)

- Button click sound is a modification of [Mouse Button Clicks](https://freesound.org/people/aphom000/sounds/687105/) licensed under [CC0](https://creativecommons.org/publicdomain/zero/1.0/)

- [Gear image](https://commons.wikimedia.org/wiki/File:Gear-icon.png) is 
licensed under [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
