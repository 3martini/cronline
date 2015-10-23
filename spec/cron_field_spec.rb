require 'spec_helper'

describe Cronline::CronField do
  it 'converts increments' do
    expect(Cronline::CronField.new('5/25', 0, 59).range.to_a).to eq([5,30,55])
  end

  it 'converts single values' do
    expect(Cronline::CronField.new('5', 0, 59).range.to_a).to eq([5])
  end

  it 'converts list values' do
    expect(Cronline::CronField.new('5,12', 0, 59).range.to_a).to eq([5, 12])
  end

  it 'converts disabled values' do
    expect(Cronline::CronField.new('?', 0, 59).range.to_a).to eq([])
  end

  it 'converts range values' do
    expect(Cronline::CronField.new('3-7', 0, 59).range.to_a).to eq([3,4,5,6,7])
  end
end
