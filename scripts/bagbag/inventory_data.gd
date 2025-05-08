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

#放置物品
func drop_slot_data(grabbed_slot_data:SlotData,index:int) ->SlotData:
	var slot_data = slot_datas[index]
	var return_slot_data:SlotData
	if slot_data and slot_data.can_fully_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data)
	
	elif slot_data and slot_data.exceed_fully_merge_with(grabbed_slot_data):
		slot_datas[index] = grabbed_slot_data
		return_slot_data = slot_data
	
	elif slot_data and slot_data.exceed_fully_merge_swap(grabbed_slot_data):
		slot_data.create_fully_merge_swap(grabbed_slot_data)   #公式
		return_slot_data = slot_data.create_fully_merge_swap(grabbed_slot_data)
		
	else:
		slot_datas[index] = grabbed_slot_data
		return_slot_data = slot_data
		
	#更新背包
	inventory_update.emit(self)
	
	return return_slot_data

func drop_single_slot_data(grabbed_slot_data:SlotData,index:int) ->SlotData:
	var slot_data = slot_datas[index]
	if !slot_data:
		slot_datas[index] = grabbed_slot_data.create_single_slot_data()
	elif slot_data.can_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data.create_single_slot_data())
		
		
	inventory_update.emit(self)
	
	if grabbed_slot_data.quantity > 0:
		return grabbed_slot_data
	else :
		return null 

func use_slot_data(index:int):
	var slot_data = slot_datas[index]
	
	#没有这个物品
	if !slot_data:
		return
		
	#这个物品不是药
	if !slot_data.item_data is ItemDataMedicine:
		return
		
	#正常使用
	if slot_data.item_data is ItemDataMedicine:
		slot_data.quantity -= 1
		if slot_data.quantity < 1:
			#只剩下最后一个药
			slot_datas[index] = null
			
	PlayerManager.use_slot_data(slot_data)  #改变角色饱腹值 
	
	inventory_update.emit(self)


func on_slot_clicked(index:int,button:int):
	inventory_interact.emit(self,index,button)
