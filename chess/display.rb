require_relative 'board'
require 'colorize'
require_relative 'cursorable'
require 'byebug'

class Display
  include Cursorable
  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def render
    puts "  #{(0..7).to_a.join(" ")}"
    @board.grid.each_with_index do |row, row_index|
      print row_index
      row.each_with_index do |col, col_index|
        if col
          print "#{col.to_s} ".colorize(colors_for(row_index, col_index, col.color))
        else
          print "  ".colorize(colors_for(row_index, col_index))
        end
      end
      puts ""
    end
    ""
  end

  def colors_for(i, j, color = nil)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_yellow
    else
      bg = :magenta
    end

    if color == :white
      text_color = :white
    elsif color == :black
      text_color = :black
    end
    { background: bg, color: text_color }
  end

  def cursor_input
      input = get_input
  end

  def get_our_input
    input = nil
    until input
      system("clear")
      render
      input = cursor_input
    end
    input
  end

  def the_game
    until @board.check_mate?(:black)
      if @board.in_check?(:white)
        puts "White in check"
      elsif @board.in_check?(:black)
        puts "Black in check"
      end
      start = get_our_input
      until @board[start]
        start = get_our_input
      end
      end_pos = get_our_input
      @board.move(start, end_pos)
    end
  end
end

b = Board.new
dsp = Display.new(b)
dsp.the_game
