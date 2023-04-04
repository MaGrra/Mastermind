# frozen_string_literal: true
require 'colorize'

class Sequence
  attr_reader :code

  def initialize
    @code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end
end

class Game
  attr_accessor :rounds, :move
  attr_reader :computer

  def initialize
    @rounds = 1
    @move = []
    @computer = []
  end

  def play_guesser
    puts "Enter the code!"11
    players_guess
    loop do
      sleep(1)
      @computer = Sequence.new
      puts "Computers first guess! #{computer.code}}"
      @rounds += 1
      if rounds > 12
        puts "AI failed lol"
        break
      elsif code_solved? == true
        break
    end
  end
  end


  def play_breaker
    @computer = Sequence.new
    puts "This is a game of mastermind!"
    loop do 
    puts "\nGuess number:#{@rounds}\n\n"
    players_guess
    correct_match(move)
    p computer.code
    @rounds += 1
    if code_solved? == true 
      break
    elsif rounds > 12
      sleep(1)
      puts "You lost :("
      break
    end
    end
  end

  def players_guess
    @move = gets.strip.split('')
    @move.map!(&:to_i)
    valid_move?
  end

  def valid_move?
    return @move if @move.length == 4 && @move.all? { |number| number.positive? && number < 7 }

    puts 'Code must be 4 digits long with numbers 1 - 6'
    players_guess
  end
end


  

  def correct_match(move)
    used_index = computer.code.map(&:clone)
    move.each_with_index do  |number, index|
    if computer.code[index] == number
      puts "Spot on"
      used_index.delete_at(used_index.index(number) || used_index.length)
    end

    
    end
    second_stage(used_index)
  end

  def second_stage(used_index)
    move.each_with_index do | number, index|
    if used_index.include?(number)
      used_index.delete_at(used_index.index(number) || used_index.length)
      puts "Almost"
    end
  end


    
end

  def code_solved?

    if computer.code == move
      puts "You did it, the code was #{computer.code}"
      true
    end
  end

def game_choice
  
  puts "Press 1 if you want to guess the code OR 2 to make computer do it"
  choice = gets.to_i
  if choice == 1
    Game.new.play_breaker
  elsif choice == 2
    Game.new.play_guesser
  else 
    "Please select one of the valid choices"
    game_choice
end
end

game_choice
