module CronLine
  class CronYears < CronField

    def self.absolute_min_year
      1970
    end

    def self.absolute_max_year
      2099
    end

    def initialize(cron_expression)
      expression = cron_expression.split(' ')[6]
      if expression.nil?
        super(CronField.wildcard, CronYears.absolute_min_year , CronYears.absolute_max_year)
      else
        super(expression, CronYears.absolute_min_year , CronYears.absolute_max_year)
      end
    end

    def time_field(time)
      time.year
    end
  end
end
