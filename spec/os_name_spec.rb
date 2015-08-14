require 'spec_helper'

describe 'device_type' do
  before do
    install_extension
  end

  it 'should pass valid device_type' do
    [
      'bot',
      'console',
      'ipod',
      'mac',
      'pc',
      'phone',
      'server',
      'simulator',
      'tablet',
      'unknown',
    ].each do |name|
      query("SELECT '#{name}'::device_type").should match name
    end
  end

  it 'should rais an exception on invalid device_type' do
    expect{query("SELECT 'kermit'::device_type")}.to throw_error('unknown input device_type: kermit')
  end
end
