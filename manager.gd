extends Control

var menu_preview_scene : PackedScene = load("res://scene/menu_and_preview/menu_and_preview.tscn")
var menu_scene : PackedScene = load("res://scene/menu/menu.tscn")

@onready var texture_preview: TextureRect = $PanelPreview/MarginContainer/HBoxContainer/TexturePreview
@onready var texture_preview_2: TextureRect = $PanelPreview/MarginContainer/HBoxContainer/TexturePreview2
@onready var texture_preview_3: TextureRect = $PanelPreview/MarginContainer/HBoxContainer/TexturePreview3
@onready var animate: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animate.play("enter_scene")

func _on_button_flow_1_pressed() -> void:
	animate.play("exit_scene")
	await animate.animation_finished
	Global.flow = 1
	get_tree().change_scene_to_packed(menu_scene)

func _on_button_flow_2_pressed() -> void:
	animate.play("exit_scene")
	await animate.animation_finished
	Global.flow = 2
	get_tree().change_scene_to_packed(menu_scene)

func _on_button_flow_3_pressed() -> void:
	animate.play("exit_scene")
	await animate.animation_finished
	Global.flow = 3
	get_tree().change_scene_to_packed(menu_preview_scene)



func _on_button_flow_1_mouse_entered() -> void:
	texture_preview.texture = load("res://assets/thubnail/menu.png")
	texture_preview_2.texture = load("res://assets/thubnail/preview.png")
	texture_preview_3.texture = load("res://assets/thubnail/detail.png")
	texture_preview.show()
	texture_preview_2.show()
	texture_preview_3.show()
	
func _on_button_flow_2_mouse_entered() -> void:
	texture_preview.texture = load("res://assets/thubnail/menu.png")
	texture_preview_2.texture = load("res://assets/thubnail/preview_detail.png")
	texture_preview.show()
	texture_preview_2.show()
	
func _on_button_flow_3_mouse_entered() -> void:
	texture_preview.texture = load("res://assets/thubnail/menu_preview.png")
	texture_preview_2.texture = load("res://assets/thubnail/detail.png")
	texture_preview.show()
	texture_preview_2.show()

func clear_preview():
	texture_preview.hide()
	texture_preview_2.hide()
	texture_preview_3.hide()


func _on_button_exit_pressed() -> void:
	get_tree().quit()
