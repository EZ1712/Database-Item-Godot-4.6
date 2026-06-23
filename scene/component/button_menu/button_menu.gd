extends Control

signal menu_pressed

func menu_data(name, image):
	$Button/LabelTitle.text = str(name)
	$Button/TextureRect.texture = image

func _on_button_pressed() -> void:
	menu_pressed.emit()
