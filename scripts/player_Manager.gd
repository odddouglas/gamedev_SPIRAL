extends Node

#这个脚本写生命值等状态
var player

func use_slot_data(slot_data: SlotData):
	slot_data.item_data.use(player)
