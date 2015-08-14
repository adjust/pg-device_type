require 'spec_helper'

describe 'persistence' do
  before do
    install_extension
  end

  it 'should persist device_types' do
    query("CREATE TABLE device_type_test AS SELECT 'phone'::device_type, 1 as num")
    query("SELECT * FROM device_type_test").should match 'phone',  1
    query("UPDATE device_type_test SET num = 2")
    query("SELECT * FROM device_type_test").should match 'phone',  2
  end
end
