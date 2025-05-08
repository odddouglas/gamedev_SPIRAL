extends Resource
class_name SlotData

@export_range(1,99) var quantity: int = 1
@export var item_data: ItemData

#相同物品合并
func  can_fully_merge_with(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data \
		and item_data.stackable \
		and quantity + other_slot_data.quantity <= 99
		

#背包物品早已达到上限，背包物品和鼠标物品交换
func exceed_fully_merge_with(other_slot_data:SlotData) -> bool:
	return item_data == other_slot_data.item_data \
		and item_data.stackable \
		and quantity == 99 \
		and quantity + other_slot_data.quantity < 99

#合并时背包达到上限，剩余返回鼠标
func exceed_fully_merge_swap(other_slot_data:SlotData) -> bool:
	return item_data == other_slot_data.item_data \
		and item_data.stackable \
		and quantity < 99 \
		and other_slot_data.quantity < 99

func can_merge_with(other_slot_data:SlotData) -> bool:
	return item_data == other_slot_data.item_data \
		and item_data.stackable \
		and quantity < 99



#算法
func create_fully_merge_swap(other_slot_data:SlotData) ->SlotData:
	other_slot_data.quantity = other_slot_data.quantity - (10 - quantity)
	quantity += 10 - quantity
	return other_slot_data

func create_single_slot_data() -> SlotData:
	var new_slot_data = duplicate()   #创建一个副本
	new_slot_data.quantity = 1
	quantity -= 1
	return new_slot_data


#相同物品相加
func fully_merge_with(other_slot_data: SlotData):
	quantity += other_slot_data.quantity
