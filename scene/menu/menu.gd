extends Control


@onready var menu_container: HBoxContainer = $MenuPreview/HBoxContainer

var preview_detail_scene : PackedScene = load("res://scene/menu/preview_detail.tscn")
var button_menu_componen : PackedScene = load("res://scene/component/button_menu.tscn")

var menu : Dictionary = {
	0 : {"name" : "Character"},
	1 : {"name" : "doksli"}
}

func _ready() -> void:
	menu_list()

func menu_list():
	for id in menu:
		var data = menu[id]
		
		var button_menu = button_menu_componen.instantiate()
		button_menu.menu_data(data["name"])
		
		button_menu.pressed.connect(func() : print(data["name"]))
		
		menu_container.add_child(button_menu)
	pass

func debug(indikator):
	print(str(indikator))

func preview(name):
	var preview_transition = preview_detail_scene.instantiate()
	
	get_tree().root.add_child(preview_transition)
	get_tree().current_scene = preview_transition
	
	preview_transition.preview_data(name)
	
	queue_free()
	pass
