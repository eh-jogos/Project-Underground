extends Node2D

onready var rock_obstacle = preload("res://main_game/RockObstacle.tscn")

var lanes
var num_of_lanes

func _ready():
	randomize()
	lanes = $Lanes.get_children()
	num_of_lanes = $Lanes.get_child_count()

func _on_Timer_timeout():
	spawn_obstacle()

func spawn_obstacle():
	var node = rock_obstacle.instance()
	lanes[randi() % num_of_lanes].add_child(node)