extends Control


@onready var menu_list: HBoxContainer = $MenuPreview/HBoxContainer
@onready var animate: AnimationPlayer = $AnimationPlayer

#var preview_detail_scene : PackedScene = load("res://scene/menu/preview_detail.tscn")
var manager_scene : PackedScene = load("res://manager.tscn")
var preview_template : PackedScene = load("res://scene/preview/preview.tscn")
var preview_detail_template : PackedScene = load("res://scene/preview_and_detail/preview_and_detail.tscn")
var menu_template : PackedScene = load("res://scene/component/button_menu/button_menu.tscn")

var menu : Dictionary = {
	1 : {"name" : "Character", "icon" : load("res://assets/character_icon.png"), "database" : "character_database"},
	2 : {"name" : "Stiker", "icon" : load("res://assets/stiker_icon.png"), "database" : "stiker_database"}
}

func _ready() -> void:
	animate.play("enter_scene")
	menu_display()

func menu_display():
	for id in menu:
		var data = menu[id]
		
		var button_menu = menu_template.instantiate()
		button_menu.menu_data(data["name"], data["icon"])
		
		button_menu.menu_pressed.connect(func() : preview(data["database"], data["name"]))
		
		menu_list.add_child(button_menu)
	#pass

func preview(database, name_database):
	var preview_transition
	
	if Global.flow == 1:
		preview_transition = preview_template.instantiate()
	elif Global.flow == 2:
		preview_transition = preview_detail_template.instantiate()
	
	animate.play("exit_scene")
	await animate.animation_finished
	
	get_tree().root.add_child(preview_transition)
	get_tree().current_scene = preview_transition
	
	preview_transition.current_database = database
	preview_transition.database_ui = name_database
	preview_transition.preview_data()
	
	queue_free()


func _on_button_back_pressed() -> void:
	animate.play("exit_scene")
	await animate.animation_finished
	get_tree().change_scene_to_packed(manager_scene)
