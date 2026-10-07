extends Node

signal missao_iniciada(missao: MissaoData)
signal missao_atualizada(progresso: int, total: int, tempo_restante: float)
signal missao_concluida(missao: MissaoData)
signal missao_falhou(missao: MissaoData)
signal erro_global_alterado(porcentagem: int)

var missao_ativa: MissaoData = null
var progresso_atual: int = 0
var tempo_restante: float = 0.0
var erros_acumulados: int = 0
var moedas_jogador: int = 0

func _process(delta: float):
	if missao_ativa != null:
		tempo_restante -= delta
		missao_atualizada.emit(progresso_atual, missao_ativa.quantidade_objetivo, tempo_restante)
		
		if tempo_restante <= 0:
			falhar_missao()

func aceitar_missao(missao: MissaoData) -> bool:
	if missao_ativa != null:
		return false
		
	missao_ativa = missao
	progresso_atual = 0
	tempo_restante = missao.tempo_limite_segundos
	missao_iniciada.emit(missao)
	return true

func registrar_progresso(quantidade: int = 1):
	if missao_ativa == null: return
	
	progresso_atual += quantidade
	if progresso_atual >= missao_ativa.quantidade_objetivo:
		concluir_missao()

func concluir_missao():
	if missao_ativa == null: return
	
	moedas_jogador += missao_ativa.recompensa_moedas
	missao_concluida.emit(missao_ativa)
	missao_ativa = null

func falhar_missao():
	if missao_ativa == null: return
	
	erros_acumulados += 4 # Regra das 25 missões (cada falha = 4%)
	erro_global_alterado.emit(erros_acumulados)
	missao_falhou.emit(missao_ativa)
	missao_ativa = null
