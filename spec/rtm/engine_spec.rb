require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RTM::Engine do
  let(:gateway){double('gateway')}
  let(:store){double('store')}

  subject{RTM::Engine.new store, gateway}

  context "auth" do
    context "no frob" do
      it "should generate an auth link and store the frob" do
        gateway.should_receive(:get_frob).and_return('frob')
        store.should_receive(:save).with(frob: 'frob')
        gateway.should_receive(:generate_auth_link).with('frob').and_return('link')
        response = subject.auth
        response.should be_exit
        response.content.should == "link"
      end
    end

  end
end

