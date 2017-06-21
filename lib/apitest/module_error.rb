module Apitest
  module ModelError
    include Apitest::Error
    def self.include(klass)
      klass.class_eval do 
        include ServiceError
        extend  ServiceError
      end
    end
  end
end