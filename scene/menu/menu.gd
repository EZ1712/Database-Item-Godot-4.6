extends Control


@onready var menu_list: HBoxContainer = $MenuPreview/HBoxContainer

#var preview_detail_scene : PackedScene = load("res://scene/menu/preview_detail.tscn")
var preview_detail_template : PackedScene = load("res://scene/preview_and_detail/preview_and_detail.tscn")
var menu_template : PackedScene = load("res://scene/component/button_menu/button_menu.tscn")

var menu : Dictionary = {
	1 : {"name" : "Character", "icon" : load("res://asset_sementaera/character.png"), "database" : "character_database"},
	2 : {"name" : "Stiker", "icon" : load("res://asset_sementaera/stiker.png"), "database" : "stiker_database"}
}

func _ready() -> void:
	menu_display()

func menu_display():
	for id in menu:
		var data = menu[id]
		
		var button_menu = menu_template.instantiate()
		button_menu.menu_data(data["name"])
		
		button_menu.menu_pressed.connect(func() : preview(data["database"]))
		
		menu_list.add_child(button_menu)
	#pass

#func debug(indikator):
	#print(str(indikator))

func preview(database):
	var preview_transition = preview_detail_template.instantiate()
	
	get_tree().root.add_child(preview_transition)
	get_tree().current_scene = preview_transition
	
	preview_transition.current_database = database
	preview_transition.preview_data()
	
	queue_free()
	pass
