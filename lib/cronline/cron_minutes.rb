module Cronline
  class CronMinutes < CronField
    def initialize(cron_expression)
      expression = cron_expression.split(' ')[1]
      super(expression, 0, 59)
    end

    def time_field(time)
      time.min
    end
  end


end
