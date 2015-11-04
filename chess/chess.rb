require_relative 'display'
require_relative 'board'
require_relative 'players'

class Game

  def initialize(player1, player2, board)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = @player1
  end

  def play
    until @board.check_mate?(:black) || @board.check_mate?(:white)
      move_piece
      switch_players
    end
    @current_player.display.finish_message
  end

  def move_piece
    @current_player.move_piece
  end

  def switch_players
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end


end

class InvalidInputError < StandardError
end

board = Board.new
player1 = HumanPlayer.new("Marek", board, :white)
player2 = HumanPlayer.new("Andrew", board, :black)
player3 = ComputerPlayer.new("Droid1", board, :white)
player4 = ComputerPlayer.new("Droid2", board, :black)
game = Game.new(player3, player4, board)
game.play
