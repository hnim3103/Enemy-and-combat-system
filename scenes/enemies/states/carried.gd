extends EnemyState

var _saved_layer: int = 0

func enter() -> void:
	obj.stop_move()
	obj.movement_enabled = false
	_saved_layer = obj.collision_layer
	obj.collision_layer = 0

func exit() -> void:
	obj.movement_enabled = true
	obj.collision_layer = _saved_layer

func take_damage(_damage_dir: Vector3, _damage: float) -> void:
	pass