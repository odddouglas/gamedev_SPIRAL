extends StaticBody2D

@export var inventory_data: InventoryData

signal toggle_inventory(box_inventory)

func player_interact():
	toggle_inventory.emit(self)
	print("da kai xiang zi")
