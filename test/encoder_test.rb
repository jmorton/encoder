require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class EncoderTest < ActiveSupport::TestCase
  
  test "setting an attribute using a constant" do
    task = ::Task.new
    task.status = Task::Status::New
    assert task.status == Task::Status::New
  end
  
  test "setting an attribute using a verbose value" do
    task = ::Task.new
    task.status = "New"
    assert task.status == Task::Status::New
  end
  
  test "setting an attribute using a an invalid value overwrites a valid one" do
    task = ::Task.new
    task.status = "New"
    task.status = "Invalid"
    assert task.status == nil
  end
  
end
