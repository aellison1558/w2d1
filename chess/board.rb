class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    place_pieces(:black, grid[0])
    place_pawns(:black, grid[1])
    place_pawns(:white, grid[6])
    place_pieces(:white, grid[7])
  end

  def place_pawns(color, row)
    #refactor to pass a position to Pawn
    row.each_index do |i|
      row[i] = Pawn.new(color)
    end
  end

  def place_pieces(color, row)
    #refactor to pass a position to new pieces
    pieces = [Rook.new(color), Knight.new(color), Bishop.new(color)]
    royalty = [Queen.new(color), King.new(color)]
    pieces = pieces + royalty + pieces.reverse
    row.each_index do |i|
      row[i] = pieces.shift
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
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

end
