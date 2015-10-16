module CronLine
  class Cron
    attr_reader :seconds, :minutes, :hours, :days, :months, :years

    @seconds
    @minutes
    @hours
    @days
    @months
    @years

    def initialize(cron_expression)
      @seconds = CronSeconds.new(cron_expression)
      @minutes = CronMinutes.new(cron_expression)
      @hours = CronHours.new(cron_expression)

      @months = CronMonths.new(cron_expression)
      @years = CronYears.new(cron_expression)

      if (cron_days_of_month = CronDaysOfMonth.new(cron_expression)).active?
        @days = cron_days_of_month
      elsif (cron_days_of_week = CronDaysOfWeek.new(cron_expression)).active?
        @days = cron_days_of_week
      else

      end
    end

    def test?(time)
      @years.test?(time) && @months.test?(time) && @days.test?(time) &&
          @hours.test?(time) && @minutes.test?(time) && @seconds.test?(time)
    end

    def precision

    end

  end
end
