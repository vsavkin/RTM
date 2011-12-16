require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Domain' do
  context "RTM::Task" do
    it "should have id, name, priority, due date, tags, list" do
      list = stub
      task = RTM::Task.new id: '123', name: 'Task Name', priority: 1, due_date: '2011-01-01', tags: ['tag1', 'tag2'], list: list
      task.id.should == '123'
      task.name.should == 'Task Name'
      task.priority.should == 1
      task.due_date.should == '2011-01-01'
      task.tags.should == ['tag1', 'tag2']
      task.list.should == list
    end
  end

  context "RTM::List" do
    it "should have an id, name and a list of tasks" do
      task1, task2 = stub, stub
      list = RTM::List.new id: '123', name: 'List Name', tasks: [task1, task2]
      list.id.should == '123'
      list.name.should == 'List Name'
      list.tasks.should == [task1, task2]
    end
  end
  
end

