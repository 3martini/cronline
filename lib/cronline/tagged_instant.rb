module CronLine
  class TaggedInstant
    attr_reader :id, :instant
    @id
    @instant

    def initialize(instant, id)
      @instant = instant
      @id = id
    end

  end
end