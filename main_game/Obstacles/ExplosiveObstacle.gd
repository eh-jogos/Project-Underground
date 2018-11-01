extends Area2D

export var deceleration_multiplyer = 2

var speed
var animation
var player

func _physics_process(delta):
	self.move_local_y(speed)


func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)
	animation = $Sprite/AnimationPlayer

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()


func _on_ExplosiveObstacle_body_entered(body):
	if body.is_in_group("player"):
		#print("%s entered the area!"%[body.name])
		player = body
		player.set_falloff_multiplyer(deceleration_multiplyer)
		player.reset_acceleration_multiplyer()
		animation.play("blow_up")

func _on_Explosion_end():
	print("Explosion Ended")
	player.set_falloff_multiplyer(-deceleration_multiplyer)

func set_speed(value):
	speed = value

func increment_speed(value):
	speed += value