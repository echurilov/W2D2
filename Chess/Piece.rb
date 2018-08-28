require 'singleton'

class Piece
  attr_reader :type
  def initialize
    @type = "Queen"
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @type = nil
  end
end