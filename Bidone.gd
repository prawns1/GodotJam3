tool
extends KinematicBody2D
class_name Bidone

# Impostazione tipo
enum BIN_TYPE {BLUE, RED, GREEN, YELLOW}
export (BIN_TYPE) var type := BIN_TYPE.GREEN setget set_type
var textures := {
	'blue': "res://asset/sprite/bidone_blu.png",
	'red': "res://asset/sprite/bidone_rosso.png",
	'green': "res://asset/sprite/bidone_verde.png",
	'yellow':"res://asset/sprite/bidone_giallo.png"
}

export var active = false
var posizione=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if not active: #muovo solo il bidone attivo
		return
	
	#controllare le collisioni con altri bidoni
	
	#il movilmento avanto o inditro dovrebbe essere leggermente diagonale per rispettare la prospettiva (45°)
	
	get_tree().set_input_as_handled() #se il segnale è effettivamente processato, lo setto come hadled
	pass

func set_type(value) -> void:
	type = value
	var text_name: String = ''
	match type:
		BIN_TYPE.BLUE:
			text_name = 'blue'
		BIN_TYPE.RED:
			text_name = 'red'
		BIN_TYPE.GREEN:
			text_name = 'green'
		BIN_TYPE.YELLOW:
			text_name = 'yellow'
	$Sprite.texture = load(textures[text_name])


func _physics_process(_delta):
	if active==true:
		var velocity=Vector2()
		if Input.is_key_pressed(KEY_RIGHT):
			velocity.x=+500
		if Input.is_key_pressed(KEY_LEFT):
				 velocity.x=-500
		if Input.is_action_just_pressed("ui_up"):
			if posizione==1:
				position.y-=40
				position.x+=40
				posizione=0
		if Input.is_action_just_pressed("ui_down"):
			if posizione==0:
				position.y+=40
				position.x-=40
				posizione=1
		move_and_slide(velocity)
		
