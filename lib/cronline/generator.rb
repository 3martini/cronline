module CronLine
  class Generator
    @seconds
    @minutes
    @hours
    @days
    @months
    @years
    @start_date
    @end_date

    @iterations

    def self.default_timezone
      'EST'
    end

    def self.max_iterations
      1
    end

    def initialize(years, months, days, hours, minutes, seconds, start_date, end_date, timezone)
      @seconds = seconds
      @minutes = minutes
      @hours = hours
      @days = days
      @months = months
      @years = years
      @start_date = start_date || Date.new
      @end_date = end_date || Date.new

      @timezone = timezone || Generator.default_timezone
    end

    def generate
      accumulator = []
      iterations = 0
      @years.each do |year|
        @months.each do |month|
          @days.each do |day|
            @hours.each do |hour|
              @minutes.each do |minute|
                @seconds.each do |second|
                  if iterations > Generator.max_iterations
                    return accumulator
                  end
                  d = DateTime.new(year, month, day, hour, minute, second, @timezone)
                  accumulator.push(d)
                end
              end
            end
          end
        end
      end
      accumulator
    end
  end
end

