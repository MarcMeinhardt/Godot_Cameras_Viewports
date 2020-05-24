extends KinematicBody

# 1. Player Movement
var direction = Vector3()
var velocity = Vector3()

var speed = 10
var acceleration = 5

# 2. Player Sight
var mouseSensitivity = 0.1

onready var pivot = $ThirdPersonCameraPivot

func _ready():
   Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# 2. Player Sight
func _input(event):
   
   if Input.is_action_just_pressed("ui_cancel"):
      Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
   
   if event is InputEventMouseMotion:
      rotate_y(deg2rad(-event.relative.x * mouseSensitivity))
      pivot.rotate_x(deg2rad(event.relative.y * mouseSensitivity))
      pivot.rotation.x = clamp(pivot.rotation.x, deg2rad(-90), deg2rad(90))

# 1. Player Movement 
func _process(delta):
   
   direction = Vector3()
   
   if Input.is_action_pressed("movement_forward"):
      direction += transform.basis.z
   if Input.is_action_pressed("movement_backwards"):
      direction -= transform.basis.z
   if Input.is_action_pressed("movement_left"):
      direction += transform.basis.x
   if Input.is_action_pressed("movement_right"):
      direction -= transform.basis.x
      
   direction = direction.normalized()
   velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
   
   velocity = move_and_slide(velocity, Vector3.UP)
