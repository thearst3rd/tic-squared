extends GridContainer

var state = 0	# 0 is active, 1 is p1 win, 2 is p2 win, 3 is draw
var values = [0, 0, 0,  0, 0, 0,  0, 0, 0]

var big_board


func press(index):
	var button = get_node("Button" + str(index))
	var turn = big_board.current_player
	values[index] = turn
	button.text = str(turn)
	button.disabled = true
	big_board.current_player = (turn % 2) + 1
	calc_win()
	big_board.handle_press(index)

func calc_win():
	# Calc horizontal lines
	for i in range(0, 9, 3):
		if values[i] != 0 and values[i] == values[i + 1] and values[i] == values[i + 2]:
			state = values[i]

	# Calc vertical lines
	for i in range(3):
		if values[i] != 0 and values[i] == values[i + 3] and values[i] == values[i + 6]:
			state = values[i]

	# Calc horizontals
	if values[4] != 0:
		if values[0] == values[4] and values[8] == values[4]:
			state = values[4]
		elif values[2] == values[4] and values[6] == values[4]:
			state = values[4]

	if state == 0:
		# Check if everything is filled, draw
		var filled = true
		for i in range(9):
			if values[i] == 0:
				filled = false
				break
		if filled:
			state = 3

	if state != 0:
		for i in range(9):
			var button = get_node("Button" + str(i))
			button.disabled = true
		big_board.calc_win()

func disable_board():
	for i in range(9):
		var button = get_node("Button" + str(i))
		button.disabled = true

func enable_board():
	if state != 0:
		return
	for i in range(9):
		if values[i] == 0:
			var button = get_node("Button" + str(i))
			button.disabled = false


## CALLBACKS ##

func _ready():
	big_board = get_parent()

#func _process(delta):
#	pass


## SIGNALS ##

# How can this be improved?
func _on_Button0_pressed():
	press(0)

func _on_Button1_pressed():
	press(1)

func _on_Button2_pressed():
	press(2)

func _on_Button3_pressed():
	press(3)

func _on_Button4_pressed():
	press(4)

func _on_Button5_pressed():
	press(5)

func _on_Button6_pressed():
	press(6)

func _on_Button7_pressed():
	press(7)

func _on_Button8_pressed():
	press(8)
