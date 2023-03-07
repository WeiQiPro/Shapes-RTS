class Keyboard_Controller
  attr_accessor

  def update(args)
    case args.state.selected_type
    when :unit
      unit_command_inputs(args)
      control_groups_1_through_0(args)
    when :building
      building_command_inputs(args)
      control_groups_1_through_0(args)
    end

    control_group_inputs(args)
  end

  def unit_command_inputs(args)
    if args.inputs.keyboard.key_down.a
      args.state.unit_command = :attack
    elsif args.inputs.keyboard.key_down.s
      args.state.selected_units.each do |unit|
        unit.commands.unshift(:stop)
      end
    elsif args.inputs.keyboard.key_down.d
      args.state.selected_units.each do |unit|
        unit.commands.unshift(:hold)
      end
    elsif args.inputs.keyboard.key_down.escape
      puts "escape"
      args.state.selected_units = []
      args.state.selected_type = nil
      args.state.unit_command = nil
    end
  end


  def control_group_inputs(args)
    number_to_control_group = {
      zero: args.state.control_group_0,
      one: args.state.control_group_1,
      two: args.state.control_group_2,
      three: args.state.control_group_3,
      four: args.state.control_group_4,
      five: args.state.control_group_5,
      six: args.state.control_group_6,
      seven: args.state.control_group_7,
      eight: args.state.control_group_8,
      nine: args.state.control_group_9
    }

    number_to_control_group.each do |number, control_group|
      if args.inputs.keyboard.key_down.send(number) && control_group.any?
        args.state.selected_units = control_group
        if control_group[0]&.unit
          args.state.selected_type = :unit
        end
      end
    end
  end

  def control_groups_1_through_0(args)
    {
      zero: 0,
      one: 1,
      two: 2,
      three: 3,
      four: 4,
      five: 5,
      six: 6,
      seven: 7,
      eight: 8,
      nine: 9
    }.each do |key, i|
      control_group(args, key, i)
    end
  end

  def control_group(args, key, index)
    if args.inputs.keyboard.key_held.control && args.inputs.keyboard.key_down.send(key)
      args.state.send("control_group_#{index}=", args.state.selected_units[0..20])
    end
  end

end

# def control_group_inputs(args)
#   {
#     zero: 0, one: 1, two: 2, three: 3, four: 4,
#     five: 5, six: 6, seven: 7, eight: 8, nine: 9
#   }.each do |key, i|
#     control_group = "control_group_#{i}".to_sym
#     if args.inputs.keyboard.key_down.send(key.to_s)
#       args.state.selected_units = args.state.send(control_group)
#       if args.state.send(control_group)[0].unit
#         args.state.selected_type = :unit
#       end
#     end
#   end
# end

# def control_groups_1_through_0(args)
#   {
#     one: :one, two: :two, three: :three, four: :four, five: :five,
#     six: :six, seven: :seven, eight: :eight, nine: :nine, zero: :zero
#   }.each do |key, i|
#     control_group(args, i, key)
#   end
# end

# def control_group(args, index, key)
#   control_key = "control_#{index}".to_sym
#   if args.inputs.keyboard.key_held.send(control_key)
#     args.state.send("control_group_#{index}", args.state.selected_units[0..20])
#   end
# end



# def control_group_inputs(args)
#   if args.inputs.keyboard.key_down.one
#     args.state.selected_units = args.state.control_group_1
#     if args.state.control_group_1[0].unit
#       args.state.selected_type = :unit
#     end
#   end

#   if args.inputs.keyboard.key_down.two
#     args.state.selected_units = args.state.control_group_2
#     if args.state.control_group_2[0].unit
#       args.state.selected_type = :unit
#     end
#   end

#   if args.inputs.keyboard.key_down.three
#     args.state.selected_units = args.state.control_group_3
#     if args.state.control_group_3[0].unit
#       args.state.selected_type = :unit
#     end
#   end

#   if args.inputs.keyboard.key_down.four
#     args.state.selected_units = args.state.control_group_4
#     if args.state.control_group_4[0].unit
#       args.state.selected_type = :unit
#     end
#   end

#   if args.inputs.keyboard.key_down.five
#     args.state.selected_units = args.state.control_group_5
#     if args.state.control_group_5[0].unit
#       args.state.selected_type = :unit
#     end
#   end

#   if args.inputs.keyboard.key_down.six
#     args.state.selected_units = args.state.control_group_6
#     if args.state.control_group_6[0].unit
#       args.state.selected_type = :unit
#     end
#   end

#   if args.inputs.keyboard.key_down.seven
#     args.state.selected_units = args.state.control_group_7
#     if args.state.control_group_7[0].unit
#       args.state.selected_type = :unit
#     end
#   end

#   if args.inputs.keyboard.key_down.eight
#     args.state.selected_units = args.state.control_group_8
#     if args.state.control_group_8[0].unit
#       args.state.selected_type = :unit
#     end
#   end

#   if args.inputs.keyboard.key_down.nine
#     args.state.selected_units = args.state.control_group_9
#     if args.state.control_group_9[0].unit
#       args.state.selected_type = :unit
#     end
#   end

#   if args.inputs.keyboard.key_down.zero
#     args.state.selected_units = args.state.control_group_0
#     if args.state.control_group_0[0].unit
#       args.state.selected_type = :unit
#     end
#   end
# end

# def control_groups_1_through_0(args)
#   control_group_1(args)
#   control_group_2(args)
#   control_group_3(args)
#   control_group_4(args)
#   control_group_5(args)
#   control_group_6(args)
#   control_group_7(args)
#   control_group_8(args)
#   control_group_9(args)
#   control_group_0(args)
# end

# def control_group_1(args)
#   if args.inputs.keyboard.key_held.control_one
#     args.state.control_group_1 = args.state.selected_units[0..20]
#   end
# end

# def control_group_2(args)
#   if args.inputs.keyboard.key_held.control_two
#     args.state.control_group_2 = args.state.selected_units[0..20]
#   end
# end

# def control_group_3(args)
#   if args.inputs.keyboard.key_held.control_three
#     args.state.control_group_3 = args.state.selected_units[0..20]
#   end
# end

# def control_group_4(args)
#   if args.inputs.keyboard.key_held.control_four
#     args.state.control_group_4 = args.state.selected_units[0..20]
#   end
# end

# def control_group_5(args)
#   if args.inputs.keyboard.key_held.control_five
#     args.state.control_group_5 = args.state.selected_units[0..20]
#   end
# end

# def control_group_6(args)
#   if args.inputs.keyboard.key_held.control_six
#     args.state.control_group_6 = args.state.selected_units[0..20]
#   end
# end

# def control_group_7(args)
#   if args.inputs.keyboard.key_held.control_seven
#     args.state.control_group_7 = args.state.selected_units[0..20]
#   end
# end

# def control_group_8(args)
#   if args.inputs.keyboard.key_held.control_eight
#     args.state.control_group_8 = args.state.selected_units[0..20]
#   end
# end

# def control_group_9(args)
#   if args.inputs.keyboard.key_held.control_nine
#     args.state.control_group_9 = args.state.selected_units[0..20]
#   end
# end

# def control_group_0(args)
#   if args.inputs.keyboard.key_held.control_zero
#     args.state.control_group_0 = args.state.selected_units[0..20]
#   end
# end
