require 'pry'

class Board
	def initialize
		@board = [
			%w(. . .),
			%w(. . .),
			%w(. . .)
		]
	end

	# def diagonals
	# 	right_down = []
	# 	3.times {||}
  # TODO - Add code so that the array at co-ordinate x, y is set to the value
  # of marker, unless it has already been set.
  #
	def mark(x, y, marker)
		if @board[y-1][x-1] == "."
			@board[y-1][x-1] = marker
			puts @board[y-1][x-1]
      puts display_board
    else
    	puts "Sorry.Play elsewhere!"
    	return false
    end
    # binding.pry
	end

	# TODO - Have the board return each of the possible winning combinations.
	#
	# def combinations
	# 	@board[0]
	# 	@board[1]
 #    @board[2]
 #    columns = @board.transpose
 #    columns[0]
 #    columns[1]
 #    columns[2]
 #    diagonal_one = [@board[0][0], @board[1][1], @board [2][2]]
 #    diagonal_two = [@board[0][2], @board[1][1], @board [2][0]]

	def each_winning_move
		columns = @board.transpose
		diagonal_one = [@board[0][0], @board[1][1], @board [2][2]]
    diagonal_two = [@board[0][2], @board[1][1], @board [2][0]]
		# possible_combinations = [@board[0], @board[1], @board[2], columns[0], columns[1], 
		# columns[2], diagonal_one, diagonal_two]
		yield @board[0]
    yield @board[1]
    yield @board[2]
    # yield @boards.transpose[0]
    # yield @boards.transpose[1]
    # yield @boards.transpose[2]
 		yield columns[0]
 		yield columns[1]
 		yield columns[2]
 		yield diagonal_one
 		yield diagonal_two

		# 3.times do |x|
		# 	3.times do |y|
		# 		@board[x-1][y-1]
		# 	end
		# end
	end

	# TODO - Add code to return the board as a String, so that it appears
	# in a 3 x 3 grid
	def to_s
		return @board.to_s
	end

	def display_board
		i=0
		while i<3
			puts @board[i].to_s
			i+=1
		end
	end
end

class Game
	def initialize
		@board = Board.new
		@players = [Nought, Cross]
		@turn = @players.sample
	end

  def change_player
  	if @turn == Cross
  		@turn = Nought
  	else
  		@turn = Cross
    end
  end

	# TODO - The main game loop goes in here.
	#
	def play
		# While the game is still going on, do the following:
			# 1. Show the board to the user

    
    marking = false
    while marking == false
    	user_input = ask_player
    	marking = @board.mark(user_input[0].to_i,user_input[1].to_i, @turn.marker)
		end
		winner
			next_turn

		



			# 2. Prompt for an co-ordinate on the Board that we want to target
			# 3. Mark the board on the given square. If the input is invalid or already
			# taken, go back to 1.
			# 4. If we've got a winner, show the board and show a congratulations method.
			# 5. Otherwise call next_turn and repeat.
			# 6. How to detect a draw?
	end
  # TODO - Return the next player's turn. I.e. not @turn but the other one.
  #
  def ask_player
		puts "Give me your coordinates!"
	  user_input = gets.strip.chomp.split(",")
	end

	def next_turn
		change_player
		play
	end

	# TODO - Return the winning Class if they have won, otherwise return nil.
	#
	def winner
		# Check each of the winning moves on the board, rows, cols and diagonals
		# to see if a Player has filled a row of three consequtive squares
    @board.each_winning_move do |line|
    	i=0
    	line.each do |value|
    		if value == @turn.marker
    			i +=1
    		end
    	end
    	if i == 3
    		puts "And we have a winner!"
    	end
    end
  end
end

class Player
	def self.filled?(row)
		row == [self.marker] * 3
	end
end

class Nought < Player
	def self.marker
		'o'
	end
end

class Cross < Player
	def self.marker
		'x'
	end
end

Game.new.play