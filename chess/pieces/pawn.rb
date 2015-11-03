class PawnPiece < Piece
  attr_accessor :first_move
  WHITE_VECTORS = [[-2, 0], [-1, 0]]
  WHITE_ATTACK = [[-1, 1], [-1, -1]]
  BLACK_VECTORS = [[2, 0], [1, 0]]
  BLACK_ATTACK = [[1, 1], [1, -1]]
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
    possible_moves.select! { |move| board.unoccupied?(move) }
    possible_moves += attack_moves
    possible_moves
  end

  def attack_moves
    @color == :white ? vectors = WHITE_ATTACK : vectors = BLACK_ATTACK
    moves = []
    vectors.each do |vector|
      moves << vector_add(@position, vector)
    end
    moves.select! { |move| board.in_bounds?(move) && !board.unoccupied?(move) }
    moves.select { |move| enemy?(move) }
  end

  def to_s
    "♟"
  end

  def piece_dup(clone_board)
    clone = self.class.new(self.color, self.position, clone_board)
    clone.first_move = self.first_move
    clone
  end
end
