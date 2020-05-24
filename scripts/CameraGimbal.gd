extends Spatial

# CAMERA : mouse control
export var invertedX = true #for inverted controls
export var invertedY = true #for inverted controls
var mouseControl = true
var mouseSensitivy = 0.005

# CAMERA : zoom in and zoom out 
export var maxZoom = 3.0
export var minZoom = 0.5
export var zoomSpeed = 0.09
var zoom = 1.5

# CAMERA : gimbal and inner gimbal 
export var rotationSpeed = PI / 2
var maxClamp = 90
var minClamp = -90

# MARKUP - : Ready 
func _ready() :
   Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# MARKUP - : Process
func _process(delta) :
   # ESC key
   if Input.is_action_just_pressed("ui_cancel") :
      Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
   
   # CAMERA control
   if !mouseControl :
      getInputKeyboard(delta)
      
   $CameraGimbalInner.rotation.x = clamp($CameraGimbalInner.rotation.x, deg2rad(minClamp), deg2rad(maxClamp))
   scale = lerp(scale, Vector3.ONE * zoom, zoomSpeed)

# MARKUP - : 
func _unhandled_input(event) :
   if mouseControl and event is InputEventMouseMotion :
      if event.relative.x != 0 :
         var direction = 1 if invertedX else -1 #for inverted controls
         rotate_object_local(Vector3.UP, direction * event.relative.x * mouseSensitivy)
      if event.relative.y != 0 :
         var direction = 1 if invertedY else -1 #for inverted controls
         var yRotation = clamp(event.relative.y, -30, 30)
         $CameraGimbalInner.rotate_object_local(Vector3.RIGHT, direction * yRotation * mouseSensitivy)
   
   if event.is_action_pressed("cam_zoom_out") :
      zoom -= zoomSpeed
   if event.is_action_pressed("cam_zoom_in") :
      zoom += zoomSpeed
   zoom = clamp(zoom, minZoom, maxZoom)

# MARKUP - : getInputKeyboard
func getInputKeyboard(delta) :
   # rotate outer gimbal around y axis 
   var yRotation = 0 
   if Input.is_action_pressed("movement_right") :
      yRotation -= 1
   if Input.is_action_pressed("movement_left") :
      yRotation += 1
   rotate_object_local(Vector3.UP, yRotation * rotationSpeed * delta)
   # rotate inner gimbal around local x axis
   var xRotation = 0 
   if Input.is_action_pressed("movement_forward") :
      xRotation += 1
   if Input.is_action_pressed("movement_backwards") :
      xRotation -= 1
   $CameraGimbalInner.rotate_object_local(Vector3.RIGHT , xRotation * rotationSpeed * delta)
   

      
   
