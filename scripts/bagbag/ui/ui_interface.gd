extends Control

@onready var player: Player = $"../../YSort/Player"
@onready var bag: Control = $bag
@onready var grabbed_slot: Control = $grabbed_slot
@onready var box: StaticBody2D = $"../../box"
@onready var bag_2: Control = $bag2  #bag_2为箱子

var box_inventory

signal  link_bag_close

#用于检测是否为空
var grabbed_slot_data:SlotData

func _ready():
	bag.set_inventory_data(player.inventory_data)
	player.inventory_data.inventory_interact.connect(on_inventory_interact)
	
	#箱子不止一个，打开更多箱子
	for node in get_tree().get_nodes_in_group("box_inventory"):
		node.toggle_inventory.connect(set_box_inventory)
	for node in get_tree().get_nodes_in_group("box_inventory"):
		node.exited_box.connect(clear_external_inventory)
		
	
	Global.esc_close.connect(_esc_close)
	connect("link_bag_close",Callable(self,"set_box_inventory"))
	bag_2.box_close.connect(_esc_close)
	bag.bag_close.connect(_esc_close)
	

func _esc_close():
	if bag_2.visible:
		link_bag_close.emit(self)
	else:
		bag.visible = false

func set_box_inventory(_box_inventory):
	bag.visible = !bag.visible
	if _box_inventory:
		if !bag_2.visible:
			set_external_inventory(_box_inventory)
			bag.visible = true
		else :
			clear_external_inventory()
			bag.visible = false


func set_external_inventory(_box_inventory):
	box_inventory = _box_inventory
	var inventory_data = box_inventory.inventory_data
	inventory_data.inventory_interact.connect(on_inventory_interact)
	bag_2.set_inventory_data(inventory_data)
	bag_2.visible = true
	Game.CAN_MOVE = false

func clear_external_inventory():
	if box_inventory:
		var inventory_data = box_inventory.inventory_data
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		bag_2.clear_inventory_data(inventory_data)
		bag_2.visible = false
		bag.visible = false
		box_inventory = null
		Game.CAN_MOVE = true

func _process(_delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position()


func on_inventory_interact(inventory_data:InventoryData, index:int, button:int):
	match [grabbed_slot_data, button]:
		#左键
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)  #点击后
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data,index)
		
		#右键
		[null,MOUSE_BUTTON_RIGHT]:
			#使用物品（吃药）
			inventory_data.use_slot_data(index)
			
		[_,MOUSE_BUTTON_RIGHT]:
			#拆分数量
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data,index)
			
		
	grabbed_slot_update()
	#print(grabbed_slot_data)

#次态更新
func grabbed_slot_update():
	if grabbed_slot_data:
		grabbed_slot.visible = true
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else :
		grabbed_slot.visible = false
