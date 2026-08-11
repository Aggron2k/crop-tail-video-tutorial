extends PanelContainer
@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_corn: Button = $MarginContainer/HBoxContainer/ToolCorn
@onready var tool_tomato: Button = $MarginContainer/HBoxContainer/ToolTomato


func _ready() -> void:
	ToolManager.enable_tool.connect(on_enable_tool_button)
	ToolManager.tool_selected.connect(on_tool_selected)

	tool_tilling.disabled = true
	tool_tilling.focus_mode = Control.FOCUS_NONE

	tool_watering_can.disabled = true
	tool_watering_can.focus_mode = Control.FOCUS_NONE

	tool_corn.disabled = true
	tool_corn.focus_mode = Control.FOCUS_NONE

	tool_tomato.disabled = true
	tool_tomato.focus_mode = Control.FOCUS_NONE

	_setup_button_hover(tool_axe, DataTypes.Tools.AxeWood)
	_setup_button_hover(tool_tilling, DataTypes.Tools.TillGround)
	_setup_button_hover(tool_watering_can, DataTypes.Tools.WaterCrops)
	_setup_button_hover(tool_corn, DataTypes.Tools.PlantCorn)
	_setup_button_hover(tool_tomato, DataTypes.Tools.PlantTomato)

	if ToolManager.selected_tool != DataTypes.Tools.None:
		on_tool_selected(ToolManager.selected_tool)


func _setup_button_hover(button: Button, tool: DataTypes.Tools) -> void:
	button.mouse_entered.connect(func(): _on_tool_mouse_entered(button))
	button.mouse_exited.connect(func(): _on_tool_mouse_exited(button, tool))


func _on_tool_mouse_entered(button: Button) -> void:
	if button.has_focus():
		button.release_focus()


func _on_tool_mouse_exited(button: Button, tool: DataTypes.Tools) -> void:
	if ToolManager.selected_tool == tool and not button.disabled:
		button.grab_focus()


func get_button_for_tool(tool: DataTypes.Tools) -> Button:
	match tool:
		DataTypes.Tools.AxeWood:
			return tool_axe
		DataTypes.Tools.TillGround:
			return tool_tilling
		DataTypes.Tools.WaterCrops:
			return tool_watering_can
		DataTypes.Tools.PlantCorn:
			return tool_corn
		DataTypes.Tools.PlantTomato:
			return tool_tomato
		_:
			return null


func on_tool_selected(tool: DataTypes.Tools) -> void:
	release_all_focus()
	var button: Button = get_button_for_tool(tool)
	if button and not button.disabled:
		if not button.is_hovered():
			button.grab_focus()


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

func on_enable_tool_button(tool: DataTypes.Tools) -> void:
	if tool == DataTypes.Tools.TillGround:
		tool_tilling.disabled = false
		tool_tilling.focus_mode = Control.FOCUS_ALL

	elif tool == DataTypes.Tools.WaterCrops:
		tool_watering_can.disabled = false
		tool_watering_can.focus_mode = Control.FOCUS_ALL

	elif tool == DataTypes.Tools.PlantCorn:
		tool_corn.disabled = false
		tool_corn.focus_mode = Control.FOCUS_ALL

	elif tool == DataTypes.Tools.PlantTomato:
		tool_tomato.disabled = false
		tool_tomato.focus_mode = Control.FOCUS_ALL
