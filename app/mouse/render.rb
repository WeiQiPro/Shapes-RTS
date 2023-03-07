def render_backgroud(args)
  args.outputs.sprites << {x: 0, y: 0, w: 1280, h: 720, r: 0, g: 0, b: 0}
end

def render_mouse(args)
  render_friendly_units(args)
  render_selected_unit_highlight(args)
  render_mouse_controls(args)
end

def render_mouse_controls(args)
  if args.state.left_button
    selector = {
      x: args.state.selector.beginning.x,
      y: args.state.selector.beginning.y,
      w: args.state.selector.ending.x - args.state.selector.beginning.x,
      h: args.state.selector.ending.y - args.state.selector.beginning.y,
      r: 175,
      g: 225,
      b: 175,
      a: 75
    }

    args.outputs.sprites << selector
    args.outputs.borders << [selector, selector, selector]
  end
end

def render_friendly_units(args)
  args.state.friendly_units.each do |unit|
    args.outputs.sprites << unit.hash
  end
end

def render_selected_unit_highlight(args)
  args.state.selected_units.each do |unit|
    args.outputs.borders << {x: unit.hash.x, y: unit.hash.y, w: unit.hash.w, h: unit.hash.h, r: 255, g: 255, b: 255}
    args.outputs.borders << {x: unit.hash.x, y: unit.hash.y, w: unit.hash.w, h: unit.hash.h, r: 255, g: 255, b: 255}
  end
end
