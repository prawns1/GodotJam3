tool
extends Area2D
class_name Rifiuto

# Impostazione tipo
enum TRASH_TYPE {APPLE, BOTTLE, MILK, JUICE}
export (TRASH_TYPE) var type := TRASH_TYPE.APPLE setget set_type
var textures := {
	'apple': "res://asset/sprite/torsolo.png",
	'bottle': "res://asset/sprite/bottiglia.png",
	'milk': "res://asset/sprite/cartone_latte.png",
	'juice': "res://asset/sprite/succo.png"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initialize(position: Vector2) -> void:
	#prendi la posizione di partenza, eventualmente aggiungere il tipo
	#per il tipo usare un valore intero 0 = mela etc...
	#perché da un altro script ha problemi a leggere gli enum
	pass

func set_type(value) -> void:
	type = value
	var text_name: String = ''
	match type:
		TRASH_TYPE.APPLE:
			text_name = 'apple'
		TRASH_TYPE.BOTTLE:
			text_name = 'bottle'
		TRASH_TYPE.MILK:
			text_name = 'milk'
		TRASH_TYPE.JUICE:
			text_name = 'juice'
	$Sprite.texture = load(textures[text_name])
