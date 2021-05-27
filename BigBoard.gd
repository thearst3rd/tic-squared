extends GridContainer

var state = 0
var current_player = 1


func handle_press(index):
	if state != 0:
		return
	var sub_board = get_node("SubBoard" + str(index))
	for i in range(9):
		var sub_board_i = get_node("SubBoard" + str(i))
		sub_board_i.enable_board()
	if sub_board.state == 0:
		for i in range(9):
			if i == index:
				continue
			var sub_board_i = get_node("SubBoard" + str(i))
			sub_board_i.disable_board()

func calc_win():
	var values = [0, 0, 0,  0, 0, 0,  0, 0, 0]
	for i in range(9):
		var sub_board = get_node("SubBoard" + str(i))
		values[i] = sub_board.state

	var wins_1 = 0
	var wins_2 = 0

	# Calc horizontal lines
	for i in range(0, 9, 3):
		if values[i] != 0 and values[i] == values[i + 1] and values[i] == values[i + 2]:
			if values[i] != 2:
				wins_1 += 1
			if values[i] != 1:
				wins_2 += 1

	# Calc vertical lines
	for i in range(3):
		if values[i] != 0 and values[i] == values[i + 3] and values[i] == values[i + 6]:
			if values[i] != 2:
				wins_1 += 1
			if values[i] != 1:
				wins_2 += 1

	# Calc horizontals
	if values[4] != 0:
		if values[0] == values[4] and values[8] == values[4]:
			if values[4] != 2:
				wins_1 += 1
			if values[4] != 1:
				wins_2 += 1
		elif values[2] == values[4] and values[6] == values[4]:
			if values[4] != 2:
				wins_1 += 1
			if values[4] != 1:
				wins_2 += 1

	# Calc winner
	if wins_1 != 0 or wins_2 != 0:
		if wins_1 > wins_2:
			state = 1
		elif wins_2 > wins_1:
			state = 2
		else:
			state = 3

	print("1 wins: " + str(wins_1))
	print("2 wins: " + str(wins_2))
	if state != 0:
		if state == 3:
			print("Draw!")
		else:
			print(str(state) + " wins!")
		for i in range(9):
			var sub_board = get_node("SubBoard" + str(i))
			sub_board.disable_board()


## CALLBACKS

func _ready():
	pass

#func _process(delta):
#	pass


## SIGNALS ##
