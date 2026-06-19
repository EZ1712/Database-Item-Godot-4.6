extends Control



var character_database : Dictionary = load("res://database/data/character_database.tres").data
var stiker_database : Dictionary = load("res://database/data/stiker_database.tres").data

var menu_and_preview : PackedScene = load("res://scene/menu_and_preview/menu_and_preview.tscn")

var sorting_method_send : String
var database_current : String

func detail_data(database, id):
	var raw_database : Dictionary = self.get(database)
	var data = raw_database[id]
	
	$PanelMain/ControlDetail/PanelDetail/Panel/MarginContainer/LabelName.text = str(data["name"])
	$PanelMain/ControlDetail/PanelDetail/PanelContainer/MarginContainer/VBoxContainer/LabelRarity.text = str(data["rarity"])
	$PanelMain/TextureImage.texture = load(data["image"])
	$PanelMain/ControlDetail/PanelDetail/Panel/MarginContainer2/ColorRect.color = rarity_color(data["rarity"])
	#$LabelDatabase.text = str(database)
	#$Panel/Panel/Label.text = str(name_display)
	
	database_current = database

func rarity_color(rarity):
	match int(rarity):
		6: return Color("fd0400")
		5: return Color("E6DE01")
		4: return Color("960DF1")

func _on_button_back_pressed() -> void:
	var menu_preview_scene = menu_and_preview.instantiate()
	
	get_tree().root.add_child(menu_preview_scene)
	get_tree().current_scene = menu_preview_scene
	
	menu_preview_scene.sorting_method = sorting_method_send
	#menu_preview_scene.data_from_detail(database_current,sorting_method_send)
	
	menu_preview_scene.preview_display(database_current)
	menu_preview_scene.preview_sorting()
	queue_free()
