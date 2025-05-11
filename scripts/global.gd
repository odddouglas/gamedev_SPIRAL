extends Node

signal esc_close

func _input(event):
	if event.is_action_pressed("ui_esc"):
		esc_close.emit()
