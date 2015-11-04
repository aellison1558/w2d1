require 'byebug'
class Piece

  DIAGONAL_VECTORS = [[1, 1],[1, -1],[-1, -1],[-1, 1]]
  STRAIGHT_VECTORS = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  attr_accessor :position
  attr_reader :board, :position, :color

  def initialize(color, pos = nil, board = nil)
    @color, @position, @board = color, pos, board
  end

  def vector_add(arr1, arr2)
    arr1.zip(arr2).map { |arr3| arr3.inject(:+) }
  end

  def enemy?(occupied_position)
   @board[occupied_position].color != self.color
  end

  def piece_dup(clone_board)
    clone = self.class.new(self.color, self.position, clone_board)
    clone
  end
end
