require_relative 'board.rb'
require 'byebug'
# module SlidingPiece
#   def moves
#
#   end
#
# end
#
# module SteppingPiece
#   def knight_diffs
#     [[2,1],[2,-1],[-2,1][-2,-1],[1,-2],[1,2],[-1,-2],[-1,2]]
#   end
#
#
#   def king_diffs
#     [[1,1],[1,0],[-1,1][0,-1],[1,-1][0,1][-1,-1][-1,0]]
#   end
#
#   def knight_moves(pos, board, color)
#     @pos
# end

class Piece
  attr_reader :color
  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def to_s
    " P "
  end

end

class Knight < Piece

  def initialize(board, pos, color)
    super(board, pos, color)
    @diffs = [[2,1],[2,-1],[-2,1],[-2,-1],[1,-2],[1,2],[-1,-2],[-1,2]]
  end

  def to_s
    "Kni"
  end

  def moves
    start_row, start_col = @pos
    possible_moves = []

    @diffs.each do |row, col|
      new_pos = [row + start_row, col + start_col]
      if @board.valid_pos(new_pos) || self.color != @board[new_pos].color
        possible_moves << new_pos
      end
    end
    possible_moves
  end

end

class King < Piece
  def initialize(board, pos, color)
    super(board, pos, color)
    @diffs = [[1,1],[1,0],[-1,1],[0,-1],[1,-1],[0,1],[-1,-1],[-1,0]]
  end

  def to_s
    " K "
  end
end

class NullPiece < Piece
  def initialize
  end
  def to_s
    "   "
  end
  def color
  end
end
