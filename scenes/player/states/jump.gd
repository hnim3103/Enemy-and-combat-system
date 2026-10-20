extends PlayerState

func enter() -> void:
	obj.change_animation("jump")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	control_moving()
	# In 3D the Y axis points up, so falling means velocity.y is negative
	if obj.velocity.y < 0:
		change_state(fsm.states.fall)
