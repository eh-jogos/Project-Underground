extends Area2D

export var acceleration_multiplyer = 2.0
export var duration = 2.0

var speed


func _physics_process(delta):
	self.move_local_y(speed)

func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()


func _on_CofeePowerUp_body_entered(body):
	if body.is_in_group("player"):
		body.enable_cofee_power_up(acceleration_multiplyer, duration)
		queue_free()



func set_speed(value):
	speed = value

func increment_speed(value):
	speed += value