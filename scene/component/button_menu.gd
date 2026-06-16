extends Control

#@onready var icon: TextureRect = $Button/Icon
#@onready var label_name: Label = $Button/LabelName
signal pressed
#var name = ""
func _ready() -> void:
	$Button.pressed.connect(func() : print("dahlah"))

func menu_data(name):
	$Button/LabelName.text = name
	pass
