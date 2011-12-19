module RTM
  class Application
    def initialize command_reader, engine, screen
      @command_reader = command_reader
      @engine = engine
      @screen = screen
    end

    def run!
      command = RTM::Engine::INIT
      while true
        response = @engine.process command
        @screen.render response
        return if response.exit?
        command = @command_reader.next_command
      end
    end
  end
end
