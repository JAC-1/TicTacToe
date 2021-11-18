module GetMove
  def getMove
    puts 'Row:'
    row = gets.chomp
    puts 'Column:'
    column = gets.chomp
    puts "Your move was row #{row} column #{column}"
    [row, column]
  end
end

module BetterWinModule
  def win(board)
    (0..2).each do |r|
      # Horizontal check
      if board[r][0] == 'X' && board[r][1] == 'X' && board[r][2] == 'X'
        return 'X'
      elsif board[r][0] == 'Y' && board[r][1] == 'Y' && board[r][2] == 'Y'
        return 'Y'
        # Vertical check
      elsif board[0][r] == 'Y' && board[1][r] == 'Y' && board[2][r] == 'Y'
        return 'Y'
      elsif board[0][r] == 'X' && board[1][r] == 'X' && board[2][r] == 'X'
        return 'X'
        # Diagonal Left to Right check
      elsif board[r][r] == 'X' && board[r + 1][r + 1] == 'X' && board[r + 2][r + 2] == 'X'
        return 'X'
      elsif board[r][r] == 'Y' && board[r + 1][r + 1] == 'Y' && board[r + 2][r + 2] == 'Y'
        return 'Y'
        # Diagonal Right to Left check
      elsif board[r][r + 2] == 'Y' && board[r + 1][r + 1] == 'Y' && board[r + 2][r] == 'Y'
        return 'Y'
      elsif board[r][r + 2] == 'X' && board[r + 1][r + 1] == 'X' && board[r + 2][r] == 'X'
        return 'X'
      else
        return false
      end
    end
  end
end

class Game
  include GetMove
  include BetterWinModule
  @@board = [
    [' ', ' ', ' '],
    [' ', ' ', ' '],
    [' ', ' ', ' ']
  ]

  def board
    return @@board
  end

  def display
    puts '    0    1    2'
    @@board.each_with_index do |line, index|
      puts "#{index} #{line}"
    end
  end
end

class Player < Game
  include GetMove
  attr_accessor :name, :symbol, :turn

  def initialize(name, symbol, turn)
    @name = name
    @symbol = symbol
    @turn = turn
  end

  def placeMarker(move)
    # 1 1 = board[1][1]
    row = Integer(move[0])
    column = Integer(move[1])
    spot = @@board[row][column]
    if spot == ' '
      @@board[row][column] = @symbol
    else
      puts 'Error: Space Taken'
    end
  end
end

def validate(game1, player1, player2)
   if game1.win(game1.board) == player1.symbol
    puts "#{player1.name} wins"
    return true
  elsif game1.win(game1.board) == player2.symbol
    puts "#{player2.name} wins"
    return true
  end
end

# Set up the game
game1 = Game.new
game1.display
validMoves = [0, 1, 2]

# Get player one name
puts 'Player 1 what is your name?'
name1 = gets.chomp

# Get player two name
puts 'Player 2 what is your name?'
name2 = gets.chomp

# Create players, assign symbol, and decide who starts
case rand(2)
when 0
  player1 = Player.new(name1, 'X', false)
  player2 = Player.new(name2, 'Y', true)
when 1
  player1 = Player.new(name1, 'Y', true)
  player2 = Player.new(name2, 'X', false)
end

puts "-----------------------------------------------------"
puts "#{player1.name}, you are #{player1.symbol}"
puts "#{player2.name}, you are #{player2.symbol}"
puts "-----------------------------------------------------"

while true
  if player1.turn == true
    puts "#{player1.name}'s move"
   
      player1.turn = false
      player2.turn = true
  elsif player2.turn == true
    puts "#{player2.name}'s move"
    choice = player2.placeMarker(player2.getMove)
    player2.turn = false
    player1.turn = true
  end
  if validate(game1, player1, player2) then break end

puts "-----------------------------------------------------"
puts "-----------------------------------------------------"
  game1.display

end

# Todo:
#   - Asign X or Y value to players
#   - Switch back and forth between players until loop breaks
#   - Handle invalid input
#   - Set private and public appropriatly
