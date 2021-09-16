extends KinematicBody2D


const GRAVIDADE = 4000
const ACCEL = 0.4
var velocidade = Vector2.ZERO
var speed = 400

var is_jumping = false
var jump_force = 1200
var jump_count = 2

var danos = false

func _ready():
	pass
	
# Plataforma
var plataforma = false
var nome_plataforma

func _physics_process(delta):
	
	var dir = 0
	
	# Aplicaçao da gravidade
	velocidade.y += GRAVIDADE * delta
	
	# Direcao do player
	dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	if dir > 0:
		$anim.flip_h = true
	if dir < 0:
		$anim.flip_h = false
	
	# Seguir a plataforma
	if dir == 0:
		if plataforma and get_parent().get_node(nome_plataforma).movendo:
			velocidade.x = get_parent().get_node(nome_plataforma).vel * 1.25
		
		
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
		is_jumping = false
		jump_count = 2
		
	# Smoke
	if dir != 0 and is_on_floor():
		$smoke.emitting = true
	else:
		$smoke.emitting = false
		
	# Animacao do personagem
	if dir != 0 and not is_jumping and is_on_floor():
		$anim.play("running")
	elif is_jumping:
		$anim.play("jump")
	elif not is_on_floor():
		$anim.play("jump")
	else:
		$anim.play("idle")

		
	
	#Pesonagem saltando estando no chao
	if Input.is_action_just_pressed("jump") and jump_count > 0:
		is_jumping = true
		jump_count -= 1
		jump()
	
	#Pesonagem saltando quando está caindo
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		is_jumping = true
		jump_count -= 2
	
	# Movimentacao
	# Vector2.UP = Vector2(0, -1) = Face da plataforma pra cima
	velocidade = move_and_slide(velocidade, Vector2.UP)
	
	
func jump():
	velocidade.y = -jump_force
	
func receber_dano(dir):
	danos = true
	
	velocidade.x = dir * 1000;
	$anim_danos.play("danos")
	yield($anim_danos, "animation_finished")
	
	danos = false
	

func _on_jump_area_entered(area):
	if area.get_parent().is_in_group("plat"):
		plataforma = true;
		nome_plataforma = area.get_parent().name

func _on_jump_area_exited(area):
	plataforma = false
