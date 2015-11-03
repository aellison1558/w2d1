require 'byebug'
class Piece

  DIAGONAL_VECTORS = [[1, 1],[1, -1],[-1, -1],[-1, 1]]
  STRAIGHT_VECTORS = [[1, 0], [0, -1], [-1, 0], [0, 1]]
  KNIGHT_VECTORS = [[2, 1], [2, -1], [-2, 1], [-2, -1],
                    [1, 2], [1, -2], [-1, 2], [-1, -2]]

  attr_accessor :position
  attr_reader :board, :position, :color

  def initialize(color, pos = nil, board = nil)
    @color, @position, @board = color, pos, board
  end

  def vector_add(arr1, arr2)
    arr1.zip(arr2).map { |arr3| arr3.inject(:+) }
  end
end
