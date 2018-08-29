require_relative 'Piece.rb'
require 'byebug'

class Board
  attr_accessor :grid, :sentinel

  def initialize
    @grid = Array.new(8) { Array.new(8) {@sentinel}}
    @sentinel = NullPiece.instance
    self.populate
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

  def tile_color(pos)
    if pos[0].even? && pos[-1].even? || pos[0].odd? && pos[-1].odd?
      :red
    elsif pos[0].odd? && pos[-1].even? || pos[0].even? && pos[-1].odd?
      :light_black
    end
  end

  def populate
    @grid.each_with_index do |row, idx|
      row.each_index do |idx2|
        case idx
        when 0
          case idx2
          when 0, 7
            self[[idx,idx2]] = Rook.new([idx, idx2], self, :black)
          when 1, 6
            self[[idx,idx2]] = Knight.new([idx, idx2], self, :black)
          when 2, 5
            self[[idx,idx2]] = Bishop.new([idx, idx2], self, :black)
          when 3
            self[[idx,idx2]] = Queen.new([idx, idx2], self, :black)
          when 4
            self[[idx,idx2]] = King.new([idx, idx2], self, :black)
          end
        when 1
          self[[idx,idx2]] = Pawn.new([idx, idx2], self, :black)
        when 2, 3, 4, 5
          self[[idx,idx2]] = @sentinel
        when 6
          self[[idx,idx2]] = Pawn.new([idx, idx2], self, :white)
        when 7
          case idx2
          when 0, 7
            self[[idx,idx2]] = Rook.new([idx, idx2], self, :white)
          when 1, 6
            self[[idx,idx2]] = Knight.new([idx, idx2], self, :white)
          when 2, 5
            self[[idx,idx2]] = Bishop.new([idx, idx2], self, :white)
          when 3
            self[[idx,idx2]] = Queen.new([idx, idx2], self, :white)
          when 4
            self[[idx,idx2]] = King.new([idx, idx2], self, :white)
          end
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    if valid_move?(start_pos, end_pos)
      piece = self[start_pos]
      self[start_pos] = @sentinel
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
      raise PieceError if empty_pos?(start_pos) || !valid_pos?(start_pos)
      raise PositionError unless valid_pos?(end_pos)
      raise MoveError unless empty_pos?(end_pos)
    rescue PositionError
      puts "End position is not valid; enter a valid move"
      return false
    rescue MoveError
      puts "End position is occupied by a #{self[end_pos]}; enter a valid move"
      return false
    rescue PieceError
      puts "There is no piece at that start position; enter a valid move"
      return false
    rescue
    end
    true
  end

end

class PositionError < StandardError; end
class MoveError <StandardError; end
class PieceError < StandardError; end
