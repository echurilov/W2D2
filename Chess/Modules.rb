module Slideable
  HORIZONTAL_DIRS = [[-1,0],[1,0]]
  VERTICAL_DIRS = [[0,-1],[0,1]]
  DIAGONAL_DIRS = [[-1,-1],[1,1],[1,-1],[-1,1]]

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def vertical_dirs
    VERTICAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

private

  def moves
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    while @board.valid_move?
      []
    end
  end
end

module Stepable
  def moves
  end
end
