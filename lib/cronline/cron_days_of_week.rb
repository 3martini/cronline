module Cronline
  class CronDaysOfWeek < CronField
    @field_expression
    @last_weekday_of_month = false

    def initialize(cron_expression)
      @field_expression = cron_expression.split(' ')[5]
      Date::ABBR_DAYNAMES.each do |abbreviation|
        unless abbreviation.nil?
          @field_expression.gsub!(/(#{abbreviation})/i, Date::ABBR_DAYNAMES.index(abbreviation).to_s)
        end
      end
      if @field_expression[-1,1] == 'L'
        @last_weekday_of_month = true
        @field_expression.sub!('L', '')
      end
      super(@field_expression, 1, 7)
    end

    def active?
      @field_expression != '?'
    end

    def range(time)
      if @last_weekday_of_month
        [last_weekday_day_of_month(super(time)[0], time)]
      else
        super(time)
      end
    end

    def test?(time)
      if @last_weekday_of_month
        test_last_weekday?(@range[0], time)
      else
        @range.include?(time.wday)
      end
    end

    # Thank you Mohit Sindhwani https://www.ruby-forum.com/topic/125970
    def last_weekday_day_of_month(weekday_number, time)
      last_day_of_month = Date.new(time.year, time.month, -1)
      last_day_wday = ((last_day_of_month.wday + 1) - weekday_number).abs
      last_day = Date.new(time.year, time.month, (last_day_of_month.day - last_day_wday))
      last_day.day
    end

    # Thank you Mohit Sindhwani https://www.ruby-forum.com/topic/125970
    def test_last_weekday?(weekday_number, time)
      last_day_of_month = Date.new(time.year, time.month, -1)
      last_day_wday = ((last_day_of_month.wday + 1) - weekday_number).abs
      last_day = Date.new(time.year, time.month, (last_day_of_month.day - last_day_wday))
      last_day.year == time.year && last_day.month == time.month && last_day.day == time.day
    end
  end
end
