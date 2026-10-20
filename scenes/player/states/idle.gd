extends PlayerState

func enter() -> void:
	obj.change_animation("idle")

func update(_delta: float) -> void:
	if control_knife():
		return

	if control_carry():
		return

	if control_attack():
		return
	# Control jump
	control_jump()
	# Control moving
	control_moving()
	# If not on floor change to fall
	if not obj.is_on_floor():
		change_state(fsm.states.fall)
