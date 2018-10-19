extends Node2D

onready var rock_obstacle = preload("res://main_game/Obstacles/RockObstacle.tscn")
onready var power_up_coffee = preload("res://main_game/PowerUps/PowerUpCofee.tscn")

export var base_speed = -10

var lanes
var num_of_lanes

func _ready():
	randomize()
	lanes = $Lanes.get_children()
	num_of_lanes = $Lanes.get_child_count()


func _on_ObstacleSpawner_timeout():
	spawn_object(rock_obstacle)

func _on_PowerUpSpawner_timeout():
	spawn_object(power_up_coffee)


func spawn_object(object):
	var node = object.instance()
	var avaiable_lanes = check_availability()
	var lane_picked = avaiable_lanes[randi() % avaiable_lanes.size()]
	
	node.set_speed(base_speed)
	lane_picked.add_child(node)


func check_availability():
	var lanes_array = []
	for lane in lanes:
		var record_lane = true
		if lane.get_child_count() > 0:
			for child in lane.get_children():
				if child.position.y > -193:
					record_lane = false
		
		if record_lane:
			lanes_array.append(lane)
	
	return lanes_array
