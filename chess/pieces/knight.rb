class KnightPiece < SteppingPiece

  def moves
    super(KNIGHT_VECTORS)
  end

  def move_dirs
    [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
  end

  def to_s
    "♞"
  end
end
