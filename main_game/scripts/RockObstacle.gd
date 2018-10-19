extends Area2D

export var speed = -10

func _ready():
	pass

func _physics_process(delta):
	self.move_local_y(speed)


func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
