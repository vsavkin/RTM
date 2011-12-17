require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RTM::Repository do
  LISTS = {"stat"=>"ok", "lists"=>{
    "list"=>[
      {"id"=>"1", "name"=>"Inbox", "deleted"=>"0", "locked"=>"1", "archived"=>"0", "position"=>"-1", "smart"=>"0", "sort_order"=>"0"},
      {"id"=>"2", "name"=>"Sent", "deleted"=>"0", "locked"=>"1", "archived"=>"0", "position"=>"1", "smart"=>"0", "sort_order"=>"0"},
      {"id"=>"3", "name"=>"Smart", "deleted"=>"0", "locked"=>"0", "archived"=>"0", "position"=>"0", "smart"=>"1", "sort_order"=>"0", "filter"=>"FILTER"}
  ]}}

  TASKS = {"stat"=>"ok", "tasks"=>{"rev"=>"rev", "list"=>
    {"id"=>"TASK_ID",
      "taskseries"=>[
        {"id"=>"1", "created"=>"2011-01-01T10:10:10Z", "modified"=>"2011-01-01T10:10:10Z",
          "name"=>"Task 1", "source"=>"js", "url"=>"", "location_id"=>"", "tags"=>[], "participants"=>[],
          "notes"=>{"note"=>{"id"=>"NOTE1", "created"=>"2011-01-01T10:10:10Z", "modified"=>"2011-01-01T10:10:10Z", "title"=>"Note Title", "$t"=>"Note Text"}},
           "task"=>{"id"=>"TASK1", "due"=>"2011-01-01T01:01:01Z", "has_due_time"=>"1", "added"=>"2011-10-02T23:53:37Z", "completed"=>"", "deleted"=>"", "priority"=>"N", "postponed"=>"0", "estimate"=>""}},

        {"id"=>"2", "created"=>"2011-01-01T10:10:10Z", "modified"=>"2011-01-01T10:10:10Z",
          "name"=>"Task 2", "source"=>"js", "url"=>"", "location_id"=>"", "tags"=>[], "participants"=>[],
          "notes"=>[],
          "task"=>{"id"=>"TASK2", "due"=>"", "has_due_time"=>"0", "added"=>"2011-10-03T16:52:27Z", "completed"=>"", "deleted"=>"", "priority"=>"N", "postponed"=>"0", "estimate"=>""}}
    ]}}}

  context "#get_data" do
    let(:gateway){double('gateway')}
    let(:repo){RTM::Repository.new gateway}

    context "gateway is alive" do
      before(:each) do
        gateway.should_receive(:get_all_lists).and_return(LISTS)
        gateway.should_receive(:get_tasks_from_list).with("1").and_return(TASKS)
        gateway.should_receive(:get_tasks_from_list).with("2").and_return(TASKS)
        gateway.should_receive(:get_tasks_from_list).with("3").and_return(TASKS)
      end
      
      it "should deserialize all lists from the gateway" do
        data = repo.get_data
        data.size.should == 3
      end

      it "should deserialize all attributes of a list" do
        list = repo.get_data.first
        list.id.should == "1"
        list.name.should == "Inbox"
      end

      it "should deserialize all tasks from a list" do
        list = repo.get_data.first
        list.tasks.size.should == 2
      end

      it "should deserialize all attributes of a task" do
        list = repo.get_data.first
        task = list.tasks.first
        task.id.should == "1"
        task.list.should == list
        task.name.should == "Task 1"
        task.priority.should == "N"
        task.due_date.should == "2011-01-01T01:01:01Z"
      end
    end

    context "gateway errors" do
      it "should raise an exception when can't get an array of lists" do
        gateway.stub(:get_all_lists){ {"stat" => "failure"} }
        expect{repo.get_data}.to raise_error(RTM::Repository::Failure)
      end

      it "should raise an exception when can't get tasks" do
        gateway.stub(:get_all_lists){LISTS}
        gateway.stub(:get_tasks_from_list){ {"stat" => "failure"} }
        expect{repo.get_data}.to raise_error(RTM::Repository::Failure)
      end
    end
  end  
end

