class Unit
  attr_accessor :unit, :type, :destination, :commands, :hash

  def initialize(type:, unit:, hash:)
    @unit = unit # true or false
    @type = type # a shape [:triangle, :square, :circle, :hexagon]
    @hash = hash # contains the x, y, w, h, path: "sprites/#{type}/color.png"
    @destination = []
    @commands = []
    @action = nil
    @speed = rand(20) + 5
  end

  def update()
    if @commands.first == :stop || @commands.first == :hold
      @commands.clear
      @destination.clear
      @action = nil
    end

    if @commands.any?
      @action = @commands.first
    end

    case @action
    when :move
      move_self() if @destination[0] != nil
    when :stop
    when :hold
    when :attack
    end
  end

  def move_self()
    # Calculate the x and y distances to the destination
    x_diff = @destination[0][:x] - @hash[:x] - @hash[:w] / 2
    y_diff = @destination[0][:y] - @hash[:y] - @hash[:h] / 2

    # Calculate the total distance to the destination using Pythagorean theorem
    total_distance = Math.sqrt(x_diff ** 2 + y_diff ** 2)
    # Check if the unit has arrived at the destination
    if total_distance <= rand(10) + 4 + @hash.w/(rand(4)+2)
      # Remove the destination from the @destination array
      @action = nil
      @destination.shift
      @commands.shift
      return
    else
      # Normalize the x and y distances to get a unit vector
      x_unit = x_diff / total_distance
      y_unit = y_diff / total_distance

      # Move the unit by a certain amount each tick, based on its speed
      x_move = x_unit * @speed
      y_move = y_unit * @speed

      # Update the unit's position in the hash
      @hash[:x] += x_move
      @hash[:y] += y_move
    end
  end

end
