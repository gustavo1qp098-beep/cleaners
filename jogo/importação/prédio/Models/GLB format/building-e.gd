extends Node3D

func _ready():
	_gerar_colisao_recursiva(self)

func _gerar_colisao_recursiva(no: Node):
	if no is MeshInstance3D:
		# Cria a colisão trimesh nativa alinhada perfeitamente com a malha da casa
		no.create_trimesh_collision()
	
	# Percorre todos os nós filhos dentro da estrutura da casa
	for filho in no.get_children():
		_gerar_colisao_recursiva(filho)
