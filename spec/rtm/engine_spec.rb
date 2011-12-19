require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RTM::Engine do
  let(:gateway){double('gateway')}
  let(:store){double('store')}
  subject{RTM::Engine.new gateway}

  context "#auth_required?" do
    
  end

  context "#authenticate" do
  end
  
end

