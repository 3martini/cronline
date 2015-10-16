module CronLine
  class CronDaysOfMonth < CronField
    @field_expression

    def initialize(cron_expression)
      @field_expression = cron_expression.split(' ')[3]
      super(@field_expression, 0, 31)
    end

    def active?
      @field_expression != '?'
    end

    def time_field(time)
      time.day
    end
  end
end
