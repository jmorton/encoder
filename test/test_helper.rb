ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require 'test/unit'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))

require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'test/unit'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/encoder'))
require File.expand_path(File.join(File.dirname(__FILE__), 'database'))
