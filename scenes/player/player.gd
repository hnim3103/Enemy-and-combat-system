class_name Player
extends BaseCharacter

## Turned on throughout the Hurt state so one hit doesn't drain health every single frame in a row.
var is_invulnerable: bool = false

var held: BaseCharacter = null
@onready var hold_point: Marker3D = $HoldPoint
@onready var grab_area: Area3D = $Direction/GrabArea3D


func _ready() -> void:
	fsm = FSM.new(self, $States, $States/Idle)
	super._ready()


## Every state of the fox can take damage, so this calls straight into the current state; whichever
## state doesn't want to lose health (Dead) overrides take_damage().
func _on_hurt_area_3d_hurt(_direction: Vector3, damage: float) -> void:
	if is_invulnerable:
		return
	fsm.current_state.take_damage(int(damage))


func find_carriable() -> BaseCharacter:
	for body in grab_area.get_overlapping_bodies():
		if body is BaseCharacter and body != self and body.can_be_carried():
			return body
	return null
