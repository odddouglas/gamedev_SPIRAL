extends Area2D
class_name NPC

@export var dialogue_start: StringName = &"npc_intro"

func get_dialogue_start() -> StringName:
	if Game.HAS_EMBER:
		return &"npc_return"
	return dialogue_start
