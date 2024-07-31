extends Node2D
class_name FishSpawner

@export var creatures_node:Node2D
@export var num_fish_to_spawn:int = 10
var fish_object = load("res://fish/FishSegment.tscn")


func _ready():
	for i in range(0, num_fish_to_spawn):
		var fish:Fish = fish_object.instantiate()
		fish.position = Vector2(randf_range(0, 1920), randf_range(0, 1080))
		creatures_node.add_child(fish)

