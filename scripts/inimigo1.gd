extends Area2D

export var dir = 1
export var velocidade = 80
var vivo = true

func _ready():
	pass

func _process(delta):
	if !$dir.is_colliding():
		dir *= -1
		
	if vivo:
		if $move.is_colliding() and dir == 1:
			scale.x = -1
			position.x += velocidade * delta
		else:
			scale.x = 1 
			position.x -= velocidade * delta


func _on_inimigo1_area_entered(area):
	if area.name == "jump" and  area.get_parent().danos == false:
		area.get_parent().jump()
		$anim.play("die")
		die()

func die():
	position.y -= 10
	vivo = false
	$anim.play("die")
	$shape.queue_free()
	yield($anim, "animation_finished")
	queue_free()
	


func _on_inimigo1_body_entered(body):
	if body.name == "player":
		body.get_node("anim_danos").play("danos")
		body.receber_dano()
