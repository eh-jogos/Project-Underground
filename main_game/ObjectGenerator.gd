extends Node2D

export var base_speed = -10

var lanes
var num_of_lanes
var obstacles
var powerups

func _ready():
	randomize()
	lanes = $Lanes.get_children()
	num_of_lanes = $Lanes.get_child_count()
	obstacles = $ObstacleList.get_resource_list()
	powerups = $PowerUpList.get_resource_list()


func _on_ObstacleSpawner_timeout():
	var rand_choice = obstacles[randi() % obstacles.size()]
	var obstacle = $ObstacleList.get_resource(rand_choice)
	spawn_object(obstacle)
	
func _on_PowerUpSpawner_timeout():
	var rand_choice = powerups[randi() % powerups.size()]
	var powerup = $PowerUpList.get_resource(rand_choice)
	spawn_object(powerup)

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
