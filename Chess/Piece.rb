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
    @symbol
  end

  def moves
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
end

class Bishop < Piece
  include Slideable
  def initialize(pos, board, color)
    super(pos, board, color)
    @symbol = " ♝ "
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
end
