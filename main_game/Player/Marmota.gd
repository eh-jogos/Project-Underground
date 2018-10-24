extends KinematicBody2D

export var movement_sensitivity = 100 
export var min_horizontal_speed = 100
export var deceleration = 2
export var max_vertical_speed = 10

var player_position
var coffee_timer
var power_up_increment

var is_tracking_on = false
var falloff_speed = 0
var falloff_multiplyer = 1
var acceleration = abs(deceleration)
var acceleration_multiplyer = 0

#### Engine Methods ####

func _ready():
	set_physics_process(true)
	coffee_timer = $CoffeeTimer

func _physics_process(delta):
	var collision = self.move_and_collide(process_movement()*delta)
	if collision:
		process_collision(collision)

#### Class Methods ####

func process_collision(collision):
	if collision.collider.is_in_group("water"):
		#self.get_tree().paused = true
		self.get_tree().reload_current_scene()

func process_movement():
	var linear_velocity = Vector2(0,0)
	player_position = self.position
	
	if is_tracking_on:
		linear_velocity.x = track_mouse()
	
	linear_velocity.y = update_falloff_speed()
	
	print("Linear Velocity: %s"%[linear_velocity])
	#print("FallOff Multiplyer: %s"%[falloff_multiplyer])
	
	return linear_velocity

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

func update_falloff_speed():
	falloff_speed += (acceleration * acceleration_multiplyer) - (deceleration * falloff_multiplyer)
	falloff_speed = clamp(falloff_speed, max_vertical_speed * -falloff_multiplyer, max_vertical_speed * acceleration_multiplyer)
	
	return falloff_speed


func enable_cofee_power_up(value, duration):
	power_up_increment = value + 1
	set_acceleration_multiplyer(power_up_increment)
	coffee_timer.wait_time = duration
	coffee_timer.start()

func _on_CoffeeTimer_timeout():
	#print("Coffee Timeout")
	set_acceleration_multiplyer(-power_up_increment)


func _on_ControlStrip_button_down():
	is_tracking_on = true

func _on_ControlStrip_button_up():
	is_tracking_on = false


func get_falloff_multiplyer():
	return falloff_multiplyer

func set_falloff_multiplyer(value):
	falloff_multiplyer += value

func get_acceleration_multiplyer():
	return acceleration_multiplyer

func set_acceleration_multiplyer(value):
	acceleration_multiplyer += value