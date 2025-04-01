extends Area2D

class_name Item

@export var inventory_item: InventoryItem # 写好的库存项目物品类。此时挂载item.gd脚本的实例就会出现资源的属性栏

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	sprite_2d.texture = inventory_item.texture
	collision_shape_2d.shape = inventory_item.ground_collision_shape
	# Set up the collision shape
