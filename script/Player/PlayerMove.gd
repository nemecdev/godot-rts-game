class_name PlayerMove

func move(obj: Spatial, speed: int):
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
    
  velocity.x = direction.x * speed * 0.1
  velocity.z = direction.z * speed * 0.1

  obj.translate(velocity)
