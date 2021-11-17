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

module Won
end

class Game
  include GetMove
  @@board = [
    ["X", "Y", "X"],
    ["X", "X", "Y"],
    [" ", " ", "X"],
  ]

  def winHorizontal?()
    # Check each row. If there are three Xs or three Ys win.
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

  def winDiagonal?()
    # [0][0] [1][1] [2][2]
    # [0][2] [1][1] [2][0]
    cY = 0
    cX = 0
    e = @@board.length
    # Check from left to right
    (0..e).each do |n|
      if @@board[n][n] == "Y"
        cY += 1
      elsif @@board[n][n] == "X"
        cX += 1
        # @@board[n][e - n]
      end
    end
    case totalWin(cY, cX)
    when true
      return true
    end
    # Check from right to left
    (0..e).each do |n|
      case @@board[n][e - n]
      when "Y"
        cY += 1
      when "X"
        cX += 1
      end
      case totalWin?(cY, cX)
      when true
        return true
      end
    end
  end

  def totalWin?(countY, countX)
    if countY == 3
      puts "Y won!"
      return "Y won!"
    elsif countX == 3
      puts "X won!"
      return "X won!"
    else
      cY = 0
      cX = 0
    end
  end

  def winVertical?()
    # [0][0] [1][0] [2][0]
    # [0][1] [1][1] [2][1]
    # [0][2] [1][2] [2][2]
    cY = 0
    cX = 0
    e = @@board.length
    (0..e).each do |n|
      @@board.each do |r|
        if r[n] == "Y"
          cY += 1
        elsif r[n] == "X"
          cX += 1
        end
      end
      case totalWin?(cY, cX)
      when true
        return true
      else
        cY = 0
        cX = 0
      end
    end
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

win = false
while win != true
  puts "#{player1.name}'s move"
  if game1.winHorizontal?()
    puts "Game won!"
    break
  elsif game1.winVertical?()
    puts "Game won!"
    break
  end
  player1Move = player1.placeMarker(game1.getMove())
  game1.display
end

# Todo:
#   - Asign X or Y value to players
#   - Switch back and forth between players until loop breaks
#   - Handle invalid input
#   - Set private and public appropriatly
