extends KinematicBody2D

export var movement_sensitivity = 100 
export var min_horizontal_speed = 100
export var starting_lives = 3

var parent
var lives_positions
var lives

var is_tracking_on = false
var player_position

#### Engine Methods ####

func _ready():
	set_physics_process(true)
	parent = self.get_parent()
	lives = starting_lives-1

func _physics_process(delta):
	if lives >= 0:
		process_collision()
		process_movement()

#### Class Methods ####

func process_collision():
	pass

func process_movement():
	var linear_velocity = Vector2(0,0)
	player_position = self.position
	
	if is_tracking_on:
		linear_velocity.x = track_mouse()
	
	linear_velocity.y = track_lives()
	
	self.move_and_slide(linear_velocity)

func track_mouse():
	var mouse_position = get_viewport().get_mouse_position()
	var viewport_max_x = get_viewport_rect().size.x
	
	mouse_position = clamp(mouse_position.x, 0.0, viewport_max_x)
	
	var horizontal_delta = mouse_position - player_position.x
	if horizontal_delta > movement_sensitivity:
		horizontal_delta = clamp(horizontal_delta, min_horizontal_speed, horizontal_delta)
	elif horizontal_delta < movement_sensitivity and horizontal_delta > -movement_sensitivity:
		horizontal_delta = 0
	else:
		horizontal_delta = clamp(horizontal_delta, horizontal_delta, -min_horizontal_speed)
	
	return horizontal_delta

func track_lives():
	var vertical_delta
	
	var next_position = parent.get_lives_position(lives)
	vertical_delta = next_position - player_position.y
	
	if vertical_delta < 0:
		vertical_delta = -150
	else:
		vertical_delta = 0
	
	return vertical_delta


func _on_ControlStrip_button_down():
	is_tracking_on = true

func _on_ControlStrip_button_up():
	is_tracking_on = false

