require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'RTM::Signer' do
  it "should sign your parameters" do
    signed_request = RTM::Signer.sign("SECRET", 'b' => 'bbb', 'a' => 'aaa', 'c' => 'ccc')
    signed_request.should == Digest::MD5.hexdigest('SECRETaaaabbbbcccc')
  end
end