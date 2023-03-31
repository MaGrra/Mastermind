# frozen_string_literal: true

class Sequence
    attr_reader :code
  def initialize
    @code = [rand(6), rand(6), rand(6), rand(6)]
  end
end

class Game
attr_reader :rounds, :computer
attr_writer :rounds
  def initialize
    @rounds = 1
    @computer = Sequence.new
  end

  def play
    puts "Guess number:#{@rounds}"
    players_guess(rounds)
  end

  def players_guess(rounds)
    move = gets
    valid_move?(move)
    rounds += 1
  end

  def valid_move?(move)
    move = move.strip.split("")
    if move.length == computer.code.length && move.all? { |number| number.to_i > 0 && number.to_i < 7 }
        return move
    else 
        puts "Code must be 4 digits long with numbers 1 - 6"
        players_guess(rounds)
    end
    
  end

end

Game.new.play