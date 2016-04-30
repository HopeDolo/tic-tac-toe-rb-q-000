WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # middle row
  [6, 7, 8], # bottom row
  [0, 3, 6], # left column
  [1, 4, 7], # middle column
  [2, 5, 8], # right column
  [0, 4, 8], # left diagonal
  [2, 4, 6]  # right diagona
]

def display_board(board)
  puts " #{board[0]} " + '|' + " #{board[1]} " + '|' + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + '|' + " #{board[4]} " + '|' + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + '|' + " #{board[7]} " + '|' + " #{board[8]} "
end

def move(board, position, value)
  board[position.to_i - 1] = value
end

def position_taken?(board, position)
  !(board[position] == " ")
end

def valid_move?(board, position)
  position.to_i.between?(1,9) &&
  !position_taken?(board, position.to_i - 1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
    if valid_move?(board,input)
      value = current_player(board)
      move(board,input, value)
      display_board(board)
    else
    turn(board)
  end
end

def turn_count(board)
  9 - board.count(" ")
end
  #count = 0
  #board.each do |value|
    #if value == "X" || value == "O"
      #count += 1
    #end
  #end
  #return count
#end

def current_player(board)
  turn_count(board).odd? ? "O" : "X" # using ternary if
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" ||
      position_1 == "O" && position_2 == "O" && position_3 == "O"
       return win_combination
    end
  end

  board.all? do |member|
    if member.eql?(" ")
      false
    end
  end
end

def full?(board)
  board.all? do |member|
    member.eql?("X") || member.eql?("O")
  end
end

def draw?(board)
   !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  win = won?(board)

  if !win
    nil
  else
    board[win[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  winner = winner(board)
  win = won?(board)
  draw = draw?(board)
  if win
    puts "Congratulations #{winner}!"
  else draw
    puts "Cats Game!"
  end
end
