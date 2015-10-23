module Cronline
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

      cron_days_of_month = CronDaysOfMonth.new(cron_expression)
      cron_days_of_week = CronDaysOfWeek.new(cron_expression)
      if (cron_days_of_month).active? && (cron_days_of_week).active?
        fail 'Only one days field is allowed'
      elsif cron_days_of_week.active?
        @days = cron_days_of_week
      elsif cron_days_of_month.active?
        @days = cron_days_of_month
      else
        fail 'One day field is required'
      end
    end

    def test?(time)
      @years.test?(time) && @months.test?(time) && @days.test?(time) &&
          @hours.test?(time) && @minutes.test?(time) && @seconds.test?(time)
    end

    def test_up_to_hours?(time)
      @years.test?(time) && @months.test?(time) && @days.test?(time) &&
          @hours.test?(time)
    end

  end
end
