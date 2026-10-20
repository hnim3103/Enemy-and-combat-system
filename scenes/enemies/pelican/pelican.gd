extends  EnemyCharacter

@onready var bullet_factory: Node3DFactory = $Direction/BulletFactory

func _ready() -> void:
	fsm = FSM.new(self, $States, $States/Fly)
	super._ready()

func fire() -> void:
	bullet_factory.create()