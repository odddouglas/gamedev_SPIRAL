extends StaticBody2D

@export var inventory_data: InventoryData

signal toggle_inventory(box_inventory)
signal exited_box

func player_interact():
	toggle_inventory.emit(self)
	#print("da kai xiang zi")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body:
		exited_box.emit()
		#print("fan wei wai")
