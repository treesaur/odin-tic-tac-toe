class TicTacToe
  def initialize()
    @grid = Array.new(3) {Array.new(3, "-")}
  end

  def play()
    turnNum = 0
    while !winner?
      puts "It is #{player(turnNum)}'s turn."
      updateGrid(playerMove(), player(turnNum))
      displayGrid()
      turnNum += 1
    end
  end

  def winner?()
    row_0 = @grid[0]
    row_1 = @grid[1]
    row_2 = @grid[2]
    column_0 = [@grid[0][0], @grid[1][0], @grid[2][0]]
    column_1 = [@grid[0][1], @grid[1][1], @grid[2][1]]
    column_2 = [@grid[0][2], @grid[1][2], @grid[2][2]]
    diagonal_0 = [@grid[0][0], @grid[1][1], @grid[2][2]]
    diagonal_1 = [@grid[2][0], @grid[1][1], @grid[0][2]]
    possible_outcomes = [row_0, row_1, row_2, column_0, column_1, column_2, diagonal_0, diagonal_1]

    possible_outcomes.each do |outcome|
      if outcome.all?("X")
        puts "X has won."
        return true
      elsif outcome.all?("O")
        puts "O has won."
        return true
      end
    end

    false
  end

  def player(turn)
    if turn % 2 == 0
      return "X"
    else
      "O"
    end
  end

  def playerMove()
    puts "Enter a position to play."
    coordinates = gets.chomp() # => ex: "[0,1]" so coordinates[1] = 0 and coordinates[3] = 1
    row = coordinates[1].to_i
    column = coordinates[3].to_i

    overlap = false
    valid_input = false
    while !overlap || !valid_input
      if /\[[0-2],[0-2]\]/.match(coordinates) == nil
        puts "Invalid position. Please enter a valid position. For example, [0,1]."
        coordinates = gets.chomp()
        row = coordinates[1].to_i
        column = coordinates[3].to_i
        valid_input = false
      else
        valid_input = true
      end

      if @grid[row][column] != "-"
        puts "That position has already been taken. Please enter another position."
        coordinates = gets.chomp()
        row = coordinates[1].to_i
        column = coordinates[3].to_i
        overlap = false
      else
        overlap = true
      end
    end
        
    [row, column]
  end

  def updateGrid(position, player)
    row = position.first
    column = position.last
    @grid[row][column] = player
  end

  def displayGrid()
    @grid.each do |row|
      print "#{row}\n"
    end
  end

end

test = TicTacToe.new()
test.play()