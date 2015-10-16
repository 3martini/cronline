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
    @max_iterations

    @iterations

    def self.default_timezone
      'EST'
    end

    def self.default_max_iterations
      10
    end

    def initialize(start_date, end_date, timezone, max_iterations)
      @start_date = start_date || Date.new
      @end_date = end_date || Date.new + 14

      @timezone = timezone || Generator.default_timezone
      @max_iterations = max_iterations || Generator.default_max_iterations
    end

    def generate(years, months, days, hours, minutes, seconds)
      accumulator = []
      iterations = 0
      years.each do |year|
        months.each do |month|
          days.each do |day|
            hours.each do |hour|
              minutes.each do |minute|
                seconds.each do |second|
                  d = DateTime.new(year, month, day, hour, minute, second, @timezone)
                  accumulator.push(d)
                  if iterations > Generator.max_iterations || d > @end_date
                    return accumulator
                  end
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

