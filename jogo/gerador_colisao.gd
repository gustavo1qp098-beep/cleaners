@tool
extends Node3D

@export var gerar_colisoes: bool = false:
	set(valor):
		if valor:
			_gerar_fisica_real(self)
			print("Colisões geradas e formas atribuídas com sucesso!")
			gerar_colisoes = false

func _gerar_fisica_real(no: Node):
	if no is MeshInstance3D:
		# Cria a colisão nativa perfeita de uma vez
		no.create_trimesh_collision()
		
		# Define o dono para salvar na cena de forma permanente
		for sub in no.get_children():
			if sub is StaticBody3D:
				sub.owner = get_tree().edited_scene_root
				for shape in sub.get_children():
					shape.owner = get_tree().edited_scene_root

	for filho in no.get_children():
		_gerar_fisica_real(filho)
