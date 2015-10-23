module Cronline
  class CronField

    @range
    @wild = false

    def self.wildcard
      '*'
    end

    def initialize(field_expression, absolute_min, absolute_max)
      @absolute_min = absolute_min
      @absolute_max = absolute_max
      if field_expression == CronField.wildcard
        #Wild
        @wild = true
        @range = Integer(absolute_min)..Integer(absolute_max)
      elsif field_expression.include?('-')
        #Range
        min = Integer(field_expression.split('-')[0])
        max = Integer(field_expression.split('-')[1])
        @range = min..max
      elsif field_expression.include?(',')
        #Value list
        @range = field_expression.split(',').map do |number_expression|
          Integer(number_expression)
        end
      elsif field_expression.include?('/')
        #Increment
        increment_start = field_expression.split('/')[0]
        increment_step = field_expression.split('/')[1]
        @range = (Integer(increment_start)..absolute_max).step(Integer(increment_step))
      elsif field_expression == '?'
        #Disabled
        @range = []
      elsif field_expression[-1, 1] == 'L'
        #Last
        @range = [Integer(field_expression.sub!('L', ''))]
      else
        #Single
        @range = [Integer(field_expression)]
      end
    end

    def range(time = nil)
      @range
    end

    def test?(time)
      range(time).include?(time_field(time))
    end

    def time_field(time)
      fail 'time_field must be implemented'
    end

  end
end
