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
        
        # At the end of this method, the underlying attribute will be set
        # to the value of this variable.
        encoded_value = nil
        
        # Retrieve the module where the constants for this attribute are defined.
        namespace = self.class.const_get(attribute_name.to_s.camelcase)
        
        # Since the given value might not match the constant name exactly
        # (because of case sensitivity or white space variations) we
        # normalize it a bit.
        normalized = arg && arg.gsub(/\s+/,'').downcase
        
        # Now we look for a constant whose name or actual value match the
        # normalized argument.  We 'tap' whatever constant name is found
        # and lookup the actual value.
        namespace.constants.find do |const_name|
          normalized == const_name.downcase ||
          normalized == namespace.const_get(const_name).downcase
        end.tap do |match|
          encoded_value = namespace.const_get(match) if match
        end
        
        # Set the value to whatever we found, possibly nil
        self.write_attribute(attribute_name, encoded_value)
      end
  
      # create getter for attribute
      self.send(:define_method, attribute_name) do
      
        encoded_attribute = self.read_attribute(attribute_name)
        
        namespace = self.class.const_get(attribute_name.to_s.camelcase)
      
        decoded_value = namespace.constants.select do |constant|
          namespace.const_get(constant) == encoded_attribute
        end.first
      
        encoded_attribute.instance_variable_set(:@decoding, decoded_value)
      
        class << encoded_attribute
          def decode
            @decoding && @decoding.underscore.titleize
          end
        end
      
        return encoded_attribute
      end # -- dynamic getter method 
        
    end # -- code()
    
  end
  
end
