require_relative 'utility'
require_relative './events/event'
require_relative './events/speaker'
require_relative './events/talk'

class Events
  class << self
    include Utility

    def run(input)
      commands = extract_commands(input)
      action, event_object, event_object_parts = get_event_parts(commands)
      run_commands(action, event_object, event_object_parts)
    end

    private

    def run_commands(action, event_object, event_object_parts)
      action = action.upcase
      event_object = event_object.upcase

      if action == 'CREATE'
        run_create_commands(event_object, event_object_parts)
      elsif action == 'PRINT'
        run_print_commands(event_object, event_object_parts)
      end
    end

    def run_create_commands(event_object, event_object_parts)
      case event_object
      when 'EVENT'
        run_create_event_commands(event_object_parts)
      when 'SPEAKER'
        run_create_speaker_commands(event_object_parts)
      when 'TALK'
        run_create_talk_commands(event_object_parts)
      end
    end

    def run_print_commands(event_object, event_object_parts)
      case event_object
      when 'TALKS'
        run_print_talks_commands(event_object_parts)
      end
    end

    def run_create_event_commands(event_object_parts)
      event_name = event_object_parts[0]
      Event.new(event_name: event_name)
    end

    def run_create_speaker_commands(event_object_parts)
      name = event_object_parts[0]
      Speaker.new(name: name)
    end

    def run_create_talk_commands(event_object_parts)
      event_name, talk_name, talk_start_time, talk_end_time, speaker_name = event_object_parts

      event = Event.find_by!(event_name: event_name)
      speaker = Speaker.find_by!(name: speaker_name)

      event.talk_overlaps?(talk_start_time: talk_start_time, talk_end_time: talk_end_time)

      talk = Talk.new(talk_name: talk_name, talk_start_time: talk_start_time, talk_end_time: talk_end_time)

      event.add_talk(talk)
      speaker.add_talk(talk)
      talk
    end

    def run_print_talks_commands(event_object_parts)
      event_name = event_object_parts[0]
      Event.print(event_name: event_name)
    end
  end
end
