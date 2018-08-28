require 'singleton'

class Piece
  attr_reader :type
  def initialize
    @type = "Q"
  end
  
  def inspect
    @type
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @type = "_"
  end
end