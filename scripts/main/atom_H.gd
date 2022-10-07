extends RigidBody2D

const atomID:int = 1
const atomMass:int = 1

var isCaptured:bool = false

# initial velocity
var velocity:Vector2 = Vector2.ZERO 
func _ready():
	self.linear_velocity = velocity
	self.mass = atomMass
