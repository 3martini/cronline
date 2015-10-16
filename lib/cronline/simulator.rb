module CronLine
  class Simulator

    def self.default_timezone
      'EST'
    end

    def self.default_max_ticks
      1000000
    end

    def self.default_max_time_output
      100
    end

    def self.default_timeframe_seconds
      1.21e+6
    end

    def initialize(
        start_time = Time.new,
        end_time = start_time + Simulator.default_timeframe_seconds,
        max_ticks = Simulator.default_max_ticks,
        max_time_output = Simulator.default_max_time_output,
        timezone = Simulator.default_timezone)
      @start_time = start_time
      @end_time = end_time
      @max_ticks = max_ticks
      @max_time_output = max_time_output
      @timezone = timezone
    end

    def simulate(tagged_crons)
      @result = []
      tagged_crons.each do |tagged_cron|
        times = simulate(tagged_cron.expression)
        times.each do |time|
          result += TaggedTime.new(time, tagged_cron.id)
        end
      end
    end

    def simulate_cron(cron_expression)
      time_accumulator = []
      cron = Cron.new(cron_expression)
      time_increment = time_increment_size
      @unix_time = @start_time.to_time.to_i
      @end_unix_time = @end_time.to_time.to_i
      @tick = 0
      while @unix_time <= @end_unix_time do
        if @tick >= @max_ticks
          puts "Max ticks reached"
          break
        end
        if time_accumulator.size >= @max_ticks
          puts "Max time output reached"
          break
        end
        time = Time.at(@unix_time)
        if cron.test?(time)
          time_accumulator.push(time)
        end
        @unix_time += time_increment
        @tick += 1
      end
      puts "Tick Count: #{@tick}"
      time_accumulator
    end

    def time_increment_size
      #TODO tune this to the maximum precision of the cron
      1
    end

  end
end
