extends Resource
class_name InventoryData

signal inventory_interact(inventory_data: InventoryData, index: int, button: int)
signal inventory_update(inventory_data)  #更新背包

@export var slot_datas: Array[SlotData]

func grab_slot_data(index:int) -> SlotData:
	var slot_data = slot_datas[index]
	if slot_data:
		#点击后
		slot_datas[index] = null
		inventory_update.emit(self)
		return slot_data
	else :
		return null


func on_slot_clicked(index:int,button:int):
	inventory_interact.emit(self,index,button)
