require_relative 'display'

class HumanPlayer
  attr_reader :display

  def initialize(name, board, color)
    @name = name
    @display = Display.new(board)
    @color = color
    @board = board
  end

  def move_piece
    begin
      start = @display.cursor_input
      until !@board[start].nil? && @board[start].color == @color
        start = @display.cursor_input
      end
      end_pos = @display.cursor_input
      raise InvalidInputError unless @board.valid_move?(start, end_pos)
    rescue InvalidInputError
    retry
    end
    @board.move(start, end_pos)
  end
end

class ComputerPlayer < HumanPlayer

  def move_piece
    system("clear")
    @display.render
    pieces = @board.grid.flatten.reject { |tile| tile.nil? || tile.color != @color }
    piece = pieces.sample
    move = piece.moves.sample
    until @board.valid_move?(piece.position, move)
      piece = pieces.sample
      move = piece.moves.sample
    end
    @board.move(piece.position, move)
    sleep(1)
  end
end
