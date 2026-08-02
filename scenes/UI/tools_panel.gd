extends PanelContainer
@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_corn: Button = $MarginContainer/HBoxContainer/ToolCorn
@onready var tool_tomato: Button = $MarginContainer/HBoxContainer/ToolTomato


func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)


func on_tool_selected(tool: DataTypes.Tools) -> void:
	match tool:
		DataTypes.Tools.AxeWood:
			tool_axe.grab_focus()
		DataTypes.Tools.TillGround:
			tool_tilling.grab_focus()
		DataTypes.Tools.WaterCrops:
			tool_watering_can.grab_focus()
		DataTypes.Tools.PlantCorn:
			tool_corn.grab_focus()
		DataTypes.Tools.PlantTomato:
			tool_tomato.grab_focus()
		DataTypes.Tools.None:
			release_all_focus()


func release_all_focus() -> void:
	tool_axe.release_focus()
	tool_tilling.release_focus()
	tool_watering_can.release_focus()
	tool_corn.release_focus()
	tool_tomato.release_focus()


func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWood)


func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.TillGround)


func _on_tool_watering_can_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WaterCrops)


func _on_tool_corn_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantCorn)


func _on_tool_tomato_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantTomato)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			ToolManager.select_tool(DataTypes.Tools.None)
