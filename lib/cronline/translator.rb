module CronLine
  class Translator

    @range_seconds = 60

    def self.range_seconds
      @range_seconds
    end

    def self.execute(tagged_crons)
      @result = []
      tagged_crons.each do |tagged_cron|
        times = Simulator.simulate(tagged_cron.expression)
        times.each do |time|
          result += TaggedTime.new(time, tagged_cron.id)
        end
      end

    end
  end
end
