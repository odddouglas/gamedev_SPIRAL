extends AnimatedSprite2D

class_name AnimationController

var facing_direction: StringName = &"front"

func play_walk_animation(velocity: Vector2) -> void:
	_play_directional_animation(velocity, &"walk")

func play_run_animation(velocity: Vector2) -> void:
	_play_directional_animation(velocity, &"run")

func play_idle_animation() -> void:
	play(StringName("%s_idle" % facing_direction))

func _play_directional_animation(velocity: Vector2, movement: StringName) -> void:
	if velocity.x > 0.0:
		facing_direction = &"right"
	elif velocity.x < 0.0:
		facing_direction = &"left"
	elif velocity.y > 0.0:
		facing_direction = &"front"
	elif velocity.y < 0.0:
		facing_direction = &"back"
	else:
		return

	play(StringName("%s_%s" % [facing_direction, movement]))
