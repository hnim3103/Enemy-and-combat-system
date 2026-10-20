extends EnemyState

@export var patrol_distance: float = 5.0
@export var drop_interval: float = 1.2

var _start_x: float = NAN

func enter() -> void:
	obj.change_animation("fly")
	if is_nan(_start_x):
		_start_x = obj.global_position.x
	timer = drop_interval

func update(delta: float) -> void:
	var step: Vector3 = obj.forward() * obj.movement_speed
	obj.velocity.x = step.x
	obj.velocity.z = step.z

	var x: float = obj.global_position.x
	var reached_end: bool = (obj.is_right() and x >= _start_x + patrol_distance) or (obj.is_left() and x <= _start_x)
	if reached_end or obj.is_on_wall():
		obj.turn_around()

	if update_timer(delta):
		obj.fire()
		timer = drop_interval
