require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))
require File.dirname(__FILE__) + '/database'

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
  
  test "a code's attribute name corresponds to a camelcased namespace" do
    task = ::Task.new
    
    class ::Task
      code :foo_bar do
        FooBar::Baz = 1
        FooBar::Buzz = 2
      end
    end
    
    assert Task.const_defined?(:FooBar)
  end
  
end
