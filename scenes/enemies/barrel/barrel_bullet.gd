extends RigidBody3D

@export var lifetime: float = 4.0
## Destroy on touching anything in collision_mask (walls, floor). Off for the barrel bullet, which bounces.
@export var free_on_body_hit: bool = false

func _ready() -> void:
	$HitArea3D.hitted.connect(_on_hitted)
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
	if free_on_body_hit:
		# body_entered needs contact_monitor = true and max_contacts_reported > 0, both set in the scenes
		body_entered.connect(func(_body: Node) -> void: queue_free())

func _on_hitted(_area: Area3D) -> void:
	queue_free()
