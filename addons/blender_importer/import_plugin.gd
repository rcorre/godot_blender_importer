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
	OS.execute("blender", cmdline)

	print("Importing ", tmp)
	var importer := EditorSceneImporter.new()
	var node := importer.import_scene_from_other_importer(tmp, flags, bake_fs)
	Directory.new().remove(tmp)
	return node
