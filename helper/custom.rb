module Ramaze; module Helper;

  module Custom
  
    def error_messages_for(model)
      msgs = model.errors.full_messages.map do |msg|
        msg.capitalize
      end
      
      msgs.join("<br/>")
    end
    
  end
  
end; end
