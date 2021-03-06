extends State

class_name IdleState

func _ready():
	print("IDLE")

func handle_input(_event):
	if self.persistent_state.moving_left or self.persistent_state.moving_right:
		self.persistent_state.change_state("run")

func _physics_process(delta):
	if Input.is_action_pressed("jump") and self.persistent_state.is_on_floor():
		self.persistent_state.change_state("jump")

	self.persistent_state.velocity = self.get_velocity(delta)
	self.persistent_state.move_and_slide_with_snap(self.persistent_state.velocity, self.persistent_state.snap_vector, Vector2.UP, false)

func get_velocity(delta):
	var v = Vector2(0, self.persistent_state.velocity.y)

	v += (Vector2.DOWN * self.persistent_state.gravity/2) + (Vector2.DOWN * self.persistent_state.gravity * delta)
	if v.y >= self.persistent_state.MAX_FALL_SPEED:
		v.y = self.persistent_state.MAX_FALL_SPEED

	return v
