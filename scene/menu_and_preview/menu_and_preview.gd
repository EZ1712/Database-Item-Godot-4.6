extends Control

var preview_template : PackedScene = load("res://scene/component/button_preview/button_preview.tscn")
var menu_template : PackedScene = load("res://scene/component/button_menu_flat/button_menu_flat.tscn")
var detail_template : PackedScene = load("res://scene/component/detail/detail.tscn")

@onready var menu_list: VBoxContainer = $MenuList/VBoxContainer
@onready var preview_list: GridContainer = $PreviewList/ScrollContainer/GridContainer

var character_database : Dictionary = load("res://database/data/character_data.tres").data
var stiker_database : Dictionary = load("res://database/data/stiker_database.tres").data

var menu : Dictionary = {
	1 : {"name" : "Character", "icon" : load("res://asset_sementaera/character.png"), "database" : "character_database"},
	2 : {"name" : "Stiker", "icon" : load("res://asset_sementaera/stiker.png"), "database" : "stiker_database"}
}

var current_database : String 

func _ready() -> void:
	menu_display()

func menu_display():
	for id in menu:
		var data = menu[id]
		
		var menu_button = menu_template.instantiate()
		menu_button.menu_data(data["name"] ,data["icon"])
		
		menu_button.menu_pressed.connect(func(): preview_display(data["database"]))
		
		menu_list.add_child(menu_button)

func preview_display(database):
	
	for child in preview_list.get_children():
		child.queue_free()
	
	var direct_database : Dictionary = self.get(database)
	
	for id in direct_database:
		var data = direct_database[id]
		
		var preview_button = preview_template.instantiate()
		preview_button.preview_data(data["name"], data["image_preview"])
		
		preview_button.preview_pressed.connect(func(): detail(data["name"], database))
		
		preview_list.add_child(preview_button)

func detail(name_display, database):
	var detail_scene = detail_template.instantiate()
	
	get_tree().root.add_child(detail_scene)
	get_tree().current_scene = detail_scene
	
	detail_scene.detail_data(name_display, database)
	
	queue_free()
