module RTM
  class Task
    attr_reader :id, :name, :priority, :due_date, :tags, :list
    
    def initialize args
      @id = args[:id]
      @name = args[:name]
      @priority = args[:priority]
      @due_date = args[:due_date]
      @tags = args[:tags]
      @list = args[:list]
    end
  end

  class List
    attr_reader :id, :name, :tasks

    def initialize args
      @id = args[:id]
      @name = args[:name]
      @tasks = args[:tasks]
    end
  end
  
end
