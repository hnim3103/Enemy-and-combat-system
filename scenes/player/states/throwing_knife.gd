extends PlayerState

const KNIFE_SIDE := preload("res://assets/sprites/knife/h_knife.png")

@export var knife_speed: float = 15.0

func enter() -> void:
	obj.change_animation("attack")
	obj.stop_horizontal()
	var knife := obj.get_node("Direction/ThrowingKnifeFactory").create() as RigidBody3D
	if knife != null:
		_face_knife(knife.get_node("Sprite3D"))
		knife.apply_impulse(obj.forward() * knife_speed)
	timer = 0.3

func update(delta: float) -> void:
	if update_timer(delta):
		change_state(fsm.states.idle)

func _face_knife(sprite: Sprite3D) -> void:
	match obj.direction:
		"down":
			sprite.flip_v = true
		"right", "left":
			sprite.texture = KNIFE_SIDE
			sprite.flip_h = obj.direction == "left"