@abstract
class_name Enemy
extends Entity

enum Type { APPROACHER, SHOOTER, CHARGER }

@export var target: Node2D
