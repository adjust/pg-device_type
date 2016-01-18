require 'spec_helper'

describe 'binary_copy' do
  before do
    install_extension
  end


  it "should copy data binary from country" do
    query("CREATE TABLE before (a device_type)")
    query("INSERT INTO before VALUES ('bot'), ('console'), ('ipod'), ('mac'), ('pc'), ('phone'), ('server'), ('simulator'), ('tablet'), ('tv'), ('unknown')")
    query("CREATE TABLE after (a device_type)")
    query("COPY before TO '/tmp/tst' WITH (FORMAT binary)")
    query("COPY after FROM '/tmp/tst' WITH (FORMAT binary)")
    query("SELECT * FROM after").should match \
    ['bot'],
    ['console'],
    ['ipod'],
    ['mac'],
    ['pc'],
    ['phone'],
    ['server'],
    ['simulator'],
    ['tablet'],
    ['tv'],
    ['unknown']
  end
end
