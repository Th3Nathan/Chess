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
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def valid_pos(pos)
    x, y = pos
    (x >= 0 && x <= 7 && y >= 0 && y <= 7) && self[pos].is_a?(NullPiece)
  end

  def move_piece(start_pos, end_pos)
    raise CannotMoveToEndPos unless valid_pos(end_pos)
    raise NoPieceToMove if self[start_pos].is_a?(NullPiece)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
  end

  def piece_row
    Array.new(8){Piece.new}
  end

  def null_row
    Array.new(8){NullPiece.new}
  end

  protected
  def make_starting_grid
    @grid = []
    2.times { @grid << piece_row}
    4.times { @grid << null_row}
    2.times { @grid << piece_row}
  end

end
