class_name NPCBase
extends CharacterBody3D

@export var area_interacao: Area3D
@export var nome_npc: String = "Cidadão"
@export var id_missao: int = 1
@export var objetivo_quantidade: int = 10
@export var recompensa_moedas: int = 20

@export_multiline var texto_inicial: String = "Você pode me ajudar a limpar a praça?"
@export_multiline var texto_em_andamento: String = "Quando terminar de recolher tudo, volte até mim!"
@export_multiline var texto_concluido: String = "Muito obrigado pela ajuda! Aqui está sua recompensa."

var jogador_perto: bool = false
var missao_aceita: bool = false
var missao_finalizada: bool = false

func _ready() -> void:
	if area_interacao:
		area_interacao.body_entered.connect(_on_body_entered)
		area_interacao.body_exited.connect(_on_body_exited)
	else:
		print("🔴 [NPC] ERRO: Arraste a Area3D para o campo 'Area Interacao' no Inspetor do NPC ", name)

func _unhandled_input(event: InputEvent) -> void:
	# Só abre se o jogador estiver REALMENTE perto e NÃO estiver em diálogo
	if jogador_perto and not GameManager.em_dialogo and event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E:
			interagir()

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") or "Player" in body.name or "player" in body.name:
		jogador_perto = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player") or "Player" in body.name or "player" in body.name:
		jogador_perto = false

func interagir() -> void:
	var caixa = get_tree().get_first_node_in_group("CaixaDialogo")
	if not caixa:
		print("🔴 [NPC] ERRO: Nenhuma cena no grupo 'CaixaDialogo' foi encontrada no Mapa!")
		return

	# Estado 1: Aceitar missão e gerar itens automaticamente
	if not missao_aceita:
		caixa.exibir_dialogo(nome_npc, texto_inicial)
		missao_aceita = true
		
		if GameManager:
			GameManager.iniciar_missao(id_missao, objetivo_quantidade)
		
		# Procura o nó GeradorLixo no mapa e manda spawnar os itens
		var gerador = get_tree().get_first_node_in_group("GeradorLixo")
		if gerador:
			gerador.gerar_lixos(objetivo_quantidade)
		else:
			print("⚠️ AVISO: Nó do GeradorLixo não foi encontrado no mapa ou não está no grupo 'GeradorLixo'!")
		return

	# Estado 2: Missão em andamento
	if missao_aceita and GameManager and GameManager.progresso_atual < GameManager.objetivo_total:
		caixa.exibir_dialogo(nome_npc, texto_em_andamento)
		return

	# Estado 3: Finalizar missão, dar moedas e remover o HUD da tela
	if missao_aceita and GameManager and GameManager.progresso_atual >= GameManager.objetivo_total and not missao_finalizada:
		caixa.exibir_dialogo(nome_npc, texto_concluido)
		if GameManager:
			GameManager.adicionar_moedas(recompensa_moedas)
			GameManager.finalizar_missao_atual() # Esconde o HUD no canto da tela
		missao_finalizada = true
