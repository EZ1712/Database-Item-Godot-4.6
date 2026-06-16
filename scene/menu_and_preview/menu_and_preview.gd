extends Control


var menu_template : PackedScene = load("res://scene/component/button_menu_flat/button_menu_flat.tscn")

@onready var menu_list: VBoxContainer = $MenuList/VBoxContainer

var menu : Dictionary = {
	1 : {"name" : "Character", "icon" : load("res://asset_sementaera/character.png"), "database" : "character"},
	2 : {"name" : "Stiker", "icon" : load("res://asset_sementaera/stiker.png"), "database" : "stiker"}
}

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
	print(database)
	pass
