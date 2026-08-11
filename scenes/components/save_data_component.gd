class_name SaveDataComponent
extends Node

@onready var parent_node: Node2D = get_parent() as Node2D

@export var save_data_resource: NodeDataResource

func _ready() -> void:
	add_to_group("save_data_component")

func save_data() -> NodeDataResource:
	if parent_node == null:
		return null

	if save_data_resource == null:
		push_error("save_data_resource is null on: ", parent_node.name)
		return null

	save_data_resource._save_data(parent_node)

	return save_data_resource
