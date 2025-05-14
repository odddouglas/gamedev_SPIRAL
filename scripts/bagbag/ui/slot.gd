extends Control

signal slot_clicked(index: int,button: int)
signal shift_slot_clicked(index: int, button: int)

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label


func set_slot_data(slot_data: SlotData):
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.item_texture
	
	if slot_data.quantity > 1:
		label.text = '%s' % slot_data.quantity
		label.visible = true
	
	else :
		label.visible = false


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and not Input.is_key_pressed(KEY_SHIFT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(),event.button_index)
		#print(get_index(),event.button_index)
	
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and Input.is_key_pressed(KEY_SHIFT) \
			and event.is_pressed():
		shift_slot_clicked.emit(get_index(),event.button_index)
