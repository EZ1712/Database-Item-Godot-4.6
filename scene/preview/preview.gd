extends Control

var menu_scene : PackedScene = load("res://scene/menu/menu.tscn")
var preview_template : PackedScene = load("res://scene/component/button_preview/button_preview.tscn")
var detail_template : PackedScene = load("res://scene/component/detail/detail.tscn")

@onready var preview_list: GridContainer = $PanelPreview/ScrollContainer/MarginContainer/GridContainer
@onready var filter_menu: OptionButton = $PanelNavigation/FilterMenu
@onready var button_ascending: Button = $PanelNavigation/ButtonAscending
@onready var label_title: Label = $LabelTitle

var character_database : Dictionary = load("res://database/data/character_database.tres").data
var stiker_database : Dictionary = load("res://database/data/stiker_database.tres").data

var database_ui : String
var current_database : String 
var filter_target : String = "Rarity"
var sorting_method : String = "desc"
var title : String = database_ui

func preview_data():
	
	label_title.text = str(database_ui)
	
	for child in preview_list.get_children():
		child.queue_free()
	
	var direct_database : Dictionary = self.get(current_database)
	
	var id_filtered = filtering(direct_database, "rarity")
	var id_data = sorting(direct_database, id_filtered , "rarity")
	
	for id in id_data:
		var data = direct_database[id]
		
		var preview_button = preview_template.instantiate()
		preview_button.preview_data(data["name"],data["image_preview"], data["rarity"])
		
		preview_button.preview_pressed.connect(func(): detail(current_database, id))
		
		preview_list.add_child(preview_button)

func detail(database, id):
	var detail_scene = detail_template.instantiate()
	
	get_tree().root.add_child(detail_scene)
	get_tree().current_scene = detail_scene
	
	detail_scene.sorting_method_send  = sorting_method
	detail_scene.filter_target_send = filter_target
	detail_scene.title_send = database_ui
	detail_scene.detail_data(database, id)
	
	queue_free()

func sorting(database, data_filter, by):
	var sort_data = data_filter
	
	if sorting_method == "asc":
		sort_data.sort_custom(func(a,b):
			var value_a = str(database[a][by]).to_lower()
			var value_b = str(database[b][by]).to_lower()
			return value_a < value_b
			)
	elif  sorting_method == "desc":
		sort_data.sort_custom(func(a,b):
			var value_a = str(database[a][by]).to_lower()
			var value_b = str(database[b][by]).to_lower()
			return value_a > value_b
			)
	return sort_data

func filtering(database, by):
	var filter_data = database.keys()
	
	if filter_target == "Rarity":
		return filter_data
	else:
		filter_data = filter_data.filter(func(id) : 
			var data = str(database[id][by]).to_lower()
			return data == str(filter_target).to_lower()
		)
		return filter_data

func ui_change():
	button_ascending.text = str(sorting_method).to_upper()
	
	if filter_target == "Rarity":
		filter_menu.text = str(filter_target)
		filter_menu.selected = 0
	else:
		filter_menu.text = str("*" + filter_target)
		filter_menu.selected = 7 - int(filter_target)
	label_title.text = str(title)

func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_packed(menu_scene)


func _on_button_ascending_pressed() -> void:
	if sorting_method == "asc":
		sorting_method = "desc"
	elif sorting_method == "desc":
		sorting_method = "asc"
	ui_change()
	preview_data()


func _on_filter_menu_item_selected(index: int) -> void:
	match index:
		0: filter_target = "Rarity"
		1: filter_target = "6"
		2: filter_target = "5"
		3: filter_target = "4"
	preview_data()
