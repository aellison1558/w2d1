require_relative 'piece'
require 'byebug'
class Board
  attr_accessor :grid
  attr_reader :grid

  def initialize(clone = false)
    @grid = Array.new(8) { Array.new(8) }
    populate unless clone
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
    piece = self[start]
    if piece.moves.include?(end_pos)
      unless next_move_in_check?(start, end_pos, self[start].color)
        update_pos(start, end_pos)
        self[end_pos] = piece
        self[start] = nil
      end
    end
  end

  def move!(start, end_pos)
    piece = self[start]
    if piece.moves.include?(end_pos)
      update_pos(start, end_pos)
      self[end_pos] = piece
      self[start] = nil
    end
  end

  def update_pos(start, end_pos)
    self[start].position = end_pos
    if self[start].is_a?(PawnPiece)
      self[start].first_move = false
    end
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


  def next_move_in_check?(start, end_pos, color)
    board_clone = self.board_dup
    board_clone.move!(start, end_pos)
    board_clone.in_check?(color)
  end

  def board_dup
    board_clone = Board.new(true)
    grid_clone = self.grid.map do |row|
      row.map { |tile| tile.is_a?(Piece) ? tile.piece_dup(board_clone) : tile }
    end
    board_clone.grid = grid_clone
    board_clone
  end

  def in_check?(color)
    pieces = grid.flatten.reject { |tile| tile.nil? }
    king = pieces.select { |piece| piece.is_a?(KingPiece) && piece.color == color }
    king = king.first #otherwise king is in a one element array
    enemies = pieces.select { |piece| piece.color != color }
    enemies.each do |piece|
      return true if piece.moves.include?(king.position)
    end
    false
  end

  def check_mate?(color)
    pieces = grid.flatten.reject { |tile| tile.nil? }
    pieces.select! { |piece| piece.color == color }
    pieces.each do |piece|
      piece.moves.each do |move|
        return false unless next_move_in_check?(piece.position, move, color)
      end
    end
    true
  end



end
