extends EditorImportPlugin

enum Presets { DEFAULT }

func get_importer_name() -> String:
	return "blender.importer"

func get_visible_name() -> String:
	return "Blender Importer"

func get_recognized_extensions() -> Array:
	return ["blend"]

func get_save_extension() -> String:
	return "tscn"

func get_resource_type():
    return "PackedScene"

func get_preset_count() -> int:
	return Presets.size()

func get_preset_name(preset: int) -> String:
	match preset:
		Presets.DEFAULT:
			return "Default"
		_:
			return "Unknown"

func get_import_options(preset: int) -> Array:
	match preset:
		Presets.DEFAULT:
			return []
		_:
			return []

func get_option_visibility(_option: String, _options: Dictionary) -> bool:
	return true

func import(source_file: String, save_path: String, options: Dictionary, platform_variants: Array, gen_files: Array):
	var blend_path := ProjectSettings.globalize_path(source_file)
	var tmp := ProjectSettings.globalize_path(save_path + ".glb")
	gen_files.push_back(tmp)
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
	var node := importer.import_scene_from_other_importer(tmp, 1, 30)
	print("node: ", node)
	var scene := PackedScene.new()
	scene.pack(node)
	var out_path := "%s.%s" % [save_path, get_save_extension()]
	print("Saving ", out_path)
	var ok := ResourceSaver.save(out_path, scene)
	print("ok: ", ok)
	return ok
