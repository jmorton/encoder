$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'
require 'active_record'
gem 'sqlite3-ruby'

require File.dirname(__FILE__) + '/../rails/init'
  
ActiveRecord::Base.logger = Logger.new('/tmp/encoder.log')
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => '/tmp/encoder.sqlite')
ActiveRecord::Migration.verbose = false
ActiveRecord::Base.default_timezone = :utc if Time.zone.nil?

ActiveRecord::Schema.define do
  create_table :tasks, :force => true do |table|
    table.string :status
    table.string :priority
  end
end

class Task < ActiveRecord::Base
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

puts 'ahoy!!'