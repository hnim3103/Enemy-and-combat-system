extends EnemyState

@export var shoot_delay: float = 0.3
@export var shot_interval: float = 0.2
@export var shot_count: int = 3

var _fire_timer: float = 0.0
var _shots_fired: int = 0
# var _has_fired: bool = false

func enter() -> void:
	obj.change_animation("shoot")
	obj.stop_move()
	# _has_fired = false
	_shots_fired = 0
	_fire_timer = shoot_delay

	# timer = obj.anim_player.get_animation("shoot_%s" % obj.direction).length

func update(delta: float) -> void:
	_fire_timer -= delta
	if _fire_timer <= 0.0:
		obj.fire()
		_shots_fired += 1
		_fire_timer = shot_interval

	if _shots_fired >= shot_count:
		change_state(fsm.states.idle)
