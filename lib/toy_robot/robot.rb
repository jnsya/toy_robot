
module ToyRobot
  class Robot
    attr_reader :location, :facing

    def initialize(location, facing)
      @location, @facing = location, facing
    end

    def turn(left_or_right)
      turn_left = { "NORTH" => "WEST", "WEST" => "SOUTH", "SOUTH" => "EAST", "EAST" => "NORTH" }
      turn_right = { "NORTH" => "EAST", "EAST" => "SOUTH", "SOUTH" => "WEST", "WEST" => "NORTH" }
      @facing = (left_or_right == "left") ? turn_left[@facing] : turn_right[@facing]
    end
  end
end
