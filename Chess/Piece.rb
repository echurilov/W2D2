require 'singleton'

class Piece
  attr_reader :type, :color
  def initialize(pos, board, color)
    @board = board
    @color = color
    @pos = pos
  end

  def inspect
    @type
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @type = "   "
  end
end

class Queen < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
    @type = " ♛ "
  end
end

class King < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
    @type = " ♚ "
  end
end

class Rook < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
    @type = " ♜ "
  end
end

class Bishop < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
    @type = " ♝ "
  end
end

class Knight < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
    @type = " ♞ "
  end
end

class Pawn < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
    @type = " ♟ "
  end
end
