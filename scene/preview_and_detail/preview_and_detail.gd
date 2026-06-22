extends Control

var menu_scene : PackedScene = load("res://scene/menu/menu.tscn")
var preview_template : PackedScene = load("res://scene/component/button_preview/button_preview.tscn")

@onready var preview_list: GridContainer = $PreviewList/ScrollContainer/GridContainer

var character_database : Dictionary = load("res://database/data/character_database.tres").data
var stiker_database : Dictionary = load("res://database/data/stiker_database.tres").data

var current_database : String 

func preview_data():
	
	var direct_database = self.get(current_database)
	
	for id in direct_database:
		var data = direct_database[id]
		
		var preview_button = preview_template.instantiate()
		preview_button.preview_data(data["name"],data["image_preview"], data["rarity"])
		
		preview_list.add_child(preview_button)
		
	
	pass



func _on_button_debug_pressed() -> void:
	print(str(current_database) + "from preview")


func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_packed(menu_scene)
