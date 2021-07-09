extends KinematicBody2D

const move_speed = 8000
const dash_speed = 40000
const dash_duration = 0.2

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
onready var dash = $Dash

func _process(delta):
	var move_direction = get_move_direction()
	play_animation(move_direction)
		
		
	##	
	# dash code goes here
	if Input.is_action_just_pressed("dash") && !dash.is_dashing() && dash.can_dash:
		dash.start_dash(sprite, dash_duration)
		
	var speed = dash_speed if dash.is_dashing() else move_speed
	#
	
	var velocity = move_direction.normalized() * speed * delta
	move_and_slide(velocity)


func get_move_direction():
	return Vector2(
		int(Input.is_action_pressed('ui_right')) - int(Input.is_action_pressed('ui_left')),
		int(Input.is_action_pressed('ui_down')) - int(Input.is_action_pressed('ui_up'))
	)
	
	
func play_animation(move_direction):
	if move_direction == Vector2.ZERO:
		anim_player.play("idle")
	else:
		sprite.flip_h = move_direction.x < 0
		anim_player.play("run")	


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	if dash.is_dashing(): return
	print("ouch!")
