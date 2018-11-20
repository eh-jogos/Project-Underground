extends Area2D

export(int) var uses = 3

var speed


func _physics_process(delta):
	self.move_local_y(speed)

func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()


func _on_DrillPowerUp_body_entered(body):
	if body.is_in_group("player"):
		body.enable_drill_power_up(uses)
		queue_free()



func set_speed(value):
	speed = value

func increment_speed(value):
	speed += value