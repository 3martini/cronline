module CronLine
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
        @wild = true
        @range = Integer(absolute_min)..Integer(absolute_max)
      elsif field_expression.include?('-')
        min = Integer(field_expression.split('-')[0])
        max = Integer(field_expression.split('-')[1])
        @range = min..max
      elsif field_expression.include?(',')
        @range = field_expression.split(',').map do |number_expression|
          Integer(number_expression)
        end
      elsif field_expression.include?('/')
        #Increment
        fail 'Increment not yet supported'
      elsif field_expression == '?'
        @range = []
      else
        #Single
        @range = [Integer(field_expression)]
      end
    end

    def range
      @range
    end

    def test?(time)
      @range.include?(time_field(time))
    end

    def time_field(time)
      fail 'time_field must be implemented'
    end

  end
end
