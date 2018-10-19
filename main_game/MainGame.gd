extends Node2D

var lives

func _ready():
	lives = $Lives

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func get_lives_position(num_of_lives):
	return lives.get_child(num_of_lives).position.y