class PawnPiece < Piece
  attr_accessor :first_move
  WHITE_VECTORS = [[-2, 0], [-1, 0]]
  BLACK_VECTORS = [[2, 0], [1, 0]]
  def initialize(color, pos = nil, board = nil)
    @first_move = true
    super
  end

  def moves
    @color == :white ? vectors = WHITE_VECTORS : vectors = BLACK_VECTORS
    moves = []
    if @first_move
      vectors.each do |vector|
        moves << vector_add(@position, vector)
      end
    else
      moves << vector_add(@position, vectors.last)
    end
    possible_moves = moves.select { |move| board.in_bounds?(move) }
    possible_moves.select { |move| board.unoccupied?(move) }
  end

  def to_s
    "♟"
  end
end
