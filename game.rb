# frozen_string_literal: true

require 'colorize'
module Colors
  def code_colors(number)
    {
      1 => "\e[101m  1  \e[0m ",
      2 => "\e[43m  2  \e[0m ",
      3 => "\e[44m  3  \e[0m ",
      4 => "\e[45m  4  \e[0m ",
      5 => "\e[46m  5  \e[0m ",
      6 => "\e[41m  6  \e[0m ",
    }[number]
  end
  
  def show_code(move)
    move.each do |num|
      
      print code_colors num
    end
  end

class Sequence
  include Colors

  attr_reader :code

  def initialize
    @code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end
end
end

class Game
  include Colors

  attr_accessor :rounds, :move
  attr_reader :computer

  def initialize
    @rounds = 1
    @move = []
    @computer = []
  end
#If player is guessing the code#
  def play_guesser
    puts 'Enter the code!'.black.on_green
    players_guess
    loop do
      sleep(1)
      @computer = Sequence.new
      puts "Computers first guess! #{show_code(computer.code)}}"
      @rounds += 1
      if rounds > 12
        puts 'AI failed lol'
        break
      elsif code_solved? == true
        break
      end
    end
  end
#Computer randomly guesses code#
  def play_breaker
    @computer = Sequence.new
    puts 'This is a game of mastermind!'
    loop do
      puts "\nGuess number:#{@rounds}\n\n"
      players_guess
      show_code(move)
      correct_match(move)
      @rounds += 1
      if code_solved? == true
        break
      elsif rounds > 12
        sleep(1)
        puts "\nYou lost :("
        puts "The code was #{show_code(computer.code)}"
        break
      end
    end
  end

  def players_guess
    @move = gets.strip.split('')
    @move.map!(&:to_i)
    valid_move?
  end
#check if input is 4.length number 1-6#
  def valid_move?
    return @move if @move.length == 4 && @move.all? { |number| number.positive? && number < 7 }
    puts 'Code must be 4 digits long with numbers 1 - 6'
    players_guess
  end
end
#checks what matches#
def correct_match(move)
  used_index = computer.code.map(&:clone)
  move.each_with_index do |number, index|
    if computer.code[index] == number
      print ' Perfect '.bold.on_green
      print "|"
      used_index.delete_at(used_index.index(number) || used_index.length)
    end
  end
  second_stage(used_index)
end
#checks non exact match#
def second_stage(used_index)
  move.each_with_index do |number, _index|
    if used_index.include?(number)
      used_index.delete_at(used_index.index(number) || used_index.length)
      print ' Almost '.on_green
      print "|"
    end
  end
end

def code_solved?
  return unless computer.code == move
  puts "\nYou did it, the code was #{show_code(computer.code)}"
  true
end

def game_choice
  puts 'Press 1 if you want to guess the code OR 2 to make computer do it'
  choice = gets.to_i
  if choice == 1
    Game.new.play_breaker
  elsif choice == 2
    Game.new.play_guesser
  else
    'Please select one of the valid choices'
    game_choice
  end
end

game_choice