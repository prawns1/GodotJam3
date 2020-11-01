extends Control

onready var timer = get_node("Timer")

#in base al punteggio attuale, diminuisce il tempo di spawn
#vedi spawnTime(score)
var score = 2

func _ready() -> void:
	timer.set_wait_time(spawnTime(score))
	
func _process(delta: float) -> void:
	timer.set_wait_time(spawnTime(score))

func _on_Timer_timeout():
	#una persona viene spawnata
	var personaScene = load("res://Persona.tscn")
	var personaInstance = personaScene.instance() #vedi Persona.gd -> ready()
	get_node("Persone").add_child(personaInstance)
	personaInstance.connect("spawn", self, "_on_trash_throw")

func spawnTime(score) -> float:
	return 3+(4/(score+1))

func _on_trash_throw(trashPosition):
	print(trashPosition)
