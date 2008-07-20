class MainController < Ramaze::Controller
  layout '/layout'
  
  helper :aspect, :custom
  
  #TODO: Before all for @logged_in
  
  before(:room, :messages, :frame, :message) do
    if session[:user].nil?
      flash[:redirect] = request.url
      flash[:error] = "You need to be logged in to see this page."
      redirect Rs(UserController, :login);
    end
  end
  
  def index
  end
  
  def room(id=nil)
    @room = Room[id]
    
    redirect :/ if @room.nil?
  end
  
  deny_layout :frame
  
  deny_layout :messages
  def messages
    msgs = ""
    
    Message.dataset.order(:id).each do |msg|
      msgs << "<p>#{msg.user.name}: #{msg.message}</p>"
    end
    
    {:msgs => msgs}.to_json
  end
  
  deny_layout :message
  def message
    Message.create(:message => request[:msg], :room => Room[request[:room]], :user => session[:user])
    {:status => true}.to_json
  end
  
  def error
    flash[:error] = "Page not found."
    redirect :/
  end
  
end

