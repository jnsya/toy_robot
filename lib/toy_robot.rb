require_relative '../lib/toy_robot/board'
require_relative '../lib/toy_robot/robot'
require 'pry'

module ToyRobot
  class Application

    def initialize
      @board = ToyRobot::Board.new([5,5])
    end

    def new_round
      loop do
        input = elicit_input
        input = convert_input(input)
        # binding.pry
        if !is_input_valid?(input)
          puts 'Please make a valid move!'
          redo
        end
        make_move(input)
      end
    end

    def is_input_valid?(input)
      command = input[:command]
      possible_commands = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]
      return false unless possible_commands.include?(command)
      return false if !@robot && command != "PLACE"
      return false if command == "PLACE" && !@board.valid_location?(input[:location])
      return false if command == "MOVE" && !@board.valid_move?(@robot.location, @robot.facing)
      true
    end

    def make_move(input)
      case input[:command]
        when "PLACE"
          @robot = ToyRobot::Robot.new(input[:location], input[:facing])
        when "MOVE"
          new_location = @board.location_after_move(@robot.location, @robot.facing)
          @robot.move_to(new_location)
        when "LEFT"
          @robot.turn("LEFT")
        when "RIGHT"
          @robot.turn("RIGHT")
        when "REPORT"
          puts "\n#{@robot.location[0]},#{@robot.location[1]},#{@robot.facing}\n"
      end
    end

    def convert_input(input)
      input = input.split(/[\s^,]+/)
      input = { command: input[0],
                location: [input[1].to_i, input[2].to_i],
                facing: input[3]
              }
    end

    def elicit_input
      puts "\n\nChoose:\nPLACE X,Y,F (e.g. 'PLACE 0,3,NORTH')\nMOVE\nLEFT\nRIGHT\nREPORT\n\n"
      gets.chomp
    end
  end
end

app = ToyRobot::Application.new
app.new_round
