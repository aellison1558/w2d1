class SlidingPiece < Piece

  def moves(move_dirs)
    possible_moves = []
    move_dirs.each do |vector|
      path = follow_vector(vector)
      possible_moves += path
    end
    possible_moves
  end

  # def move_dirs
  #   raise NotImplemetedError, "you need to implement move_dirs"
  # end

  def follow_vector(vector)
    path = []
    next_position = vector_add(@position, vector)
    while board.in_bounds?(next_position)
      if board.unoccupied?(next_position)
        path << next_position
        next_position = vector_add(next_position, vector)
      else
        path << next_position if enemy?(next_position)
        break
      end
    end
    path
  end
end
