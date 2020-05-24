extends Spatial

# MARKUP - : Properties
var lookSensitivity : float = 15.0
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0

var mouseDelta : Vector2 = Vector2()


onready var player = get_parent()

# MARKUP - : Ready
func _ready():
   Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# MARKUP - : Input   
func _input(event):
   
   if event is InputEventMouseMotion :
      mouseDelta = event.relative
      
   if Input.is_action_just_pressed("ui_cancel"):
      Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# MARKUP - : Process
func _process(delta):
   
   var rotation = Vector3(mouseDelta.y, mouseDelta.x, 0) * lookSensitivity * delta
   
   rotation_degrees.x += rotation.x
   rotation_degrees.x = clamp(rotation_degrees.x, minLookAngle, maxLookAngle)
   
   player.rotation_degrees.y -= rotation.y
   
   mouseDelta = Vector2()
