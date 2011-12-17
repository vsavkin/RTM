require 'pstore'

module RTM
  class Storage
    FILE_NAME = "/tmp/rtm.pstore"
    
    def initialize
      @store = PStore.new FILE_NAME
    end
    
    def save data
      @store.transaction do
        @store[:rtm] = data
      end
    end

    def read
      @store.transaction(true) do
        @store[:rtm]
      end
    end
  end
end
