module CronLine
  class Simulator

    def self.default_max_ticks
      1e+5
    end

    def self.default_max_time_output
      365
    end

    def self.default_timeframe_seconds
      12.month.to_i
    end

    class Builder
      def initialize
        @start_time = Time.new
        @end_time = @start_time + Simulator.default_timeframe_seconds
        @max_ticks = Simulator.default_max_ticks
        @max_time_output = Simulator.default_max_time_output
      end

      def set_timezone(timezone_string)
        @timezone = timezone_string
        self
      end

      def set_start_time(start_time)
        @start_time = start_time
        self
      end

      def set_end_time(end_time)
        @end_time = end_time
        self
      end

      def set_duration(duration)
        @end_time = @start_time + duration
        self
      end

      def set_max_ticks(max_ticks)
        @max_ticks = max_ticks
        self
      end

      def set_max_time_output(max_time_output)
        @max_time_output = max_time_output
        self
      end

      def build
        @start_time = @start_time || Time.new
        Simulator.new(
            @timezone || nil,
            @start_time,
            @end_time,
            @max_ticks,
            @max_time_output)
      end
    end

    def self.builder
      Builder.new
    end

    def initialize(
        timezone = nil,
        start_time = Time.new,
        end_time = start_time + Simulator.default_timeframe_seconds,
        max_ticks = Simulator.default_max_ticks,
        max_time_output = Simulator.default_max_time_output)
      @start_time = start_time
      @end_time = end_time
      @max_ticks = max_ticks
      @max_time_output = max_time_output
      @timezone = timezone
    end

    def simulate_cron(cron_expression)
      @time_accumulator = []
      cron = Cron.new(cron_expression)
      time_increment = time_increment_size
      @start_unix_time = aligned_start_time(@start_time)
      @end_unix_time = @end_time.to_time.to_i
      @tick = 0
      while @start_unix_time <= @end_unix_time do
        if stop_simulation
          break
        end
        if @timezone.nil?
          time = Time.at(@start_unix_time)
        else
          time = Time.at(@start_unix_time).in_time_zone(@timezone)
        end
        if cron.test_up_to_hours?(time)
          @time_accumulator += generate_hours_and_seconds(cron, time)
        end
        @start_unix_time += time_increment
      end
      puts "Ticks #{@tick}"
      @time_accumulator
    end

    def generate_hours_and_seconds(cron, time)
      accumulator = []
      cron.minutes.range.each do |minute|
        cron.seconds.range.each do |second|
          @tick += 1
          accumulator.push(Time.new(time.year, time.month, time.day, time.hour, minute, second))
        end
      end
      accumulator
    end

    def stop_simulation
      if @tick >= @max_ticks
        return true
      end
      if @time_accumulator.size >= @max_time_output
        return true
      end
    end

    def aligned_start_time(start_time)
      #Align to day since minutes / seconds are relatively deterministic across timezones and DST...
      Time.new(start_time.year, start_time.month, start_time.day, start_time.hour).to_i
    end

    def time_increment_size
      #Skip seconds and minutes since we will generate these
      1.hours.to_i
    end

  end
end
