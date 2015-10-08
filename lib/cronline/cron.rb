module CronLine
  class Cron
    @seconds = []
    @minutes = []
    @hours = []
    @days_of_month = []
    @months = []
    @days_of_week = []
    @years = []


    def initialize(cron_expression)
      @seconds = CronSeconds.new(cron_expression)
      @minutes = CronMinutes.new(cron_expression)
    end

    def test?(time)
      #Given the field values, does this time cause the cron to fire?
      @seconds.test?(time)
    end


  end
end
