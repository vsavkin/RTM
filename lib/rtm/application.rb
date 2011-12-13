module RTM
  class Application
    def initialize command_reader, engine, screen
      @command_reader = command_reader
      @engine = engine
      @screen = screen
    end

    def run!
      while command = @command_reader.next_command
        response = @engine.process(command)
        @screen.render response
      end
    end
  end
end