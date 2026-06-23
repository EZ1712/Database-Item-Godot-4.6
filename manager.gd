extends Control

var menu_preview_scene : PackedScene = load("res://scene/menu_and_preview/menu_and_preview.tscn")
var menu_scene : PackedScene = load("res://scene/menu/menu.tscn")

func _on_button_flow_1_pressed() -> void:
	Global.flow = 1
	get_tree().change_scene_to_packed(menu_scene)

func _on_button_flow_2_pressed() -> void:
	Global.flow = 2
	get_tree().change_scene_to_packed(menu_scene)

func _on_button_flow_3_pressed() -> void:
	Global.flow = 3
	get_tree().change_scene_to_packed(menu_preview_scene)
