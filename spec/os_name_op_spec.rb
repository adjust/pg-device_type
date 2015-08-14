require 'spec_helper'

describe 'device_type_op' do
  before do
    install_extension
  end

  it 'should implement gt' do
    query("SELECT 'phone'::device_type > 'ipod'::device_type").should match 't'
    query("SELECT 'phone'::device_type >= 'ipod'::device_type").should match 't'
    query("SELECT 'ipod'::device_type < 'pc'::device_type").should match 't'
    query("SELECT NOT('phone'::device_type < 'ipod'::device_type)").should match 't'
    query("SELECT NOT('phone'::device_type <= 'ipod'::device_type)").should match 't'
  end

  it 'should implement lt' do
    query("SELECT 'phone'::device_type > 'ipod'::device_type").should match 't'
    query("SELECT 'phone'::device_type >= 'ipod'::device_type").should match 't'
    query("SELECT NOT('phone'::device_type < 'ipod'::device_type)").should match 't'
    query("SELECT NOT('phone'::device_type <= 'ipod'::device_type)").should match 't'
  end

  it 'should implement eq' do
    query("SELECT NOT('phone'::device_type = 'ipod'::device_type)").should match 't'
    query("SELECT 'ipod'::device_type = 'ipod'::device_type").should match 't'
  end

  it 'should implement neq' do
    query("SELECT 'phone'::device_type != 'ipod'::device_type").should match 't'
    query("SELECT NOT('ipod'::device_type != 'ipod'::device_type)").should match 't'
  end
end
