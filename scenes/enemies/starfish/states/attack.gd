extends EnemyState

@export var charge_multiplier: float = 3.0
@export var wind_up: float = 0.8
@export var charge_time: float = 0.9

const WARN_COLOR := Color(1.0, 0.4, 0.4)
const BLINK_TIME := 0.1

var _charging: bool = false
var _charge_direction: Vector3 = Vector3.ZERO
var _blink: Tween

func enter() -> void:
	obj.change_animation("attack")
	obj.stop_horizontal()
	_charge_direction = _aim_at_player()
	obj.disable_check_player_in_sight()
	_charging = false
	timer = wind_up

	obj.anim_player.speed_scale = 0.0
	_blink = obj.create_tween().set_loops()
	_blink.tween_property(obj.sprite, "modulate", WARN_COLOR, BLINK_TIME)
	_blink.tween_property(obj.sprite, "modulate", Color.WHITE, BLINK_TIME)

func exit() -> void:
	_end_wind_up()
	obj.enable_check_player_in_sight()

func _end_wind_up() -> void:
	obj.anim_player.speed_scale = 1.0
	if _blink != null and _blink.is_valid():
		_blink.kill()
	obj.sprite.modulate = Color.WHITE

func _aim_at_player() -> Vector3:
	if obj.found_player == null or not is_instance_valid(obj.found_player):
		return obj.forward()
	var aim: Vector3 = obj.found_player.global_position - obj.global_position
	aim.y = 0.0
	if aim.length_squared() < 0.0001:
		return obj.forward()
	return aim.normalized()

func update(delta: float) -> void:
	if not _charging:
		if update_timer(delta):
			_end_wind_up()
			_charging = true
			timer = charge_time
		return
	var step: Vector3 = _charge_direction * obj.movement_speed * charge_multiplier
	obj.velocity.x = step.x
	obj.velocity.z = step.z
	if obj.is_touch_wall() or (obj.is_on_floor() and obj.is_can_fall()):
		change_state(fsm.states.run)
		return
	if update_timer(delta):
		change_state(fsm.states.run)
