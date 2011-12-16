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
          "notes"=>{
            "note"=>{"id"=>"NOTE1", "created"=>"2011-01-01T10:10:10Z", "modified"=>"2011-01-01T10:10:10Z", "title"=>"Note Title", "$t"=>"Note Text"}},
        "task"=>
          {"id"=>"TASK1", "due"=>"", "has_due_time"=>"0", "added"=>"2011-10-02T23:53:37Z", "completed"=>"", "deleted"=>"", "priority"=>"N", "postponed"=>"0", "estimate"=>""}},

          {"id"=>"2", "created"=>"2011-01-01T10:10:10Z", "modified"=>"2011-01-01T10:10:10Z",
            "name"=>"Task 2", "source"=>"js", "url"=>"", "location_id"=>"", "tags"=>[], "participants"=>[],
            "notes"=>[],
            "task"=>{"id"=>"TASK2", "due"=>"", "has_due_time"=>"0", "added"=>"2011-10-03T16:52:27Z", "completed"=>"", "deleted"=>"", "priority"=>"N", "postponed"=>"0", "estimate"=>""}}
    ]}}}

  it "should work" do

  end
end

