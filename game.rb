module GetMove
  def getMove()
    puts "Row:"
    row = gets.chomp
    puts "Column:"
    column = gets.chomp
    puts "Your move was row #{row} column #{column}"
    return [row, column]
  end
end

class Game
  include GetMove
  @@board = [
    ["X", "Y", "X"],
    ["X", "Y", "Y"],
    [" ", " ", " "],
  ]

  def win?()
    @@board.each do |line|
      xCount = 0
      yCount = 0
      line.each do |move|
        if move == "Y"
          yCount += 1
        elsif move == "X"
          xCount += 1
        else
          next
        end
      end
      if xCount == 3
        puts "X won!"
        return true
      elsif yCount == 3
        puts "Y won!"
        return true
      end
    end
    return false
  end

  def display()
    puts "    0    1    2"
    @@board.each_with_index do |line, index|
      puts "#{index} #{line}"
    end
  end

  def placeMarker(move)
    # 1 1 = board[1][1]
    row = Integer(move[0])
    column = Integer(move[1])
    spot = @@board[row][column]
    if spot == " "
      @@board[row][column] = "X"
    else
      puts "Error: Space Taken"
    end
  end
end

class Player < Game
  include GetMove
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

game1 = Game.new()
game1.display
# game1.placeMarker(game1.getMove)

# Get player one's name
puts "Player 1 what is your name?"
name1 = gets.chomp
player1 = Player.new(name1)

while game1.win? != true
  game1.display
  puts "#{player1.name}'s move"
  player1Move = player1.placeMarker(game1.getMove())
  game1.display
end

# Todo:
#   - Asign X or Y value to players
#   - Switch back and forth between players until loop breaks
#   - Handle invalid input
#   - Set private and public appropriatly
#   - Better way to handel player name?
