module CronLine
  class Cron
    @seconds = []
    @minutes = []
    @hours = []
    @days_of_month = []
    @months = []
    @days_of_week = []
    @years = []


    def self.create(cron_expression)
      subject = Cron.new
      #parse the string, set the values for each of the field types
    end

    def test(time)
      #Given the field values, does this time cause the cron to fire?
    end
  end
end