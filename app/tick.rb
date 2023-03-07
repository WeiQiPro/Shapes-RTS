def tick(args)
  render_backgroud(args)
  if args.tick_count.zero?
    args.state.mouse = Mouse_Controller.new
    args.state.keyboard = Keyboard_Controller.new
    args.state.friendly_units = create_units(10)
  end

  args.state.mouse.update(args)
  args.state.keyboard.update(args)
  mouse_selection_collision(args)
  render_mouse(args)
  debug?(args)
end

def debug?(args)
  args.state.friendly_units.each do |unit|
    unit.update()
  end

  if args.state.left_button
    args.outputs.labels << {x: 20, y: 720, text: "left mouse button pressed", r: 255, g: 255, b: 255}
    args.outputs.labels << {x: 20, y: 700, text: "Beginning: #{args.state.selector.beginning.x}, #{args.state.selector.beginning.y}", r: 255, g: 255, b: 255}
    args.outputs.labels << {x: 20, y: 680, text: "Ending:    #{args.state.selector.ending.x}, #{args.state.selector.ending.y}", r: 255, g: 255, b: 255}
  elsif args.state.right_button
    args.outputs.labels << {x: 20, y: 720, text: "right mouse button pressed", r: 255, g: 255, b: 255}
  end

  if args.state.unit_command != nil
    text_command = args.gtk.calcstringbox("command: #{args.state.unit_command.to_s}")
    args.outputs.labels << {x: 640 - text_command[0]/2, y: 720 - text_command[1]/2, text: "command: #{args.state.unit_command.to_s}", r: 255, g: 255, b: 255}
  end
end

def create_units(number)
  srand(Time.now.to_i)
  units = []
  number.times do
    unit_types = [:triangle, :square, :circle, :hexagon]
    unit_type = unit_types.sample

    unit = true

    w = rand(60) + 20
    h = w
    x = rand(1220) + w/2
    y = rand(640) + w/2

    basic_colors = ["red", "orange", "yellow", "green", "blue", "indigo"]
    color = basic_colors.sample

    path = "sprites/#{unit_type}/#{color}.png"
    hash = {x: x, y: y, w: w, h: h, path: path}

    units << Unit.new(type: unit_type, unit: unit, hash: hash)
  end
  units
end
