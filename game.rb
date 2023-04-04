# frozen_string_literal: true

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
    @computer = Sequence.new
    @move = []
  end

  def play
    puts "This is a game of mastermind!"
    loop do 
    puts "\nGuess number:#{@rounds}\n\n"
    p @computer.code
    players_guess
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
    match?(move)
  end

  def valid_move?
    return @move if @move.length == computer.code.length && @move.all? { |number| number.positive? && number < 7 }

    puts 'Code must be 4 digits long with numbers 1 - 6'
    players_guess
  end
end

  def match?(move)
      correct_match(move)
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


Game.new.play
