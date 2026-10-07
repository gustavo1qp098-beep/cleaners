class_name MissaoData
extends Resource

@export var id: String = ""
@export var titulo: String = ""
@export_multiline var dialogo_inicio: String = ""
@export_multiline var dialogo_fim: String = ""
@export var ferramenta_necessaria: String = ""
@export var quantidade_objetivo: int = 1
@export var tempo_limite_segundos: float = 360.0
@export var recompensa_moedas: int = 40
