# Deprecated

See https://github.com/V-Sekai/godot-blender instead. These somehow both released at the same time.
Also note that this may be a feature built-in to Godot4: https://github.com/godotengine/godot/pull/54886#pullrequestreview-805381255.

# Godot Blender Importer

This is a plugin for Godot 3.4 to directly import [blender](https://www.blender.org/) source files without needing to (manually) export to an intermediate format.
Just save a `.blend` file, and open it as a scene in Godot!
The `blender` executable must be on your `PATH`.

## Pros:

- Allows for faster iteration, which is especially useful during game jams
- No more forgetting to export from Blender 
- No need to commit intermediate files to version control

## Cons:

- Everyone working on the project must have Blender installed
- CI build nodes must have Blender installed if you're using a CI build

## Project Status

This project is currently in an experimental state. 
However, I have [used it successfully](https://git.sr.ht/~rcorre/jamcraft) in one recent game jam.
Please [open an issue](https://github.com/rcorre/godot_blender_importer/issues/new) if you encounter any problems!
