module CronLine
  class TaggedCron
    attr_reader :expression, :id
    @id
    @expression

    def initialize(id, expression)
      @id = id
      @expression = expression
    end
  end
end
