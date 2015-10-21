module CronLine
  class CronDaysOfWeek < CronField
    @field_expression

    def initialize(cron_expression)
      @field_expression = cron_expression.split(' ')[5]
      Date::ABBR_DAYNAMES.each do |abbreviation|
        unless abbreviation.nil?
          @field_expression.gsub!(/(#{abbreviation})/i, Date::ABBR_DAYNAMES.index(abbreviation).to_s)
        end
      end
      super(@field_expression, 1, 7)
    end

    def active?
      @field_expression != '?'
    end

    def test?(time)
      @range.include?(time.wday)
    end
  end
end
