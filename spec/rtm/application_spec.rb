require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RTM::Application do
  let(:command_reader) {double('reader')}
  let(:engine) {double('engine')}
  let(:screen) {double('screen')}
  let(:init_command){RTM::Engine::INIT}

  let(:exit_response){stub("exit?" => true)}
  let(:continue_response){stub("exit?" => false)}

  subject {RTM::Application.new(command_reader, engine, screen)}

  context "engine initialization fails" do
    it "should print the response and exit" do
      engine.should_receive(:process).with(init_command).and_return(exit_response)
      screen.should_receive(:render).with(exit_response)
      subject.run!
    end
  end

  context "engine initialization succeeds" do
    it "should read commands till engine returns an exit response" do
      engine.should_receive(:process).with(init_command).and_return(continue_response)
      screen.should_receive(:render).with(continue_response)
      
      command_reader.should_receive(:next_command).and_return('exit')
      engine.should_receive(:process).with('exit').and_return(exit_response)
      screen.should_receive(:render).with(exit_response)
      subject.run!
    end
  end
end
