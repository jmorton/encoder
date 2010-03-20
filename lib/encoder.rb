module Encoder
  
  def self.included(base)
    base.class_eval do
      extend ClassMethods
    end
  end
  
  module ClassMethods
  
    #
    # Creates getter and setter methods for an attribute.  The getter
    # returns a 'decodable' string that provides more meaning.
    #
    # Example:
    #
    # class Task
    #   include Encoder
    #   code :priority do
    #     Priority::Low = "L"
    #   end
    # end
    #
    # t = Task.new
    # t.priority = Priority::Low
    # t.priority                   # => "L"
    # t.priority.decode            # => "Low"
    #
    def code(attribute_name, &block)
      
      # Create a 'namespace' for constants 
      const_set(attribute_name.to_s.camelcase, Module.new)
      
      # Expecting constants to be assigned values.
      yield
      
      # create setter for attribute
      self.send(:define_method, "#{attribute_name}=") do |arg|
        
        # Find the encoded value for the specified value
        namespace = self.class.const_get(attribute_name.to_s.capitalize)
        
        # If the arg is a constant name...
        value = namespace.const_defined?(arg) ? namespace.const_get(arg) : nil
        
        # If the arg is already an encoded value...
        value ||= arg if namespace.constants.find { |c| arg.downcase == namespace.const_get(c).downcase }          
        
        # Set the value to whatever we found, possibly nil
        self.instance_variable_set("@#{attribute_name}", value)
      end
  
      # create getter for attribute
      self.send(:define_method, attribute_name) do
      
        encoded_attribute = self.instance_variable_get("@#{attribute_name}")
        
        namespace = self.class.const_get(attribute_name.to_s.camelcase)
      
        decoded_value = namespace.constants.select do |constant|
          namespace.const_get(constant) == encoded_attribute
        end.first
      
        encoded_attribute.instance_variable_set(:@decoding, decoded_value)
      
        class << encoded_attribute
          def decoding
            @decoding
          end
        end
      
        return encoded_attribute
      end # -- dynamic getter method 
        
    end # -- code()
    
  end
  
end
