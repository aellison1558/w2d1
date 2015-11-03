
class RookPiece < SlidingPiece
  def moves
    super(STRAIGHT_VECTORS)
  end

  def to_s
     "♜"
  end
end
