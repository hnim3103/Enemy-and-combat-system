extends EnemyState

@export var shoot_interval: float = 1.5

func enter() -> void:
	obj.change_animation("idle")
	timer = shoot_interval

func update(_delta: float) -> void:
	if update_timer(_delta):
		if obj.found_player != null:
			change_state(fsm.states.shoot)
		else:
			timer = shoot_interval