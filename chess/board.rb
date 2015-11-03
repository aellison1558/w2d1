require_relative 'piece'
class Board
  attr_accessor :grid
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    place_pieces(:black, grid[0], 0)
    place_pawns(:black, grid[1], 1)
    place_pawns(:white, grid[6], 6)
    place_pieces(:white, grid[7], 7)
  end

  def place_pawns(color, row, row_index)
    #refactor to pass a position to Pawn
    row.each_index do |i|
      row[i] = PawnPiece.new(color, [row_index, i], self)
    end
  end

  def place_pieces(color, row, row_index)
    #refactor to pass a position to new pieces
    pieces = [RookPiece.new(color, nil, self), KnightPiece.new(color, nil, self), BishopPiece.new(color, nil, self)]
    royalty = [QueenPiece.new(color, nil, self), KingPiece.new(color, nil, self)]
    pieces = pieces + royalty + pieces.reverse
    row.each_index do |i|
      row[i] = pieces.shift
      row[i].position = [row_index, i]
    end
  end

  def move(start, end_pos)
    # Can put these either here or wherever we get user input
    # raise "No piece at start position" if self[start].nil?
    # raise error if can't move to end_pos
    piece = self[start]
    self[end_pos] = piece
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def in_bounds?(pos)
    pos.none? {|coordinate| coordinate < 0 || coordinate > 7}
  end

  def unoccupied?(pos)
    self[pos].nil?
  end

end
