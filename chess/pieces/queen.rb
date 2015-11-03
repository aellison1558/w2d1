class QueenPiece < SlidingPiece
  def moves
    super(DIAGONAL_VECTORS + STRAIGHT_VECTORS)
  end

  def to_s
    "♛"
  end
end
