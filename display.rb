require_relative 'board'
require 'colorize'
require_relative 'cursor'
require 'colorized_string'



class Display
  attr_reader :board

  def initialize
    @board = Board.new()
    @cursor = Cursor.new([0,0], @board)
  end

  def move(new_pos)

  end

  def explore
    while true
      render
      @cursor.get_input
    end
  end

  def get_color(row, col)

    color = :black
    color = :white if @board[[row, col]].color == :white

    if @cursor.cursor_pos == [row, col]
      {background: :yellow, color: color}
    elsif (row + col).odd?
      {background: :light_blue, color: color}
    else
      {background: :red, color: color}
    end
  end

  def render()
    system('clear')
    build_grid = @board.grid.map.with_index do |row, row_num|
      row.map.with_index do |tile, col_num|
        color = get_color(row_num, col_num)
        tile.to_s.colorize(color)
      end
    end

    build_grid.each {|row| puts row.join}



  end
end
