extends Node2D
class_name Mirror
#TODO: 该镜面实现，出现mask的光源图层遮罩问题，不仅位于镜像角色上层，且同时位于玩家上层

@export var character: Node # 目标角色节点
@onready var reflection: Sprite2D = $Reflection # 镜像对象

# 处理镜像位置同步
func _process(_delta: float) -> void:
	# 计算镜像相对于镜子的垂直距离
	var distance_y = character.global_position.y - global_position.y
	_update_reflection_position(distance_y)
	#_update_reflection_frame()

func _update_reflection_position(distance_y):
	# 更新镜像对象的位置
	reflection.global_position = Vector2(
		character.global_position.x,
		global_position.y - distance_y
	)

#TODO: get_mirrored_frame在玩家节点处定义
func _update_reflection_frame():
	# 旋转镜像角色的动画帧
	reflection.frame = character.get_mirrored_frame()
