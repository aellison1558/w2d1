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

  def prompt_check
    if @board.in_check?(:white)
      puts "White in check"
    elsif @board.in_check?(:black)
      puts "Black in check"
    end
  end

  def colors_for(i, j, color = nil)
    mode = nil
    if [i, j] == @cursor_pos
      bg = :light_red
      mode = :blink
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
    { background: bg, color: text_color, mode: mode }
  end

  def cursor_input
    input = nil
    until input
      system("clear")
      render
      prompt_check
      puts "Make a move"
      input = get_input
    end
    input
  end

  def finish_message
    system("clear")
    render
    if @board.check_mate?(:black)
      puts "White wins!"
    elsif @board.check_mate?(:white)
      puts "Black wins!"
    elsif @board.stalemate?
      puts "Stalemate!"
    end
  end


end
