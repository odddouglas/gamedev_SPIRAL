extends CharacterBody2D
class_name player

@onready var animated_sprite_2d: AnimationController = $AnimatedSprite2D # 控制玩家动画的节点

const SPEED = 5000.0

# 物理帧处理函数
func _physics_process(delta: float) -> void:
	
	# 获取玩家的输入方向向量
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# 如果有方向输入，设置速度矢量
	if direction:
		velocity = direction * SPEED * delta
	else:
		# 如果没有输入，逐步将速度减为 0（缓动效果）
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.y = move_toward(velocity.y, 0, SPEED * delta)

	# 如果速度不为零，播放移动动画；否则播放静止动画
	if velocity != Vector2.ZERO:
		animated_sprite_2d.play_walk_animation(velocity)
	else:
		animated_sprite_2d.play_idle_animation()

	# 移动角色并处理碰撞
	move_and_slide()
