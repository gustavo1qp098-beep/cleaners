extends Node3D

@export var cena_lixo: PackedScene # Arraste o lixo.tscn no Inspetor

func gerar_lixos(quantidade: int) -> void:
	if not cena_lixo:
		print("🔴 ERRO: Arraste a cena lixo.tscn para o campo Cena Lixo no GeradorLixo!")
		return

	# Pega todos os nós marcados como Pontos de Spawn
	var pontos = get_children()
	
	if pontos.size() == 0:
		print("🔴 ERRO: Adicione nós Node3D/Marker3D dentro do GeradorLixo para definir onde os lixos podem nascer!")
		return

	# Embaralha a lista de pontos para o spawn ser aleatório
	pontos.shuffle()

	# Spawna o lixo nos pontos disponíveis
	var total_para_gerar = min(quantidade, pontos.size())
	for i in range(total_para_gerar):
		var novo_lixo = cena_lixo.instantiate() as Node3D
		get_parent().add_child(novo_lixo)
		novo_lixo.global_position = pontos[i].global_position
		
	print("🧹 Spawndei ", total_para_gerar, " lixos em pontos válidos do mapa!")
