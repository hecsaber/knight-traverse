class Node
  attr_accessor :row, :column, :parent

  def initialize(row, column, parent = nil)
    @row = row
    @column = column
    @parent = parent
  end
end

class Knight
  attr_reader :rows, :columns
  POSSIBLE_MOVES = 8

  def initialize
    @rows = [-2, -1, 1, 2, -2, -1, 1, 2]
    @columns = [-1, -2, -2, -1, 1, 2, 2, 1]
  end

  def knight_move(start, finish)
    queue = []
    visited = []
    visited.push([2, 0])
    res = []
    queue << start

    until queue.empty? do
      first = queue.shift
      solution = first
      return show_steps(solution) if first.row == finish.row && first.column == finish.column
      
      POSSIBLE_MOVES.times do |i|
        next_row = first.row + rows[i]
        next_column = first.column + columns[i]
        visit = [next_row, next_column]
        if !visited.include?(visit) && legal_move?(next_row, next_column)
          solution = Node.new(next_row, next_column, first)
          queue << solution
          visited << visit
        end
      end
    end
    return nil
  end

  private 

  def legal_move?(row, column)
    return row >= 0 && column >= 0 && row < 8 && column < 8
  end

  def show_steps(steps, res = [])
    return res.unshift([steps.row, steps.column]) if steps.parent.nil?

    res.unshift([steps.row, steps.column])
    show_steps(steps.parent, res)
    res
  end

end

game = Knight.new
start = Node.new(0, 0)
finish = Node.new(0, 1)

result = game.knight_move(start, finish)

puts "You made it in #{result.size - 1} moves.\nHere is your result:\n"
result.each { |i| puts "#{i}\n" }