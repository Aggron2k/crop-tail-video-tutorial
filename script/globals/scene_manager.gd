extends Node

var main_scene_path: String = "res://scenes/level/main_scene.tscn"
var main_scene_root_path: String = "/root/MainScene"
var main_scene_level_root_path: String = "/root/MainScene/GameRoot/LevelRoot"


var level_scenes : Dictionary = {
	"Level1": "res://scenes/level/level_1.tscn"
}

func load_main_scene_container() -> void:
	if get_tree().root.has_node(main_scene_root_path):
		return
	
	var packed_scene: PackedScene = load(main_scene_path)
	if packed_scene != null:
		var node: Node = packed_scene.instantiate()
		if node != null:
			get_tree().root.add_child(node)
		
func load_level(level : String) -> void:
	var scene_path: String = level_scenes.get(level, "")
	
	if scene_path == "":
		return
		
	var packed_scene: PackedScene = load(scene_path)
	if packed_scene == null:
		return
		
	var level_scene: Node = packed_scene.instantiate()
	var level_root: Node = get_node_or_null(main_scene_level_root_path)
	
	if level_root != null:
		var nodes = level_root.get_children()
		
		if nodes != null:
			for node: Node in nodes:
				node.queue_free()
				
		await get_tree().process_frame
				
		level_root.add_child(level_scene)

