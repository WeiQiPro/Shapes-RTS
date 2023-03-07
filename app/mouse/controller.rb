class Mouse_Controller
  attr_accessor

  def update(args)
    left_button_pressed(args)
    right_button_pressed(args)
  end

  def left_button_pressed(args)
    if args.inputs.mouse.button_left
      args.state.left_button = true
      args.state.selector.beginning ||= {x: args.inputs.mouse.x, y: args.inputs.mouse.y}
      args.state.selector.ending = {x: args.inputs.mouse.x, y: args.inputs.mouse.y}
      args.state.selector.collision = {
        x: args.state.selector.beginning.x + (((args.state.selector.ending.x) - args.state.selector.beginning.x) < 0 ? ((args.state.selector.ending.x) - args.state.selector.beginning.x) : 0),
        y: args.state.selector.beginning.y + (((args.state.selector.ending.y) - args.state.selector.beginning.y) < 0 ? ((args.state.selector.ending.y) - args.state.selector.beginning.y) : 0),
        w: ((args.state.selector.ending.x) - args.state.selector.beginning.x).abs,
        h: ((args.state.selector.ending.y) - args.state.selector.beginning.y).abs
      }
    end

    if args.inputs.mouse.up && !args.inputs.keyboard.key_down.shift
      args.state.left_button = false
      args.state.selector.beginning = nil
      args.state.selector.ending = nil
    end
  end

  def right_button_pressed(args)
    if args.inputs.mouse.button_right
      args.state.right_button = true
      args.state.selector.destination ||= {x: args.inputs.mouse.x, y: args.inputs.mouse.y}
      send_commands(args)
    end

    if args.inputs.mouse.up
      args.state.right_button = false
      args.state.selector.destination = nil
      args.state.unit_command = nil
    end
  end

  def send_commands(args)

    case args.state.selected_type

    when :unit

      destination = args.state.selector.destination
      if args.state.unit_command.nil?
        command = :move
      else
        command = args.state.unit_command
      end

      args.state.selected_units.each do |unit|
        if args.inputs.keyboard.key_held.shift
          unit.destination << destination
        else
          unit.destination[0] = destination
        end
        unit.commands.unshift(command)
      end
    when :building
      args.state.selected_building.each do |building|
        building.update(args.state.selector.destination, args.state.building_command)
      end
    end
  end
end
