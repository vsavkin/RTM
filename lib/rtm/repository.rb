module RTM
  class Repository
    class Failure < StandardError; end
    
    def initialize gateway
      @gateway = gateway
    end
    
    def get_data
      data = @gateway.get_all_lists
      ensure_ok_status data
      
      extract_lists_data(data).map do |list_data|
        create_list_with_tasks_from_data list_data
      end
    end

    private
    def create_list_with_tasks_from_data list_data
      create_list_from_data(list_data).tap do |list|
        tasks_data = @gateway.get_tasks_from_list list_data["id"]
        ensure_ok_status tasks_data
        
        tasks = extract_tasks_data(tasks_data).map do |task_data|
          create_task_from_data(task_data, list)
        end
        list.tasks = tasks
      end      
    end
    
    def extract_lists_data data
      data["lists"]["list"]
    end

    def extract_tasks_data data
      data["tasks"]["list"]["taskseries"]
    end
    
    def create_list_from_data list_data
      RTM::List.new(id: list_data["id"], name: list_data["name"])
    end

    def create_task_from_data task_data, list
      RTM::Task.new(id: task_data["id"], name: task_data["name"], priority:  task_data["task"]["priority"], due_date: task_data["task"]["due"], list: list)
    end

    def ensure_ok_status data
      raise Failure, data["stat"] unless data["stat"] == "ok"
    end
  end
end
