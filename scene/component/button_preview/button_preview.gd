extends Control

signal preview_pressed

func preview_data(name_display, image_preview, rarity):
	$PanelContainer/NameDisplay.text = str(name_display)
	$Button/ImagePreview.texture = load(image_preview)
	#$Button/RarityBorder.texture.gradient.set_color(0, rarity_color(rarity))
	$Button/Label.text = str(rarity)
	$Button/ColorRect.color = rarity_color(rarity)
	#var border = $Button/RarityBorder.texture.duplicate()
	#border.gradient.set_color(0, rarity_color(rarity))
	#$Button/RarityBorder.texture = border
	$Button/TextureRect.modulate = rarity_color(rarity)
	
	#pass

func rarity_color(rarity):
	match int(rarity):
		6: return Color("fd0400")
		5: return Color("E6DE01")
		4: return Color("960DF1")
		#3: return 
	#pass

func _on_button_pressed() -> void:
	preview_pressed.emit()
