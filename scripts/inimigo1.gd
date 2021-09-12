extends Area2D

export var dir = 1
export var velocidade = 80

func _ready():
	pass

func _process(delta):
	if !$dir.is_colliding():
		dir *= -1
		
	if $move.is_colliding() and dir == 1:
		scale.x = -1
		position.x += velocidade * delta
	else:
		scale.x = 1 
		position.x -= velocidade * delta
