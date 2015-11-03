require_relative 'board'
require 'colorize'
require_relative 'cursorable'

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
          print "#{col.to_s} ".colorize(colors_for(row_index, col_index))
        else
          print "  ".colorize(colors_for(row_index, col_index))
        end
      end
      puts ""
    end
    ""
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg, color: :white }
  end

  def cursor_input
    # input = nil
    # until input
      input = get_input
    # end
    # input
  end

  def the_game
    input = nil
    until input
      system("clear")
      render
      input = cursor_input
    end
    input
  end
end
