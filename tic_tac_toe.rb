require 'pry'

class Board
	def initialize
		@board = [
			%w(. . .),
			%w(. . .),
			%w(. . .)
		]
	end

  # TODO - Add code so that the array at co-ordinate x, y is set to the value
  # of marker, unless it has already been set.
  #

	def mark(x, y, marker)
		if @board[y-1][x-1] == "."
			@board[y-1][x-1] = marker
			puts @board[y-1][x-1]
      puts to_s
    else
    	puts "Sorry.Play elsewhere!"
    	return false
    end
	end

  def complete
    flat = @board.flatten
    true unless flat.include?"."
  end

  # true unless @board[i] == "."


	# TODO - Have the board return each of the possible winning combinations.

	def each_winning_move
		columns = @board.transpose
		diagonal_one = [@board[0][0], @board[1][1], @board [2][2]]
    diagonal_two = [@board[0][2], @board[1][1], @board [2][0]]

		possible_combinations = [@board[0], @board[1], @board[2], columns[0], columns[1],
		columns[2], diagonal_one, diagonal_two]

		possible_combinations.each {|n| yield n}
	end

	# TODO - Add code to return the board as a String, so that it appears
	# in a 3 x 3 grid

	def to_s
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

  def ask_player
    puts "Give me your coordinates!"
    coord = gets.strip.chomp.split(",")
    if coord[0].to_i > 3 || coord[1].to_i > 3
      puts "You are outside the board!Try again!"
      ask_player
    end
    coord
  end

  def change_player
  	if @turn == Cross
  		@turn = Nought
  	else
  		@turn = Cross
    end
  end

 #  counts = 0
	# def draw
	# 	if next_turn
	# 		counts+=1
	# 	end
	# 	if counts == 8
	# 		puts "No winner! We have a draw"
	# 		puts "Would you like to play again?"
	# 		answer = gets.strip.chomp.downcase
	# 		if answer == 'yes'
	# 		Game.new.play
	# 	  end
	# 	end
	# end

	# TODO - The main game loop goes in here.
	#
	def play
		# While the game is still going on, do the following:
			# 1. Show the board to the user
      # 2. Prompt for an co-ordinate on the Board that we want to target
      # 3. Mark the board on the given square. If the input is invalid or already
      # taken, go back to 1.
      # 4. If we've got a winner, show the board and show a congratulations method.
      # 5. Otherwise call next_turn and repeat.
      # 6. How to detect a draw?
    marking = false
    while marking == false
    	coord = ask_player
    	marking = @board.mark(coord[0].to_i,coord[1].to_i, @turn.marker)
		end
		winner
    @board.complete
    if @board.complete
      puts "We have a draw! No winner for now! Start again!"
      Game.new.play
    end
		next_turn

	end
  # TODO - Return the next player's turn. I.e. not @turn but the other one.
  #
  def next_turn
    change_player
    play
  end

	# TODO - Return the winning Class if they have won, otherwise return nil.
	#
	def winner
		# Check each of the winning moves on the board, rows, cols and diagonals
		# to see if a Player has filled a row of three consequtive squares
    @board.each_winning_move do |move|
    	i=0
    	move.each do |spot|
    			i += 1 if spot == @turn.marker
    	end
      if i == 3
      	puts "You are the winner!Congratulations!"
        puts "Now let's play again!"
        Game.new.play
      end
    end
  end

  # def complete
  #   binding.pry
  #   @board.flatten!
  #   for i in @board
  #     true unless @board[i] == "."
  #   end
  # end

end

class Player
	def self.filled?(row)
		row == [self.marker] * 3
	end
end

class Nought < Player
	def self.marker
		'O'
	end
end

class Cross < Player
	def self.marker
		'X'
	end
end

Game.new.play