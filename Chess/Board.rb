require_relative 'Piece.rb'
require 'byebug'

class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) {NullPiece.instance}}
  end
  
  def parse(position)
    [position[0].to_i, position[-1].to_i]
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  
  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end
  
  def populate
    @grid.each_with_index do |row, idx|
      row.each_index do |idx2|
        if idx < 2 || idx > 5
          self[[idx,idx2]] = Piece.new 
        else 
          self[[idx,idx2]] = NullPiece.instance
        end
      end
    end
  end
  
  def move_piece(start_pos, end_pos)
    if valid_move?(start_pos, end_pos)
      piece = self[start_pos]
      self[start_pos] = NullPiece.instance
      self[end_pos] = piece
    else
      move_piece(parse(gets.chomp),parse(gets.chomp))
    end
    self 
  end
  
  def valid_pos?(pos)
    x, y = pos
    x >= 0 && x < 8 && y >= 0 && y < 8
  end
  
  def empty_pos?(pos)
    if valid_pos?(pos)
      self[pos].is_a?(NullPiece)
    end
  end
  
  def valid_move?(start_pos, end_pos)
    begin
      # debugger
      raise PieceError if empty_pos?(start_pos) || !valid_pos?(start_pos)
      raise PositionError unless valid_pos?(end_pos)
      raise MoveError unless empty_pos?(end_pos)
    rescue PositionError
      puts "End position is not valid; enter a valid move"
      # end_pos = parse(gets.chomp)
      return false
      # move_piece(start_pos, end_pos)
      # retry
    rescue MoveError
      puts "End position is occupied by a #{self[end_pos]}; enter a valid move"
      # end_pos = parse(gets.chomp)
      return false
      # move_piece(start_pos, end_pos)
      # retry
    rescue PieceError
      # debugger
      puts "There is no piece at that start position; enter a valid move"
      # start_pos = parse(gets.chomp)
      return false
      # move_piece(start_pos, end_pos)
      # retry
    rescue
    end
    true
  end
  
end

class PositionError < StandardError; end
class MoveError <StandardError; end
class PieceError < StandardError; end