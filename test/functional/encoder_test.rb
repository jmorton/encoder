require File.expand_path(File.join(File.dirname(__FILE__), '../test_helper'))

class EncoderTest < ActiveSupport::TestCase
  
  test "setting an attribute using a constant persists the encoding" do
    task = ::Task.new
    task.status = Task::Status::New
    task.save
    
    db_task = ::Task.first
    assert db_task.status == 'N'
  end

  test "setting an attribute using a description persists the correct encoding" do
    task = ::Task.new
    task.status = 'New'
    task.save
    
    db_task = ::Task.first
    assert db_task.status == 'N'
    assert db_task.status.decode == 'New'
  end
  
end
