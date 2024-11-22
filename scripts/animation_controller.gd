extends AnimatedSprite2D
# 继承 AnimatedSprite2D，控制动画播放

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

const RUN_TO_IDLE = {
	"back_run": "back_idle",
	"front_run": "front_idle",
	"right_run": "right_idle",
	"left_run": "left_idle",
	"left_up_run": "left_idle",
	"left_down_run": "left_idle",
	"right_up_run": "right_idle",
	"right_down_run": "right_idle"
}

# 播放步行移动动画，根据速度矢量方向判断当前的移动动画
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

# 播放跑步移动动画，根据速度矢量方向判断当前的跑步动画
func play_run_animation(velocity: Vector2):
	if velocity.x > 0 and velocity.y < 0: # 右上方向
		play("right_run")
	elif velocity.x > 0 and velocity.y > 0: # 右下方向
		play("right_run")
	elif velocity.x < 0 and velocity.y < 0: # 左上方向
		play("left_run")
	elif velocity.x < 0 and velocity.y > 0: # 左下方向
		play("left_run")
		
	elif velocity.y == 0 and velocity.x > 0: # 向右移动
		play("right_run")
	elif velocity.y == 0 and velocity.x < 0: # 向左移动
		play("left_run")
	elif velocity.x == 0 and velocity.y > 0: # 向下移动
		play("front_run")
	elif velocity.x == 0 and velocity.y < 0: # 向上移动
		play("back_run")

# 播放静止动画，将当前动画转换为静止状态
func play_idle_animation():
	# 检查当前动画是否在 WALK_TO_IDLE 或 RUN_TO_IDLE 中
	if WALK_TO_IDLE.keys().has(animation):
		play(WALK_TO_IDLE[animation])
	elif RUN_TO_IDLE.keys().has(animation):
		play(RUN_TO_IDLE[animation])
