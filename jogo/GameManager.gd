extends Node

signal missao_atualizada(id_missao: int, progresso: int, total: int)
signal moedas_alteradas(nova_qtd: int)

var moedas: int = 0:
	set(valor):
		moedas = max(0, valor)
		moedas_alteradas.emit(moedas)

var missao_ativa_id: int = 0
var progresso_atual: int = 0
var objetivo_total: int = 0
var em_dialogo: bool = false

func adicionar_moedas(qtd: int) -> void:
	moedas += qtd

func iniciar_missao(id: int, total: int) -> void:
	missao_ativa_id = id
	progresso_atual = 0
	objetivo_total = total
	missao_atualizada.emit(missao_ativa_id, progresso_atual, objetivo_total)

func adicionar_progresso(qtd: int = 1) -> void:
	if missao_ativa_id != 0:
		progresso_atual += qtd
		missao_atualizada.emit(missao_ativa_id, progresso_atual, objetivo_total)

func finalizar_missao_atual() -> void:
	missao_ativa_id = 0
	progresso_atual = 0
	objetivo_total = 0
	missao_atualizada.emit(0, 0, 0) # Envia 0 para esconder a mensagem da tela

func travar_jogador(travar: bool) -> void:
	em_dialogo = travar
	if travar:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
