extends Control

signal preview_pressed

func preview_data(name_display, image_preview):
	$PanelContainer/NameDisplay.text = str(name_display)
	$Button/ImagePreview.texture = image_preview
	pass

func _on_button_pressed() -> void:
	preview_pressed.emit()
