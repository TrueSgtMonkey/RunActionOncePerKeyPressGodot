extends Sprite2D

const MAX_RADIUS : float = 200.0
const MIN_RADIUS : float = 50.0

@export var radius : float = 200.0
@export var speed : float = 2.5
@export var radiusIncreaseSpeed : float = 25.0

var add : float = 0.0
var originalPosition : Vector2
var isDecreasing : bool = false
var isSpinning : bool = false
var isSpinningHeldDown : bool = false

func _ready():
  originalPosition = position

func _input(event):
  if event.is_action_pressed("toggle_visible"):
    visible = !visible
    
func _physics_process(delta):
  runSpinSpriteInput(delta)
    
func runSpinSpriteInput(delta : float):
  if Input.is_action_pressed("toggle_spin") && !isSpinningHeldDown:
    isSpinning = !isSpinning
    isSpinningHeldDown = true
  elif Input.is_action_just_released("toggle_spin"):
    isSpinningHeldDown = false

  if isSpinning:
    spinSprite(delta)
  
func spinSprite(delta : float):
  add += delta
  var xAdd : float = cos(add * speed) * radius
  var yAdd : float = sin(add * speed) * radius
  
  position.x = originalPosition.x + xAdd
  position.y = originalPosition.y + yAdd
  
  if radius <= MIN_RADIUS:
    isDecreasing = false
  elif radius >= MAX_RADIUS:
    isDecreasing = true

  if isDecreasing:
    radius += delta * -radiusIncreaseSpeed
  else:
    radius += delta * radiusIncreaseSpeed
