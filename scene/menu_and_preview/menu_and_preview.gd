extends Control

var preview_template : PackedScene = load("res://scene/component/button_preview/button_preview.tscn")
var menu_template : PackedScene = load("res://scene/component/button_menu_flat/button_menu_flat.tscn")
var detail_template : PackedScene = load("res://scene/component/detail/detail.tscn")

@onready var menu_list: VBoxContainer = $MenuList/VBoxContainer
@onready var preview_list: GridContainer = $PreviewList/ScrollContainer/GridContainer
@onready var button_ascending: Button = $Panel/Sort/ButtonAscending

var character_database : Dictionary = load("res://database/data/character_database.tres").data
var stiker_database : Dictionary = load("res://database/data/stiker_database.tres").data

var menu : Dictionary = {
	1 : {"name" : "Character", "icon" : load("res://asset_sementaera/character.png"), "database" : "character_database"},
	2 : {"name" : "Stiker", "icon" : load("res://asset_sementaera/stiker.png"), "database" : "stiker_database"}
}

var sorting_catogory

var sorting_method : String = "asc"
var current_database : String = "character_database"
var sorting_by : String

func _ready() -> void:
	menu_display()
	preview_display(current_database,sorting(self.get(current_database), "name"))
	button_method_text()

func menu_display():
	for id in menu:
		var data = menu[id]
		
		var menu_button = menu_template.instantiate()
		menu_button.menu_data(data["name"] ,data["icon"])
		
		menu_button.menu_pressed.connect(func(): preview_display(data["database"], sorting(self.get(data["database"]), "name")))
		#menu_button.menu_pressed.connect(func(): preview_display(data["database"]))
		menu_button.menu_pressed.connect(func(): current_database = data["database"])
		
		menu_list.add_child(menu_button)

func preview_display(database, sort_data : Array = []):
	
	current_database = database
	
	for child in preview_list.get_children():
		child.queue_free()
	
	var direct_database : Dictionary = self.get(database)
	
	var id_data = sort_data
	
	if sort_data.is_empty():
		id_data = direct_database.keys()
	#var id_data = sorting(database)
	
	for id in id_data:
		var data = direct_database[id]
		
		var preview_button = preview_template.instantiate()
		preview_button.preview_data(data["name"], data["image_preview"], data["rarity"])
		
		preview_button.preview_pressed.connect(func(): detail(database, id))
		
		preview_list.add_child(preview_button)

func detail(database, id):
	var detail_scene = detail_template.instantiate()
	
	get_tree().root.add_child(detail_scene)
	get_tree().current_scene = detail_scene
	
	detail_scene.sorting_method_send  = sorting_method
	detail_scene.detail_data(database, id)
	
	queue_free()

func sorting(database, by):
	#var raw_database = self.get(database)
	var sort_data = database.keys()
	
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


#func _on_option_button_item_selected(index: int) -> void:
	#var sort_database : Dictionary = self.get(current_database)
	#if index == 0:
		#var id_sort = sorting(sort_database, "name", "asc")
		#preview_display(current_database, id_sort)
		#sorting_method = "asc"
	#elif index == 1:
		#var id_sort = sorting(sort_database, "name", "desc")
		#preview_display(current_database, id_sort)
		#sorting_method = "desc"
		#print(sort_database)

func button_method_text():
	button_ascending.text = str(sorting_method).to_upper()

func preview_sorting():
	#var sort_database : Dictionary = self.get(current_database)
	var id_sort = sorting(self.get(current_database), "name")
	preview_display(current_database, id_sort)
	button_method_text()

func _on_button_ascending_pressed():
	if sorting_method == "asc":
		sorting_method = "desc"
	elif sorting_method == "desc":
		sorting_method = "asc"
	
	button_method_text()
	preview_sorting()
