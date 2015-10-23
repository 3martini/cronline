module Cronline
  class CronDaysOfMonth < CronField
    @last_day_of_month = false

    def initialize(cron_expression)
      @field_expression = cron_expression.split(' ')[3]
      if @field_expression == 'L'
        @last_day_of_month = true
        @field_expression.sub!('L', '')
      else
        super(@field_expression, 0, 31)
      end
    end

    def active?
      @field_expression != '?'
    end

    def time_field(time)
      time.day
    end

    def range(time)
      if @last_day_of_month
        puts @last_day_of_month
        [last_day_of_month(time)]
      else
        super(time)
      end
    end

    private

    def last_day_of_month(time)
        Date.new(time.year, time.month, -1).day
    end
  end
end
