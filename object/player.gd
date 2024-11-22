extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimationController = $AnimatedSprite2D # 控制玩家动画的节点

const SPEED_WALK = 5000.0 # 步行速度
const SPEED_RUN = 8000.0 # 跑步速度

# 物理帧处理函数
func _physics_process(delta: float) -> void:
	# 检测是否按住了 Shift 键
	var is_running = Input.is_action_pressed("shift")
	
	# 获取玩家的输入方向向量
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# 如果有方向输入，设置速度矢量
	if direction:
		var speed = SPEED_RUN if is_running else SPEED_WALK # 根据是否跑步选择速度
		velocity = direction * speed * delta

		# 播放对应动画
		if is_running:
			animated_sprite_2d.play_run_animation(velocity)
		else:
			animated_sprite_2d.play_walk_animation(velocity)
	else:
		# 如果没有输入，逐步将速度减为 0（缓动效果）
		velocity.x = move_toward(velocity.x, 0, SPEED_WALK * delta)
		velocity.y = move_toward(velocity.y, 0, SPEED_WALK * delta)

		# 播放静止动画
		animated_sprite_2d.play_idle_animation()

	# 移动角色并处理碰撞
	move_and_slide()
