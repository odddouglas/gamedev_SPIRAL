extends AnimatedSprite2D
#继承得到animation这个成员

class_name AnimationController

# 常量：从移动动画到静止动画的映射关系
const WALK_TO_IDLE = {
	"back_walk": "back_idle",
	"front_walk": "front_idle",
	"right_walk": "right_idle",
	"left_walk": "left_idle",
	"left_up_walk": "left_idle",
	"left_down_walk": "left_idle",
	"right_up_walk": "right_idle",
	"right_down_walk": "right_idle"
}

# 播放移动动画，根据速度矢量方向判断当前的移动动画
func play_walk_animation(velocity: Vector2):
	if velocity.x > 0 and velocity.y < 0: # 右上方向
		play("right_walk")
	elif velocity.x > 0 and velocity.y > 0: # 右下方向
		play("right_walk")
	elif velocity.x < 0 and velocity.y < 0: # 左上方向
		play("left_walk")
	elif velocity.x < 0 and velocity.y > 0: # 左下方向
		play("left_walk")
		
	elif velocity.y == 0 and velocity.x > 0: # 向右移动
		play("right_walk")
	elif velocity.y == 0 and velocity.x < 0: # 向左移动
		play("left_walk")
	elif velocity.x == 0 and velocity.y > 0: # 向下移动
		play("front_walk")
	elif velocity.x == 0 and velocity.y < 0: # 向上移动
		play("back_walk")

# 播放静止动画，将当前动画转换为静止状态
func play_idle_animation():
	# 检查当前动画是否在 MOVEMENT_TO_IDLE 中
	if WALK_TO_IDLE.keys().has(animation):
		# 播放对应的静止动画
		play(WALK_TO_IDLE[animation])
