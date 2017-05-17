module Apitest
  module Error
    def error(error_code = nil , data = nil,message = nil)
      hash = {
        status:       'error'      ,
        error_code:   error_code   ,
        message:      message.nil? ? self::ERROR[error_code] : message ,
        data:         data         ,
      }  
      raise "#{self.to_s}::Error".constantize.new hash
    end

    def success(message = nil , data = nil)
      hash              = {}
      hash[:status]     = 'ok' 
      if message.is_a? Hash
        hash[:message]  = message[:message] ? message[:message] : ''
        hash[:data]     = message[:data]    ? message[:data]    : message 
      else
        hash[:message]  = message ? message :  ''
        hash[:data]     = data    ? data    :  {} 
      end
      return hash
    end

    class Error < StandardError
      def error
        eval(message)
      end
      def error_code
        error[:error_code]
      end
    end
  end
end