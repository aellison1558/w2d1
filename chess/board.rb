class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    place_pieces(black, grid[0])
    place_pawns(black, grid[1])
    place_pawns(white, grid[6])
    place_pieces(white, grid[7])
  end

  def place_pawns(color, row)
    row.each_index do |i|
      row[i] = Piece.new(pawn, color)
    end
  end

  def place_pieces(color, row)
  end
end
