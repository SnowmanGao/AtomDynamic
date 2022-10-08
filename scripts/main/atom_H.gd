extends RigidBody2D

const atomID:int = 1
const atomMass:int = 1
var isCaptured:bool = false setget setCaptured

# initial velocity
var velocity:Vector2 = Vector2.ZERO 
func _ready():
	self.linear_velocity = velocity
	self.mass = atomMass

func setCaptured(val):
	if(val):
		# layers: BIN mask to DEC
		self.layers = 2
	else:
		self.layers = 3
