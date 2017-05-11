require 'byebug'
require_relative 'piece'
class NoPieceToMove < StandardError
end

class CannotMoveToEndPos < StandardError
end


class Board
  attr_reader :grid
  def initialize
    self.make_starting_grid()
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def valid_pos(pos)
    row, col = pos
    (row >= 0 && row <= 7 && col >= 0 && col <= 7) && self[pos].is_a?(NullPiece)
  end

  def valid_cursor_pos(pos)
    row, col = pos
    (row >= 0 && row <= 7 && col >= 0 && col <= 7)
  end

  def move_piece(start_pos, end_pos)
    raise CannotMoveToEndPos unless valid_pos(end_pos)
    raise NoPieceToMove if self[start_pos].is_a?(NullPiece)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
  end

  def piece_row(row, color)
    [Piece.new(self, [row, 0], color),
     Knight.new(self, [row, 1], color),
     Piece.new(self, [row, 2], color),
     King.new(self, [row, 3], color),
     Piece.new(self, [row, 4], color),
     Piece.new(self, [row, 5], color),
     Knight.new(self, [row, 6], color),
     Piece.new(self, [row, 7], color)]
  end

  def pawn_row(row, color)
    (0..7).to_a.map {|col| Piece.new(self, [row, col], color) }
  end

  def null_row
    Array.new(8){NullPiece.new}
  end

  protected
  def make_starting_grid
    @grid = []
    @grid << piece_row(0, :black)
    @grid << pawn_row(1, :black)
    4.times { @grid << null_row}
    @grid << pawn_row(6, :white)
    @grid << piece_row(7, :white)
  end

end
