extends PlayerState

## Currently carrying something overhead.

const LIFT_TIME := 0.18
const THROW_SPEED := 8.0
const THROW_UP_SPEED := 6.0
const MAX_CHARGE_TIME := 1.0


var _tween: Tween
var _charge_time: float = -1.0

func enter() -> void:
	obj.stop_horizontal()
	obj.change_animation("carry_idle")
	obj.held.be_picked_up(obj.hold_point)
	_tween = obj.create_tween()
	_tween.tween_property(obj.held, "position", Vector3.ZERO, LIFT_TIME)
	_charge_time = -1.0

func exit() -> void:
	if _tween != null and _tween.is_valid():
		_tween.kill()

	if obj.held != null:
		obj.held.be_dropped(obj.held.global_position)
		obj.held = null


func update(delta: float) -> void:
	if _tween.is_running():
		return

	if Input.is_action_just_pressed("carry"):
		_charge_time = 0.0
	elif _charge_time >= 0.0:
		if Input.is_action_pressed("carry"):
			_charge_time += delta
		else:
			_throw()
			return

	var is_moving := move_by_input(obj.held.carry_speed_scale)
	obj.change_animation("carry" if is_moving else "carry_idle")
	
func _throw() -> void:
	var power := 1.0 + minf(_charge_time / MAX_CHARGE_TIME, 1.0)
	var throw_velocity: Vector3 = obj.forward() * THROW_SPEED * power
	throw_velocity.y = THROW_UP_SPEED
	obj.held.be_thrown(throw_velocity)
	obj.held = null
	change_state(fsm.states.throw)
