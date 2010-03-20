require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class Task
  include ::Encoder
  
	code :status do
	  Status::New      = "N"
	  Status::Pending  = "P"
	  Status::Finished = "F"
	end
	
	code :priority do
	  Priority::High =  "H"
	  Priority::Low =   "L"
  end
	
end

# t = Demo.new
# puts Demo.constants.inspect
# puts Demo::Status.constants.inspect
# puts Demo::Priority.constants.inspect
# 
# t.status   = 'P'
# t.priority = 'L'
# 
# puts "Status: #{t.status} is for #{t.status.decoding}"
# puts "Priority: #{t.priority} is for #{t.priority.decoding}"
# 
# t.status = 'N'
# puts "#{t.status} is for #{t.status.decoding}"
# 
# t.status = 'F'
# puts "#{t.status} is for #{t.status.decoding}"
# 
# t.status = 'O'
# puts "#{t.status} is for #{t.status.decoding}"
