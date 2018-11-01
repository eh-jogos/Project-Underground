extends Node2D

export var base_speed = -10

var lanes
var num_of_lanes
var obstacles
var long_obstacles
var powerups

func _ready():
	randomize()
	lanes = $Lanes.get_children()
	num_of_lanes = $Lanes.get_child_count()
	obstacles = $ObstacleList.get_resource_list()
	long_obstacles = $LongObstacleList.get_resource_list()
	powerups = $PowerUpList.get_resource_list()


func _on_ObstacleSpawner_timeout():
	var rand_choice = obstacles[randi() % obstacles.size()]
	var obstacle = $ObstacleList.get_resource(rand_choice)
	spawn_object(obstacle)

func _on_LongObstacleSpawner_timeout():
	var rand_choice = long_obstacles[randi() % long_obstacles.size()]
	var long_obstacle = $LongObstacleList.get_resource(rand_choice)
	spawn_object(long_obstacle, true)
	

func _on_PowerUpSpawner_timeout():
	var rand_choice = powerups[randi() % powerups.size()]
	var powerup = $PowerUpList.get_resource(rand_choice)
	spawn_object(powerup)

func spawn_object(object, is_it_long = false):
	var node = object.instance()
	var avaiable_lanes = check_availability(is_it_long)
	if avaiable_lanes.size() == 0:
		print("NOT POSSIBLE TO SPAWN")
		pass
	else:
		var lane_picked = avaiable_lanes[randi() % avaiable_lanes.size()]
		
		node.set_speed(base_speed)
		lane_picked.add_child(node)


func check_availability(is_it_long):
	var lanes_array = []
	for lane in lanes:
		var record_lane = true
		if lane.get_child_count() > 0:
			for child in lane.get_children():
				if child.position.y > -193:
					record_lane = false
		
		if record_lane:
			lanes_array.append(lane)
	
	if is_it_long and lanes_array.size() >= 3:
		lanes_array = [$Lanes.get_child(1)]
	elif is_it_long:
		lanes_array = []
	
	
	return lanes_array
