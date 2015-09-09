require "generator"
module CronLine
  class Translator

    @range_seconds = 604800 # One Day in seconds
    @start_time = Time.now

    def self.execute(tagged_crons)
      @result = []
      tagged_crons.each do |tagged_cron|
        result += TaggedInstant.new(Generator.generate(tagged_cron.expression), tagged_cron.id)
      end

    end
  end
end