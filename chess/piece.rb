require 'byebug'
class Piece

  DIAGONAL_VECTORS = [[1, 1],[1, -1],[-1, -1],[-1, 1]]
  STRAIGHT_VECTORS = [[1, 0], [0, -1], [-1, 0], [0, 1]]
  KNIGHT_VECTORS = [[2, 1], [2, -1], [-2, 1], [-2, -1],
                    [1, 2], [1, -2], [-1, 2], [-1, -2]]

  attr_accessor :position
  attr_reader :board, :position

  def initialize(color, pos = nil, board = nil)
    @color, @position, @board = color, pos, board
  end

  def vector_add(arr1, arr2)
    arr1.zip(arr2).map { |arr3| arr3.inject(:+) }
  end
end

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

class SteppingPiece < Piece

  def moves(directions)
    moves = []
    directions.each do |vector|
      next_position = vector_add(@position, vector)
      moves << next_position if board.in_bounds?(next_position)
    end
    moves.select { |move| board.unoccupied?(move) }
  end
end

class RookPiece < SlidingPiece
  def moves
    super(STRAIGHT_VECTORS)
  end

  def to_s
    @color == :white ? "♖" : "♜"
  end
end

class KnightPiece < SteppingPiece

  def moves
    super(KNIGHT_VECTORS)
  end

  def to_s
    @color == :white ? "♘" : "♞"
  end
end

class BishopPiece < SlidingPiece
  def moves
    super(DIAGONAL_VECTORS)
  end

  def to_s
    @color == :white ? "♗" : "♝"
  end
end

class QueenPiece < SlidingPiece
  def moves
    super(DIAGONAL_VECTORS + STRAIGHT_VECTORS)
  end

  def to_s
    @color == :white ? "♕" : "♛"
  end
end

class KingPiece < SteppingPiece
  def moves
    super(DIAGONAL_VECTORS + STRAIGHT_VECTORS)
  end

  def to_s
    @color == :white ? "♔" : "♚"
  end
end

class PawnPiece < Piece

  def to_s
    @color == :white ? "♙" : "♟"
  end
end
