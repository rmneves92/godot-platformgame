extends Node2D


func _ready():
	pass


func _on_pulo_duplo_body_entered(body):
	if body.name == "player":
		animar($pulo_duplo/anim, $pulo_duplo)
		body.pulo_duplo = true
		
func _on_engrenagem_body_entered(body):
	if body.name == "player":
		animar($engrenagem/anim, $engrenagem)
		body.engrenagem = true
		
func _on_energia_body_entered(body):
	if body.name == "player":
		animar($energia/anim, $energia)
		body.energia = true

func animar(node_path, node_name):
	node_path.play("fade_scale")
	yield(node_path, "animation_finished")
	node_name.queue_free()
	
