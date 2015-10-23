require 'spec_helper'

describe Cronline::CronDaysOfWeek do
  it 'converts last Sunday of month' do
    expect(Cronline::CronDaysOfWeek.new('0 0 0 ? 2 1L')
               .range(Time.new(2015, 2, 1)).to_a).to eq([22])
  end
end
