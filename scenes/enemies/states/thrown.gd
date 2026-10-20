extends EnemyState

func enter() -> void:
	obj.change_animation("run")
	_hit_shape().disabled = false;

func exit() -> void:
	obj.stop_horizontal()
	_hit_shape().set_deffered("disabled", true)

func update(_delta: float) -> void:
	if obj.is_on_floor() and obj.velocity.y <= 0.0:
		change_state(fsm.default_state)

func take_damage(_damage_dir: Vector3, _damage: float) -> void:
	pass

func _hit_shape() -> CollisionShape3D:
	return obj.get_node("Directon/HitArea3D/CollisionShape3D")