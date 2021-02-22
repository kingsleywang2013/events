require 'spec_helper'
require 'events/event'
require 'events/speaker'
require 'events/talk'

RSpec.describe Event do
  describe '.add_talk' do
    let(:event) { Event.new(event_name: 'new_event') }

    context 'should add talks for event' do
      let(:talk) { Talk.new(talk_name: 'hello', talk_start_time: '9:30am', talk_end_time: '10:30am') }

      it 'should return correct talks' do
        event.add_talk(talk)
        expect(event.talks).to eq([talk])
      end
    end
  end

  describe '#find_by!' do
    let!(:event) { Event.new(event_name: 'test') }

    context 'when event could be found' do
      it 'should return correct event' do
        expect(Event.find_by!(event_name: 'test')).to eq(event)
      end
    end

    context 'when event could not be found' do
      it 'should raise error' do
        expect { Event.find_by!(event_name: 'fake') }.to raise_error(StandardError, "There is no event 'fake' created yet.")
      end
    end
  end

  describe '.talk_overlaps?' do
    let(:event) { Event.new(event_name: 'an_event') }

    context 'when there is talk time is overlaps' do
      before do
        talk = Talk.new(talk_name: 'hello', talk_start_time: '9:30am', talk_end_time: '10:30am')
        event.add_talk(talk)
      end

      it 'should raise error' do
        expect { event.talk_overlaps?(talk_start_time: '10:00am', talk_end_time: '10:30am') }.to raise_error(StandardError, "cannot add a talk from 10:00am to 10:30am because a talk hello from 9:30am to 10:30am already exists in the event 'an_event'")
      end
    end
  end

  describe '#print' do
    context 'when there is no any talks for event' do
      let!(:event) { Event.new(event_name: 'hello_event') }

      it 'should return default message' do
        expect(Event.print(event_name: 'hello_event')).to eq("There is no any talks for 'hello_event'")
      end
    end

    context 'when there is talk for event' do
      let!(:event) { Event.new(event_name: 'beauty_event') }

      before do
        talk = Talk.new(talk_name: 'code challenge', talk_start_time: '9:30am', talk_end_time: '10:30am')
        speaker = Speaker.new(name: 'Sam')
        talk.speaker = speaker
        event.add_talk(talk)
      end

      it 'should return correct result' do
        expect(Event.print(event_name: 'beauty_event')).to eq("9:30am - 10:30am\n\tcode challenge presented by Sam")
      end
    end
  end
end
