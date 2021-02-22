class Talk
  attr_reader :talk_name, :talk_start_time, :talk_end_time
  attr_accessor :event, :speaker

  def initialize(talk_name:, talk_start_time:, talk_end_time:)
    @talk_name = talk_name
    @talk_start_time = talk_start_time
    @talk_end_time = talk_end_time
  end

  def to_s
    "Talk #{@talk_name} has been created"
  end
end
