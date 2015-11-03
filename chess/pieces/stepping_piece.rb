
class SteppingPiece < Piece

  def moves(directions)
    moves = []
    directions.each do |vector|
      next_position = vector_add(@position, vector)
      moves << next_position if board.in_bounds?(next_position)
    end
    moves.select! { |move| board.unoccupied?(move) || enemy?(move) }
    moves
  end
end
