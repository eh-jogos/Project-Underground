extends Area2D

export var deceleration_multiplyer = 2

var speed


func _physics_process(delta):
	self.move_local_y(speed)


func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()


func _on_RockObstacle_body_entered(body):
	if body.is_in_group("player"):
		#print("%s entered the area!"%[body.name])
		body.set_falloff_multiplyer(deceleration_multiplyer)

func _on_RockObstacle_body_exited(body):
	if body.is_in_group("player"):
		#print("%s exited the area!"%[body.name])
		body.set_falloff_multiplyer(-deceleration_multiplyer)


func set_speed(value):
	speed = value

func increment_speed(value):
	speed += value