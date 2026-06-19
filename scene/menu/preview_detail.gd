extends Control

signal menu_diklik(database_data)

@onready var label_title: Label = $PanelTitle/LabelTitle

func _ready() -> void:
	#$PanelTitle/LabelTitle.pressed.connect(emit_custom_signal)
	pass

func preview_data(db_data):
	label_title.text = name 
	self.set_meta("db_data", db_data)
	pass

func emit_custom_signal():
	var data_to_send = self.get_meta("db_data")
	emit_signal("menu_diklik", data_to_send)

	pass
