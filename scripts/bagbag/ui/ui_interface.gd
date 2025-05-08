extends Control

@onready var player: Player = $"../../YSort/Player"
@onready var bag: Control = $bag
@onready var grabbed_slot: Control = $grabbed_slot


#用于检测是否为空
var grabbed_slot_data:SlotData

func _ready():
	bag.set_inventory_data(player.inventory_data)
	player.inventory_data.inventory_interact.connect(on_inventory_interact)

func _process(_delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position()


func on_inventory_interact(inventory_data:InventoryData, index:int, button:int):
	match [grabbed_slot_data, button]:
		#左键
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)  #点击后
		[_, MOUSE_BUTTON_LEFT]:
			pass
			#grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data,index)
		
	grabbed_slot_update()
	print(grabbed_slot_data)

#次态更新
func grabbed_slot_update():
	if grabbed_slot_data:
		grabbed_slot.visible = true
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else :
		grabbed_slot.visible = false
