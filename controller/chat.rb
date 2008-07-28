class ChatController < Ramaze::Controller
  layout '/layout'
  
  map '/'
  
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
  
  # Page that does everything and contains the javascript.
  def room(id=nil)
    @room = Room[id]

    @room.add_user(session[:user])
    
    session[:rooms] = {} if session[:rooms].nil?
      
    session[:rooms][@room.id] = @room
    
    #TODO: Remove all the rooms that are not in use right now.
    redirect :/ if @room.nil?
  end
  
  # action that quits a room
  def quit
    if request.post?
      room_id = request[:room].to_i
      
      #DB.execute(RoomUser.filter(:room_id => room_id, :user_id => session[:user].id).delete_sql)
      Joined.filter(:room_id => room_id, :user_id => session[:user].id).delete
      
      session[:rooms].delete(room_id)
    end
  end
  
  # action that creates a form
  def create_room
    if request.post?
      room = Room.create :name => request[:room_name]
    
      redirect Rs(:room, room.id)
    end
  end

  #############################################################################
  ########################################################## ERROR HANDLING ###
  #############################################################################
  def error
    flash[:error] = "Page not found."
    redirect :/
  end

  #############################################################################
  #################################################################### AJAX ###
  #############################################################################
  
  # Deny layout to ajax call and returns some json
  deny_layout :reload, :messages, :users, :message
  
  # Combine both
  def reload
    {:users => users, :msgs => messages}.to_json
  end
  

  # Ajax call that inserts a message if the msg receive is not nil or empty
  def message
    return {:status => true}.to_json if request[:msg] == "" or request[:msg].nil?

    Message.create(:message => request[:msg], :room => Room[request[:room]], :user => session[:user])

    {:status => true}.to_json
  end
  
  
  private
  # Ajax call that returns the messages for a certain room and update the table
  # that contains the relation between the users and the rooms so it can be
  # showed to the users
  def messages
    Joined[:user_id => session[:user].id, :room_id => request[:room]].save

    msgs = ""
    Message.filter(:room_id => request[:room]).order(:id).each do |msg|
      msgs << "<p>#{msg.user.name}: #{msg.message}</p>"
    end

    msgs
  end


  # Ajax call that populates the users list in the room. Based on the users that
  # refreshed the messages in the last 5 seconds (based on the 2 seconds polling)
  def users
    users = ""

    Room[request[:room]].users_dataset.filter(:stamp > Time.now - 15).each do |user|
      users << "<option>#{user.name}</option>"
    end
    
    users
  end

end

