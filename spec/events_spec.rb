require 'spec_helper'
require 'events'
require 'events/event'
require 'events/speaker'
require 'events/talk'

RSpec.describe Events do
  describe '#run' do
    subject { Events.run(input) }

    context 'when inputs raise error' do
      shared_examples 'raise error' do
        it 'should raise error' do
          expect { subject }.to raise_error(StandardError, error_message)
        end
      end

      context 'when input action is not in [CREATE, PRINT]' do
        let(:input) { 'UPDATE EVENT new_event' }
        let(:error_message) { 'UPDATE is not a valid Action in ["CREATE", "PRINT"]' }

        include_examples 'raise error'
      end

      context 'when input action is CREATE' do
        context 'when input action object is not in [EVENT SPEAKER TALK]' do
          let(:input) { 'CREATE EVENTSS new_event' }
          let(:error_message) { 'EVENTSS is not a valid action object in ["EVENT", "SPEAKER", "TALK"]' }

          include_examples 'raise error'
        end

        context "when input action's number of args are not correct" do
          context "when input action object is EVENT" do
            let(:input) { 'CREATE EVENT new_event hello' }
            let(:error_message) { 'Your input args are not valid for EVENT, we expect number of args is 1' }

            include_examples 'raise error'
          end

          context "when input action object is SPEAKER" do
            let(:input) { 'CREATE SPEAKER Sam hello' }
            let(:error_message) { 'Your input args are not valid for SPEAKER, we expect number of args is 1' }

            include_examples 'raise error'
          end

          context "when input action object is TALK" do
            let(:input) { 'CREATE TALK new_event hello' }
            let(:error_message) { 'Your input args are not valid for TALK, we expect number of args is 5' }

            include_examples 'raise error'
          end
        end

        context 'when talk_start_time or talk_end_time is invalid' do
          let(:input) { 'CREATE TALK new_event "new talk" 2:pm 2:30pm Sam' }
          let(:error_message) { 'Either 2:pm or 2:30pm is invalid' }

          include_examples 'raise error'
        end

        context 'when talk_start_time is greater than talk_end_time is invalid' do
          let(:input) { 'CREATE TALK new_event "new talk" 2:00pm 1:30pm Sam' }
          let(:error_message) { 'start time: 2:00pm should be less than end time: 1:30pm' }

          include_examples 'raise error'
        end
      end

      context 'when input action is PRINT' do
        context 'when input action object is not in [TALKS]' do
          let(:input) { 'PRINT EVENTSS new_event' }
          let(:error_message) { 'EVENTSS is not a valid action object in ["TALKS"]' }

          include_examples 'raise error'
        end

        context "when input action's number of args are not correct" do
          context 'when input action object is TALKS' do
            let(:input) { 'PRINT TALKS new_event hello' }
            let(:error_message) { 'Your input args are not valid for TALKS, we expect number of args is 1' }

            include_examples 'raise error'
          end
        end
      end
    end

    context 'when inputs are correct' do
      context 'when create EVENT' do
        let(:input) { 'CREATE EVENT new_event' }
        let(:event) { Event.new(event_name: 'new_event') }

        it 'should return correct result' do
          expect(Event).to receive(:new).with(event_name: 'new_event').and_return(event)
          expect(subject).to eq(event)
        end
      end

      context 'when create SPEAKER' do
        let(:input) { 'CREATE SPEAKER Sam' }
        let(:speaker) { Speaker.new(name: 'Sam') }

        it 'should return correct result' do
          expect(Speaker).to receive(:new).with(name: 'Sam').and_return(speaker)
          expect(subject).to eq(speaker)
        end
      end

      context 'when create TALK' do
        let(:input) { "CREATE TALK the_event 'hello world' 2:00pm 2:30pm Sam" }
        let(:event) { Event.new(event_name: 'the_event') }
        let(:speaker) { Speaker.new(name: 'Sam') }
        let(:talk) { Talk.new(talk_name: "'hello world'", talk_start_time: '2:00pm', talk_end_time: '2:30pm') }

        it 'should return correct result' do
          expect(Event).to receive(:find_by!).with(event_name: 'the_event').and_return(event)
          expect(Speaker).to receive(:find_by!).with(name: 'Sam').and_return(speaker)
          expect(Talk).to receive(:new).with(talk_name: "'hello world'", talk_start_time: '2:00pm', talk_end_time: '2:30pm').and_return(talk)
          expect(event).to receive(:talk_overlaps?).with(talk_start_time: '2:00pm', talk_end_time: '2:30pm').and_return(nil)
          expect(subject).to eq(talk)
        end
      end

      context 'when print TALKS' do
        let(:input) { 'PRINT TALKS an_event' }
        let(:print_result) { "9:30am - 10:30am\n\tcode challenge presented by Sam" }
        let(:event) { Event.new(event_name: 'an_event') }

        it 'should return correct result' do
          expect(Event).to receive(:print).with(event_name: 'an_event').and_return(print_result)

          subject
        end
      end
    end
  end
end
