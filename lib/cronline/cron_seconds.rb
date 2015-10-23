module Cronline
  class CronSeconds < CronField
    def initialize(cron_expression)
      expression = cron_expression.split(' ')[0]
      super(expression, 0 ,59)
    end

    def time_field(time)
      time.sec
    end
  end
end
