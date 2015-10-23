module Cronline
  class CronMonths < CronField
    def initialize(cron_expression)
      expression = cron_expression.split(' ')[4]
      Date::ABBR_MONTHNAMES.each do |abbreviation|
        unless abbreviation.nil?
          expression.gsub!(/(#{abbreviation})/i, Date::ABBR_MONTHNAMES.index(abbreviation).to_s)
        end
      end
      super(expression, 1, 12)
    end

    def time_field(time)
      time.month
    end
  end


end
