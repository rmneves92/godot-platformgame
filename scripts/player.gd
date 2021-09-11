extends KinematicBody2D


const GRAVIDADE = 4000
const ACCEL = 0.4
var velocidade = Vector2.ZERO
var speed = 400


var jump_force = 1200
var jump_count = 2

func _ready():
	pass

func _physics_process(delta):
	
	var dir = 0
	
	# Aplicaçao da gravidade
	velocidade.y += GRAVIDADE * delta
	
	
	
	# Direcao do player
	if Input.is_action_pressed("left"):
		dir = -1
		$sprite.flip_h = false
	
	if Input.is_action_pressed("right"):
		dir = 1
		$sprite.flip_h = true
		
	
		
	# Aplicacao da velocidade
	#velocidade.x = dir * speed
	
	
	# Aceleracao do personagem
	if dir != 0:
		velocidade.x = lerp(velocidade.x, dir * speed, ACCEL)
	else:
		if is_on_floor():
			velocidade.x = lerp(velocidade.x, 0, ACCEL/2)
		else:
			velocidade.x = lerp(velocidade.x, 0, ACCEL/20)
		
	
	# Reset pulos
	if is_on_floor():
		jump_count = 2
		
		
	
	#Pesonagem saltando estando no chao
	if Input.is_action_just_pressed("jump") and jump_count > 0:
		jump()
		jump_count -= 1
	
	#Pesonagem saltando quando está caindo
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		jump_count -= 2
	
	
	
		
	# Movimentacao
	# Vector2.UP = Vector2(0, -1) = Face da plataforma pra cima
	velocidade = move_and_slide(velocidade, Vector2.UP)
	
	
func jump():
	velocidade.y = -jump_force
