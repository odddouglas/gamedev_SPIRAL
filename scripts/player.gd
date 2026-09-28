extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimationController = $AnimatedSprite2D # 控制玩家动画的节点

#规定角色相关常量
const SPEED_WALK = 100.0 # 步行速度
const SPEED_RUN = 160.0 # 跑步速度
#规定角色相关变量
var INTERACT_AREA: Area2D = null # 停留的交互区域
var INTERACT_DIALOGUE: StringName = &"pickup_ornot"


func _ready() -> void:
	# 连接对话管理器的对话结束事件
	DialogueManager.connect("dialogue_ended", _on_dialogue_ended)

# 物理帧处理函数
func _physics_process(_delta: float) -> void:
	# 检测是否处于可以移动的状态，如果不是，则直接return
	if not Game.CAN_MOVE:
		velocity = Vector2.ZERO # 停止移动
		animated_sprite_2d.play_idle_animation()
		return
	
	# 检测是否按住了 Shift 键
	var is_running = Input.is_action_pressed("shift")
	
	# 获取玩家的输入方向向量
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# 如果有方向输入，设置速度矢量
	if direction:
		var speed = SPEED_RUN if is_running else SPEED_WALK # 根据是否跑步选择速度
		velocity = direction * speed

		# 播放对应动画
		if is_running:
			animated_sprite_2d.play_run_animation(velocity)
		else:
			animated_sprite_2d.play_walk_animation(velocity)
	else:
		velocity = Vector2.ZERO

		# 播放静止动画
		animated_sprite_2d.play_idle_animation()

	# 移动角色并处理碰撞
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Item:
		INTERACT_AREA = area # 保护当前交互区域（该区域内的Area2对象）
		INTERACT_DIALOGUE = &"pickup_ornot"
	elif area is NPC:
		INTERACT_AREA = area
		INTERACT_DIALOGUE = area.get_dialogue_start()
	else:
		return

	Game.CAN_MOVE = false # 限制角色移动
	DialogueManager.show_dialogue_balloon(load("res://dialogue/test.dialogue"), INTERACT_DIALOGUE)

#对话框结束的处理函数（需要在ready函数中connect）
func _on_dialogue_ended(resource: DialogueResource) -> void:
	#resource这个参数不用也要传
	print("Dialogue finished:", resource)
	Game.CAN_MOVE = true # 解除角色移动的限制
	if INTERACT_AREA is Item and Game.CAN_PICKUP and is_instance_valid(INTERACT_AREA):
		INTERACT_AREA.queue_free() # 销毁交互区域
		Game.CAN_PICKUP = false # 限制角色进行拾取
		Game.HAS_EMBER = true
	INTERACT_AREA = null

#master
