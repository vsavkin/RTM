module RTM
  class Engine
    INIT = "init"

    def initialize store, gateway
      @store, @gateway = store, gateway
    end
    
    def auth
      frob = @gateway.get_frob
      @store.save frob: frob
      content = @gateway.generate_auth_link frob
      AuthResponse.new content
    end


    class AuthResponse
      attr_reader :content
      
      def initialize content
        @content = content
      end

      def exit?
        true
      end
    end
  end
end
