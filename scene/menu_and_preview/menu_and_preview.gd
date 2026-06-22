extends Control

var preview_template : PackedScene = load("res://scene/component/button_preview/button_preview.tscn")
var menu_template : PackedScene = load("res://scene/component/button_menu_flat/button_menu_flat.tscn")
var detail_template : PackedScene = load("res://scene/component/detail/detail.tscn")

@onready var menu_list: VBoxContainer = $MenuList/VBoxContainer
@onready var preview_list: GridContainer = $PreviewList/ScrollContainer/GridContainer
@onready var button_ascending: Button = $Panel/ButtonAscending
@onready var filter_menu: OptionButton = $Panel/FilterMenu
@onready var label_title: Label = $LabelTitle


var character_database : Dictionary = load("res://database/data/character_database.tres").data
var stiker_database : Dictionary = load("res://database/data/stiker_database.tres").data

var menu : Dictionary = {
	1 : {"name" : "Character", "icon" : load("res://asset_sementaera/character.png"), "database" : "character_database"},
	2 : {"name" : "Stiker", "icon" : load("res://asset_sementaera/stiker.png"), "database" : "stiker_database"}
}

var sorting_catogory

var sorting_method : String = "desc"
var current_database : String = "character_database"
var sorting_by : String
var filter_target : String = "Rarity"
var title : String = "Character"

func _ready() -> void:
	menu_display()
	preview_display(current_database)
	ui_change()

func menu_display():
	for id in menu:
		var data = menu[id]
		
		var menu_button = menu_template.instantiate()
		menu_button.menu_data(data["name"] ,data["icon"])
		
		menu_button.menu_pressed.connect(func(): preview_display(data["database"]))
		menu_button.menu_pressed.connect(func(): current_database = data["database"])
		menu_button.menu_pressed.connect(func(): title = data["name"])
		menu_button.menu_pressed.connect(func(): ui_change())
		
		menu_list.add_child(menu_button)

func preview_display(database):
	
	for child in preview_list.get_children():
		child.queue_free()
	
	var direct_database : Dictionary = self.get(database)	
	
	var id_filtered = filtering(direct_database, "rarity")
	var id_data = sorting(direct_database, id_filtered , "rarity")
	
	
	
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
	detail_scene.filter_target_send = filter_target
	detail_scene.detail_data(database, id)
	
	queue_free()

func sorting(database, data_filter, by):
	#var sort_data = database.keys()
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
	

func _on_button_ascending_pressed():
	if sorting_method == "asc":
		sorting_method = "desc"
	elif sorting_method == "desc":
		sorting_method = "asc"
	
	ui_change()
	preview_display(current_database)


func _on_filter_menu_item_selected(index: int) -> void:
	match index:
		0: filter_target = "Rarity"
		1: filter_target = "6"
		2: filter_target = "5"
		3: filter_target = "4"
	preview_display(current_database)


func _on_debug_pressed() -> void:
	print(filter_target)
