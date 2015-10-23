require 'spec_helper'

describe Cronline::CronDaysOfMonth do
  it 'converts last day of month' do
    expect(Cronline::CronDaysOfMonth.new('0 0 0 L 2 ?').range(Time.new(2015, 2, 1)).to_a).to eq([28])
  end
end
