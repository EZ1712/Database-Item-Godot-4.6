extends Control

var menu_and_preview : PackedScene = load("res://scene/menu_and_preview/menu_and_preview.tscn")

var database_current : String

func detail_data(name_display, database):
	$LabelDatabase.text = str(database)
	$Panel/Panel/Label.text = str(name_display)
	
	database_current = database
	pass


func _on_button_back_pressed() -> void:
	var menu_preview_scene = menu_and_preview.instantiate()
	
	get_tree().root.add_child(menu_preview_scene)
	get_tree().current_scene = menu_preview_scene
	
	menu_preview_scene.preview_display(database_current)
	queue_free()
