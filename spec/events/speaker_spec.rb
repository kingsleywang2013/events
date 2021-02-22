require 'spec_helper'
require 'events/speaker'
require 'events/talk'

RSpec.describe Speaker do
  describe '.add_talk' do
    let(:speaker) { Speaker.new(name: 'Sam') }

    context 'should add talks for speaker' do
      let(:talk) { Talk.new(talk_name: 'hello', talk_start_time: '9:30am', talk_end_time: '10:30am') }

      it 'should return correct talks' do
        speaker.add_talk(talk)
        expect(speaker.talks).to eq([talk])
      end
    end
  end

  describe '#find_by!' do
    let!(:speaker) { Speaker.new(name: 'David') }

    context 'when speaker could be found' do
      it 'should return correct speaker' do
        expect(Speaker.find_by!(name: 'David')).to eq(speaker)
      end
    end

    context 'when event could not be found' do
      it 'should raise error' do
        expect { Speaker.find_by!(name: 'fake') }.to raise_error(StandardError, "There is no speaker 'fake' created yet.")
      end
    end
  end
end
