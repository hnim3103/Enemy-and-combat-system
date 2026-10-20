extends PlayerState

## The throw pose.

func enter() -> void:
	obj.change_animation("throw")
	obj.stop_horizontal()
	timer = 0.25


func update(delta: float) -> void:
	if update_timer(delta):
		change_state(fsm.states.idle)
