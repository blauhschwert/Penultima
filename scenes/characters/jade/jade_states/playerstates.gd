class_name JadeState
extends State

const IDLE = "Idle"
const WALKING = "Walk"
const HURT = "Hurt"

var jade : JadePlayer
var jade_player : AnimationPlayer
var jade_hurtbox : Area2D
var jade_progressbar : ProgressBar

func _ready() -> void:
	await owner.ready
	jade = owner as JadePlayer
	assert(jade != null,
	"The JadeState state type must be used only in the player/jade scene.
	It needs the owner to be a Player node")
	
