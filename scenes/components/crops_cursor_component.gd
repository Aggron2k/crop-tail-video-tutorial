class_name CropsCursorComponent

extends Node2D

@export var tilled_soil_tilemap_layer: TileMapLayer
@onready var player: Player = get_tree().get_first_node_in_Group("player")


var corn_plant_scene = preload	("res://scenes/object/plants/corn.tscn")
var tomato_plant_scene = preload	("res://scenes/object/plants/tomato.tscn")

var mouse_position: Vector2
var cell_positio: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float

func _ready() -> void:
	if !player:
		player = get_tree().get_first_node_in_group("player") as Player

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("remove_dirt"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
	elif event.is_action_pressed("hit"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			
func get_cell_under_mouse() -> void:
	mouse_position = tilled_soil_tilemap_layer.get_local_mouse_position()
	cell_position = tilled_soil_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = tilled_soil_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = grass_tilled_soil_tilemap_layertilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)

func add_crop() -> void:
	if distance < 20.0:
		if ToolManager.selected_tool == DataTypes.Tools.PlantCorn:
			var corn_instance = corn_plant_scene.instantiate() as Node2D
			corn_instance.global_position = local_cell_position
			get_parent().find_child("CropField").add_child(corn_instance)
