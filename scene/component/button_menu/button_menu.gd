extends Control

signal menu_pressed

func menu_data(name):
	$Button/LabelTitle.text = str(name)
	pass

func _on_button_pressed() -> void:
	menu_pressed.emit()
