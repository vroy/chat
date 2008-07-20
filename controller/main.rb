class MainController < Ramaze::Controller
  layout '/layout'
  
  helper :aspect
  
  def index
  end
  
  def room(id=nil)
    @room = Room[id]
    
    redirect :/ if @room.nil?
  end
  
  deny_layout :messages
  def messages
    msgs = ""
    
    Message.dataset.order(:id).each do |msg|
      msgs << "<p>#{msg.message}</p>"
    end
    
    {:msgs => msgs}.to_json
  end
  
  deny_layout :message
  def message
    Message.create(:message => request[:msg], :room => Room[request[:room]])
    {:status => true}.to_json
  end
  
end

