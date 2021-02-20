module Utility
  VALID_ACTION = %w[CREATE PRINT].freeze
  VALID_CREATE_OBJECTS = %w[EVENT SPEAKER TALK].freeze
  VALID_PRINT_OBJECTS = %w[TALKS].freeze
  VALID_CREATE_OBJECT_MAPPING = {
    'EVENT': 1,
    'SPEAKER': 1,
    'TALK': 5
  }.freeze
  VALID_PRINT_OBJECT_MAPPING = {
    'PRINT': 1
  }

  def extract_commands(input)
    input.split(/\s(?=(?:[^'"]|'[^']*'|"[^"]*")*$)/)
  end

  def check_valid_action(commands)
    action = commands[0]

    unless VALID_ACTION.include?(aciton)
      raise StandardError, "#{action} is not a valid Action in #{VALID_ACTION}"
    end

    action
  end

  def get_event_parts(commands)
    action = check_valid_action(commands)
    event_object = commands[1]
    event_object_parts = commands[1...-1]

    if action.upcase == 'CREATE'
      check_valid_create_objects(event_object, event_object_parts)
    elsif action.upcase == 'PRINT'
      check_valid_print_objects(event_object, event_object_parts)
    end

    [action, event_object, event_object_parts]
  end

  def check_valid_create_objects(event_object, event_object_parts)
    # Check if event_object is valid in [EVENT SPEAKER TALK]
    unless VALID_CREATE_OBJECTS.include?(event_object.upcase)
      raise StandardError, "#{event_object} is not a valid Action in #{VALID_CREATE_OBJECTS}"
    end

    # Check if number of args are valid for each [EVENT SPEAKER TALK]
    unless VALID_CREATE_OBJECT_MAPPING[event_object] == event_object_parts.length
      raise StandardError, "Your input args are not valid for #{event_object}, we expect number of args is #{VALID_CREATE_OBJECT_MAPPING[event_object]}"
    end
  end

  def check_valid_print_objects(event_object, event_object_parts)
    # Check if event_object is valid in [EVENT SPEAKER TALK]
    unless VALID_PRINT_OBJECTS.include?(event_object.upcase)
      raise StandardError, "#{event_object} is not a valid Action in #{VALID_PRINT_OBJECTS}"
    end

    # Check if number of args are valid for each [EVENT SPEAKER TALK]
    unless VALID_PRINT_OBJECT_MAPPING[event_object] == event_object_parts.length
      raise StandardError, "Your input args are not valid for #{event_object}, we expect number of args is #{VALID_PRINT_OBJECT_MAPPING[event_object]}"
    end
  end
end