class SlidingPiece < Piece

  def moves(directions)
    possible_moves = []
    directions.each do |vector|
      path = follow_vector(vector)
      possible_moves += path
    end
    possible_moves
  end

  def follow_vector(vector)
    path = []
    next_position = vector_add(@position, vector)
    while board.in_bounds?(next_position)
      if board.unoccupied?(next_position)
        path << next_position
        next_position = vector_add(next_position, vector)
      else
        break
      end
    end
    path
  end
end
