class KnightPiece < SteppingPiece

  def moves
    super(KNIGHT_VECTORS)
  end

  def to_s
    "♞"
  end
end
