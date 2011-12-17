require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RTM::Storage do
  let :data do
    [{"a"=>1}, {"b" => 2}]
  end
  
  it "should store all data on the disk" do
    RTM::Storage.new.save data
    RTM::Storage.new.read.should == data
  end
end
