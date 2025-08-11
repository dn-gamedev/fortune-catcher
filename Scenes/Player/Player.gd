class_name Player extends CharacterBody2D

const TILE_SIZE := 32
var walk_speed := 10.0
var initial_position := Vector2.ZERO
var input_direction := Vector2.ZERO
var is_moving := false
var percent_moved_to_next_tile := 0.0

func _ready() -> void:
  initial_position = position

func _physics_process(delta: float) -> void:
  if is_moving == false:
    process_player_input()
  else:
    move(delta)

func process_player_input() -> void:
  if input_direction.y == 0:
    input_direction.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")) 
  if input_direction.x == 0:
    input_direction.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
  
  if input_direction != Vector2.ZERO:
    is_moving = true
    initial_position = position
  else:
    is_moving = false

func move(delta: float) -> void:
  percent_moved_to_next_tile += walk_speed * delta
  if percent_moved_to_next_tile >= 1.0:
    position = initial_position + (TILE_SIZE * input_direction)
    print(position)
    percent_moved_to_next_tile = 0.0
    is_moving = false
  else:
    position = initial_position + (TILE_SIZE * input_direction * percent_moved_to_next_tile)