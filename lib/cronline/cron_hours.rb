module CronLine
  class CronHours < CronField
    def initialize(cron_expression)
      expression = cron_expression.split(' ')[2]
      super(expression, 0, 23)
    end

    def time_field(time)
      time.hour
    end
  end
end
