require 'colorize'
require_relative 'Board.rb'
require_relative 'Cursor.rb'

class Display
  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
  end 
  
  def render
    
  end
end