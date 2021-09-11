extends KinematicBody2D

const GRAVIDADE = 4000
var velocidade = Vector2.ZERO
var speed = 500
var jump_force = 1200

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
	velocidade.x = dir * speed
	
	#Pesonagem saltando
	if Input.is_action_just_pressed("jump"):
		jump()
	
		
	# Movimentacao
	# Vector2.UP = Vector2(0, -1) = Face da plataforma pra cima
	velocidade = move_and_slide(velocidade, Vector2.UP)
	
	
func jump():
	velocidade.y = -jump_force
