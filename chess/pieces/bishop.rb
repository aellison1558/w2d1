
class BishopPiece < SlidingPiece
  def moves
    super(DIAGONAL_VECTORS)
  end

  def to_s
    "♝"
  end
end
