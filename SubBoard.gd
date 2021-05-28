extends GridContainer

var state = 0	# 0 is active, 1 is p1 win, 2 is p2 win, 3 is draw
var values = [0, 0, 0,  0, 0, 0,  0, 0, 0]
var selected

var big_board

var theme_red
var theme_blue


func get_button(index):
	return get_node("Button" + str(index))

func press(index):
	var button = get_button(index)
	var turn = big_board.current_player
	values[index] = turn
	if turn == 1:
		button.text = "X"
		#button.font_color = Color(1, 0, 0, 1)
		button.theme = theme_red
	else: # turn == 2
		button.text = "O"
		#button.font_color = Color(0, 0, 1, 1)
		button.theme = theme_blue
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
		disable_board()
		big_board.calc_win()

func disable_board():
	selected = false
	for i in range(9):
		var button = get_button(i)
		button.disabled = true
	update()

func enable_board():
	if state != 0:
		return
	selected = true
	for i in range(9):
		if values[i] == 0:
			var button = get_button(i)
			button.disabled = false
	update()


## CALLBACKS ##

func _ready():
	big_board = get_parent()
	selected = true

	theme_red = Theme.new()
	theme_red.set_color("font_color_disabled", "Button", Color(1, 0, 0, 1))
	theme_blue = Theme.new()
	theme_blue.set_color("font_color_disabled", "Button", Color(0, 0, 1, 1))

#func _process(delta):
#	pass

func _draw():
	if selected:
		var margin = 6
		var rect = Rect2(Vector2(-margin, -margin), rect_size + Vector2(2 * margin, 2 * margin))
		var col = Color(1, 0, 0, 1) if big_board.current_player == 1 else Color(0, 0, 1, 1)
		draw_rect(rect, col, false, 3)
	if state != 0:
		draw_rect(Rect2(Vector2(0, 0), rect_size), Color(1, 1, 1, 0.3), true)
		var col
		if state == 3:
			col = Color(0, 1, 0, 1)
		else:
			col = Color(1, 0, 0, 1) if state == 1 else Color(0, 0, 1, 1)

		if state == 1 or state == 3:
			draw_line(Vector2(10, 10), rect_size - Vector2(10, 10), col, 5)
			draw_line(Vector2(rect_size.x - 10, 10), Vector2(10, rect_size.y - 10), col, 5)
		if state == 2 or state == 3:
			draw_circle(rect_size / 2, rect_size.x / 2 - 10, col)



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
