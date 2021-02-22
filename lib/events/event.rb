require 'time'

class Event
  attr_reader :event_name, :talks

  @@events = []

  def initialize(event_name:)
    @event_name = event_name
    @@events << self
    @talks = []
  end

  def self.find_by!(event_name:)
    event = @@events.detect { |event| event.event_name.upcase == event_name.upcase }

    unless event
      raise StandardError, "There is no event '#{event_name}' created yet."
    end

    event
  end

  def self.print(event_name:)
    event = Event.find_by!(event_name: event_name)

    print_results = []

    if event.talks.size == 0
      return "There is no any talks for '#{event_name}'"
    end

    event.talks.each do |talk|
      print_results << "#{talk.talk_start_time} - #{talk.talk_end_time}"
      print_results << "\t#{talk.talk_name} presented by #{talk.speaker.name}"
    end

    return print_results.join("\n")
  end

  def add_talk(talk)
    @talks << talk
    talk.event = self
  end

  def talk_overlaps?(talk_start_time:, talk_end_time:)
    overlap_talk = self.talks.detect { |talk| Time.parse(talk_start_time) <= Time.parse(talk.talk_end_time) && Time.parse(talk.talk_start_time) <= Time.parse(talk_end_time) }


    if overlap_talk
      raise StandardError, "cannot add a talk from #{talk_start_time} to #{talk_end_time} because a talk #{overlap_talk.talk_name} from #{overlap_talk.talk_start_time} to #{overlap_talk.talk_end_time} already exists in the event '#{self.event_name}'"
    end

  end

  def to_s
    "Event '#{@event_name}' has been created"
  end
end
