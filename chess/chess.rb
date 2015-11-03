require_relative 'display'
require_relative 'board'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @current_player = :white
  end

  def get_our_input
    input = nil
    until input
      system("clear")
      @display.render
      prompt_check
      input = @display.cursor_input
    end
    input
  end

  def prompt_check
    if @board.in_check?(:white)
      puts "White in check"
    elsif @board.in_check?(:black)
      puts "Black in check"
    end
  end

  def play
    until @board.check_mate?(:black) || @board.check_mate?(:white)
      play_turn
      switch_players
    end
    finish_message
  end

  def play_turn
    begin
      start = get_our_input
      until !@board[start].nil? && @board[start].color == @current_player
        puts "Please select a piece to move"
        start = get_our_input
      end
      end_pos = get_our_input
      raise InvalidInputError unless @board.valid_move?(start, end_pos)
    rescue
    retry
    end
    @board.move(start, end_pos)
  end

  def switch_players
    @current_player = (@current_player == :white ? :black : :white)
  end

  def finish_message
    system("clear")
    @display.render
    if @board.check_mate?(:black)
      puts "White wins!"
    elsif @board.check_mate?(:white)
      puts "Black wins!"
    end
  end
end

Game.new.play
