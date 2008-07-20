class MainController < Ramaze::Controller
  layout '/layout'
  
  helper :aspect, :custom
  
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
    
    if RoomUser[:user_id => session[:user].id, :room_id => id].nil?
      @room.add_user(session[:user])
    end
    
    redirect :/ if @room.nil?
  end
  
  deny_layout :frame
  
  deny_layout :messages
  def messages
    msgs = ""
    
    room = Room[request[:room]]
    
    room_user = RoomUser[:user_id => session[:user].id, :room_id => room.id]
      
    unless room_user.nil?
      room_user.save
    end
    
    Message.filter(:room_id => request[:room]).order(:id).each do |msg|
      msgs << "<p>#{msg.user.name}: #{msg.message}</p>"
    end
    
    {:msgs => msgs}.to_json
  end
  
  deny_layout :message
  def message
    return {:status => true}.to_json if request[:msg] == "" or request[:msg].nil?
    
    Message.create(:message => request[:msg], :room => Room[request[:room]], :user => session[:user])
    {:status => true}.to_json
  end
  
  def error
    flash[:error] = "Page not found."
    redirect :/
  end
  
end

