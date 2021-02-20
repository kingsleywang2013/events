class Events
  class << self
    include Utility

    def run(input)
      commands = extract_commands(input)
      action, event_object, event_object_parts = get_event_parts(commands)
    end
  end
end
