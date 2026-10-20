extends PlayerState

## Currently carrying something overhead.

const LIFT_TIME := 0.18
const  THORW_SPEED := 8.0
const  THROW_UP_SPEED := 6.0

var _tween: Tween

func enter() -> void:
	obj.stop_horizontal()
	obj.change_animation("carry_idle")
	obj.held.be_picked_up(obj.hold_point)
	_tween = obj.create_tween()
	_tween.tween_property(obj.held, "position", Vector3.ZERO, LIFT_TIME)

func exit() -> void:
	if _tween != null and _tween.is_valid():
		_tween.kill()

	if obj.held != null:
		obj.held.be_dropeed(obj.held.global_position)
		obj.held = null


func update(_delta: float) -> void:
	if _tween.is_running():
		return

	if Input.is_action_just_pressed("carry"):
		var throw_velocity: Vector3 = obj.forward() * THORW_SPEED
		throw_velocity.y = THROW_UP_SPEED
		obj.held.be_thrown(throw_velocity)
		obj.held = null
		change_state(fsm.states.throw)
		return
	
	obj.change_animation("carry" if move_by_input(0.6) else "carry_idle")
