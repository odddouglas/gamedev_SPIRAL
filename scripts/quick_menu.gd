extends Control
@onready var pos: Control = $Pos

#TAU 是数学常数，等于 2 * PI（相当于 360°）。计算当前子节点相对于圆周的角度。旋转 θ 角度，使子节点均匀分布在圆周上
func _process(_delta: float) -> void:
	for I in pos.get_child_count():
		var angle = I / (pos.get_child_count() / TAU)
		pos.get_child(I).global_position = Vector2(80, 0).rotated(angle) + pos.global_position
