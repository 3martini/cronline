require 'spec_helper'

describe CronLine::Generator do
  it 'Generates dates' do
    dates = CronLine::Generator.new(2015..2017, 1..3, 1, 4, 0, 0, DateTime.now, DateTime.now, 'EST')
    puts dates.generate
  end

end
