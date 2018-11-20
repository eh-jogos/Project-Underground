extends CollisionShape2D

export(Color, RGB) var healthy_color
export(Color, RGB) var half_damaged_color
export(Color, RGB) var damaged_color

var max_health
var health
var sprite

### Class Methods
func set_health(hp):
	max_health = hp
	health = hp
	modulate_color()
	
	self.disabled = false
	self.show()
	sprite.show()

func modulate_color():
	if health == max_health:
		sprite.modulate = healthy_color
	elif health >= 0.5*max_health and health < 0.75*max_health:
		sprite.modulate = half_damaged_color
	elif health < 0.5*max_health:
		sprite.modulate = damaged_color

func use_drill():
	var return_status = true
	health -= 1
	
	if health <= 0:
		break_drill()
		return_status = false
	else:
		modulate_color()
	
	return return_status

func break_drill():
	self.hide()
	self.disabled = true
	max_health = 0
	health = 0


### Engine Methods

func _ready():
	sprite = $Sprite
	break_drill()
