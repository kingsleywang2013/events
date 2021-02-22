require 'spec_helper'
require 'events/event'
require 'events/speaker'
require 'events/talk'

RSpec.describe Talk do
  let(:event) { Event.new(event_name: 'new_event') }
  let(:speaker) { Speaker.new(name: 'Sam') }
  let(:talk) { Talk.new(talk_name: 'hello', talk_start_time: '9:30am', talk_end_time: '10:30am') }

  it 'should belongs to event' do
    event.add_talk(talk)

    expect(talk.event).to eq(event)
  end

  it 'should belongs to speaker' do
    speaker.add_talk(talk)

    expect(talk.speaker).to eq(speaker)
  end
end
