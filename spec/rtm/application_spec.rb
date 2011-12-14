require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RTM::Application do
  let(:command_reader) {mock}
  let(:engine) {mock}
  let(:screen) {mock}
  subject {RTM::Application.new(command_reader, engine, screen)}

  it "should exit when command reader returns nil" do
    command_reader.should_receive(:next_command).and_return(nil)
    subject.run!
  end

  it "should call engine" do
    command_reader.should_receive(:next_command).and_return('command')
    engine.should_receive(:process).with('command')
    screen.stub(:render)
    command_reader.should_receive(:next_command).and_return(nil)
    subject.run!
  end

  it "should render the response from the engine" do
    command_reader.should_receive(:next_command).and_return('command')
    engine.should_receive(:process).with('command').and_return('response')
    screen.should_receive(:render).with('response')
    command_reader.should_receive(:next_command).and_return(nil)
    subject.run!
  end
end
