class Speaker
  attr_reader :name, :talks

  @@speakers = []

  def initialize(name:)
    @name = name
    @@speakers << self
    @talks = []
  end

  def self.find_by!(name:)
    speaker = @@speakers.detect { |speaker| speaker.name.upcase == name.upcase }

    unless speaker
      raise StandardError, "There is no speaker '#{name}' created yet."
    end

    speaker
  end

  def add_talk(talk)
    @talks << talk
    talk.speaker = self
  end

  def to_s
    "Speaker '#{@name}' has been created"
  end
end
