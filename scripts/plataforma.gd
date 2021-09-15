extends StaticBody2D

var pos_inicial = Vector2()
var pos_final = Vector2()
var distancia = 300
var vel = 100
var dir = 1
export var lado = 1

func _ready():
	add_to_group("plat")
	if lado == 1:
		pos_inicial = position
		pos_final = pos_inicial + Vector2(distancia * dir, 0)
	if lado == -1:
		pos_inicial = position
		pos_final = pos_inicial - Vector2(distancia * dir, 0)

func _physics_process(delta):
	if lado == 1:
		if dir == 1:
			vel = 100
			position.x += vel * delta
			if position.x >= pos_final.x:
				dir *= -1
		
		if dir == -1:
			vel = -100
			position.x += vel * delta
			if position.x <= pos_inicial.x:
				dir *= -1
	else:
		if dir == -1:
			vel = -100
			position.x += vel * delta
			if position.x <= pos_final.x:
				dir *= -1
		
		if dir == 1:
			vel = 100
			position.x += vel * delta
			if position.x >= pos_inicial.x:
				dir *= -1
		
			
		
