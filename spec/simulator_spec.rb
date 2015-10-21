require 'spec_helper'

describe CronLine::Simulator do
  it 'simulates cron times' do
    times = CronLine::Simulator.builder
              .set_max_time_output(5)
              .set_start_time(Time.new(2015, 1, 1))
              .set_duration(1.week)
              .build
              .simulate_cron('0 30 7 ? * MON,WED *')
    expect(times).to eq([Time.parse('2015-01-05 07:30:00.000000000 -0500'),
                         Time.parse('2015-01-07 07:30:00.000000000 -0500')])
  end

  it 'simulates cron times across funny daylight savings changes' do
    times = CronLine::Simulator.builder
                .set_max_time_output(5)
                .set_start_time(Time.new(2015, 11, 1))
                .set_duration(1.week)
                .build
                .simulate_cron('0 0 1 1 * ? *')
    expect(times).to eq([Time.parse('2015-11-01 01:00:00.000000000 -0400'),
                         Time.parse('2015-11-01 01:00:00.000000000 -0400')])
  end

end
