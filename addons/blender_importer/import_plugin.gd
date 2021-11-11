extends EditorSceneImporter

func _get_extensions() -> Array:
	return ["blend"]

func _get_import_flags() -> int:
	return IMPORT_SCENE

func _import_animation(path: String, flags: int, bake_fs: int) -> Animation:
	return null

func _import_scene(path: String, flags: int, bake_fs: int) -> Node:
	var blend_path := ProjectSettings.globalize_path(path)
	var tmp := blend_path + ".glb"
	var cmdline := [
		blend_path,
		"-b",
		"--python-expr",
		"import bpy; bpy.ops.export_scene.gltf(filepath='%s')" % tmp,
	]
	print("Running ", cmdline)
	var err := OS.execute("blender", cmdline)
	if err != 0:
		push_error("Command `%s` failed with code: %d" % [cmdline, err])
		return null

	print("Importing ", tmp)
	var node := import_scene_from_other_importer(tmp, flags, bake_fs, 0)
	err = Directory.new().remove(tmp)
	if err != 0:
		push_error("Failed to remove temp file '%s', error: %d" % [tmp, err])
	return node
