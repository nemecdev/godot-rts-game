extends Spatial

export(float, 1.0, 10.0) var move_speed = 6.0
export(float, 0, 1.0) var move_lerp_weight = 0.08

export(float, 1.0, 10.0) var zoom_speed = 5.0
export(float, 0, 1.0) var zoom_lerp_weight = 0.01

export(float, 2.0, 4.0) var max_zoom_in = 4.0
export(float, 10.0, 25.0) var max_zoom_out = 20.0

export var cam_path: NodePath = '../Camera'

var cam: Camera

func _ready():
  zoom_speed = (zoom_speed * 20)
  move_speed = (move_speed * 5)

  cam = get_node(cam_path)

func _process(delta):
  _move(move_speed * delta, move_lerp_weight)
  _zoom(zoom_speed * delta, max_zoom_in, max_zoom_out, zoom_lerp_weight)
  _rotate()

func _move(_speed: float, _lerp_weight: float):
  var direction = Vector3.ZERO
  var velocity = Vector3.ZERO

  if Input.is_action_pressed("ui_up"):
    direction.z -= 1
  if Input.is_action_pressed("ui_down"):
    direction.z += 1
  if Input.is_action_pressed("ui_left"):
    direction.x -= 1
  if Input.is_action_pressed("ui_right"):
    direction.x += 1

  if direction != Vector3.ZERO:
    direction = direction.normalized()

  velocity.x = direction.x * _speed
  velocity.z = direction.z * _speed

  self.translate(velocity)
  cam.transform.origin = lerp(cam.transform.origin, self.transform.origin, _lerp_weight)


func _zoom(
  _speed: float,
  _max_zoom_in: float,
  _max_zoom_out: float,
  _zoom_lerp_weight: float
):
  if Input.is_action_just_released("ui_zoom_in"):
    self.transform.origin.y = clamp(
      self.transform.origin.y - 1 * _speed,
      _max_zoom_in,
      _max_zoom_out
    )

  if Input.is_action_just_released("ui_zoom_out"):
    self.transform.origin.y = clamp(
      self.transform.origin.y + 1 * _speed,
      _max_zoom_in,
      _max_zoom_out
    )

  cam.transform.origin.y = clamp(
    lerp(cam.transform.origin.y, self.transform.origin.y, _zoom_lerp_weight),
    _max_zoom_in,
    _max_zoom_out
  )

func _rotate():
  if Input.is_action_just_pressed('ui_cam_rotate'):
    print_debug(cam.transform.basis)
