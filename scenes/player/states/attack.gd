extends PlayerState

const LUNGE_SPEED: float = 4.0
const LUNGE_DECEL: float = 20.0

func enter() -> void:
	obj.change_animation("attack")
	var push: Vector3 = obj.forward() * LUNGE_SPEED
	obj.velocity.x = push.x
	obj.velocity.z = push.z
	obj.anim_player.animation_finished.connect(_on_animation_finished)
	_hit_shape().disabled = false


func exit() -> void:
	obj.anim_player.animation_finished.disconnect(_on_animation_finished)
	_hit_shape().disabled = true

func update(delta: float) -> void:
	obj.velocity.x = move_toward(obj.velocity.x, 0.0, LUNGE_DECEL * delta)
	obj.velocity.z = move_toward(obj.velocity.z, 0.0, LUNGE_DECEL * delta)

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with("attack"):
		change_state(fsm.previous_state)


func _hit_shape() -> CollisionShape3D:
	return obj.get_node("Direction/HitArea3D/CollisionShape3D")
