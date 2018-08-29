require 'singleton'
require_relative 'Modules.rb'

class Piece
  attr_reader :symbol, :color, :selected

  def initialize(pos, board, color)
    @board = board
    @color = color
    @pos = pos
    @selected = false
  end

  def select_piece
    @selected = true
  end

  def deselect_piece
    @selected = false
  end

  def inspect
    "#{@symbol} #{self.object_id}"
  end

  def moves
    []
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @symbol = "   "
  end
end

class Queen < Piece
  include Slideable
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = " ♛ "
  end
end

class King < Piece
  include Stepable
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = " ♚ "
  end
end

class Rook < Piece
  include Slideable
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = " ♜ "
  end

  def diagonal_dirs
    []
  end
end

class Bishop < Piece
  include Slideable
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = " ♝ "
  end

  def horizontal_dirs
    []
  end

  def vertical_dirs
    []
  end
end

class Knight < Piece
  include Stepable
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = " ♞ "
  end
end

class Pawn < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = " ♟ "
  end

# private

  def at_start_row?
    if self.color == :white && pos[-1] == 6
      true
    elsif self.color == :black && pos[-1] == 1
      true
    else
      false
    end
  end

  def forward_dir
    if self.color == :white
      -1
    elsif self.color == :black
      1
    end
  end

  def forward_steps
    new_pos = [(@pos[0] + self.forward_dir), @pos[-1]]
    @board.move_piece(@pos, new_pos)
  end

  def side_attacks
  end
end
