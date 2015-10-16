module CronLine
  class CronField

    @acceptance
    @wild = false

    def self.wildcard
      '*'
    end

    def initialize(field_expression, absolute_min, absolute_max)
      @absolute_min = absolute_min
      @absolute_max = absolute_max
      if field_expression == CronField.wildcard
        @wild = true
        @acceptance = Integer(absolute_min)..Integer(absolute_max)
      elsif field_expression.include?('-')
        min = Integer(field_expression.split('-')[0])
        max = Integer(field_expression.split('-')[1])
        @acceptance = min..max
      elsif field_expression.include?(',')
        @acceptance = field_expression.split(',').map do |number_expression|
          Integer(number_expression)
        end
      elsif field_expression.include?('/')
        #Increment
        fail 'Increment not yet supported'
      elsif field_expression == '?'
        @acceptance = []
      else
        #Single
        @acceptance = [Integer(field_expression)]
      end
    end

    def generate_values
      @acceptance
    end

    def test?(time)
      @acceptance.include?(time_field(time))
    end

    def time_field(time)
      fail 'time_field must be implemented'
    end

    def wild?
      @wild
    end

  end
end
