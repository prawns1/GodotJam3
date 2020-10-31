extends Node2D

class_name Persona

export (int) var speed = 3;
export (int) var fallSpeed = 10;

var rng = RandomNumberGenerator.new()

var spawnPoint = Vector2()
var heightSpawnBound = [30, 60] #altezza minima e massima di spawn

#questi lavorano insieme, in base al "workIndex" settato in initSpawn()
var workIndex
var widthSpawnBound = [50, 1000] 
var direction = [+1, -1]
var destroyAtPosition = [1000, 50]

func _ready():
	initSpawn()
	
func _process(delta):
	setNewPosition() #nuova posizione e controllo di esistenza

func initSpawn():
	rng.randomize()
	#altezza random scelta in un range tra hSB[0] ed [1]
	var spawnHeight = rng.randf_range(heightSpawnBound[0], heightSpawnBound[1])
	workIndex = rng.randi() % 2
	#larghezza scelta in corrispondenza al workIndex settato
	var spawnWidth = widthSpawnBound[workIndex]
	($".").set_position(Vector2(spawnWidth,spawnHeight) )

func setNewPosition():
	var exPos = get_position()
	exPos.x += speed * direction[workIndex]
	#se provenivo da sinistra e ho raggiunto la fine a destra,
	#oppure se provenivo da destra e ho raggiunto la fine a sinistra- muoro
	if( (workIndex==0 && exPos.x >= destroyAtPosition[workIndex]) ||
		(workIndex==1 && exPos.x <= destroyAtPosition[workIndex]) ):
		queue_free()
	set_position(Vector2(exPos.x, exPos.y))
	
