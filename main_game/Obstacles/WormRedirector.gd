extends Path2D

export var deceleration_multiplyer = 2

var speed
var animation


func _physics_process(delta):
	self.move_local_y(speed)


func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)
	animation = $PathFollow2D/WormObstacle/PathAnimator
	var random_second = rand_range(0, animation.current_animation_length)
	print(random_second)
	animation.seek(random_second)

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()


func _on_WormObstacle_body_entered(body):
	if body.is_in_group("player"):
		#print("%s entered the area!"%[body.name])
		body.set_falloff_multiplyer(deceleration_multiplyer)
		body.toggle_movement_restraint(true)
		animation.play("die")

func _on_WormObstacle_body_exited(body):
	if body.is_in_group("player"):
		#print("%s exited the area!"%[body.name])
		body.set_falloff_multiplyer(-deceleration_multiplyer)
		body.toggle_movement_restraint(false)
		animation.play("dead")


func set_speed(value):
	speed = value

func increment_speed(value):
	speed += value