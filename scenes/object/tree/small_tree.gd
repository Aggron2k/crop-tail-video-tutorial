extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component_node: DamageComponent = $DamageComponent

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component_node.max_damaged_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage: int) -> void:
	damage_component_node.apply_damage(hit_damage)

func on_max_damage_reached() -> void:
	print("max damage reached")
	queue_free()
