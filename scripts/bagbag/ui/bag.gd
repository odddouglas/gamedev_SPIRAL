extends Control

@onready var item_grid: GridContainer = $PanelContainer/MarginContainer3/item_grid

const Slot = preload("res://scenes/ui/slot.tscn")

#设置背包信息
func set_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_update.connect(populate_inventory_data)
	populate_inventory_data(inventory_data)
	

func populate_inventory_data(inventory_data: InventoryData):
	for i in item_grid.get_children():
		i.queue_free()
		
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)
