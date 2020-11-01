extends Node2D

class_name Persona
signal spawn(position)

export (int) var speed = 3;
export (int) var fallSpeed = 10;

var rng = RandomNumberGenerator.new()

var spawnPoint = Vector2()
var heightSpawnBound = [96, 192] #altezza minima e massima di spawn

#questi lavorano insieme, in base al "workIndex" settato in initSpawn()
var workIndex
var widthSpawnBound = [50, 1000]
var direction = [+1, -1]
var destroyAtPosition = [1000, 50]

#Persona spawna un Rifiuto ad un certo punto (asse x) 
#compreso tra widthSpawnBound[0] e widthSpawnBound[1] con un certo offset
var trashSpawnPosition
const tsp_xOffset = 200

#Puo' darsi che Persona.position.x != trashSpawnPosition
#ci va bene anche solo un intorno di trashSpawnPosition ma evitiamo spawn spam
var trashSpawned = false
var xAround = 10

func _ready():
	initSpawn()
	trashSpawnPosition = int(rand_range(widthSpawnBound[0] + tsp_xOffset, widthSpawnBound[1] - tsp_xOffset))
	print(trashSpawnPosition)
	
func _process(delta):
	setNewPosition() #nuova posizione, controllo di esistenza, di spawn rifiuto

func initSpawn():
	rng.randomize()
	#altezza random scelta in un range tra hSB[0] ed [1]
	var spawnHeight = heightSpawnBound[rng.randi()%2]
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
	
	#se Persona si trova in trashSpawnPosition, spawno un Rifiuto
	if(trashSpawnPosition - xAround <= exPos.x && exPos.x <= trashSpawnPosition + xAround):
		if(trashSpawned == false):
			throw()
			trashSpawned = true
	
	set_position(Vector2(exPos.x, exPos.y))

func throw():
	emit_signal("spawn", get_position() )
