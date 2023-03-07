def mouse_selection_collision(args)
  selected_units = []

  if args.state.left_button
    args.state.friendly_units.each do |unit|
      unit_rect = {x: unit.hash.x, y: unit.hash.y, w: unit.hash.w, h: unit.hash.h}
      if args.geometry.intersect_rect?(args.state.selector.collision, unit_rect)
        selected_units << unit
      end
      if args.geometry.intersect_rect?(unit_rect, args.state.selector.collision)
        selected_units << unit
      end
      if args.geometry.inside_rect?(args.state.selector.collision, unit_rect)
          selected_units << unit
      end
      if args.geometry.inside_rect?(unit_rect, args.state.selector.collision)
        selected_units << unit
      end
    end

    if selected_units.any? { |unit| unit.unit == true }
      args.state.selected_type = :unit
      args.state.selected_units = selected_units.select { |unit| unit.unit == true }
      args.state.selected_units.reject! { |unit| unit.unit == false }
    else
      args.state.selected_units = []
    end
  end
end
